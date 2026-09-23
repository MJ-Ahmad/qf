import json
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent

locations_path = BASE_DIR / "locations.json"
institutions_path = BASE_DIR / "institutions.json"

if not locations_path.exists():
    raise FileNotFoundError(f"Missing file: {locations_path}")

if not institutions_path.exists():
    raise FileNotFoundError(f"Missing file: {institutions_path}")

locations_data = json.loads(locations_path.read_text(encoding="utf-8"))
institutions_data = json.loads(institutions_path.read_text(encoding="utf-8"))

# Support both raw array and wrapped schema
locations_list = locations_data.get("locations", locations_data)

if not isinstance(locations_list, list):
    raise ValueError("locations.json must contain a list or a 'locations' array")

if not isinstance(institutions_data, list):
    raise ValueError("institutions.json must contain a list of institutions")

location_ids = {item["id"] for item in locations_list if isinstance(item, dict) and "id" in item}

missing = []
invalid = []

for inst in institutions_data:
    if not isinstance(inst, dict):
        invalid.append({"record": inst, "reason": "not an object"})
        continue

    location_id = inst.get("locationId")
    institution_id = inst.get("id") or "UNKNOWN"

    if not location_id:
        invalid.append({
            "institutionId": institution_id,
            "reason": "missing locationId"
        })
        continue

    if location_id not in location_ids:
        missing.append({
            "institutionId": institution_id,
            "locationId": location_id
        })

if missing:
    print("❌ Missing location references found:")
    print(json.dumps(missing, ensure_ascii=False, indent=2))
else:
    print("✅ All institution location references are valid.")

if invalid:
    print("\n⚠️ Invalid institution entries:")
    print(json.dumps(invalid, ensure_ascii=False, indent=2))
