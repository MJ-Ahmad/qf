#!/usr/bin/env bash
# investor.sh
# portal_gateway/ লোকেশন থেকে রান করুন: bash investor.sh
# এটি investor/ ফোল্ডার ও তার ভেতরের সবগুলো টেমপ্লেট + বাস্তব প্রোফাইল ফাইল তৈরি করবে।
set -e

echo "investor/ ফোল্ডার তৈরি করা হচ্ছে..."

mkdir -p "investor/_template"
mkdir -p "investor/alamin"

cat > "investor/_template/data.json" << 'QFEOF'
{
  "_readme": "এই ফাইলটি টেমপ্লেট — নতুন বিনিয়োগকারীর জন্য investor/{username}/ ফোল্ডার তৈরি করে এই টেমপ্লেট কপি করুন, তারপর security.passwordSha256 (hash-generator.html দিয়ে তৈরি করুন) এবং investor, investment, returns, ledger.entries এ প্রকৃত তথ্য বসান। investor.roles ও contract.clauses এর লেখাগুলো সাধারণত সব বিনিয়োগকারীর জন্য একই রকম থাকে, দরকার হলে বদলান।",
  "site": {
    "title": {
      "bn": "বিনিয়োগ প্রোফাইল",
      "en": "Investor profile"
    },
    "brand": {
      "bn": "কোরআনের ফেরিওয়ালা",
      "en": "Quraner Fariwala"
    },
    "logo": "https://mj-ahmad.github.io/qf/assets/logo.png",
    "logoAlt": {
      "bn": "কোরআনের ফেরিওয়ালার লোগো",
      "en": "Quraner Fariwala logo"
    },
    "homeUrl": "/qf/home/index.html",
    "defaultLang": "bn",
    "timezone": "Asia/Dhaka",
    "currencySymbol": "৳",
    "currencyWord": {
      "bn": "টাকা",
      "en": "Tk."
    },
    "clockLabel": {
      "bn": "বাংলাদেশ সময়",
      "en": "Bangladesh time"
    },
    "gatewayUrl": "../../"
  },
  "security": {
    "passwordSha256": ""
  },
  "lockScreen": {
    "greeting": {
      "bn": "আসসালামু আলাইকুম",
      "en": "As-salamu alaykum"
    },
    "title": {
      "bn": "পাসওয়ার্ড প্রয়োজন",
      "en": "Password required"
    },
    "profileFor": {
      "bn": "ব্যক্তিগত বিনিয়োগ প্রোফাইল",
      "en": "Personal investment profile"
    },
    "subtitle": {
      "bn": "এই পাতাটি সুরক্ষিত। দেখতে সঠিক পাসওয়ার্ড দিন।",
      "en": "This page is protected. Enter the correct password to view it."
    },
    "passwordLabel": {
      "bn": "পাসওয়ার্ড",
      "en": "Password"
    },
    "placeholder": {
      "bn": "পাসওয়ার্ড লিখুন",
      "en": "Enter password"
    },
    "button": {
      "bn": "খুলুন",
      "en": "Unlock"
    },
    "wrongPassword": {
      "bn": "পাসওয়ার্ড ভুল হয়েছে। আবার চেষ্টা করুন।",
      "en": "Incorrect password. Please try again."
    },
    "contactNote": {
      "bn": "পাসওয়ার্ড পরিবর্তন বা কোনো প্রশ্ন থাকলে যোগাযোগ করুন:",
      "en": "To change the password or for any questions, contact:"
    },
    "contactEmail": "quranerfariwala@gmail.com"
  },
  "investor": {
    "photo": "",
    "monogram": {
      "bn": "",
      "en": ""
    },
    "name": {
      "bn": "",
      "en": ""
    },
    "formalName": "",
    "roles": [
      {
        "bn": "বিনিয়োগকারী",
        "en": "Investor"
      }
    ],
    "position": {
      "bn": "",
      "en": ""
    },
    "father": {
      "bn": "",
      "en": ""
    },
    "mother": {
      "bn": "",
      "en": ""
    },
    "nid": "",
    "phone": {
      "display": "",
      "tel": ""
    },
    "address": {
      "bn": "",
      "en": ""
    }
  },
  "founder": {
    "name": {
      "bn": "মোঃ জাফর আহমদ",
      "en": "Md. Jafar Ahmad"
    },
    "title": {
      "bn": "প্রতিষ্ঠাতা পরিচালক, কোরআনের ফেরিওয়ালা",
      "en": "Founder Director, Quraner Fariwala"
    }
  },
  "investment": {
    "total": 0,
    "agreementDate": "",
    "agreementTimeLabel": {
      "bn": "",
      "en": ""
    }
  },
  "returns": {
    "quantity": 0,
    "termMonths": 0,
    "retailPrice": 0,
    "wholesalePrice": 0,
    "headline": {
      "bn": "{qty} কপি কোরআন মাজীদ",
      "en": "{qty} copies of the Quran Majid"
    },
    "description": {
      "bn": "কোরআনের ফেরিওয়ালা থেকে হিফজ শিক্ষার্থীদের জন্য মুদ্রিত",
      "en": "Printed by Quraner Fariwala for Hifz students"
    }
  },
  "ledger": {
    "entries": []
  },
  "ui": {
    "summaryTitle": {
      "bn": "বিনিয়োগের সারসংক্ষেপ",
      "en": "Investment summary"
    },
    "tiles": {
      "total": {
        "bn": "মোট বিনিয়োগ",
        "en": "Total investment"
      },
      "paid": {
        "bn": "পরিশোধিত",
        "en": "Paid"
      },
      "due": {
        "bn": "বাকি",
        "en": "Remaining"
      }
    },
    "ledgerTitle": {
      "bn": "লেনদেনের ধারাবাহিকতা",
      "en": "Transaction timeline"
    },
    "counted": {
      "bn": "পরিশোধে গণ্য",
      "en": "Counted as paid"
    },
    "infoTitle": {
      "bn": "ব্যক্তিগত তথ্য",
      "en": "Personal information"
    },
    "labels": {
      "name": {
        "bn": "নাম",
        "en": "Name"
      },
      "father": {
        "bn": "পিতা",
        "en": "Father"
      },
      "mother": {
        "bn": "মাতা",
        "en": "Mother"
      },
      "nid": {
        "bn": "এনআইডি নম্বর",
        "en": "NID number"
      },
      "phone": {
        "bn": "মোবাইল",
        "en": "Mobile"
      },
      "address": {
        "bn": "ঠিকানা",
        "en": "Address"
      },
      "position": {
        "bn": "দায়িত্ব",
        "en": "Position"
      }
    },
    "agreementTitle": {
      "bn": "চুক্তি ও সিদ্ধান্ত",
      "en": "Agreement and decision"
    },
    "agreementText": {
      "bn": "{date} তারিখে {time} মোঃ জাফর আহমদের সাথে মৌখিক আলোচনার মাধ্যমে প্রাথমিক পর্যায়ে {total} বিনিয়োগের সিদ্ধান্ত হয়েছে। {term} পর বিনিয়োগকারী {qty} কপি কোরআন মাজীদ পাবেন। চুক্তিনামায় পক্ষ, পরিশোধ ও বাকির পূর্ণ বিবরণ আছে।",
      "en": "On {date}, {time}, it was decided in oral discussion with Md. Jafar Ahmad that {total} will be invested at the initial stage. After {term} the investor will receive {qty} copies of the Quran Majid. The agreement sets out the parties, payments and balance in full."
    },
    "viewContract": {
      "bn": "চুক্তিনামা দেখুন",
      "en": "View agreement"
    },
    "recordNote": {
      "bn": "এই পাতার তথ্য মৌখিক সিদ্ধান্ত ও লেনদেনের রেকর্ড হিসেবে সংরক্ষিত। কোনো তথ্যে ভুল বা আপত্তি থাকলে জানান: {email}",
      "en": "The information on this page is kept as a record of the oral decision and the transactions. If you find a mistake or have an objection, write to: {email}"
    },
    "returns": {
      "title": {
        "bn": "বিনিয়োগের বিনিময়ে প্রাপ্তি",
        "en": "Received in return"
      },
      "copies": {
        "bn": "কপি",
        "en": "copies"
      },
      "termText": {
        "bn": "{n} মাস",
        "en": "{n} month{s}"
      },
      "term": {
        "bn": "মেয়াদ",
        "en": "Term"
      },
      "delivery": {
        "bn": "ডেলিভারির সময়",
        "en": "Delivery due"
      },
      "retail": {
        "bn": "প্রতি কপি, খুচরা মূল্য",
        "en": "Per copy, retail price"
      },
      "wholesale": {
        "bn": "প্রতি কপি, পাইকারি মূল্য",
        "en": "Per copy, wholesale price"
      },
      "retailTotal": {
        "bn": "{qty} কপির খুচরা মূল্য",
        "en": "Retail value of {qty} copies"
      },
      "wholesaleTotal": {
        "bn": "{qty} কপির পাইকারি মূল্য",
        "en": "Wholesale value of {qty} copies"
      },
      "countdown": {
        "future": {
          "bn": "আর {days} দিন বাকি",
          "en": "{days} day{s} to go"
        },
        "today": {
          "bn": "নির্ধারিত দিন আজই",
          "en": "Due today"
        },
        "past": {
          "bn": "নির্ধারিত সময়ের {days} দিন পার হয়েছে",
          "en": "{days} day{s} past the due date"
        }
      }
    },
    "close": {
      "bn": "বন্ধ করুন",
      "en": "Close"
    },
    "print": {
      "bn": "প্রিন্ট / PDF",
      "en": "Print / PDF"
    },
    "switchGateway": {
      "bn": "অন্য পোর্টাল বেছে নিন",
      "en": "Choose a different portal"
    }
  },
  "contract": {
    "invocation": "بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ",
    "title": {
      "bn": "বিনিয়োগ চুক্তিনামা",
      "en": "Investment Agreement"
    },
    "subtitle": {
      "bn": "মৌখিক সিদ্ধান্তের লিখিত রেকর্ড",
      "en": "Written record of an oral decision"
    },
    "dateLabel": {
      "bn": "সিদ্ধান্তের তারিখ",
      "en": "Date of decision"
    },
    "partiesTitle": {
      "bn": "চুক্তিবদ্ধ পক্ষ",
      "en": "The parties"
    },
    "firstParty": {
      "bn": "প্রথম পক্ষ",
      "en": "First party"
    },
    "secondParty": {
      "bn": "দ্বিতীয় পক্ষ (বিনিয়োগকারী)",
      "en": "Second party (investor)"
    },
    "recital": {
      "bn": "{date} তারিখে {time} উভয় পক্ষের মধ্যে মৌখিক আলোচনার মাধ্যমে নিচের সিদ্ধান্ত গৃহীত হয়েছে। সেই সিদ্ধান্ত এই নথিতে লিপিবদ্ধ করা হলো।",
      "en": "On {date}, {time}, the following was decided between the two parties in oral discussion. That decision is recorded in this document."
    },
    "clausesTitle": {
      "bn": "লিপিবদ্ধ সিদ্ধান্ত",
      "en": "Terms recorded"
    },
    "clauses": [
      {
        "title": {
          "bn": "বিনিয়োগের পরিমাণ",
          "en": "Investment amount"
        },
        "text": {
          "bn": "দ্বিতীয় পক্ষ প্রাথমিক পর্যায়ে মোট {total} বিনিয়োগ করবেন।",
          "en": "The second party will invest a total of {total} at the initial stage."
        }
      },
      {
        "title": {
          "bn": "মেয়াদ ও বিনিময়",
          "en": "Term and return"
        },
        "text": {
          "bn": "বিনিয়োগের মেয়াদ {term}, চুক্তির তারিখ থেকে গণনা করে {delivery} পর্যন্ত। মেয়াদ শেষে প্রথম পক্ষ কোরআনের ফেরিওয়ালার পক্ষ থেকে দ্বিতীয় পক্ষকে {qty} কপি কোরআন মাজীদ প্রদান করবেন। এই কোরআন মাজীদ কোরআনের ফেরিওয়ালা থেকে হিফজ শিক্ষার্থীদের জন্য মুদ্রিত।",
          "en": "The investment term is {term}, counted from the date of the agreement up to {delivery}. At the end of the term the first party, on behalf of Quraner Fariwala, will give the second party {qty} copies of the Quran Majid, printed by Quraner Fariwala for Hifz students."
        }
      },
      {
        "title": {
          "bn": "বাজারমূল্য",
          "en": "Market value"
        },
        "text": {
          "bn": "উল্লিখিত কোরআন মাজীদের বাজারমূল্য প্রতি কপি খুচরা {retail} এবং পাইকারি {wholesale}। সেই হিসাবে {qty} কপির মূল্য খুচরায় {retailTotal} এবং পাইকারিতে {wholesaleTotal}।",
          "en": "The market price of these copies is {retail} each at retail and {wholesale} each at wholesale. On that basis {qty} copies are worth {retailTotal} at retail and {wholesaleTotal} at wholesale."
        }
      },
      {
        "title": {
          "bn": "পরিশোধ ও সমন্বয়",
          "en": "Payment and adjustment"
        },
        "text": {
          "bn": "নিচের সারণিতে উল্লিখিত পরিশোধসমূহ এবং পূর্বে দেওয়া ঋণ বিনিয়োগের পরিশোধ হিসেবে গণ্য হবে।",
          "en": "The payments and the earlier loan listed in the table below count as payment toward the investment."
        }
      },
      {
        "title": {
          "bn": "বর্তমান হিসাব",
          "en": "Current position"
        },
        "text": {
          "bn": "উপরের হিসাব অনুযায়ী মোট পরিশোধিত {paid} এবং বাকি {due}।",
          "en": "On the above, the total paid is {paid} and the balance remaining is {due}."
        }
      },
      {
        "title": {
          "bn": "অন্যান্য শর্ত",
          "en": "Other terms"
        },
        "text": {
          "bn": "এই নথিতে যা লিপিবদ্ধ হয়েছে তার বাইরের কোনো শর্ত, যেমন বাকি টাকা পরিশোধের সময়, এখানে উল্লেখ নেই। উভয় পক্ষ সম্মত হয়ে লিখিতভাবে যুক্ত করলে তা এই চুক্তিনামার অংশ হবে।",
          "en": "Terms beyond those recorded here, such as the time for paying the remaining balance, are not set out in this document. They become part of this agreement only if both parties agree and add them in writing."
        }
      }
    ],
    "paymentsTitle": {
      "bn": "পরিশোধের বিবরণ",
      "en": "Payment record"
    },
    "table": {
      "date": {
        "bn": "তারিখ",
        "en": "Date"
      },
      "detail": {
        "bn": "বিবরণ",
        "en": "Detail"
      },
      "amount": {
        "bn": "পরিমাণ",
        "en": "Amount"
      }
    },
    "signatures": {
      "line": {
        "bn": "স্বাক্ষর",
        "en": "Signature"
      },
      "witness": {
        "bn": "সাক্ষী",
        "en": "Witness"
      }
    },
    "note": {
      "bn": "এই নথি তথ্য ও রেকর্ড সংরক্ষণের জন্য। আইনগত কার্যকারিতা বা ব্যাখ্যার প্রয়োজনে যোগ্য আইনজীবীর পরামর্শ নিন।",
      "en": "This document is for information and record-keeping. For legal effect or interpretation, consult a qualified lawyer."
    }
  },
  "footer": {
    "copyright": {
      "bn": "© ২০২৬ কোরআনের ফেরিওয়ালা। সর্বস্বত্ব সংরক্ষিত।",
      "en": "© 2026 Quraner Fariwala. All rights reserved."
    },
    "tagline": {
      "bn": "পবিত্র কোরআনের গবেষণা, মুদ্রণ ও বিতরণের মাধ্যমে সমাজকে এগিয়ে নেওয়া, এমজে আহমদ",
      "en": "Empowering communities through Research, Printing & Distribution of Holy Quran, by MJ-Ahmad"
    }
  }
}
QFEOF

