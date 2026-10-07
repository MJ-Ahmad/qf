import json
import urllib.request
from datetime import date
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent
OUTPUT_FILE = BASE_DIR / "locations.json"

SOURCE_URL = (
    "https://raw.githubusercontent.com/"
    "open-admin-data/bangladesh-administrative-divisions/"
    "main/data/all-upazila.json"
)

def get_json(url):
    with urllib.request.urlopen(url, timeout=30) as response:
        return json.loads(response.read().decode("utf-8"))

def safe_str(value):
    if value is None:
        return ""
    return str(value).strip()

def normalize_name(value):
    if isinstance(value, dict):
        bn = safe_str(value.get("bn") or value.get("bangla") or value.get("বাংলা"))
        en = safe_str(value.get("en") or value.get("english") or value.get("English"))
        return {"bn": bn, "en": en}
    elif isinstance(value, str):
        return {"bn": value, "en": value}
    else:
        return {"bn": "", "en": ""}

def normalize_record(item, idx):
    division = normalize_name(item.get("division") or item.get("division_name") or item.get("divisionName") or {})
    district = normalize_name(item.get("district") or item.get("district_name") or item.get("districtName") or {})
    upazila = normalize_name(item.get("upazila") or item.get("upazila_name") or item.get("upazilaName") or {})

    division_id = safe_str(item.get("division_id") or item.get("divisionId"))
    district_id = safe_str(item.get("district_id") or item.get("districtId"))
    upazila_id = safe_str(item.get("upazila_id") or item.get("upazilaId") or item.get("id") or "")

    if not upazila_id:
        upazila_id = f"UPZ-{idx:04d}"

    record_id = f"LOC-{division_id}-{district_id}-{upazila_id}" if division_id and district_id and upazila_id else f"LOC-{idx:06d}"

    return {
        "id": record_id,
        "level": "upazila",
        "country": {"bn": "বাংলাদেশ", "en": "Bangladesh"},
        "divisionId": division_id,
        "districtId": district_id,
        "upazilaId": upazila_id,
        "division": division,
        "district": district,
        "upazila": upazila,
        "cityCorporation": None,
        "municipality": None,
        "union": None,
        "ward": None,
        "village": None,
        "postOffice": None,
        "postalCode": None,
        "latitude": item.get("latitude") or item.get("lat"),
        "longitude": item.get("longitude") or item.get("lng") or item.get("lon"),
        "status": "active",
        "source": {
            "name": "Bangladesh Administrative Divisions Dataset",
            "url": SOURCE_URL,
            "retrievedOn": str(date.today())
        }
    }

def main():
    data = get_json(SOURCE_URL)

    if isinstance(data, dict):
        for key in ("data", "upazilas", "items", "results"):
            if key in data:
                data = data[key]
                break

    if not isinstance(data, list):
        raise ValueError("Unexpected JSON structure. Expected list at top level.")

    normalized = [normalize_record(item, idx + 1) for idx, item in enumerate(data)]
    normalized.sort(key=lambda x: (
        (x["division"].get("en") or "").lower(),
        (x["district"].get("en") or "").lower(),
        (x["upazila"].get("en") or "").lower()
    ))

    final = {
        "schemaVersion": "1.0",
        "dataset": "qf-locations",
        "country": {"bn": "বাংলাদেশ", "en": "Bangladesh"},
        "scope": ["division", "district", "upazila"],
        "recordCount": len(normalized),
        "generatedOn": str(date.today()),
        "source": {
            "name": "Bangladesh Administrative Divisions Dataset",
            "url": SOURCE_URL
        },
        "locations": normalized
    }

    OUTPUT_FILE.write_text(json.dumps(final, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"Generated {OUTPUT_FILE}")
    print(f"Records: {len(normalized)}")
    print("This is generated from the official Bangladesh administrative divisions dataset.")

if __name__ == "__main__":
    main()
