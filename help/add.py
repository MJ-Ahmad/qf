#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
add_codecraft.py — CodeCraft এ নতুন এন্ট্রি যোগ করার স্ক্রিপ্ট

ব্যবহার:
    python add_codecraft.py           নতুন এন্ট্রি যোগ করুন
    python add_codecraft.py serve     ব্রাউজারে দেখার জন্য লোকাল সার্ভার চালু করুন (পোর্ট 8000)
    python add_codecraft.py serve 9000
    python add_codecraft.py list      সব এন্ট্রির তালিকা দেখুন
    python add_codecraft.py delete    একটি এন্ট্রি মুছুন
"""

import json
import os
import re
import sys
import time
import urllib.parse
import urllib.request

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DATA_FILE = os.path.join(BASE_DIR, "data.json")

DEFAULT_MENUS = ["স্ক্রিপ্ট", "ফাইল", "নির্দেশনা"]

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


# ---------------------------------------------------------------- data file --
def load_data():
    if not os.path.exists(DATA_FILE):
        return {
            "site": {
                "title": "CodeCraft",
                "subtitle": "আমার স্ক্রিপ্ট, ফাইল ও নির্দেশনার সংগ্রহ",
            },
            "menus": list(DEFAULT_MENUS),
            "items": [],
        }
    with open(DATA_FILE, "r", encoding="utf-8") as f:
        data = json.load(f)
    data.setdefault("site", {"title": "CodeCraft", "subtitle": ""})
    data.setdefault("menus", list(DEFAULT_MENUS))
    data.setdefault("items", [])
    return data


def save_data(data):
    tmp = DATA_FILE + ".tmp"
    with open(tmp, "w", encoding="utf-8", newline="\n") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
        f.write("\n")
    os.replace(tmp, DATA_FILE)  # আধা-লেখা ফাইল থেকে ডাটা নষ্ট হওয়া ঠেকায়


def all_menus(data):
    menus = list(data["menus"])
    for it in data["items"]:
        if it.get("menu") and it["menu"] not in menus:
            menus.append(it["menu"])
    return menus


# ------------------------------------------------------------------- input --
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


def choose_menu(data):
    menus = all_menus(data)
    print("\nকোন মেনুর আওতায় যোগ করবেন?")
    for i, name in enumerate(menus, 1):
        print(f"  {i}. {name}")
    custom_no = len(menus) + 1
    print(f"  {custom_no}. ➕ কাস্টম মেনু (নিজে লিখবো)")
    while True:
        raw = ask("নম্বর লিখুন (অথবা সরাসরি মেনুর নাম লিখুন)")
        if raw.isdigit():
            n = int(raw)
            if 1 <= n <= len(menus):
                return menus[n - 1]
            if n == custom_no:
                return ask("নতুন মেনুর নাম")
            print("  ⚠ ভুল নম্বর।")
        else:
            return raw  # সরাসরি নাম লিখলে সেটাই মেনু


# ------------------------------------------------------------ file / source --
def to_raw_github(url):
    """github.com/…/blob/… লিংককে raw লিংকে বদলায়।"""
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
    ext = os.path.splitext(filename)[1].lower()
    return EXT_LANG.get(ext, "Text")


# ---------------------------------------------------------------- commands --
def cmd_add():
    data = load_data()
    print("=" * 46)
    print("  CodeCraft — নতুন এন্ট্রি যোগ করুন")
    print("=" * 46)

    menu = choose_menu(data)
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

    language = ask("ভাষা/লেবেল (HTML, JSON, Python, Node…)",
                   default=guess_language(filename or ""))

    item = {
        "id": f"{int(time.time())}-{len(data['items']) + 1}",
        "menu": menu,
        "title": title,
        "description": description,
        "language": language,
        "filename": filename or "",
        "code": code,
        "created": time.strftime("%Y-%m-%d"),
    }

    if menu not in data["menus"]:
        data["menus"].append(menu)
    data["items"].append(item)
    save_data(data)

    print("\n✔ যোগ হয়েছে!")
    print(f"  মেনু     : {menu}")
    print(f"  হেডলাইন  : {title}")
    print(f"  ভাষা     : {language}   ফাইল: {filename or '—'}   ({len(code.splitlines())} লাইন)")
    print("\nদেখতে চালান:  python add_codecraft.py serve")


def cmd_list():
    data = load_data()
    if not data["items"]:
        print("এখনও কোনো এন্ট্রি নেই।")
        return
    for i, it in enumerate(data["items"], 1):
        print(f"{i:>3}. [{it['menu']}] {it['title']}  ({it.get('language', '')} {it.get('filename', '')})")


def cmd_delete():
    data = load_data()
    if not data["items"]:
        print("মোছার মতো কোনো এন্ট্রি নেই।")
        return
    cmd_list()
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
    print("✔ মুছে ফেলা হয়েছে।")


def cmd_serve(port):
    import functools
    import http.server
    import socketserver
    import webbrowser

    handler = functools.partial(http.server.SimpleHTTPRequestHandler, directory=BASE_DIR)
    socketserver.TCPServer.allow_reuse_address = True
    try:
        with socketserver.TCPServer(("127.0.0.1", port), handler) as httpd:
            url = f"http://localhost:{port}/index.html"
            print(f"CodeCraft চালু: {url}   (বন্ধ করতে Ctrl+C)")
            try:
                webbrowser.open(url)
            except Exception:
                pass
            httpd.serve_forever()
    except OSError as e:
        print(f"সার্ভার চালু করা যায়নি: {e}\nঅন্য পোর্ট দিন, যেমন: python add_codecraft.py serve 9000")
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