cat > "investor/_template/index.html" << 'QFEOF'
<!DOCTYPE html>
<html lang="bn">
<head>
  <meta charset="utf-8" />
  <title>বিনিয়োগ প্রোফাইল</title>
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <meta name="robots" content="noindex,nofollow" />
  <meta name="theme-color" content="#0a3a31" />
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Amiri:wght@400;700&family=Hind+Siliguri:wght@400;500;600;700&family=Tiro+Bangla:ital@0;1&display=swap" rel="stylesheet" />
  <style>
    :root {
      --night: #0a3a31;
      --emerald: #136b55;
      --gold: #b8892d;
      --gold-deep: #83600f;
      --gold-soft: #ead9a6;
      --lapis: #25417f;
      --bg: #f1f5f0;
      --white: #ffffff;
      --ink: #15221d;
      --muted: #586a62;
      --line: #d5ddd3;
      --parch: #f7eed4;
      --parch-line: #d9c48a;
      --serif: 'Tiro Bangla', 'Noto Serif Bengali', Georgia, serif;
      --sans: 'Hind Siliguri', 'Noto Sans Bengali', system-ui, -apple-system, 'Segoe UI', sans-serif;
      /* eight-pointed star (Rub el Hizb) used for the avatar, timeline nodes and clause numbers */
      --star: polygon(50.00% 0.00%,64.64% 14.64%,85.36% 14.64%,85.36% 35.36%,100.00% 50.00%,85.36% 64.64%,85.36% 85.36%,64.64% 85.36%,50.00% 100.00%,35.36% 85.36%,14.64% 85.36%,14.64% 64.64%,0.00% 50.00%,14.64% 35.36%,14.64% 14.64%,35.36% 14.64%);
      --lattice: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='72' height='72' viewBox='0 0 72 72'%3E%3Cg fill='none' stroke='%23ead9a6' stroke-opacity='.12' stroke-width='1.2'%3E%3Crect x='16' y='16' width='40' height='40'/%3E%3Crect x='16' y='16' width='40' height='40' transform='rotate(45 36 36)'/%3E%3C/g%3E%3C/svg%3E");
    }


    * { box-sizing: border-box; }
    html { -webkit-text-size-adjust: 100%; }
    body {
      margin: 0; background: var(--bg); color: var(--ink);
      font-family: var(--sans); font-size: 16px; line-height: 1.7;
    }
    body.noscroll { overflow: hidden; }
    h1, h2, h3, h4, p, ul, ol, dl, dd, figure { margin: 0; }
    ul, ol { padding: 0; list-style: none; }
    a { color: var(--emerald); }
    img { max-width: 100%; }
    button { font-family: inherit; }
    .hidden { display: none !important; }
    .invisible { visibility: hidden; }
    .sr-only { position: absolute; width: 1px; height: 1px; overflow: hidden; clip: rect(0 0 0 0); white-space: nowrap; }
    :focus-visible { outline: 3px solid var(--gold); outline-offset: 2px; }


    /* ---------- language switch (always visible) ---------- */
    .langbar {
      position: fixed; top: 12px; right: 12px; z-index: 90; display: flex; gap: 2px; padding: 3px;
      background: rgba(10, 58, 49, .92); border: 1px solid rgba(234, 217, 166, .5); border-radius: 999px;
    }
    .langbar button {
      border: 0; background: transparent; color: var(--gold-soft); border-radius: 999px;
      padding: 3px 12px; font-size: .9rem; cursor: pointer;
    }
    .langbar button[aria-pressed="true"] { background: var(--gold-soft); color: var(--night); font-weight: 600; }


    /* ---------- lock screen ---------- */
    #lockScreen {
      position: relative; min-height: 100vh; min-height: 100dvh; display: grid; place-items: center; padding: 72px 20px 32px;
      background: radial-gradient(120% 90% at 50% 0%, #12604e 0%, var(--night) 62%);
    }
    #lockScreen::before { content: ""; position: absolute; inset: 0; background-image: var(--lattice); pointer-events: none; }
    .lock-card {
      position: relative; width: 100%; max-width: 420px; text-align: center; background: var(--white);
      border-top: 4px solid var(--gold); border-radius: 4px; padding: 30px 24px 24px;
      box-shadow: 0 24px 60px rgba(0, 0, 0, .35);
    }
    .lock-logo { width: 56px; height: 56px; border-radius: 8px; }
    .lock-greet { margin-top: 10px; font-family: var(--serif); color: var(--gold-deep); font-size: 1.1rem; }
    .lock-card h1 { font-family: var(--serif); font-weight: 400; font-size: 1.9rem; line-height: 1.3; color: var(--night); }
    .lock-for { margin-top: 6px; font-weight: 600; }
    .lock-sub { margin-top: 4px; color: var(--muted); font-size: .95rem; }
    .lock-card input {
      width: 100%; margin-top: 18px; padding: 11px 14px; font: inherit; border: 1px solid #b9c4bb; border-radius: 4px; background: #fbfdfb;
    }
    .lock-card input:focus { border-color: var(--emerald); outline: 3px solid rgba(19, 107, 85, .25); outline-offset: 0; }
    .btn {
      display: inline-flex; align-items: center; justify-content: center; gap: 10px; border: 0; border-radius: 4px;
      padding: 12px 22px; font: 600 1.05rem var(--sans); cursor: pointer;
    }
    .btn-solid { width: 100%; margin-top: 12px; background: var(--emerald); color: #fff; }
    .btn-solid:hover { background: var(--night); }
    #lockMsg { min-height: 1.7em; margin-top: 10px; color: #a12b2b; font-size: .95rem; }
    .lock-contact { margin-top: 10px; font-size: .82rem; color: var(--muted); border-top: 1px solid var(--line); padding-top: 12px; }
    #loadError {
      position: relative; max-width: 420px; background: #fff; border-top: 4px solid #a12b2b; border-radius: 4px;
      padding: 20px; color: #7a1f1f; font-size: .95rem;
    }


    /* ---------- hero ---------- */
    .hero { position: relative; overflow: hidden; color: #fff; padding: 18px 20px 46px; background: linear-gradient(180deg, var(--night), #0e4a3e); }
    .hero::before { content: ""; position: absolute; inset: 0; background-image: var(--lattice); pointer-events: none; }
    .hero::after { content: ""; position: absolute; left: 0; right: 0; bottom: 0; height: 4px; background: linear-gradient(90deg, transparent, var(--gold), transparent); }
    .hero-inner { position: relative; max-width: 860px; margin: 0 auto; }
    .brandrow { display: inline-flex; align-items: center; gap: 10px; max-width: calc(100% - 130px); color: var(--gold-soft); text-decoration: none; font-weight: 600; line-height: 1.3; }
    .brandrow img { width: 36px; height: 36px; border-radius: 6px; background: #fff; flex: none; }
    .identity { margin-top: 26px; text-align: center; }
    .avatar { width: 136px; height: 136px; margin: 0 auto; background: var(--gold); clip-path: var(--star); display: grid; place-items: center; }
    .avatar-in { width: calc(100% - 10px); height: calc(100% - 10px); background: var(--emerald); clip-path: var(--star); display: grid; place-items: center; overflow: hidden; }
    .avatar-in img { width: 100%; height: 100%; object-fit: cover; }
    .monogram { font-family: var(--serif); font-size: 3.4rem; line-height: 1; color: var(--gold-soft); }
    .name { margin-top: 18px; font-family: var(--serif); font-weight: 400; font-size: clamp(2.4rem, 9vw, 3.8rem); line-height: 1.2; }
    .formal { margin-top: 2px; color: var(--gold-soft); letter-spacing: .14em; font-size: .95rem; }
    .roles { margin-top: 16px; display: flex; flex-wrap: wrap; justify-content: center; gap: 8px; }
    .roles li { border: 1px solid rgba(234, 217, 166, .55); color: var(--gold-soft); padding: 3px 14px; border-radius: 999px; font-size: .92rem; }


    /* ---------- main ---------- */
    main { max-width: 860px; margin: 0 auto; padding: 0 18px 56px; }
    .clockline { padding: 14px 0 2px; text-align: center; color: var(--muted); font-size: .9rem; }
    .sec { margin-top: 34px; }
    .sec > h2 { display: flex; align-items: center; gap: 14px; font-family: var(--serif); font-weight: 400; font-size: 1.65rem; line-height: 1.3; color: var(--night); }
    .sec > h2::after { content: ""; flex: 1; height: 1px; background: linear-gradient(90deg, var(--gold), transparent); }


    .sheet { margin-top: 14px; background: var(--white); border: 1px solid var(--line); border-top: 3px solid var(--gold); border-radius: 4px; padding: 22px 18px 18px; }
    .figures { display: grid; grid-template-columns: repeat(3, 1fr); gap: 12px; }
    .fig { border-top: 3px solid var(--line); padding-top: 8px; min-width: 0; }
    .fig small { display: block; color: var(--muted); font-size: .85rem; line-height: 1.4; }
    .fig strong { display: block; font-family: var(--serif); font-weight: 400; font-size: clamp(1.15rem, 4.6vw, 1.9rem); line-height: 1.35; overflow-wrap: anywhere; }
    .fig.total { border-color: var(--gold); }
    .fig.paid { border-color: var(--emerald); }
    .fig.paid strong { color: var(--emerald); }
    .fig.due { border-color: var(--lapis); }
    .fig.due strong { color: var(--lapis); }
    .bar {
      display: flex; height: 16px; margin-top: 20px; overflow: hidden; border-radius: 2px;
      background: repeating-linear-gradient(135deg, rgba(37, 65, 127, .3) 0 6px, rgba(37, 65, 127, .13) 6px 12px);
    }
    .bar-paid { width: 0; background: var(--emerald); transition: width 1.5s cubic-bezier(.2, .7, .2, 1); }
    .barcap { display: flex; justify-content: space-between; gap: 12px; margin-top: 8px; font-size: .9rem; color: var(--muted); }
    .barcap b { font-weight: 600; }
    .barcap .k-paid b { color: var(--emerald); }
    .barcap .k-due b { color: var(--lapis); }


    .ret-top { display: flex; align-items: center; gap: 18px; }
    .qty { position: relative; flex: none; width: 108px; height: 108px; display: grid; place-items: center; text-align: center; background: var(--gold); clip-path: var(--star); }
    .qty::after { content: ""; position: absolute; inset: 5px; background: var(--night); clip-path: var(--star); }
    .qty > div { position: relative; z-index: 1; }
    .qty b { display: block; font-family: var(--serif); font-weight: 400; font-size: 2.1rem; line-height: 1.1; color: var(--gold-soft); }
    .qty small { display: block; font-size: .78rem; line-height: 1.2; color: #fff; }
    .ret-text h3 { font-family: var(--serif); font-weight: 400; font-size: 1.5rem; line-height: 1.35; color: var(--night); }
    .ret-text p { margin-top: 2px; color: var(--muted); font-size: .95rem; line-height: 1.6; }
    .ret-grid { display: grid; grid-template-columns: 1fr 1fr; column-gap: 20px; margin-top: 18px; border-top: 1px solid var(--line); }
    .ret-grid > div { padding: 10px 0; border-bottom: 1px solid var(--line); min-width: 0; }
    .ret-grid dt { color: var(--muted); font-size: .82rem; line-height: 1.45; }
    .ret-grid dd { font-weight: 500; overflow-wrap: anywhere; }
    .ret-grid .sub { display: block; font-weight: 400; font-size: .85rem; color: var(--lapis); }


    .ledger { position: relative; margin-top: 18px; padding-left: 36px; }
    .ledger::before { content: ""; position: absolute; left: 11px; top: 8px; bottom: 8px; width: 2px; background: linear-gradient(var(--gold), var(--gold-soft)); }
    .entry { position: relative; padding-bottom: 24px; }
    .entry:last-child { padding-bottom: 0; }
    .node { position: absolute; left: -36px; top: 1px; width: 24px; height: 24px; background: var(--gold); clip-path: var(--star); }
    .node::after { content: ""; position: absolute; inset: 4px; background: var(--bg); clip-path: var(--star); }
    .entry.paid .node::after { background: var(--emerald); }
    .entry-head { display: flex; justify-content: space-between; align-items: baseline; gap: 12px; }
    .entry-head h4 { font-size: 1.08rem; font-weight: 600; }
    .entry-amt { font-family: var(--serif); font-size: 1.2rem; white-space: nowrap; color: var(--gold-deep); }
    .entry.paid .entry-amt { color: var(--emerald); }
    .entry-when { color: var(--muted); font-size: .9rem; }
    .entry-note { margin-top: 2px; font-size: .95rem; }
    .entry-ref { margin-top: 2px; font-size: .9rem; color: var(--muted); }
    .entry-ref b { font-weight: 600; color: var(--ink); letter-spacing: .05em; user-select: all; }
    .badge { display: inline-block; margin-top: 6px; padding: 0 10px; border-radius: 999px; font-size: .8rem; background: rgba(19, 107, 85, .1); color: var(--emerald); }


    .info { margin-top: 14px; display: grid; grid-template-columns: 1fr; border-top: 1px solid var(--line); }
    .info > div { padding: 11px 0; border-bottom: 1px solid var(--line); }
    .info dt { color: var(--muted); font-size: .85rem; }
    .info dd { font-size: 1.05rem; font-weight: 500; overflow-wrap: anywhere; }
    .info .dim { color: var(--muted); font-weight: 400; font-size: .9rem; letter-spacing: .06em; }
    @media (min-width: 640px) {
      .info { grid-template-columns: 1fr 1fr; column-gap: 36px; }
      .info .wide { grid-column: 1 / -1; }
    }


    .cta { position: relative; overflow: hidden; margin-top: 40px; padding: 28px 22px 30px; background: var(--night); color: #fff; border-radius: 4px; }
    .cta::before { content: ""; position: absolute; inset: 0; background-image: var(--lattice); pointer-events: none; }
    .cta > * { position: relative; }
    .cta h2 { font-family: var(--serif); font-weight: 400; font-size: 1.65rem; line-height: 1.3; color: var(--gold-soft); }
    .cta p { margin-top: 8px; max-width: 62ch; color: #dbe8e2; }
    .btn-gold { margin-top: 18px; background: var(--gold-soft); color: var(--night); }
    .btn-gold:hover { background: #fff; }
    .note { margin-top: 22px; font-size: .88rem; color: var(--muted); }
    .foot { padding: 22px 18px; text-align: center; background: var(--night); color: #cfe0d8; font-size: .88rem; }
    .foot p + p { margin-top: 2px; opacity: .85; }


    /* ---------- agreement viewer ---------- */
    .cv { position: fixed; inset: 0; z-index: 70; display: none; overflow-y: auto; background: radial-gradient(120% 70% at 50% 0%, #0c3a30 0%, #04170f 75%); -webkit-overflow-scrolling: touch; }
    .cv.open { display: block; animation: fade .5s ease both; }
    .cv-bar { position: sticky; top: 0; z-index: 2; display: flex; gap: 8px; padding: 10px 12px; padding-right: 130px; background: rgba(4, 23, 15, .96); }
    .tb { border: 1px solid rgba(234, 217, 166, .45); background: rgba(255, 255, 255, .08); color: var(--gold-soft); border-radius: 4px; padding: 6px 14px; font: 500 .95rem var(--sans); cursor: pointer; }
    .tb:hover { background: rgba(255, 255, 255, .16); }


    .paper {
      position: relative; width: calc(100% - 24px); max-width: 780px; margin: 16px auto 48px; padding: 38px 22px 34px;
      color: #2b2414; border: 1px solid var(--parch-line); box-shadow: 0 30px 80px rgba(0, 0, 0, .55);
      background: radial-gradient(circle at 18% 8%, rgba(255, 255, 255, .6), transparent 55%), var(--parch);
      animation: paper-in 1s cubic-bezier(.2, .7, .2, 1) both;
    }
    .paper::before { content: ""; position: absolute; inset: 8px; border: 1px solid var(--gold); pointer-events: none; }
    .paper::after { content: ""; position: absolute; inset: 12px; border: 1px solid rgba(184, 137, 45, .4); pointer-events: none; }
    @media (min-width: 700px) { .paper { padding: 58px 60px 50px; } }


    .reveal { opacity: 0; animation: rise .8s cubic-bezier(.2, .7, .2, 1) forwards; animation-delay: calc(var(--i) * .16s + .55s); }
    @keyframes fade { from { opacity: 0; } to { opacity: 1; } }
    @keyframes paper-in { from { opacity: 0; transform: translateY(46px) scale(.96); } to { opacity: 1; transform: none; } }
    @keyframes rise { from { opacity: 0; transform: translateY(16px); } to { opacity: 1; transform: none; } }
    @keyframes draw { to { stroke-dashoffset: 0; } }
    @keyframes stamp {
      0% { opacity: 0; transform: scale(2.4) rotate(-26deg); }
      55% { opacity: .95; }
      100% { opacity: .9; transform: scale(1) rotate(-8deg); }
    }


    .invocation { text-align: center; font-family: 'Amiri', 'Noto Naskh Arabic', serif; font-size: 2rem; line-height: 1.8; color: var(--night); }
    .orn svg { display: block; width: 240px; max-width: 100%; height: 20px; margin: 4px auto 0; overflow: visible; }
    .orn path { fill: none; stroke: var(--gold); stroke-width: 1.5; stroke-dasharray: 1; stroke-dashoffset: 1; animation: draw 1.4s ease forwards; animation-delay: calc(var(--i) * .16s + .7s); }
    .orn polygon { fill: var(--gold); }
    .c-brand { display: flex; align-items: center; justify-content: center; gap: 10px; margin-top: 14px; color: var(--gold-deep); font-weight: 600; }
    .c-brand img { width: 30px; height: 30px; border-radius: 5px; background: #fff; }
    .c-title { margin-top: 10px; text-align: center; }
    .c-title h2 { font-family: var(--serif); font-weight: 400; font-size: clamp(1.9rem, 6vw, 2.6rem); line-height: 1.3; color: var(--night); }
    .c-title p { color: #7b6a3c; }
    .c-date { margin-top: 12px; text-align: center; }
    .c-h { margin-top: 26px; font-family: var(--serif); font-weight: 400; font-size: 1.35rem; color: var(--night); border-bottom: 1px solid var(--parch-line); padding-bottom: 4px; }
    .parties { display: grid; gap: 14px; margin-top: 14px; }
    @media (min-width: 640px) { .parties { grid-template-columns: 1fr 1fr; } }
    .party { border: 1px solid var(--parch-line); background: rgba(255, 255, 255, .38); padding: 14px 16px; }
    .party h4 { margin-bottom: 4px; font-family: var(--serif); font-weight: 400; font-size: 1.05rem; color: var(--gold-deep); }
    .pname { font-size: 1.15rem; font-weight: 600; }
    .prole { font-size: .92rem; color: #5b4d27; }
    .party dl { display: grid; grid-template-columns: auto 1fr; gap: 2px 12px; margin-top: 8px; font-size: .92rem; }
    .party dt { color: #7b6a3c; }
    .party dd { overflow-wrap: anywhere; }
    .recital { margin-top: 20px; }
    .clauses { display: grid; gap: 16px; margin-top: 16px; }
    .clauses li { display: grid; grid-template-columns: 36px 1fr; gap: 12px; align-items: start; }
    .cn { width: 36px; height: 36px; display: grid; place-items: center; background: var(--gold); clip-path: var(--star); font-weight: 600; font-size: .85rem; color: #2b2414; }
    .clauses h4 { font-family: var(--serif); font-weight: 400; font-size: 1.12rem; color: var(--night); }
    table.pay { width: 100%; margin-top: 12px; border-collapse: collapse; font-size: .95rem; }
    .pay th { text-align: left; padding: 6px; border-bottom: 2px solid var(--gold); color: var(--gold-deep); font-weight: 600; }
    .pay td { padding: 8px 6px; border-bottom: 1px solid var(--parch-line); vertical-align: top; }
    .pay .num { text-align: right; white-space: nowrap; }
    .pay small { display: block; color: #6b5c30; }
    .pay tr.sum td { font-weight: 600; }
    .pay tr.due td { font-family: var(--serif); font-weight: 400; font-size: 1.15rem; color: var(--lapis); border-bottom: 3px double var(--gold); }
    .signs { display: grid; gap: 26px; margin-top: 38px; }
    @media (min-width: 640px) { .signs { grid-template-columns: repeat(3, 1fr); gap: 22px; } }
    .sign .line { height: 44px; border-bottom: 1px solid #2b2414; }
    .sign small { display: block; color: #7b6a3c; line-height: 1.4; }
    .sign b { display: block; margin-top: 4px; line-height: 1.4; }
    .seal {
      position: relative; width: 122px; height: 122px; margin: 28px auto 0; display: grid; place-items: center; padding: 12px;
      text-align: center; border: 3px double var(--emerald); border-radius: 50%; color: var(--emerald);
      font-family: var(--serif); line-height: 1.2; opacity: 0; transform: rotate(-8deg);
      animation: stamp .55s cubic-bezier(.3, 1.5, .5, 1) forwards; animation-delay: calc(var(--i) * .16s + .55s);
    }
    .seal::before { content: ""; position: absolute; inset: 6px; border: 1px solid var(--emerald); border-radius: 50%; }
    .seal i { display: block; font-style: normal; font-size: .9rem; }
    .c-note { margin-top: 24px; text-align: center; font-size: .85rem; color: #6b5c30; }
    .paper, .seal { -webkit-print-color-adjust: exact; print-color-adjust: exact; }


    @media (prefers-reduced-motion: reduce) {
      .cv.open, .paper, .reveal, .orn path { animation: none !important; opacity: 1 !important; transform: none !important; stroke-dashoffset: 0 !important; }
      .seal { animation: none !important; opacity: .9 !important; transform: rotate(-8deg) !important; }
      .bar-paid { transition: none; }
    }


    @media print {
      body { background: #fff; }
      #lockScreen, #app, .langbar, .cv-bar { display: none !important; }
      .cv { position: static; display: block; overflow: visible; background: none; animation: none; }
      .paper { width: auto; max-width: none; margin: 0; box-shadow: none; }
      .cv.open, .paper, .reveal, .orn path { animation: none !important; opacity: 1 !important; transform: none !important; stroke-dashoffset: 0 !important; }
      .seal { animation: none !important; opacity: .9 !important; transform: rotate(-8deg) !important; }
      @page { margin: 12mm; }
    }
    .switch { display: flex; width: fit-content; margin-top: 14px; padding: 6px 16px; border: 1px solid var(--gold-soft); border-radius: 999px; background: rgba(234, 217, 166, .12); color: var(--gold-soft); text-decoration: none; font-weight: 600; font-size: .95rem; }
    .switch:hover { background: var(--gold-soft); color: var(--night); }
  </style>
</head>
<body>


  <!--
    Everything shown on this page comes from data.json.
      data-bind="path"          sets the element text
      data-bind-href / -src / -alt / -placeholder / -aria-label   set that attribute
      data-prefix="tel:"        optional prefix for the attribute value
  -->


  <div class="langbar" role="group" aria-label="Language">
    <button id="langBn" type="button" onclick="setLang('bn')" aria-pressed="true">বাংলা</button>
    <button id="langEn" type="button" onclick="setLang('en')" aria-pressed="false">EN</button>
  </div>


  <!-- LOCK SCREEN -->
  <div id="lockScreen">
    <div id="lockCard" class="lock-card invisible">
      <img class="lock-logo" data-bind-src="site.logo" data-bind-alt="site.logoAlt" alt="" />
      <p class="lock-greet" data-bind="lockScreen.greeting"></p>
      <h1 data-bind="lockScreen.title"></h1>
      <p class="lock-for" data-bind="lockScreen.profileFor"></p>
      <p class="lock-sub" data-bind="lockScreen.subtitle"></p>


      <label for="passwordInput" class="sr-only" data-bind="lockScreen.passwordLabel"></label>
      <input id="passwordInput" type="password" autocomplete="current-password" data-bind-placeholder="lockScreen.placeholder" />
      <button id="unlockBtn" type="button" class="btn btn-solid" onclick="unlock()" data-bind="lockScreen.button"></button>
      <p id="lockMsg" role="alert"></p>
      <p class="lock-contact"><span data-bind="lockScreen.contactNote"></span> <strong data-bind="lockScreen.contactEmail"></strong></p>
    </div>
    <div id="loadError" class="hidden" role="alert"></div>
  </div>


  <!-- PROFILE (shown after unlock) -->
  <div id="app" class="hidden">
    <header class="hero">
      <div class="hero-inner">
        <a class="brandrow" data-bind-href="site.homeUrl">
          <img data-bind-src="site.logo" data-bind-alt="site.logoAlt" alt="" />
          <span data-bind="site.brand"></span>
        </a>
        <a class="switch" data-bind-href="site.gatewayUrl" data-bind="ui.switchGateway"></a>


        <div class="identity">
          <div class="avatar"><div class="avatar-in" id="avatarInner"></div></div>
          <h1 class="name" data-bind="investor.name"></h1>
          <p class="formal" data-bind="investor.formalName"></p>
          <ul class="roles" id="roles"></ul>
        </div>
      </div>
    </header>


    <main>
      <p class="clockline"><span data-bind="site.clockLabel"></span>: <time id="clock"></time></p>


      <section class="sec">
        <h2 data-bind="ui.summaryTitle"></h2>
        <div class="sheet">
          <div class="figures">
            <div class="fig total"><small data-bind="ui.tiles.total"></small><strong id="figTotal"></strong></div>
            <div class="fig paid"><small data-bind="ui.tiles.paid"></small><strong id="figPaid"></strong></div>
            <div class="fig due"><small data-bind="ui.tiles.due"></small><strong id="figDue"></strong></div>
          </div>
          <div class="bar" id="bar" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
            <div class="bar-paid" id="barPaid"></div>
          </div>
          <div class="barcap">
            <span class="k-paid"><b id="pctPaid"></b> <span data-bind="ui.tiles.paid"></span></span>
            <span class="k-due"><b id="pctDue"></b> <span data-bind="ui.tiles.due"></span></span>
          </div>
        </div>
      </section>


      <section class="sec">
        <h2 data-bind="ui.returns.title"></h2>
        <div class="sheet">
          <div class="ret-top">
            <div class="qty"><div><b id="retQty"></b><small data-bind="ui.returns.copies"></small></div></div>
            <div class="ret-text">
              <h3 data-bind="returns.headline"></h3>
              <p data-bind="returns.description"></p>
            </div>
          </div>
          <dl class="ret-grid" id="retGrid"></dl>
        </div>
      </section>


      <section class="sec">
        <h2 data-bind="ui.ledgerTitle"></h2>
        <ol class="ledger" id="ledger"></ol>
      </section>


      <section class="sec">
        <h2 data-bind="ui.infoTitle"></h2>
        <dl class="info">
          <div class="wide"><dt data-bind="ui.labels.name"></dt><dd><span data-bind="investor.name"></span> <span class="dim" data-bind="investor.formalName"></span></dd></div>
          <div><dt data-bind="ui.labels.father"></dt><dd data-bind="investor.father"></dd></div>
          <div><dt data-bind="ui.labels.mother"></dt><dd data-bind="investor.mother"></dd></div>
          <div><dt data-bind="ui.labels.nid"></dt><dd data-bind="investor.nid"></dd></div>
          <div><dt data-bind="ui.labels.phone"></dt><dd><a data-bind="investor.phone.display" data-bind-href="investor.phone.tel" data-prefix="tel:"></a></dd></div>
          <div class="wide"><dt data-bind="ui.labels.position"></dt><dd data-bind="investor.position"></dd></div>
          <div class="wide"><dt data-bind="ui.labels.address"></dt><dd data-bind="investor.address"></dd></div>
        </dl>
      </section>


      <section class="cta">
        <h2 data-bind="ui.agreementTitle"></h2>
        <p data-bind="ui.agreementText"></p>
        <button type="button" class="btn btn-gold" onclick="openContract()">
          <span aria-hidden="true">📜</span><span data-bind="ui.viewContract"></span>
        </button>
      </section>


      <p class="note" data-bind="ui.recordNote"></p>
    </main>


    <footer class="foot">
      <p data-bind="footer.copyright"></p>
      <p data-bind="footer.tagline"></p>
    </footer>
  </div>


  <!-- AGREEMENT VIEWER -->
  <div id="contractView" class="cv" role="dialog" aria-modal="true" data-bind-aria-label="contract.title">
    <div class="cv-bar">
      <button id="cvClose" type="button" class="tb" onclick="closeContract()"><span aria-hidden="true">✕ </span><span data-bind="ui.close"></span></button>
      <button type="button" class="tb" onclick="window.print()"><span aria-hidden="true">🖨 </span><span data-bind="ui.print"></span></button>
    </div>
    <article class="paper" id="paper"></article>
  </div>


  <script>
    // ------------------------------------------------------------------
    // Data
    // ------------------------------------------------------------------
    const DATA_URL = 'data.json';
    let DATA = null;
    let LANG = 'bn';
    let TZ = 'Asia/Dhaka';
    let CV_OPEN = false;
    let lastFocus = null;
    let clockTimer = null;


    const $ = (id) => document.getElementById(id);
    const get = (path) => path.split('.').reduce((o, k) => (o == null ? undefined : o[k]), DATA);
    // plain value: same in every language. {bn, en} object: current language.
    const tr = (v) => (v !== null && typeof v === 'object') ? (v[LANG] ?? v.en ?? v.bn ?? '') : (v ?? '');
    const T = (path) => tr(get(path));
    const fill = (tpl, vars) => String(tpl).replace(/\{(\w+)\}/g, (_, k) => (k in vars ? vars[k] : ''));


    // ------------------------------------------------------------------
    // Formatting (Bengali digits in Bengali mode)
    // ------------------------------------------------------------------
    const LOC = () => LANG === 'bn'
      ? { num: 'bn-BD', date: 'bn-BD', time: 'bn-BD' }
      : { num: 'en-US', date: 'en-GB', time: 'en-US' };
    const nfmt = (n) => new Intl.NumberFormat(LOC().num, { maximumFractionDigits: 2 }).format(n);
    const money = (n) => `${DATA.site.currencySymbol} ${nfmt(n)}`;
    const moneyWords = (n) => {
      const w = tr(DATA.site.currencyWord);
      return LANG === 'bn' ? `${nfmt(n)} ${w}` : `${w} ${nfmt(n)}`;
    };
    const hasTime = (s) => String(s).includes('T');
    const when = (s) => new Date(hasTime(s) ? s : s + 'T12:00:00+06:00');
    const fmtDate = (d) => new Intl.DateTimeFormat(LOC().date, { timeZone: TZ, day: 'numeric', month: 'long', year: 'numeric' }).format(d);
    // Bengali reads time as "রাত ৯:৪০"; English as "9:40 PM"
    const bnPeriod = (h) => h >= 4 && h < 6 ? 'ভোর' : h >= 6 && h < 12 ? 'সকাল' : h >= 12 && h < 15 ? 'দুপুর' : h >= 15 && h < 18 ? 'বিকাল' : h >= 18 && h < 20 ? 'সন্ধ্যা' : 'রাত';
    function fmtTime(d, withSeconds) {
      if (LANG === 'bn') {
        const p = {};
        new Intl.DateTimeFormat('en-US', { timeZone: TZ, hour: 'numeric', minute: 'numeric', second: 'numeric', hourCycle: 'h23' })
          .formatToParts(d).forEach(x => { p[x.type] = x.value; });
        const hr = Number(p.hour) % 24;
        const two = new Intl.NumberFormat('bn-BD', { minimumIntegerDigits: 2, useGrouping: false });
        return `${bnPeriod(hr)} ${nfmt(hr % 12 || 12)}:${two.format(Number(p.minute))}` + (withSeconds ? ':' + two.format(Number(p.second)) : '');
      }
      return new Intl.DateTimeFormat('en-US', { timeZone: TZ, hour: 'numeric', minute: '2-digit', ...(withSeconds ? { second: '2-digit' } : {}), hour12: true }).format(d);
    }
    const whenText = (e) => {
      const d = when(e.date);
      const t = e.timeLabel ? tr(e.timeLabel) : (hasTime(e.date) ? fmtTime(d) : '');
      return fmtDate(d) + (t ? ', ' + t : '');
    };
    const refsOf = (e) => [].concat(e.references || e.reference || []);
    const entryAmount = (e) => (e.amountFrom ? get(e.amountFrom) : e.amount);


    function totals() {
      const total = Number(DATA.investment.total) || 0;
      const paid = DATA.ledger.entries.filter(e => e.countsAsPaid).reduce((s, e) => s + (Number(entryAmount(e)) || 0), 0);
      const due = Math.max(total - paid, 0);
      const pct = total > 0 ? Math.min((paid / total) * 100, 100) : 0;
      return { total, paid, due, pct };
    }


    // agreement date + N months (day is clamped to the month length)
    function addMonths(dateStr, n) {
      const [y, m, d] = dateStr.slice(0, 10).split('-').map(Number);
      const idx = (m - 1) + n;
      const ny = y + Math.floor(idx / 12), nm = ((idx % 12) + 12) % 12;
      const last = new Date(Date.UTC(ny, nm + 1, 0)).getUTCDate();
      return `${ny}-${String(nm + 1).padStart(2, '0')}-${String(Math.min(d, last)).padStart(2, '0')}`;
    }
    const plural = (n) => (LANG === 'en' && n !== 1 ? 's' : '');
    const dueDate = () => when(addMonths(DATA.investment.agreementDate, Number(DATA.returns.termMonths) || 0));
    const termText = () => {
      const n = Number(DATA.returns.termMonths) || 0;
      return fill(T('ui.returns.termText'), { n: nfmt(n), s: plural(n) });
    };
    // whole calendar days (Dhaka) from today until the given date
    const dayNo = (d) => {
      const p = {};
      new Intl.DateTimeFormat('en-US', { timeZone: TZ, year: 'numeric', month: 'numeric', day: 'numeric' }).formatToParts(d).forEach(x => { p[x.type] = x.value; });
      return Date.UTC(Number(p.year), Number(p.month) - 1, Number(p.day)) / 86400000;
    };


    function vars() {
      const t = totals(), R = DATA.returns;
      return {
        total: moneyWords(t.total), paid: moneyWords(t.paid), due: moneyWords(t.due),
        date: fmtDate(when(DATA.investment.agreementDate)),
        time: tr(DATA.investment.agreementTimeLabel),
        email: DATA.lockScreen.contactEmail,
        qty: nfmt(R.quantity), term: termText(), delivery: fmtDate(dueDate()),
        retail: moneyWords(R.retailPrice), wholesale: moneyWords(R.wholesalePrice),
        retailTotal: moneyWords(R.quantity * R.retailPrice),
        wholesaleTotal: moneyWords(R.quantity * R.wholesalePrice)
      };
    }
    const TT = (path) => fill(T(path), vars());


    // Small DOM helper (all data goes in as text, never as HTML)
    function h(tag, attrs, ...kids) {
      const el = document.createElement(tag);
      Object.entries(attrs || {}).forEach(([k, v]) => {
        if (v === false || v == null) return;
        if (k === 'class') el.className = v; else el.setAttribute(k, v === true ? '' : v);
      });
      kids.flat().forEach(k => {
        if (k == null || k === false) return;
        el.append(k instanceof Node ? k : document.createTextNode(String(k)));
      });
      return el;
    }


    // ------------------------------------------------------------------
    // Rendering
    // ------------------------------------------------------------------
    const BIND_ATTRS = ['href', 'src', 'alt', 'placeholder', 'aria-label'];


    function applyBindings() {
      document.querySelectorAll('[data-bind]').forEach(el => { el.textContent = TT(el.getAttribute('data-bind')); });
      BIND_ATTRS.forEach(attr => {
        document.querySelectorAll('[data-bind-' + attr + ']').forEach(el => {
          const prefix = el.getAttribute('data-prefix') || '';
          el.setAttribute(attr, prefix + TT(el.getAttribute('data-bind-' + attr)));
        });
      });
      document.title = TT('site.title');
    }


    function renderHero() {
      const av = $('avatarInner');
      av.textContent = '';
      if (DATA.investor.photo) av.append(h('img', { src: DATA.investor.photo, alt: T('investor.name') }));
      else av.append(h('span', { class: 'monogram' }, T('investor.monogram')));


      const ul = $('roles');
      ul.textContent = '';
      (DATA.investor.roles || []).forEach(r => ul.append(h('li', {}, tr(r))));
    }


    function renderSummary() {
      const t = totals();
      $('figTotal').textContent = money(t.total);
      $('figPaid').textContent = money(t.paid);
      $('figDue').textContent = money(t.due);
      $('pctPaid').textContent = nfmt(t.pct) + '%';
      $('pctDue').textContent = nfmt(100 - t.pct) + '%';
      $('bar').setAttribute('aria-valuenow', String(Math.round(t.pct)));
    }


    function animateBar() {
      const bar = $('barPaid');
      bar.style.width = '0%';
      requestAnimationFrame(() => requestAnimationFrame(() => { bar.style.width = totals().pct + '%'; }));
    }


    function renderLedger() {
      const ol = $('ledger');
      ol.textContent = '';
      DATA.ledger.entries.forEach(e => {
        const paid = !!e.countsAsPaid;
        ol.append(h('li', { class: 'entry kind-' + e.type + (paid ? ' paid' : '') },
          h('span', { class: 'node', 'aria-hidden': 'true' }),
          h('div', { class: 'entry-head' },
            h('h4', {}, tr(e.title)),
            h('span', { class: 'entry-amt' }, (paid ? '+ ' : '') + money(entryAmount(e)))),
          h('p', { class: 'entry-when' }, whenText(e)),
          h('p', { class: 'entry-note' }, fill(tr(e.note), vars())),
          ...refsOf(e).map(r => h('p', { class: 'entry-ref' }, tr(r.label) + ': ', h('b', {}, r.value))),
          paid ? h('span', { class: 'badge' }, T('ui.counted')) : null));
      });
    }


    function updateCountdown() {
      const el = $('retCountdown');
      if (!el) return;
      const left = dayNo(dueDate()) - dayNo(new Date());
      const key = left > 0 ? 'future' : left === 0 ? 'today' : 'past';
      const n = Math.abs(left);
      el.textContent = fill(T('ui.returns.countdown.' + key), { days: nfmt(n), s: plural(n) });
    }


    function renderReturns() {
      const R = DATA.returns, v = vars(), L = (k) => fill(T('ui.returns.' + k), v);
      $('retQty').textContent = nfmt(R.quantity);
      const item = (label, value, extra) => h('div', {}, h('dt', {}, label), h('dd', {}, value, extra || null));
      const grid = $('retGrid');
      grid.textContent = '';
      grid.append(
        item(L('term'), v.term),
        item(L('delivery'), v.delivery, h('span', { class: 'sub', id: 'retCountdown' })),
        item(L('retail'), money(R.retailPrice)),
        item(L('wholesale'), money(R.wholesalePrice)),
        item(L('retailTotal'), money(R.quantity * R.retailPrice)),
        item(L('wholesaleTotal'), money(R.quantity * R.wholesalePrice)));
      updateCountdown();
    }


    // Static ornament (no data in it)
    const ORN_SVG =
      '<svg viewBox="0 0 300 24" aria-hidden="true" focusable="false">' +
      '<path d="M4 12H132" pathLength="1"/><path d="M168 12H296" pathLength="1"/>' +
      '<polygon points="150.00,2.00 152.93,4.93 157.07,4.93 157.07,9.07 160.00,12.00 157.07,14.93 157.07,19.07 152.93,19.07 150.00,22.00 147.07,19.07 142.93,19.07 142.93,14.93 140.00,12.00 142.93,9.07 142.93,4.93 147.07,4.93"/>' +
      '</svg>';


    function renderContract() {
      const C = DATA.contract, inv = DATA.investor, fo = DATA.founder, L = DATA.ui.labels;
      const v = vars(), t = totals();
      const paper = $('paper');
      paper.textContent = '';


      let i = 0;                                    // order of the reveal sequence
      const R = (el) => { el.classList.add('reveal'); el.style.setProperty('--i', i++); return el; };
      const row = (dt, dd) => [h('dt', {}, dt), h('dd', {}, dd)];


      if (C.invocation) paper.append(R(h('p', { class: 'invocation', lang: 'ar', dir: 'rtl' }, C.invocation)));


      const orn = h('div', { class: 'orn' });
      orn.innerHTML = ORN_SVG;
      paper.append(R(orn));


      paper.append(R(h('div', { class: 'c-brand' }, h('img', { src: DATA.site.logo, alt: '' }), h('span', {}, T('site.brand')))));
      paper.append(R(h('div', { class: 'c-title' }, h('h2', {}, T('contract.title')), h('p', {}, T('contract.subtitle')))));
      paper.append(R(h('p', { class: 'c-date' }, h('b', {}, T('contract.dateLabel') + ': '), v.date + ', ' + v.time)));


      paper.append(R(h('h3', { class: 'c-h' }, T('contract.partiesTitle'))));
      paper.append(R(h('div', { class: 'parties' },
        h('div', { class: 'party' },
          h('h4', {}, T('contract.firstParty')),
          h('p', { class: 'pname' }, T('founder.name')),
          h('p', { class: 'prole' }, T('founder.title'))),
        h('div', { class: 'party' },
          h('h4', {}, T('contract.secondParty')),
          h('p', { class: 'pname' }, T('investor.name') + ' (' + inv.formalName + ')'),
          h('dl', {},
            ...row(tr(L.father), T('investor.father')),
            ...row(tr(L.mother), T('investor.mother')),
            ...row(tr(L.nid), inv.nid),
            ...row(tr(L.phone), inv.phone.display),
            ...row(tr(L.position), T('investor.position')),
            ...row(tr(L.address), T('investor.address')))))));


      paper.append(R(h('p', { class: 'recital' }, fill(T('contract.recital'), v))));


      paper.append(R(h('h3', { class: 'c-h' }, T('contract.clausesTitle'))));
      paper.append(h('ol', { class: 'clauses' }, ...C.clauses.map((c, idx) =>
        R(h('li', {},
          h('span', { class: 'cn' }, nfmt(idx + 1)),
          h('div', {}, h('h4', {}, tr(c.title)), h('p', {}, fill(tr(c.text), v))))))));


      paper.append(R(h('h3', { class: 'c-h' }, T('contract.paymentsTitle'))));
      const sumRow = (label, val, cls) => h('tr', { class: 'sum ' + cls }, h('td', { colspan: '2' }, label), h('td', { class: 'num' }, val));
      paper.append(R(h('table', { class: 'pay' },
        h('thead', {}, h('tr', {},
          h('th', {}, T('contract.table.date')), h('th', {}, T('contract.table.detail')), h('th', { class: 'num' }, T('contract.table.amount')))),
        h('tbody', {}, ...DATA.ledger.entries.filter(e => e.countsAsPaid).map(e =>
          h('tr', {},
            h('td', {}, whenText(e)),
            h('td', {}, h('b', {}, tr(e.title)), h('small', {}, fill(tr(e.note), vars())),
              ...refsOf(e).map(r => h('small', {}, tr(r.label) + ': ' + r.value))),
            h('td', { class: 'num' }, money(entryAmount(e)))))),
        h('tfoot', {},
          sumRow(T('ui.tiles.total'), money(t.total), 'total'),
          sumRow(T('ui.tiles.paid'), money(t.paid), 'paid'),
          sumRow(T('ui.tiles.due'), money(t.due), 'due')))));


      const sign = (label, name, role) => h('div', { class: 'sign' },
        h('div', { class: 'line' }), h('small', {}, label),
        name ? h('b', {}, name) : null, role ? h('small', {}, role) : null);
      paper.append(R(h('div', { class: 'signs' },
        sign(T('contract.signatures.line'), T('founder.name'), T('contract.firstParty')),
        sign(T('contract.signatures.line'), T('investor.name'), T('contract.secondParty')),
        sign(T('contract.signatures.witness'), '', ''))));


      const seal = h('div', { class: 'seal', 'aria-hidden': 'true' }, h('div', {}, h('b', {}, T('site.brand')), h('i', {}, '✦')));
      seal.style.setProperty('--i', i++);
      paper.append(seal);


      paper.append(R(h('p', { class: 'c-note' }, T('contract.note'))));
    }


    function openContract() {
      lastFocus = document.activeElement;
      renderContract();
      const cv = $('contractView');
      cv.scrollTop = 0;
      cv.classList.add('open');
      CV_OPEN = true;
      $('app').inert = true;
      document.body.classList.add('noscroll');
      $('cvClose').focus();
    }


    function closeContract() {
      $('contractView').classList.remove('open');
      CV_OPEN = false;
      $('app').inert = false;
      document.body.classList.remove('noscroll');
      if (lastFocus && lastFocus.focus) lastFocus.focus();
    }


    // ------------------------------------------------------------------
    // Clock, language
    // ------------------------------------------------------------------
    function tickClock() {
      if (!DATA) return;
      const now = new Date();
      $('clock').textContent = fmtDate(now) + ', ' + fmtTime(now, true);
      updateCountdown();
    }


    function setLang(lang) {
      if (!DATA) return;
      LANG = lang === 'en' ? 'en' : 'bn';
      document.documentElement.lang = LANG;
      $('langBn').setAttribute('aria-pressed', String(LANG === 'bn'));
      $('langEn').setAttribute('aria-pressed', String(LANG === 'en'));
      applyBindings();
      renderHero();
      renderSummary();
      renderReturns();
      renderLedger();
      if (CV_OPEN) renderContract();
      tickClock();
    }


    // ------------------------------------------------------------------
    // Password (client-side only): SHA-256 of the input vs data.json
    // ------------------------------------------------------------------
    async function sha256Hex(text) {
      const buf = await crypto.subtle.digest('SHA-256', new TextEncoder().encode(text));
      return Array.from(new Uint8Array(buf)).map(b => b.toString(16).padStart(2, '0')).join('');
    }


    async function unlock() {
      if (!DATA) return;
      const msg = $('lockMsg');
      let ok = false;
      try {
        const hash = await sha256Hex($('passwordInput').value);
        ok = hash === String(DATA.security.passwordSha256 || '').toLowerCase();
      } catch (e) {
        msg.textContent = 'Password check needs HTTPS or localhost.';
        return;
      }
      if (!ok) { msg.textContent = T('lockScreen.wrongPassword'); return; }


      msg.textContent = '';
      $('passwordInput').value = '';
      $('lockScreen').classList.add('hidden');
      $('app').classList.remove('hidden');
      window.scrollTo(0, 0);
      animateBar();
    }


    // ------------------------------------------------------------------
    // Start
    // ------------------------------------------------------------------
    $('passwordInput').addEventListener('keydown', (e) => { if (e.key === 'Enter') unlock(); });
    document.addEventListener('keydown', (e) => { if (e.key === 'Escape' && CV_OPEN) closeContract(); });


    (async function init() {
      try {
        const res = await fetch(DATA_URL, { cache: 'no-store' });
        if (!res.ok) throw new Error('HTTP ' + res.status);
        DATA = await res.json();
      } catch (err) {
        $('lockCard').classList.add('hidden');
        const box = $('loadError');
        box.textContent = 'Could not load ' + DATA_URL + ' (' + err.message + '). ' +
          'Keep it in the same folder as this page and open the page through a web server, not by double-clicking the file.';
        box.classList.remove('hidden');
        return;
      }
      TZ = DATA.site.timezone || 'Asia/Dhaka';
      setLang(DATA.site.defaultLang || 'bn');
      $('lockCard').classList.remove('invisible');
      clockTimer = setInterval(tickClock, 1000);
    })();
  </script>
</body>
</html>
QFEOF

cat > "investor/alamin/data.json" << 'QFEOF'
{
  "_readme": "শুধু মান বদলান, কাঠামো নয়। {\"bn\":…, \"en\":…} মানে ভাষাভেদে আলাদা লেখা; সাধারণ স্ট্রিং দুই ভাষাতেই একই দেখায়। লেখার ভেতরে {total} {paid} {due} {date} {time} {email} নিজে থেকে বসে যায়। পরিশোধিত, বাকি ও শতাংশ হিসাব হয় investment.total এবং ledger.entries (countsAsPaid: true) থেকে, আলাদা করে লিখতে হয় না।",
  "site": {
    "title": {
      "bn": "হাফেজ আল আমিনের বিনিয়োগ প্রোফাইল",
      "en": "Investor profile of Hafez Al Amin"
    },
    "brand": {
      "bn": "কোরআনের ফেরিওয়ালা",
      "en": "Quraner Fariwala"
    },
    "logo": "https://mj-ahmad.github.io/qf/assets/logo.png",
    "logoAlt": {
      "bn": "কোরআনের ফেরিওয়ালার লোগো",
      "en": "Quraner Fariwala logo"
    },
    "homeUrl": "/qf/home/index.html",
    "defaultLang": "bn",
    "timezone": "Asia/Dhaka",
    "currencySymbol": "৳",
    "currencyWord": {
      "bn": "টাকা",
      "en": "Tk."
    },
    "clockLabel": {
      "bn": "বাংলাদেশ সময়",
      "en": "Bangladesh time"
    },
    "gatewayUrl": "../../"
  },
  "security": {
    "passwordSha256": "b446ac390294fae2f8a54c5f111769d84cf2755b1de5486338a92aa37dd8f1bf"
  },
  "lockScreen": {
    "greeting": {
      "bn": "আসসালামু আলাইকুম",
      "en": "As-salamu alaykum"
    },
    "title": {
      "bn": "পাসওয়ার্ড প্রয়োজন",
      "en": "Password required"
    },
    "profileFor": {
      "bn": "হাফেজ আল আমিনের ব্যক্তিগত বিনিয়োগ প্রোফাইল",
      "en": "Personal investment profile of Hafez Al Amin"
    },
    "subtitle": {
      "bn": "এই পাতাটি সুরক্ষিত। দেখতে সঠিক পাসওয়ার্ড দিন।",
      "en": "This page is protected. Enter the correct password to view it."
    },
    "passwordLabel": {
      "bn": "পাসওয়ার্ড",
      "en": "Password"
    },
    "placeholder": {
      "bn": "পাসওয়ার্ড লিখুন",
      "en": "Enter password"
    },
    "button": {
      "bn": "খুলুন",
      "en": "Unlock"
    },
    "wrongPassword": {
      "bn": "পাসওয়ার্ড ভুল হয়েছে। আবার চেষ্টা করুন।",
      "en": "Incorrect password. Please try again."
    },
    "contactNote": {
      "bn": "পাসওয়ার্ড পরিবর্তন বা কোনো প্রশ্ন থাকলে যোগাযোগ করুন:",
      "en": "To change the password or for any questions, contact:"
    },
    "contactEmail": "quranerfariwala@gmail.com"
  },
  "investor": {
    "photo": "",
    "monogram": {
      "bn": "আ",
      "en": "A"
    },
    "name": {
      "bn": "হাফেজ আল আমিন",
      "en": "Hafez Al Amin"
    },
    "formalName": "MD AL AMIN",
    "roles": [
      {
        "bn": "প্রধান দায়িত্বশীল, কুষ্টিয়া জেলা",
        "en": "District head, Kushtia"
      },
      {
        "bn": "বিনিয়োগকারী",
        "en": "Investor"
      }
    ],
    "position": {
      "bn": "প্রধান দায়িত্বশীল (কুষ্টিয়া জেলা), কোরআনের ফেরিওয়ালা",
      "en": "District head (Kushtia), Quraner Fariwala"
    },
    "father": {
      "bn": "মোঃ রফিকুল ইসলাম",
      "en": "Md. Rafiqul Islam"
    },
    "mother": {
      "bn": "হাবিবা খাতুন",
      "en": "Habiba Khatun"
    },
    "nid": "9164051816",
    "phone": {
      "display": "+880 1611-509535",
      "tel": "+8801611509535"
    },
    "address": {
      "bn": "গ্রাম: জোতমোড়া, ডাকঘর: যদুবয়রা - ৭০১০, থানা: কুমারখালী, জেলা: কুষ্টিয়া",
      "en": "Village: Jotmora, Post office: Jadubayra - 7010, Thana: Kumarkhali, District: Kushtia"
    }
  },
  "founder": {
    "name": {
      "bn": "মোঃ জাফর আহমদ",
      "en": "Md. Jafar Ahmad"
    },
    "title": {
      "bn": "প্রতিষ্ঠাতা পরিচালক, কোরআনের ফেরিওয়ালা",
      "en": "Founder Director, Quraner Fariwala"
    }
  },
  "investment": {
    "total": 19200,
    "agreementDate": "2026-09-13",
    "agreementTimeLabel": {
      "bn": "আসরের নামাজের পর",
      "en": "after the Asr prayer"
    }
  },
  "returns": {
    "quantity": 64,
    "termMonths": 1,
    "retailPrice": 500,
    "wholesalePrice": 450,
    "headline": {
      "bn": "{qty} কপি কোরআন মাজীদ",
      "en": "{qty} copies of the Quran Majid"
    },
    "description": {
      "bn": "কোরআনের ফেরিওয়ালা থেকে হিফজ শিক্ষার্থীদের জন্য মুদ্রিত",
      "en": "Printed by Quraner Fariwala for Hifz students"
    }
  },
  "ledger": {
    "entries": [
      {
        "type": "loan",
        "date": "2025-08-25",
        "title": {
          "bn": "ঋণ",
          "en": "Loan"
        },
        "note": {
          "bn": "কোরআনের ফেরিওয়ালাতে দেওয়া ঋণ, বিনিয়োগের পরিশোধ হিসেবে গণ্য",
          "en": "Loan to Quraner Fariwala, counted as part of the payment"
        },
        "amount": 1000,
        "countsAsPaid": true
      },
      {
        "type": "agreement",
        "date": "2026-09-13",
        "timeLabel": {
          "bn": "আসরের নামাজের পর",
          "en": "after the Asr prayer"
        },
        "title": {
          "bn": "মৌখিক সিদ্ধান্ত",
          "en": "Oral decision"
        },
        "note": {
          "bn": "মোঃ জাফর আহমদের সাথে আলোচনায় {term} মেয়াদে বিনিয়োগ এবং বিনিময়ে {qty} কপি কোরআন মাজীদ নির্ধারিত হয়",
          "en": "Agreed with Md. Jafar Ahmad: an investment for {term}, in return for {qty} copies of the Quran Majid"
        },
        "amountFrom": "investment.total",
        "countsAsPaid": false
      },
      {
        "type": "cash",
        "date": "2026-09-13T21:40:00+06:00",
        "title": {
          "bn": "ক্যাশ পরিশোধ",
          "en": "Cash payment"
        },
        "note": {
          "bn": "মোঃ জাফর আহমদের হাতে ক্যাশ প্রদান",
          "en": "Handed in cash to Md. Jafar Ahmad"
        },
        "amount": 5000,
        "countsAsPaid": true
      },
      {
        "type": "nagad",
        "date": "2026-09-20T18:03:00+06:00",
        "title": {
          "bn": "নগদ (Nagad) এর মাধ্যমে পরিশোধ",
          "en": "Payment via Nagad"
        },
        "note": {
          "bn": "কোরআনের ফেরিওয়ালার প্রাতিষ্ঠানিক নগদ নম্বরে মোবাইল ব্যাংকিংয়ের মাধ্যমে পরিশোধ",
          "en": "Paid by mobile banking to the institutional Nagad number of Quraner Fariwala"
        },
        "references": [
          {
            "label": {
              "bn": "প্রাপক নগদ নম্বর",
              "en": "Receiving Nagad number"
            },
            "value": "01788856628"
          },
          {
            "label": {
              "bn": "ট্রানজ্যাকশন আইডি",
              "en": "Transaction ID"
            },
            "value": "760TXARM"
          }
        ],
        "amount": 2000,
        "countsAsPaid": true
      }
    ]
  },
  "ui": {
    "summaryTitle": {
      "bn": "বিনিয়োগের সারসংক্ষেপ",
      "en": "Investment summary"
    },
    "tiles": {
      "total": {
        "bn": "মোট বিনিয়োগ",
        "en": "Total investment"
      },
      "paid": {
        "bn": "পরিশোধিত",
        "en": "Paid"
      },
      "due": {
        "bn": "বাকি",
        "en": "Remaining"
      }
    },
    "ledgerTitle": {
      "bn": "লেনদেনের ধারাবাহিকতা",
      "en": "Transaction timeline"
    },
    "counted": {
      "bn": "পরিশোধে গণ্য",
      "en": "Counted as paid"
    },
    "infoTitle": {
      "bn": "ব্যক্তিগত তথ্য",
      "en": "Personal information"
    },
    "labels": {
      "name": {
        "bn": "নাম",
        "en": "Name"
      },
      "father": {
        "bn": "পিতা",
        "en": "Father"
      },
      "mother": {
        "bn": "মাতা",
        "en": "Mother"
      },
      "nid": {
        "bn": "এনআইডি নম্বর",
        "en": "NID number"
      },
      "phone": {
        "bn": "মোবাইল",
        "en": "Mobile"
      },
      "address": {
        "bn": "ঠিকানা",
        "en": "Address"
      },
      "position": {
        "bn": "দায়িত্ব",
        "en": "Position"
      }
    },
    "agreementTitle": {
      "bn": "চুক্তি ও সিদ্ধান্ত",
      "en": "Agreement and decision"
    },
    "agreementText": {
      "bn": "{date} তারিখে {time} মোঃ জাফর আহমদের সাথে মৌখিক আলোচনার মাধ্যমে প্রাথমিক পর্যায়ে {total} বিনিয়োগের সিদ্ধান্ত হয়েছে। {term} পর বিনিয়োগকারী {qty} কপি কোরআন মাজীদ পাবেন। চুক্তিনামায় পক্ষ, পরিশোধ ও বাকির পূর্ণ বিবরণ আছে।",
      "en": "On {date}, {time}, it was decided in oral discussion with Md. Jafar Ahmad that {total} will be invested at the initial stage. After {term} the investor will receive {qty} copies of the Quran Majid. The agreement sets out the parties, payments and balance in full."
    },
    "viewContract": {
      "bn": "চুক্তিনামা দেখুন",
      "en": "View agreement"
    },
    "recordNote": {
      "bn": "এই পাতার তথ্য মৌখিক সিদ্ধান্ত ও লেনদেনের রেকর্ড হিসেবে সংরক্ষিত। কোনো তথ্যে ভুল বা আপত্তি থাকলে জানান: {email}",
      "en": "The information on this page is kept as a record of the oral decision and the transactions. If you find a mistake or have an objection, write to: {email}"
    },
    "returns": {
      "title": {
        "bn": "বিনিয়োগের বিনিময়ে প্রাপ্তি",
        "en": "Received in return"
      },
      "copies": {
        "bn": "কপি",
        "en": "copies"
      },
      "termText": {
        "bn": "{n} মাস",
        "en": "{n} month{s}"
      },
      "term": {
        "bn": "মেয়াদ",
        "en": "Term"
      },
      "delivery": {
        "bn": "ডেলিভারির সময়",
        "en": "Delivery due"
      },
      "retail": {
        "bn": "প্রতি কপি, খুচরা মূল্য",
        "en": "Per copy, retail price"
      },
      "wholesale": {
        "bn": "প্রতি কপি, পাইকারি মূল্য",
        "en": "Per copy, wholesale price"
      },
      "retailTotal": {
        "bn": "{qty} কপির খুচরা মূল্য",
        "en": "Retail value of {qty} copies"
      },
      "wholesaleTotal": {
        "bn": "{qty} কপির পাইকারি মূল্য",
        "en": "Wholesale value of {qty} copies"
      },
      "countdown": {
        "future": {
          "bn": "আর {days} দিন বাকি",
          "en": "{days} day{s} to go"
        },
        "today": {
          "bn": "নির্ধারিত দিন আজই",
          "en": "Due today"
        },
        "past": {
          "bn": "নির্ধারিত সময়ের {days} দিন পার হয়েছে",
          "en": "{days} day{s} past the due date"
        }
      }
    },
    "close": {
      "bn": "বন্ধ করুন",
      "en": "Close"
    },
    "print": {
      "bn": "প্রিন্ট / PDF",
      "en": "Print / PDF"
    },
    "switchGateway": {
      "bn": "অন্য পোর্টাল বেছে নিন",
      "en": "Choose a different portal"
    }
  },
  "contract": {
    "invocation": "بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ",
    "title": {
      "bn": "বিনিয়োগ চুক্তিনামা",
      "en": "Investment Agreement"
    },
    "subtitle": {
      "bn": "মৌখিক সিদ্ধান্তের লিখিত রেকর্ড",
      "en": "Written record of an oral decision"
    },
    "dateLabel": {
      "bn": "সিদ্ধান্তের তারিখ",
      "en": "Date of decision"
    },
    "partiesTitle": {
      "bn": "চুক্তিবদ্ধ পক্ষ",
      "en": "The parties"
    },
    "firstParty": {
      "bn": "প্রথম পক্ষ",
      "en": "First party"
    },
    "secondParty": {
      "bn": "দ্বিতীয় পক্ষ (বিনিয়োগকারী)",
      "en": "Second party (investor)"
    },
    "recital": {
      "bn": "{date} তারিখে {time} উভয় পক্ষের মধ্যে মৌখিক আলোচনার মাধ্যমে নিচের সিদ্ধান্ত গৃহীত হয়েছে। সেই সিদ্ধান্ত এই নথিতে লিপিবদ্ধ করা হলো।",
      "en": "On {date}, {time}, the following was decided between the two parties in oral discussion. That decision is recorded in this document."
    },
    "clausesTitle": {
      "bn": "লিপিবদ্ধ সিদ্ধান্ত",
      "en": "Terms recorded"
    },
    "clauses": [
      {
        "title": {
          "bn": "বিনিয়োগের পরিমাণ",
          "en": "Investment amount"
        },
        "text": {
          "bn": "দ্বিতীয় পক্ষ প্রাথমিক পর্যায়ে মোট {total} বিনিয়োগ করবেন।",
          "en": "The second party will invest a total of {total} at the initial stage."
        }
      },
      {
        "title": {
          "bn": "মেয়াদ ও বিনিময়",
          "en": "Term and return"
        },
        "text": {
          "bn": "বিনিয়োগের মেয়াদ {term}, চুক্তির তারিখ থেকে গণনা করে {delivery} পর্যন্ত। মেয়াদ শেষে প্রথম পক্ষ কোরআনের ফেরিওয়ালার পক্ষ থেকে দ্বিতীয় পক্ষকে {qty} কপি কোরআন মাজীদ প্রদান করবেন। এই কোরআন মাজীদ কোরআনের ফেরিওয়ালা থেকে হিফজ শিক্ষার্থীদের জন্য মুদ্রিত।",
          "en": "The investment term is {term}, counted from the date of the agreement up to {delivery}. At the end of the term the first party, on behalf of Quraner Fariwala, will give the second party {qty} copies of the Quran Majid, printed by Quraner Fariwala for Hifz students."
        }
      },
      {
        "title": {
          "bn": "বাজারমূল্য",
          "en": "Market value"
        },
        "text": {
          "bn": "উল্লিখিত কোরআন মাজীদের বাজারমূল্য প্রতি কপি খুচরা {retail} এবং পাইকারি {wholesale}। সেই হিসাবে {qty} কপির মূল্য খুচরায় {retailTotal} এবং পাইকারিতে {wholesaleTotal}।",
          "en": "The market price of these copies is {retail} each at retail and {wholesale} each at wholesale. On that basis {qty} copies are worth {retailTotal} at retail and {wholesaleTotal} at wholesale."
        }
      },
      {
        "title": {
          "bn": "পরিশোধ ও সমন্বয়",
          "en": "Payment and adjustment"
        },
        "text": {
          "bn": "নিচের সারণিতে উল্লিখিত পরিশোধসমূহ এবং পূর্বে দেওয়া ঋণ বিনিয়োগের পরিশোধ হিসেবে গণ্য হবে।",
          "en": "The payments and the earlier loan listed in the table below count as payment toward the investment."
        }
      },
      {
        "title": {
          "bn": "বর্তমান হিসাব",
          "en": "Current position"
        },
        "text": {
          "bn": "উপরের হিসাব অনুযায়ী মোট পরিশোধিত {paid} এবং বাকি {due}।",
          "en": "On the above, the total paid is {paid} and the balance remaining is {due}."
        }
      },
      {
        "title": {
          "bn": "অন্যান্য শর্ত",
          "en": "Other terms"
        },
        "text": {
          "bn": "এই নথিতে যা লিপিবদ্ধ হয়েছে তার বাইরের কোনো শর্ত, যেমন বাকি টাকা পরিশোধের সময়, এখানে উল্লেখ নেই। উভয় পক্ষ সম্মত হয়ে লিখিতভাবে যুক্ত করলে তা এই চুক্তিনামার অংশ হবে।",
          "en": "Terms beyond those recorded here, such as the time for paying the remaining balance, are not set out in this document. They become part of this agreement only if both parties agree and add them in writing."
        }
      }
    ],
    "paymentsTitle": {
      "bn": "পরিশোধের বিবরণ",
      "en": "Payment record"
    },
    "table": {
      "date": {
        "bn": "তারিখ",
        "en": "Date"
      },
      "detail": {
        "bn": "বিবরণ",
        "en": "Detail"
      },
      "amount": {
        "bn": "পরিমাণ",
        "en": "Amount"
      }
    },
    "signatures": {
      "line": {
        "bn": "স্বাক্ষর",
        "en": "Signature"
      },
      "witness": {
        "bn": "সাক্ষী",
        "en": "Witness"
      }
    },
    "note": {
      "bn": "এই নথি তথ্য ও রেকর্ড সংরক্ষণের জন্য। আইনগত কার্যকারিতা বা ব্যাখ্যার প্রয়োজনে যোগ্য আইনজীবীর পরামর্শ নিন।",
      "en": "This document is for information and record-keeping. For legal effect or interpretation, consult a qualified lawyer."
    }
  },
  "footer": {
    "copyright": {
      "bn": "© ২০২৬ কোরআনের ফেরিওয়ালা। সর্বস্বত্ব সংরক্ষিত।",
      "en": "© 2026 Quraner Fariwala. All rights reserved."
    },
    "tagline": {
      "bn": "পবিত্র কোরআনের গবেষণা, মুদ্রণ ও বিতরণের মাধ্যমে সমাজকে এগিয়ে নেওয়া, এমজে আহমদ",
      "en": "Empowering communities through Research, Printing & Distribution of Holy Quran, by MJ-Ahmad"
    }
  }
}
QFEOF

cat > "investor/alamin/index.html" << 'QFEOF'
<!DOCTYPE html>
<html lang="bn">
<head>
  <meta charset="utf-8" />
  <title>বিনিয়োগ প্রোফাইল</title>
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <meta name="robots" content="noindex,nofollow" />
  <meta name="theme-color" content="#0a3a31" />
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Amiri:wght@400;700&family=Hind+Siliguri:wght@400;500;600;700&family=Tiro+Bangla:ital@0;1&display=swap" rel="stylesheet" />
  <style>
    :root {
      --night: #0a3a31;
      --emerald: #136b55;
      --gold: #b8892d;
      --gold-deep: #83600f;
      --gold-soft: #ead9a6;
      --lapis: #25417f;
      --bg: #f1f5f0;
      --white: #ffffff;
      --ink: #15221d;
      --muted: #586a62;
      --line: #d5ddd3;
      --parch: #f7eed4;
      --parch-line: #d9c48a;
      --serif: 'Tiro Bangla', 'Noto Serif Bengali', Georgia, serif;
      --sans: 'Hind Siliguri', 'Noto Sans Bengali', system-ui, -apple-system, 'Segoe UI', sans-serif;
      /* eight-pointed star (Rub el Hizb) used for the avatar, timeline nodes and clause numbers */
      --star: polygon(50.00% 0.00%,64.64% 14.64%,85.36% 14.64%,85.36% 35.36%,100.00% 50.00%,85.36% 64.64%,85.36% 85.36%,64.64% 85.36%,50.00% 100.00%,35.36% 85.36%,14.64% 85.36%,14.64% 64.64%,0.00% 50.00%,14.64% 35.36%,14.64% 14.64%,35.36% 14.64%);
      --lattice: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='72' height='72' viewBox='0 0 72 72'%3E%3Cg fill='none' stroke='%23ead9a6' stroke-opacity='.12' stroke-width='1.2'%3E%3Crect x='16' y='16' width='40' height='40'/%3E%3Crect x='16' y='16' width='40' height='40' transform='rotate(45 36 36)'/%3E%3C/g%3E%3C/svg%3E");
    }


    * { box-sizing: border-box; }
    html { -webkit-text-size-adjust: 100%; }
    body {
      margin: 0; background: var(--bg); color: var(--ink);
      font-family: var(--sans); font-size: 16px; line-height: 1.7;
    }
    body.noscroll { overflow: hidden; }
    h1, h2, h3, h4, p, ul, ol, dl, dd, figure { margin: 0; }
    ul, ol { padding: 0; list-style: none; }
    a { color: var(--emerald); }
    img { max-width: 100%; }
    button { font-family: inherit; }
    .hidden { display: none !important; }
    .invisible { visibility: hidden; }
    .sr-only { position: absolute; width: 1px; height: 1px; overflow: hidden; clip: rect(0 0 0 0); white-space: nowrap; }
    :focus-visible { outline: 3px solid var(--gold); outline-offset: 2px; }


    /* ---------- language switch (always visible) ---------- */
    .langbar {
      position: fixed; top: 12px; right: 12px; z-index: 90; display: flex; gap: 2px; padding: 3px;
      background: rgba(10, 58, 49, .92); border: 1px solid rgba(234, 217, 166, .5); border-radius: 999px;
    }
    .langbar button {
      border: 0; background: transparent; color: var(--gold-soft); border-radius: 999px;
      padding: 3px 12px; font-size: .9rem; cursor: pointer;
    }
    .langbar button[aria-pressed="true"] { background: var(--gold-soft); color: var(--night); font-weight: 600; }


    /* ---------- lock screen ---------- */
    #lockScreen {
      position: relative; min-height: 100vh; min-height: 100dvh; display: grid; place-items: center; padding: 72px 20px 32px;
      background: radial-gradient(120% 90% at 50% 0%, #12604e 0%, var(--night) 62%);
    }
    #lockScreen::before { content: ""; position: absolute; inset: 0; background-image: var(--lattice); pointer-events: none; }
    .lock-card {
      position: relative; width: 100%; max-width: 420px; text-align: center; background: var(--white);
      border-top: 4px solid var(--gold); border-radius: 4px; padding: 30px 24px 24px;
      box-shadow: 0 24px 60px rgba(0, 0, 0, .35);
    }
    .lock-logo { width: 56px; height: 56px; border-radius: 8px; }
    .lock-greet { margin-top: 10px; font-family: var(--serif); color: var(--gold-deep); font-size: 1.1rem; }
    .lock-card h1 { font-family: var(--serif); font-weight: 400; font-size: 1.9rem; line-height: 1.3; color: var(--night); }
    .lock-for { margin-top: 6px; font-weight: 600; }
    .lock-sub { margin-top: 4px; color: var(--muted); font-size: .95rem; }
    .lock-card input {
      width: 100%; margin-top: 18px; padding: 11px 14px; font: inherit; border: 1px solid #b9c4bb; border-radius: 4px; background: #fbfdfb;
    }
    .lock-card input:focus { border-color: var(--emerald); outline: 3px solid rgba(19, 107, 85, .25); outline-offset: 0; }
    .btn {
      display: inline-flex; align-items: center; justify-content: center; gap: 10px; border: 0; border-radius: 4px;
      padding: 12px 22px; font: 600 1.05rem var(--sans); cursor: pointer;
    }
    .btn-solid { width: 100%; margin-top: 12px; background: var(--emerald); color: #fff; }
    .btn-solid:hover { background: var(--night); }
    #lockMsg { min-height: 1.7em; margin-top: 10px; color: #a12b2b; font-size: .95rem; }
    .lock-contact { margin-top: 10px; font-size: .82rem; color: var(--muted); border-top: 1px solid var(--line); padding-top: 12px; }
    #loadError {
      position: relative; max-width: 420px; background: #fff; border-top: 4px solid #a12b2b; border-radius: 4px;
      padding: 20px; color: #7a1f1f; font-size: .95rem;
    }


    /* ---------- hero ---------- */
    .hero { position: relative; overflow: hidden; color: #fff; padding: 18px 20px 46px; background: linear-gradient(180deg, var(--night), #0e4a3e); }
    .hero::before { content: ""; position: absolute; inset: 0; background-image: var(--lattice); pointer-events: none; }
    .hero::after { content: ""; position: absolute; left: 0; right: 0; bottom: 0; height: 4px; background: linear-gradient(90deg, transparent, var(--gold), transparent); }
    .hero-inner { position: relative; max-width: 860px; margin: 0 auto; }
    .brandrow { display: inline-flex; align-items: center; gap: 10px; max-width: calc(100% - 130px); color: var(--gold-soft); text-decoration: none; font-weight: 600; line-height: 1.3; }
    .brandrow img { width: 36px; height: 36px; border-radius: 6px; background: #fff; flex: none; }
    .identity { margin-top: 26px; text-align: center; }
    .avatar { width: 136px; height: 136px; margin: 0 auto; background: var(--gold); clip-path: var(--star); display: grid; place-items: center; }
    .avatar-in { width: calc(100% - 10px); height: calc(100% - 10px); background: var(--emerald); clip-path: var(--star); display: grid; place-items: center; overflow: hidden; }
    .avatar-in img { width: 100%; height: 100%; object-fit: cover; }
    .monogram { font-family: var(--serif); font-size: 3.4rem; line-height: 1; color: var(--gold-soft); }
    .name { margin-top: 18px; font-family: var(--serif); font-weight: 400; font-size: clamp(2.4rem, 9vw, 3.8rem); line-height: 1.2; }
    .formal { margin-top: 2px; color: var(--gold-soft); letter-spacing: .14em; font-size: .95rem; }
    .roles { margin-top: 16px; display: flex; flex-wrap: wrap; justify-content: center; gap: 8px; }
    .roles li { border: 1px solid rgba(234, 217, 166, .55); color: var(--gold-soft); padding: 3px 14px; border-radius: 999px; font-size: .92rem; }


    /* ---------- main ---------- */
    main { max-width: 860px; margin: 0 auto; padding: 0 18px 56px; }
    .clockline { padding: 14px 0 2px; text-align: center; color: var(--muted); font-size: .9rem; }
    .sec { margin-top: 34px; }
    .sec > h2 { display: flex; align-items: center; gap: 14px; font-family: var(--serif); font-weight: 400; font-size: 1.65rem; line-height: 1.3; color: var(--night); }
    .sec > h2::after { content: ""; flex: 1; height: 1px; background: linear-gradient(90deg, var(--gold), transparent); }


    .sheet { margin-top: 14px; background: var(--white); border: 1px solid var(--line); border-top: 3px solid var(--gold); border-radius: 4px; padding: 22px 18px 18px; }
    .figures { display: grid; grid-template-columns: repeat(3, 1fr); gap: 12px; }
    .fig { border-top: 3px solid var(--line); padding-top: 8px; min-width: 0; }
    .fig small { display: block; color: var(--muted); font-size: .85rem; line-height: 1.4; }
    .fig strong { display: block; font-family: var(--serif); font-weight: 400; font-size: clamp(1.15rem, 4.6vw, 1.9rem); line-height: 1.35; overflow-wrap: anywhere; }
    .fig.total { border-color: var(--gold); }
    .fig.paid { border-color: var(--emerald); }
    .fig.paid strong { color: var(--emerald); }
    .fig.due { border-color: var(--lapis); }
    .fig.due strong { color: var(--lapis); }
    .bar {
      display: flex; height: 16px; margin-top: 20px; overflow: hidden; border-radius: 2px;
      background: repeating-linear-gradient(135deg, rgba(37, 65, 127, .3) 0 6px, rgba(37, 65, 127, .13) 6px 12px);
    }
    .bar-paid { width: 0; background: var(--emerald); transition: width 1.5s cubic-bezier(.2, .7, .2, 1); }
    .barcap { display: flex; justify-content: space-between; gap: 12px; margin-top: 8px; font-size: .9rem; color: var(--muted); }
    .barcap b { font-weight: 600; }
    .barcap .k-paid b { color: var(--emerald); }
    .barcap .k-due b { color: var(--lapis); }


    .ret-top { display: flex; align-items: center; gap: 18px; }
    .qty { position: relative; flex: none; width: 108px; height: 108px; display: grid; place-items: center; text-align: center; background: var(--gold); clip-path: var(--star); }
    .qty::after { content: ""; position: absolute; inset: 5px; background: var(--night); clip-path: var(--star); }
    .qty > div { position: relative; z-index: 1; }
    .qty b { display: block; font-family: var(--serif); font-weight: 400; font-size: 2.1rem; line-height: 1.1; color: var(--gold-soft); }
    .qty small { display: block; font-size: .78rem; line-height: 1.2; color: #fff; }
    .ret-text h3 { font-family: var(--serif); font-weight: 400; font-size: 1.5rem; line-height: 1.35; color: var(--night); }
    .ret-text p { margin-top: 2px; color: var(--muted); font-size: .95rem; line-height: 1.6; }
    .ret-grid { display: grid; grid-template-columns: 1fr 1fr; column-gap: 20px; margin-top: 18px; border-top: 1px solid var(--line); }
    .ret-grid > div { padding: 10px 0; border-bottom: 1px solid var(--line); min-width: 0; }
    .ret-grid dt { color: var(--muted); font-size: .82rem; line-height: 1.45; }
    .ret-grid dd { font-weight: 500; overflow-wrap: anywhere; }
    .ret-grid .sub { display: block; font-weight: 400; font-size: .85rem; color: var(--lapis); }


    .ledger { position: relative; margin-top: 18px; padding-left: 36px; }
    .ledger::before { content: ""; position: absolute; left: 11px; top: 8px; bottom: 8px; width: 2px; background: linear-gradient(var(--gold), var(--gold-soft)); }
    .entry { position: relative; padding-bottom: 24px; }
    .entry:last-child { padding-bottom: 0; }
    .node { position: absolute; left: -36px; top: 1px; width: 24px; height: 24px; background: var(--gold); clip-path: var(--star); }
    .node::after { content: ""; position: absolute; inset: 4px; background: var(--bg); clip-path: var(--star); }
    .entry.paid .node::after { background: var(--emerald); }
    .entry-head { display: flex; justify-content: space-between; align-items: baseline; gap: 12px; }
    .entry-head h4 { font-size: 1.08rem; font-weight: 600; }
    .entry-amt { font-family: var(--serif); font-size: 1.2rem; white-space: nowrap; color: var(--gold-deep); }
    .entry.paid .entry-amt { color: var(--emerald); }
    .entry-when { color: var(--muted); font-size: .9rem; }
    .entry-note { margin-top: 2px; font-size: .95rem; }
    .entry-ref { margin-top: 2px; font-size: .9rem; color: var(--muted); }
    .entry-ref b { font-weight: 600; color: var(--ink); letter-spacing: .05em; user-select: all; }
    .badge { display: inline-block; margin-top: 6px; padding: 0 10px; border-radius: 999px; font-size: .8rem; background: rgba(19, 107, 85, .1); color: var(--emerald); }


    .info { margin-top: 14px; display: grid; grid-template-columns: 1fr; border-top: 1px solid var(--line); }
    .info > div { padding: 11px 0; border-bottom: 1px solid var(--line); }
    .info dt { color: var(--muted); font-size: .85rem; }
    .info dd { font-size: 1.05rem; font-weight: 500; overflow-wrap: anywhere; }
    .info .dim { color: var(--muted); font-weight: 400; font-size: .9rem; letter-spacing: .06em; }
    @media (min-width: 640px) {
      .info { grid-template-columns: 1fr 1fr; column-gap: 36px; }
      .info .wide { grid-column: 1 / -1; }
    }


    .cta { position: relative; overflow: hidden; margin-top: 40px; padding: 28px 22px 30px; background: var(--night); color: #fff; border-radius: 4px; }
    .cta::before { content: ""; position: absolute; inset: 0; background-image: var(--lattice); pointer-events: none; }
    .cta > * { position: relative; }
    .cta h2 { font-family: var(--serif); font-weight: 400; font-size: 1.65rem; line-height: 1.3; color: var(--gold-soft); }
    .cta p { margin-top: 8px; max-width: 62ch; color: #dbe8e2; }
    .btn-gold { margin-top: 18px; background: var(--gold-soft); color: var(--night); }
    .btn-gold:hover { background: #fff; }
    .note { margin-top: 22px; font-size: .88rem; color: var(--muted); }
    .foot { padding: 22px 18px; text-align: center; background: var(--night); color: #cfe0d8; font-size: .88rem; }
    .foot p + p { margin-top: 2px; opacity: .85; }


    /* ---------- agreement viewer ---------- */
    .cv { position: fixed; inset: 0; z-index: 70; display: none; overflow-y: auto; background: radial-gradient(120% 70% at 50% 0%, #0c3a30 0%, #04170f 75%); -webkit-overflow-scrolling: touch; }
    .cv.open { display: block; animation: fade .5s ease both; }
    .cv-bar { position: sticky; top: 0; z-index: 2; display: flex; gap: 8px; padding: 10px 12px; padding-right: 130px; background: rgba(4, 23, 15, .96); }
    .tb { border: 1px solid rgba(234, 217, 166, .45); background: rgba(255, 255, 255, .08); color: var(--gold-soft); border-radius: 4px; padding: 6px 14px; font: 500 .95rem var(--sans); cursor: pointer; }
    .tb:hover { background: rgba(255, 255, 255, .16); }


    .paper {
      position: relative; width: calc(100% - 24px); max-width: 780px; margin: 16px auto 48px; padding: 38px 22px 34px;
      color: #2b2414; border: 1px solid var(--parch-line); box-shadow: 0 30px 80px rgba(0, 0, 0, .55);
      background: radial-gradient(circle at 18% 8%, rgba(255, 255, 255, .6), transparent 55%), var(--parch);
      animation: paper-in 1s cubic-bezier(.2, .7, .2, 1) both;
    }
    .paper::before { content: ""; position: absolute; inset: 8px; border: 1px solid var(--gold); pointer-events: none; }
    .paper::after { content: ""; position: absolute; inset: 12px; border: 1px solid rgba(184, 137, 45, .4); pointer-events: none; }
    @media (min-width: 700px) { .paper { padding: 58px 60px 50px; } }


    .reveal { opacity: 0; animation: rise .8s cubic-bezier(.2, .7, .2, 1) forwards; animation-delay: calc(var(--i) * .16s + .55s); }
    @keyframes fade { from { opacity: 0; } to { opacity: 1; } }
    @keyframes paper-in { from { opacity: 0; transform: translateY(46px) scale(.96); } to { opacity: 1; transform: none; } }
    @keyframes rise { from { opacity: 0; transform: translateY(16px); } to { opacity: 1; transform: none; } }
    @keyframes draw { to { stroke-dashoffset: 0; } }
    @keyframes stamp {
      0% { opacity: 0; transform: scale(2.4) rotate(-26deg); }
      55% { opacity: .95; }
      100% { opacity: .9; transform: scale(1) rotate(-8deg); }
    }


    .invocation { text-align: center; font-family: 'Amiri', 'Noto Naskh Arabic', serif; font-size: 2rem; line-height: 1.8; color: var(--night); }
    .orn svg { display: block; width: 240px; max-width: 100%; height: 20px; margin: 4px auto 0; overflow: visible; }
    .orn path { fill: none; stroke: var(--gold); stroke-width: 1.5; stroke-dasharray: 1; stroke-dashoffset: 1; animation: draw 1.4s ease forwards; animation-delay: calc(var(--i) * .16s + .7s); }
    .orn polygon { fill: var(--gold); }
    .c-brand { display: flex; align-items: center; justify-content: center; gap: 10px; margin-top: 14px; color: var(--gold-deep); font-weight: 600; }
    .c-brand img { width: 30px; height: 30px; border-radius: 5px; background: #fff; }
    .c-title { margin-top: 10px; text-align: center; }
    .c-title h2 { font-family: var(--serif); font-weight: 400; font-size: clamp(1.9rem, 6vw, 2.6rem); line-height: 1.3; color: var(--night); }
    .c-title p { color: #7b6a3c; }
    .c-date { margin-top: 12px; text-align: center; }
    .c-h { margin-top: 26px; font-family: var(--serif); font-weight: 400; font-size: 1.35rem; color: var(--night); border-bottom: 1px solid var(--parch-line); padding-bottom: 4px; }
    .parties { display: grid; gap: 14px; margin-top: 14px; }
    @media (min-width: 640px) { .parties { grid-template-columns: 1fr 1fr; } }
    .party { border: 1px solid var(--parch-line); background: rgba(255, 255, 255, .38); padding: 14px 16px; }
    .party h4 { margin-bottom: 4px; font-family: var(--serif); font-weight: 400; font-size: 1.05rem; color: var(--gold-deep); }
    .pname { font-size: 1.15rem; font-weight: 600; }
    .prole { font-size: .92rem; color: #5b4d27; }
    .party dl { display: grid; grid-template-columns: auto 1fr; gap: 2px 12px; margin-top: 8px; font-size: .92rem; }
    .party dt { color: #7b6a3c; }
    .party dd { overflow-wrap: anywhere; }
    .recital { margin-top: 20px; }
    .clauses { display: grid; gap: 16px; margin-top: 16px; }
    .clauses li { display: grid; grid-template-columns: 36px 1fr; gap: 12px; align-items: start; }
    .cn { width: 36px; height: 36px; display: grid; place-items: center; background: var(--gold); clip-path: var(--star); font-weight: 600; font-size: .85rem; color: #2b2414; }
    .clauses h4 { font-family: var(--serif); font-weight: 400; font-size: 1.12rem; color: var(--night); }
    table.pay { width: 100%; margin-top: 12px; border-collapse: collapse; font-size: .95rem; }
    .pay th { text-align: left; padding: 6px; border-bottom: 2px solid var(--gold); color: var(--gold-deep); font-weight: 600; }
    .pay td { padding: 8px 6px; border-bottom: 1px solid var(--parch-line); vertical-align: top; }
    .pay .num { text-align: right; white-space: nowrap; }
    .pay small { display: block; color: #6b5c30; }
    .pay tr.sum td { font-weight: 600; }
    .pay tr.due td { font-family: var(--serif); font-weight: 400; font-size: 1.15rem; color: var(--lapis); border-bottom: 3px double var(--gold); }
    .signs { display: grid; gap: 26px; margin-top: 38px; }
    @media (min-width: 640px) { .signs { grid-template-columns: repeat(3, 1fr); gap: 22px; } }
    .sign .line { height: 44px; border-bottom: 1px solid #2b2414; }
    .sign small { display: block; color: #7b6a3c; line-height: 1.4; }
    .sign b { display: block; margin-top: 4px; line-height: 1.4; }
    .seal {
      position: relative; width: 122px; height: 122px; margin: 28px auto 0; display: grid; place-items: center; padding: 12px;
      text-align: center; border: 3px double var(--emerald); border-radius: 50%; color: var(--emerald);
      font-family: var(--serif); line-height: 1.2; opacity: 0; transform: rotate(-8deg);
      animation: stamp .55s cubic-bezier(.3, 1.5, .5, 1) forwards; animation-delay: calc(var(--i) * .16s + .55s);
    }
    .seal::before { content: ""; position: absolute; inset: 6px; border: 1px solid var(--emerald); border-radius: 50%; }
    .seal i { display: block; font-style: normal; font-size: .9rem; }
    .c-note { margin-top: 24px; text-align: center; font-size: .85rem; color: #6b5c30; }
    .paper, .seal { -webkit-print-color-adjust: exact; print-color-adjust: exact; }


    @media (prefers-reduced-motion: reduce) {
      .cv.open, .paper, .reveal, .orn path { animation: none !important; opacity: 1 !important; transform: none !important; stroke-dashoffset: 0 !important; }
      .seal { animation: none !important; opacity: .9 !important; transform: rotate(-8deg) !important; }
      .bar-paid { transition: none; }
    }


    @media print {
      body { background: #fff; }
      #lockScreen, #app, .langbar, .cv-bar { display: none !important; }
      .cv { position: static; display: block; overflow: visible; background: none; animation: none; }
      .paper { width: auto; max-width: none; margin: 0; box-shadow: none; }
      .cv.open, .paper, .reveal, .orn path { animation: none !important; opacity: 1 !important; transform: none !important; stroke-dashoffset: 0 !important; }
      .seal { animation: none !important; opacity: .9 !important; transform: rotate(-8deg) !important; }
      @page { margin: 12mm; }
    }
    .switch { display: flex; width: fit-content; margin-top: 14px; padding: 6px 16px; border: 1px solid var(--gold-soft); border-radius: 999px; background: rgba(234, 217, 166, .12); color: var(--gold-soft); text-decoration: none; font-weight: 600; font-size: .95rem; }
    .switch:hover { background: var(--gold-soft); color: var(--night); }
  </style>
</head>
<body>


  <!--
    Everything shown on this page comes from data.json.
      data-bind="path"          sets the element text
      data-bind-href / -src / -alt / -placeholder / -aria-label   set that attribute
      data-prefix="tel:"        optional prefix for the attribute value
  -->


  <div class="langbar" role="group" aria-label="Language">
    <button id="langBn" type="button" onclick="setLang('bn')" aria-pressed="true">বাংলা</button>
    <button id="langEn" type="button" onclick="setLang('en')" aria-pressed="false">EN</button>
  </div>


  <!-- LOCK SCREEN -->
  <div id="lockScreen">
    <div id="lockCard" class="lock-card invisible">
      <img class="lock-logo" data-bind-src="site.logo" data-bind-alt="site.logoAlt" alt="" />
      <p class="lock-greet" data-bind="lockScreen.greeting"></p>
      <h1 data-bind="lockScreen.title"></h1>
      <p class="lock-for" data-bind="lockScreen.profileFor"></p>
      <p class="lock-sub" data-bind="lockScreen.subtitle"></p>


      <label for="passwordInput" class="sr-only" data-bind="lockScreen.passwordLabel"></label>
      <input id="passwordInput" type="password" autocomplete="current-password" data-bind-placeholder="lockScreen.placeholder" />
      <button id="unlockBtn" type="button" class="btn btn-solid" onclick="unlock()" data-bind="lockScreen.button"></button>
      <p id="lockMsg" role="alert"></p>
      <p class="lock-contact"><span data-bind="lockScreen.contactNote"></span> <strong data-bind="lockScreen.contactEmail"></strong></p>
    </div>
    <div id="loadError" class="hidden" role="alert"></div>
  </div>


  <!-- PROFILE (shown after unlock) -->
  <div id="app" class="hidden">
    <header class="hero">
      <div class="hero-inner">
        <a class="brandrow" data-bind-href="site.homeUrl">
          <img data-bind-src="site.logo" data-bind-alt="site.logoAlt" alt="" />
          <span data-bind="site.brand"></span>
        </a>
        <a class="switch" data-bind-href="site.gatewayUrl" data-bind="ui.switchGateway"></a>


        <div class="identity">
          <div class="avatar"><div class="avatar-in" id="avatarInner"></div></div>
          <h1 class="name" data-bind="investor.name"></h1>
          <p class="formal" data-bind="investor.formalName"></p>
          <ul class="roles" id="roles"></ul>
        </div>
      </div>
    </header>


    <main>
      <p class="clockline"><span data-bind="site.clockLabel"></span>: <time id="clock"></time></p>


      <section class="sec">
        <h2 data-bind="ui.summaryTitle"></h2>
        <div class="sheet">
          <div class="figures">
            <div class="fig total"><small data-bind="ui.tiles.total"></small><strong id="figTotal"></strong></div>
            <div class="fig paid"><small data-bind="ui.tiles.paid"></small><strong id="figPaid"></strong></div>
            <div class="fig due"><small data-bind="ui.tiles.due"></small><strong id="figDue"></strong></div>
          </div>
          <div class="bar" id="bar" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
            <div class="bar-paid" id="barPaid"></div>
          </div>
          <div class="barcap">
            <span class="k-paid"><b id="pctPaid"></b> <span data-bind="ui.tiles.paid"></span></span>
            <span class="k-due"><b id="pctDue"></b> <span data-bind="ui.tiles.due"></span></span>
          </div>
        </div>
      </section>


      <section class="sec">
        <h2 data-bind="ui.returns.title"></h2>
        <div class="sheet">
          <div class="ret-top">
            <div class="qty"><div><b id="retQty"></b><small data-bind="ui.returns.copies"></small></div></div>
            <div class="ret-text">
              <h3 data-bind="returns.headline"></h3>
              <p data-bind="returns.description"></p>
            </div>
          </div>
          <dl class="ret-grid" id="retGrid"></dl>
        </div>
      </section>


      <section class="sec">
        <h2 data-bind="ui.ledgerTitle"></h2>
        <ol class="ledger" id="ledger"></ol>
      </section>


      <section class="sec">
        <h2 data-bind="ui.infoTitle"></h2>
        <dl class="info">
          <div class="wide"><dt data-bind="ui.labels.name"></dt><dd><span data-bind="investor.name"></span> <span class="dim" data-bind="investor.formalName"></span></dd></div>
          <div><dt data-bind="ui.labels.father"></dt><dd data-bind="investor.father"></dd></div>
          <div><dt data-bind="ui.labels.mother"></dt><dd data-bind="investor.mother"></dd></div>
          <div><dt data-bind="ui.labels.nid"></dt><dd data-bind="investor.nid"></dd></div>
          <div><dt data-bind="ui.labels.phone"></dt><dd><a data-bind="investor.phone.display" data-bind-href="investor.phone.tel" data-prefix="tel:"></a></dd></div>
          <div class="wide"><dt data-bind="ui.labels.position"></dt><dd data-bind="investor.position"></dd></div>
          <div class="wide"><dt data-bind="ui.labels.address"></dt><dd data-bind="investor.address"></dd></div>
        </dl>
      </section>


      <section class="cta">
        <h2 data-bind="ui.agreementTitle"></h2>
        <p data-bind="ui.agreementText"></p>
        <button type="button" class="btn btn-gold" onclick="openContract()">
          <span aria-hidden="true">📜</span><span data-bind="ui.viewContract"></span>
        </button>
      </section>


      <p class="note" data-bind="ui.recordNote"></p>
    </main>


    <footer class="foot">
      <p data-bind="footer.copyright"></p>
      <p data-bind="footer.tagline"></p>
    </footer>
  </div>


  <!-- AGREEMENT VIEWER -->
  <div id="contractView" class="cv" role="dialog" aria-modal="true" data-bind-aria-label="contract.title">
    <div class="cv-bar">
      <button id="cvClose" type="button" class="tb" onclick="closeContract()"><span aria-hidden="true">✕ </span><span data-bind="ui.close"></span></button>
      <button type="button" class="tb" onclick="window.print()"><span aria-hidden="true">🖨 </span><span data-bind="ui.print"></span></button>
    </div>
    <article class="paper" id="paper"></article>
  </div>


  <script>
    // ------------------------------------------------------------------
    // Data
    // ------------------------------------------------------------------
    const DATA_URL = 'data.json';
    le
