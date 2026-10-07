#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
add.py — "কোরআনের ফেরিওয়ালা" CodeCraft এ নতুন এন্ট্রি যোগ করার স্ক্রিপ্ট

ব্যবহার (index.html ও data.json এর ফোল্ডারে চালান):
    python add.py            নতুন এন্ট্রি যোগ করুন
    python add.py serve      লোকাল সার্ভার চালু করুন (পোর্ট 8000)
    python add.py serve 9000 অন্য পোর্টে চালু করুন
    python add.py list       মেনুর গাছ ও এন্ট্রির সংখ্যা দেখুন
    python add.py setup      প্রাথমিক মেনু + লোগো বিদ্যমান data.json এ যোগ করুন
    python add.py delete     একটি এন্ট্রি মুছুন
"""

import json
import os
import re
import shutil
import subprocess
import sys
import time
import urllib.parse
import urllib.request

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DATA_FILE = os.path.join(BASE_DIR, "data.json")

SITE_TITLE = "কোরআনের ফেরিওয়ালা"
SITE_TAGLINE = "CodeCraft — স্ক্রিপ্ট, ফাইল ও নির্দেশনার সংগ্রহ"
ROOT_LABEL = "mj-ahmad"
LOGO_URL = "https://MJ-Ahmad.github.io/qf/assets/logo.png"

# প্রাথমিক মেনুর গাছ (সাব মেনু থাকলে {"name": …, "children": […]})
PRESET_MENUS = [
    "Systems",
    {"name": "Projects", "children": ["Quraner Fariwala", "MJSovereign"]},
    "README", "Git", "Python", "Node", "JSON", ".NET", "CLI", "Command", "Scripts",
]
SEP = " › "

# ফাইলের এক্সটেনশন থেকে ভাষা/লেবেল চেনার তালিকা
EXT_LANG = {
    ".html": "HTML", ".htm": "HTML", ".css": "CSS",
    ".json": "JSON", ".py": "Python",
    ".js": "Node", ".mjs": "Node", ".cjs": "Node",
    ".ts": "TypeScript", ".sh": "Bash", ".bash": "Bash", ".zsh": "Bash",
    ".php": "PHP", ".java": "Java", ".c": "C", ".cpp": "C++", ".cs": "C#",
    ".go": "Go", ".rs": "Rust", ".sql": "SQL",
    ".yml": "YAML", ".yaml": "YAML", ".xml": "XML",
    ".md": "Markdown", ".txt": "Text", ".env": "Text", ".ini": "Text",
}


# ------------------------------------------------------------ menu tree ----
def norm_nodes(lst):
    """মেনু তালিকাকে {name, children} গাছে বদলায় (পুরোনো ফরম্যাটও চলে)।"""
    out = []
    for m in lst or []:
        if isinstance(m, str):
            out.append({"name": m, "children": []})
        elif isinstance(m, dict) and m.get("name"):
            out.append({"name": m["name"], "children": norm_nodes(m.get("children"))})
    return out


def find_node(nodes, name):
    return next((n for n in nodes if n["name"] == name), None)


def children_of(tree, path):
    """path এর ভেতরের সন্তান-তালিকা ফেরত দেয় (না থাকলে তৈরি করে)।"""
    lst = tree
    for name in path:
        node = find_node(lst, name)
        if node is None:
            node = {"name": name, "children": []}
            lst.append(node)
        lst = node["children"]
    return lst


def merge_nodes(dst, src):
    """src এর মেনু dst এ যোগ করে; যা আগে থেকে আছে তা অক্ষত থাকে।"""
    for n in src:
        cur = find_node(dst, n["name"])
        if cur is None:
            dst.append({"name": n["name"], "children": []})
            cur = dst[-1]
        merge_nodes(cur["children"], n["children"])


def count_items(items, path):
    return sum(1 for it in items if it["path"][:len(path)] == path)


# ------------------------------------------------------------ data file ----
def normalize(data):
    """পুরোনো data.json (একস্তরের menu) নতুন গাছ-কাঠামোতে বদলায়।"""
    site = data.setdefault("site", {})
    if site.get("title") in (None, "", "CodeCraft"):
        site["title"] = SITE_TITLE
        site["tagline"] = SITE_TAGLINE
    if "tagline" not in site:
        site["tagline"] = site.pop("subtitle", SITE_TAGLINE)
    site.pop("subtitle", None)
    if site.get("logo") in (None, "", "logo.png"):
        site["logo"] = LOGO_URL
    site.setdefault("root_label", ROOT_LABEL)

    data["menus"] = norm_nodes(data.get("menus") or PRESET_MENUS)
    data.setdefault("items", [])
    for it in data["items"]:
        if not isinstance(it.get("path"), list) or not it["path"]:
            it["path"] = [it["menu"]] if it.get("menu") else []
        it.pop("menu", None)
        children_of(data["menus"], it["path"])   # মেনুর গাছে না থাকলে যোগ করে
    return data


def load_data():
    if not os.path.exists(DATA_FILE):
        return normalize({"site": {}, "menus": [], "items": []})
    with open(DATA_FILE, "r", encoding="utf-8") as f:
        return normalize(json.load(f))


def save_data(data):
    tmp = DATA_FILE + ".tmp"
    with open(tmp, "w", encoding="utf-8", newline="\n") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
        f.write("\n")
    os.replace(tmp, DATA_FILE)   # আধা-লেখা ফাইলে ডাটা নষ্ট হওয়া ঠেকায়


# ---------------------------------------------------------------- input ----
def ask(prompt, required=True, default=None):
    while True:
        suffix = f" [{default}]" if default else ""
        try:
            value = input(f"{prompt}{suffix}: ").strip()
        except EOFError:
            print("\nইনপুট শেষ হয়ে গেছে, বন্ধ করা হলো।")
            sys.exit(1)
        if not value and default:
            return default
        if value or not required:
            return value
        print("  ⚠ এটি খালি রাখা যাবে না।")


def ask_multiline(prompt):
    print(f"{prompt} (একাধিক লাইন লিখতে পারেন; শেষ করতে একটি খালি লাইনে Enter চাপুন)")
    lines = []
    while True:
        try:
            line = input("  > ")
        except EOFError:
            break
        if line == "":
            if lines:
                break
            print("  ⚠ বিবরণ খালি রাখা যাবে না।")
            continue
        lines.append(line)
    return "\n".join(lines)


def choose_path(data):
    """মেনু → সাব মেনু → সাব-সাব মেনু… ধাপে ধাপে নেমে গিয়ে পথ বেছে নেয়।"""
    path = []
    print(f"\nকোন মেনুর আওতায় যোগ করবেন?   ({data['site'].get('root_label', ROOT_LABEL)}/)")
    print("(মেনু বেছে ভেতরে ঢুকুন; দরকার হলে নতুন মেনু/সাব মেনু বানান; শেষে 0 দিয়ে সংরক্ষণ করুন)")
    while True:
        kids = children_of(data["menus"], path)
        print("\n  📂 " + (SEP.join(path) if path else data["site"].get("root_label", ROOT_LABEL) + "/"))
        for i, n in enumerate(kids, 1):
            total = count_items(data["items"], path + [n["name"]])
            sub = f", {len(n['children'])}টি সাব মেনু" if n["children"] else ""
            print(f"   {i}. {n['name']}  ({total}টি এন্ট্রি{sub})")
        new_no = len(kids) + 1
        print(f"   {new_no}. ➕ নতুন {'সাব মেনু' if path else 'মেনু'} তৈরি করুন")
        if path:
            print(f"   0. ✔ এখানেই সংরক্ষণ করুন  ({SEP.join(path)})")

        raw = ask("নম্বর লিখুন (অথবা সরাসরি নাম লিখুন)")
        if raw == "0" and path:
            return path
        if raw.isdigit():
            n = int(raw)
            if 1 <= n <= len(kids):
                path = path + [kids[n - 1]["name"]]
            elif n == new_no:
                path = path + [ask("নতুন নাম")]
            else:
                print("  ⚠ ভুল নম্বর।")
                continue
        else:
            path = path + [raw]   # সরাসরি নাম: থাকলে ঢুকবে, না থাকলে নতুন হবে
        children_of(data["menus"], path)   # নতুন হলে গাছে যোগ হয় (সেভ হবে শেষে)


# -------------------------------------------------------- file / source ----
def to_raw_github(url):
    m = re.match(r"^https?://github\.com/([^/]+)/([^/]+)/blob/(.+)$", url)
    if m:
        return f"https://raw.githubusercontent.com/{m.group(1)}/{m.group(2)}/{m.group(3)}"
    return url


def read_source(src):
    """(কোড, ফাইলের নাম) ফেরত দেয়। ব্যর্থ হলে None।"""
    if re.match(r"^https?://", src, re.I):
        url = to_raw_github(src)
        try:
            req = urllib.request.Request(url, headers={"User-Agent": "CodeCraft/1.0"})
            with urllib.request.urlopen(req, timeout=20) as resp:
                raw = resp.read()
        except Exception as e:
            print(f"  ⚠ লিংক থেকে আনা যায়নি: {e}")
            return None
        name = os.path.basename(urllib.parse.urlparse(url).path) or "file.txt"
    else:
        path = os.path.expanduser(src.strip('"').strip("'"))
        candidates = [path] if os.path.isabs(path) else [
            os.path.join(BASE_DIR, path),      # এই স্ক্রিপ্টের ফোল্ডারেই থাকলে
            os.path.join(os.getcwd(), path),   # বর্তমান টার্মিনাল ফোল্ডারে থাকলে
        ]
        found = next((p for p in candidates if os.path.isfile(p)), None)
        if not found:
            print("  ⚠ ফাইল পাওয়া যায়নি। নাম/পথ আবার দেখুন।")
            return None
        try:
            with open(found, "rb") as f:
                raw = f.read()
        except OSError as e:
            print(f"  ⚠ ফাইল পড়া যায়নি: {e}")
            return None
        name = os.path.basename(found)

    try:
        text = raw.decode("utf-8-sig")
    except UnicodeDecodeError:
        print("  ⚠ এটি টেক্সট ফাইল নয় (বা UTF-8 নয়)। ছবি/বাইনারি ফাইল যোগ করা যাবে না।")
        return None
    return text.replace("\r\n", "\n").rstrip("\n"), name


def read_pasted_code():
    print("কোড/টেক্সট পেস্ট করুন। শেষ করতে একটি আলাদা লাইনে শুধু END লিখুন।")
    lines = []
    while True:
        try:
            line = input()
        except EOFError:
            break
        if line.strip() == "END":
            break
        lines.append(line)
    return "\n".join(lines).rstrip("\n")


def guess_language(filename):
    return EXT_LANG.get(os.path.splitext(filename)[1].lower(), "Text")


# ------------------------------------------------------------- commands ----
def cmd_add():
    data = load_data()
    print("=" * 50)
    print(f"  {SITE_TITLE} — CodeCraft এ নতুন এন্ট্রি")
    print("=" * 50)

    path = choose_path(data)
    title = ask("\nহেডলাইন (শিরোনাম)")
    description = ask_multiline("\nবিবরণ")

    print("\nফাইলের লিংক (https://…) লিখুন, অথবা ফাইল একই ফোল্ডারে থাকলে শুধু ফাইলের নাম লিখুন।")
    print("ফাইল ছাড়া শুধু কোড পেস্ট করতে চাইলে খালি রেখে Enter চাপুন।")
    code = filename = None
    while code is None:
        src = ask("ফাইল লিংক / ফাইলের নাম", required=False)
        if not src:
            code = read_pasted_code()
            if not code:
                print("  ⚠ কিছুই পেস্ট করা হয়নি।")
                code = None
                continue
            filename = ask("ফাইলের নাম (যেমন app.py, না থাকলে খালি রাখুন)", required=False)
            break
        result = read_source(src)
        if result:
            code, filename = result

    language = ask("ভাষা/লেবেল (HTML, JSON, Python, Node…)", default=guess_language(filename or ""))

    data["items"].append({
        "id": str(time.time_ns() // 1_000_000),
        "path": path,
        "title": title,
        "description": description,
        "language": language,
        "filename": filename or "",
        "code": code,
        "created": time.strftime("%Y-%m-%d"),
    })
    save_data(data)

    print("\n✔ যোগ হয়েছে!")
    print(f"  মেনু    : {SEP.join(path)}")
    print(f"  হেডলাইন : {title}")
    print(f"  ভাষা    : {language}   ফাইল: {filename or '—'}   ({len(code.splitlines())} লাইন)")
    print("\nদেখতে চালান:  python add.py serve")


def cmd_setup():
    """প্রাথমিক মেনু, লোগো ও রুট-নাম বিদ্যমান data.json এ যোগ করে (কিছু মোছে না)।"""
    data = load_data()
    merge_nodes(data["menus"], norm_nodes(PRESET_MENUS))
    data["site"]["logo"] = LOGO_URL
    data["site"]["root_label"] = ROOT_LABEL
    save_data(data)
    print("✔ প্রাথমিক মেনু, লোগো ও রুট-নাম সেট হয়েছে। আগের এন্ট্রি অক্ষত আছে।")
    print()
    cmd_list()


def print_tree(nodes, items, path, depth):
    for n in nodes:
        p = path + [n["name"]]
        print("   " + "    " * depth + f"├─ {n['name']}  ({count_items(items, p)})")
        print_tree(n["children"], items, p, depth + 1)


def cmd_list():
    data = load_data()
    print(f"{data['site'].get('root_label', ROOT_LABEL)}/  — সব এন্ট্রি: {len(data['items'])}টি\n")
    print_tree(data["menus"], data["items"], [], 0)


def cmd_delete():
    data = load_data()
    if not data["items"]:
        print("মোছার মতো কোনো এন্ট্রি নেই।")
        return
    for i, it in enumerate(data["items"], 1):
        print(f"{i:>3}. [{SEP.join(it['path'])}] {it['title']}  ({it.get('language', '')} {it.get('filename', '')})")
    raw = ask("\nকোন নম্বরটি মুছবেন? (বাতিল করতে খালি রাখুন)", required=False)
    if not raw.isdigit() or not (1 <= int(raw) <= len(data["items"])):
        print("বাতিল করা হলো।")
        return
    it = data["items"][int(raw) - 1]
    if ask(f"“{it['title']}” মুছে ফেলবেন? (y/n)", default="n").lower() != "y":
        print("বাতিল করা হলো।")
        return
    data["items"].pop(int(raw) - 1)
    save_data(data)
    print("✔ মুছে ফেলা হয়েছে। (মেনুটি থেকে যাবে; দরকার হলে data.json থেকে মুছুন)")


def open_in_browser(url):
    """Termux হলে termux-open-url, নয়তো ডিফল্ট ব্রাউজার।"""
    try:
        if shutil.which("termux-open-url"):
            subprocess.Popen(["termux-open-url", url])
        else:
            import webbrowser
            webbrowser.open(url)
    except Exception:
        pass   # খুলতে না পারলে ব্যবহারকারী নিজেই লিংক খুলবেন


def cmd_serve(port):
    import functools
    import http.server
    import socketserver

    handler = functools.partial(http.server.SimpleHTTPRequestHandler, directory=BASE_DIR)
    socketserver.TCPServer.allow_reuse_address = True
    try:
        with socketserver.TCPServer(("127.0.0.1", port), handler) as httpd:
            url = f"http://localhost:{port}/index.html"
            print(f"{SITE_TITLE} চালু: {url}   (বন্ধ করতে Ctrl+C)")
            open_in_browser(url)
            httpd.serve_forever()
    except OSError as e:
        print(f"সার্ভার চালু করা যায়নি: {e}\nঅন্য পোর্ট দিন, যেমন: python add.py serve 9000")
    except KeyboardInterrupt:
        print("\nসার্ভার বন্ধ করা হলো।")


def main():
    args = sys.argv[1:]
    cmd = args[0].lower() if args else "add"
    try:
        if cmd == "add":
            cmd_add()
        elif cmd == "list":
            cmd_list()
        elif cmd == "setup":
            cmd_setup()
        elif cmd == "delete":
            cmd_delete()
        elif cmd == "serve":
            cmd_serve(int(args[1]) if len(args) > 1 and args[1].isdigit() else 8000)
        else:
            print(__doc__)
    except KeyboardInterrupt:
        print("\nবাতিল করা হলো।")


if __name__ == "__main__":
    main()
