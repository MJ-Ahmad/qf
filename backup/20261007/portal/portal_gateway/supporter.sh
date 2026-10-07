#!/usr/bin/env bash
# supporter.sh
# portal_gateway/ লোকেশন থেকে রান করুন: bash supporter.sh
# এটি supporter/ ফোল্ডার ও তার ভেতরের সবগুলো টেমপ্লেট + বাস্তব প্রোফাইল ফাইল তৈরি করবে।
set -e

echo "supporter/ ফোল্ডার তৈরি করা হচ্ছে..."

mkdir -p "supporter/_template"
mkdir -p "supporter/arefa-begum"
mkdir -p "supporter/delowar-hossain"
mkdir -p "supporter/rafika-sultana"
mkdir -p "supporter/tarikul-haque"

cat > "supporter/_template/data.json" << 'QFEOF'
{
  "_readme": "এই ফাইলটি টেমপ্লেট — নতুন সাপোর্টারের জন্য supporter/{username}/ ফোল্ডার তৈরি করে এই টেমপ্লেট কপি করুন, security.passwordSha256 (hash-generator.html দিয়ে তৈরি করুন) এবং person, contributions.entries এ প্রকৃত তথ্য বসান। সাপোর্টাররা কোনো শর্ত বা প্রতিদান ছাড়াই সহায়তা করেন, তাই distribution অংশ সাধারণত খালি থাকবে (স্বয়ংক্রিয়ভাবে লুকানো থাকবে)।",
  "site": {
    "title": {
      "bn": "সাপোর্টারের প্রোফাইল",
      "en": "Supporter profile"
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
    "gatewayUrl": "../../",
    "defaultLang": "bn",
    "timezone": "Asia/Dhaka",
    "currencySymbol": "৳",
    "currencyWord": {
      "bn": "টাকা",
      "en": "Tk."
    }
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
      "bn": "ব্যক্তিগত সহযোগিতার প্রোফাইল",
      "en": "Personal contribution profile"
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
  "person": {
    "photo": "",
    "monogram": {
      "bn": "",
      "en": ""
    },
    "name": {
      "bn": "",
      "en": ""
    },
    "role": {
      "bn": "সাপোর্টার",
      "en": "Supporter"
    }
  },
  "contributions": {
    "entries": []
  },
  "distribution": {
    "mode": "",
    "note": {
      "bn": "",
      "en": ""
    },
    "entries": []
  },
  "ui": {
    "summaryTitle": {
      "bn": "সহায়তার সারসংক্ষেপ",
      "en": "Support summary"
    },
    "tiles": {
      "taka": {
        "bn": "মোট সহায়তা (টাকা)",
        "en": "Total support (Tk.)"
      },
      "copies": {
        "bn": "মোট কোরআন (কপি)",
        "en": "Total Quran copies"
      },
      "copiesShort": {
        "bn": "কপি",
        "en": "copies"
      }
    },
    "ledgerTitle": {
      "bn": "সহায়তার ধারাবাহিকতা",
      "en": "Support timeline"
    },
    "noEntries": {
      "bn": "এখনো কোনো এন্ট্রি যুক্ত করা হয়নি।",
      "en": "No entries have been added yet."
    },
    "distTitle": {
      "bn": "বিতরণের হিসাব",
      "en": "Distribution record"
    },
    "distModes": {
      "organization": {
        "bn": "প্রতিষ্ঠানের মাধ্যমে বিতরণ",
        "en": "Distributed by the organization"
      },
      "self": {
        "bn": "নিজ হাতে বিতরণ করেছেন",
        "en": "Distributed personally by the donor"
      },
      "mixed": {
        "bn": "প্রতিষ্ঠান ও নিজে — উভয়ভাবে বিতরণ",
        "en": "Distributed both by the organization and personally"
      }
    },
    "thanksTitle": {
      "bn": "কৃতজ্ঞতা",
      "en": "With gratitude"
    },
    "thanksText": {
      "bn": "কোনো শর্ত বা প্রতিদানের প্রত্যাশা ছাড়াই আপনি পাশে থেকেছেন — এই আন্তরিকতা আমাদের সবচেয়ে বড় শক্তি। আল্লাহ আপনাকে উত্তম প্রতিদান দিন।",
      "en": "You stood beside us without any condition or expectation of return — that sincerity is our greatest strength. May Allah reward you well."
    },
    "recordNote": {
      "bn": "এই পাতার তথ্য সহায়তার রেকর্ড হিসেবে সংরক্ষিত। কোনো তথ্যে ভুল বা আপত্তি থাকলে জানান: {email}",
      "en": "The information on this page is kept as a record of the support given. If you find a mistake or have an objection, write to: {email}"
    },
    "switchGateway": {
      "bn": "অন্য পোর্টাল বেছে নিন",
      "en": "Choose a different portal"
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

cat > "supporter/_template/index.html" << 'QFEOF'
<!DOCTYPE html>
<html lang="bn">
<head>
<meta charset="utf-8">
<title>সহযোগিতার প্রোফাইল</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta name="robots" content="noindex,nofollow">
<meta name="theme-color" content="#0a3a31">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Hind+Siliguri:wght@400;500;600;700&family=Tiro+Bangla:ital@0;1&display=swap" rel="stylesheet">
<style>
:root{
  --night:#0a3a31;--emerald:#136b55;--gold:#b8892d;--gold-deep:#83600f;--gold-soft:#ead9a6;
  --bg:#f1f5f0;--white:#ffffff;--ink:#15221d;--muted:#586a62;--line:#d5ddd3;
  --serif:'Tiro Bangla','Noto Serif Bengali',Georgia,serif;--sans:'Hind Siliguri','Noto Sans Bengali',system-ui,sans-serif;
  --star: polygon(50.00% 0.00%,64.64% 14.64%,85.36% 14.64%,85.36% 35.36%,100.00% 50.00%,85.36% 64.64%,85.36% 85.36%,64.64% 85.36%,50.00% 100.00%,35.36% 85.36%,14.64% 85.36%,14.64% 64.64%,0.00% 50.00%,14.64% 35.36%,14.64% 14.64%,35.36% 14.64%);
  --lattice:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='72' height='72' viewBox='0 0 72 72'%3E%3Cg fill='none' stroke='%23ead9a6' stroke-opacity='.12' stroke-width='1.2'%3E%3Crect x='16' y='16' width='40' height='40'/%3E%3Crect x='16' y='16' width='40' height='40' transform='rotate(45 36 36)'/%3E%3C/g%3E%3C/svg%3E");
}
*{box-sizing:border-box}
body{margin:0;background:var(--bg);color:var(--ink);font:16px/1.7 var(--sans)}
a{color:var(--emerald)}
img{max-width:100%}
.hidden{display:none!important}
.invisible{visibility:hidden}
:focus-visible{outline:3px solid var(--gold);outline-offset:2px}

.langbar{position:fixed;top:12px;right:12px;z-index:90;display:flex;gap:2px;padding:3px;background:rgba(10,58,49,.92);border:1px solid rgba(234,217,166,.5);border-radius:999px}
.langbar button{border:0;background:transparent;color:var(--gold-soft);border-radius:999px;padding:3px 12px;font-size:.9rem;cursor:pointer}
.langbar button[aria-pressed="true"]{background:var(--gold-soft);color:var(--night);font-weight:600}

#lockScreen{position:relative;min-height:100vh;min-height:100dvh;display:grid;place-items:center;padding:72px 20px 32px;background:radial-gradient(120% 90% at 50% 0%,#12604e 0%,var(--night) 62%)}
#lockScreen::before{content:"";position:absolute;inset:0;background-image:var(--lattice);pointer-events:none}
.lock-card{position:relative;width:100%;max-width:420px;text-align:center;background:var(--white);border-top:4px solid var(--gold);border-radius:4px;padding:30px 24px 24px;box-shadow:0 24px 60px rgba(0,0,0,.35)}
.lock-logo{width:56px;height:56px;border-radius:8px}
.lock-greet{margin-top:10px;font-family:var(--serif);color:var(--gold-deep);font-size:1.1rem}
.lock-card h1{margin:0;font-family:var(--serif);font-weight:400;font-size:1.9rem;line-height:1.3;color:var(--night)}
.lock-for{margin-top:6px;font-weight:600}
.lock-sub{margin-top:4px;color:var(--muted);font-size:.95rem}
.lock-card input{width:100%;margin-top:18px;padding:11px 14px;font:inherit;border:1px solid #b9c4bb;border-radius:4px;background:#fbfdfb}
.lock-card input:focus{border-color:var(--emerald);outline:3px solid rgba(19,107,85,.25);outline-offset:0}
.btn{display:inline-flex;align-items:center;justify-content:center;gap:10px;border:0;border-radius:4px;padding:12px 22px;font:600 1.05rem var(--sans);cursor:pointer}
.btn-solid{width:100%;margin-top:12px;background:var(--emerald);color:#fff}
.btn-solid:hover{background:var(--night)}
#lockMsg{min-height:1.7em;margin-top:10px;color:#a12b2b;font-size:.95rem}
.lock-contact{margin-top:10px;font-size:.82rem;color:var(--muted);border-top:1px solid var(--line);padding-top:12px}
#loadError{position:relative;max-width:420px;margin:60px auto;background:#fff;border-top:4px solid #a12b2b;border-radius:4px;padding:20px;color:#7a1f1f;font-size:.95rem}

.hero{position:relative;overflow:hidden;color:#fff;padding:18px 20px 44px;background:linear-gradient(180deg,var(--night),#0e4a3e)}
.hero::before{content:"";position:absolute;inset:0;background-image:var(--lattice);pointer-events:none}
.hero::after{content:"";position:absolute;left:0;right:0;bottom:0;height:4px;background:linear-gradient(90deg,transparent,var(--gold),transparent)}
.hero-inner{position:relative;max-width:820px;margin:0 auto}
.brandrow{display:inline-flex;align-items:center;gap:10px;max-width:calc(100% - 130px);color:var(--gold-soft);text-decoration:none;font-weight:600}
.brandrow img{width:36px;height:36px;border-radius:6px;background:#fff;flex:none}
.switch{display:flex;width:fit-content;margin-top:14px;padding:6px 16px;border:1px solid var(--gold-soft);border-radius:999px;background:rgba(234,217,166,.12);color:var(--gold-soft);text-decoration:none;font-weight:600;font-size:.95rem}
.switch:hover{background:var(--gold-soft);color:var(--night)}
.identity{margin-top:24px;text-align:center}
.avatar{width:120px;height:120px;margin:0 auto;background:var(--gold);clip-path:var(--star);display:grid;place-items:center}
.avatar-in{width:calc(100% - 10px);height:calc(100% - 10px);background:var(--emerald);clip-path:var(--star);display:grid;place-items:center;overflow:hidden}
.avatar-in img{width:100%;height:100%;object-fit:cover}
.monogram{font-family:var(--serif);font-size:2.9rem;line-height:1;color:var(--gold-soft)}
.name{margin-top:16px;font-family:var(--serif);font-weight:400;font-size:clamp(2rem,8vw,3rem);line-height:1.2}
.roleline{margin-top:4px;color:var(--gold-soft);font-size:.98rem}

main{max-width:820px;margin:0 auto;padding:0 18px 56px}
.sec{margin-top:32px}
.sec>h2{display:flex;align-items:center;gap:14px;font-family:var(--serif);font-weight:400;font-size:1.5rem;line-height:1.3;color:var(--night)}
.sec>h2::after{content:"";flex:1;height:1px;background:linear-gradient(90deg,var(--gold),transparent)}
.sheet{margin-top:14px;background:var(--white);border:1px solid var(--line);border-top:3px solid var(--gold);border-radius:4px;padding:22px 18px 18px}

.figures{display:grid;grid-template-columns:repeat(2,1fr);gap:12px}
.fig{border-top:3px solid var(--line);padding-top:8px;min-width:0}
.fig small{display:block;color:var(--muted);font-size:.85rem}
.fig strong{display:block;font-family:var(--serif);font-weight:400;font-size:clamp(1.15rem,4.6vw,1.9rem)}
.fig.taka{border-color:var(--gold)}
.fig.copies{border-color:var(--emerald)}
.fig.copies strong{color:var(--emerald)}

.ledger{position:relative;margin-top:6px;padding-left:36px}
.ledger::before{content:"";position:absolute;left:11px;top:8px;bottom:8px;width:2px;background:linear-gradient(var(--gold),var(--gold-soft))}
.entry{position:relative;padding-bottom:22px}
.entry:last-child{padding-bottom:0}
.node{position:absolute;left:-36px;top:1px;width:24px;height:24px;background:var(--emerald);clip-path:var(--star)}
.node::after{content:"";position:absolute;inset:4px;background:var(--bg);clip-path:var(--star)}
.entry-head{display:flex;justify-content:space-between;align-items:baseline;gap:12px}
.entry-head h4{margin:0;font-size:1.05rem;font-weight:600}
.entry-amt{font-family:var(--serif);font-size:1.15rem;white-space:nowrap;color:var(--emerald)}
.entry-when{color:var(--muted);font-size:.9rem}
.entry-note{margin-top:2px;font-size:.95rem}
.empty{color:var(--muted);font-size:.92rem;text-align:center;padding:8px 0}

.dist-mode{display:inline-block;margin-bottom:10px;padding:2px 12px;border-radius:999px;background:rgba(19,107,85,.1);color:var(--emerald);font-size:.85rem;font-weight:600}

.thanks{position:relative;overflow:hidden;margin-top:36px;padding:26px 22px 28px;background:var(--night);color:#fff;border-radius:4px}
.thanks::before{content:"";position:absolute;inset:0;background-image:var(--lattice);pointer-events:none}
.thanks>*{position:relative}
.thanks h2{font-family:var(--serif);font-weight:400;font-size:1.5rem;color:var(--gold-soft);margin:0}
.thanks p{margin-top:8px;max-width:62ch;color:#dbe8e2}
.note{margin-top:20px;font-size:.88rem;color:var(--muted)}
.foot{padding:22px 18px;text-align:center;background:var(--night);color:#cfe0d8;font-size:.88rem}
.foot p+p{margin-top:2px;opacity:.85}
</style>
</head>
<body>
<div class="langbar" role="group" aria-label="Language">
  <button id="langBn" type="button" onclick="setLang('bn')" aria-pressed="true">বাংলা</button>
  <button id="langEn" type="button" onclick="setLang('en')" aria-pressed="false">EN</button>
</div>

<div id="lockScreen">
  <div id="lockCard" class="lock-card invisible">
    <img class="lock-logo" data-bind-src="site.logo" data-bind-alt="site.logoAlt" alt="">
    <p class="lock-greet" data-bind="lockScreen.greeting"></p>
    <h1 data-bind="lockScreen.title"></h1>
    <p class="lock-for" data-bind="lockScreen.profileFor"></p>
    <p class="lock-sub" data-bind="lockScreen.subtitle"></p>
    <label for="passwordInput" class="sr-only" data-bind="lockScreen.passwordLabel"></label>
    <input id="passwordInput" type="password" autocomplete="current-password" data-bind-placeholder="lockScreen.placeholder">
    <button id="unlockBtn" type="button" class="btn btn-solid" onclick="unlock()" data-bind="lockScreen.button"></button>
    <p id="lockMsg" role="alert"></p>
    <p class="lock-contact"><span data-bind="lockScreen.contactNote"></span> <strong data-bind="lockScreen.contactEmail"></strong></p>
  </div>
  <div id="loadError" class="hidden" role="alert"></div>
</div>

<div id="app" class="hidden">
  <header class="hero"><div class="hero-inner">
    <a class="brandrow" data-bind-href="site.homeUrl">
      <img data-bind-src="site.logo" data-bind-alt="site.logoAlt" alt="">
      <span data-bind="site.brand"></span>
    </a>
    <a class="switch" data-bind-href="site.gatewayUrl" data-bind="ui.switchGateway"></a>
    <div class="identity">
      <div class="avatar"><div class="avatar-in" id="avatarInner"></div></div>
      <h1 class="name" data-bind="person.name"></h1>
      <p class="roleline" data-bind="person.role"></p>
    </div>
  </div></header>

  <main>
    <section class="sec">
      <h2 data-bind="ui.summaryTitle"></h2>
      <div class="sheet">
        <div class="figures">
          <div class="fig taka"><small data-bind="ui.tiles.taka"></small><strong id="figTaka"></strong></div>
          <div class="fig copies"><small data-bind="ui.tiles.copies"></small><strong id="figCopies"></strong></div>
        </div>
      </div>
    </section>

    <section class="sec">
      <h2 data-bind="ui.ledgerTitle"></h2>
      <ol class="ledger" id="ledger"></ol>
    </section>

    <section class="sec hidden" id="distSection">
      <h2 data-bind="ui.distTitle"></h2>
      <div class="sheet">
        <span class="dist-mode" id="distMode"></span>
        <p id="distNote"></p>
        <ol class="ledger" id="distLedger" style="margin-top:16px"></ol>
      </div>
    </section>

    <section class="thanks">
      <h2 data-bind="ui.thanksTitle"></h2>
      <p data-bind="ui.thanksText"></p>
    </section>

    <p class="note" data-bind="ui.recordNote"></p>
  </main>

  <footer class="foot">
    <p data-bind="footer.copyright"></p>
    <p data-bind="footer.tagline"></p>
  </footer>
</div>

<script>
const DATA_URL='data.json';
let DATA=null,LANG='bn',TZ='Asia/Dhaka';
const $=id=>document.getElementById(id);
const get=path=>path.split('.').reduce((o,k)=>(o==null?undefined:o[k]),DATA);
const tr=v=>(v!==null&&typeof v==='object')?(v[LANG]??v.en??v.bn??''):(v??'');
const T=path=>tr(get(path));
const fill=(tpl,vars)=>String(tpl).replace(/\{(\w+)\}/g,(_,k)=>(k in vars?vars[k]:''));

const LOC=()=>LANG==='bn'?{num:'bn-BD',date:'bn-BD'}:{num:'en-US',date:'en-GB'};
const nfmt=n=>new Intl.NumberFormat(LOC().num,{maximumFractionDigits:2}).format(n);
const money=n=>`${DATA.site.currencySymbol} ${nfmt(n)}`;
const emailVar=()=>DATA.lockScreen.contactEmail;
const when=s=>new Date(String(s).includes('T')?s:s+'T12:00:00+06:00');
const fmtDate=d=>new Intl.DateTimeFormat(LOC().date,{timeZone:TZ,day:'numeric',month:'long',year:'numeric'}).format(d);

function vars(){
  const t=totals();
  return { taka: money(t.taka), copies: nfmt(t.copies), email: emailVar() };
}
const TT=path=>fill(T(path),vars());

const BIND_ATTRS=['href','src','alt','placeholder','aria-label'];
function applyBindings(){
  document.querySelectorAll('[data-bind]').forEach(el=>{ el.textContent=TT(el.getAttribute('data-bind')); });
  BIND_ATTRS.forEach(attr=>{
    document.querySelectorAll('[data-bind-'+attr+']').forEach(el=>{
      const prefix=el.getAttribute('data-prefix')||'';
      el.setAttribute(attr, prefix+TT(el.getAttribute('data-bind-'+attr)));
    });
  });
  document.title=TT('site.title');
}

function h(tag,attrs,...kids){
  const el=document.createElement(tag);
  Object.entries(attrs||{}).forEach(([k,v])=>{ if(v===false||v==null)return; if(k==='class')el.className=v; else el.setAttribute(k,v===true?'':v); });
  kids.flat().forEach(k=>{ if(k==null||k===false)return; el.append(k instanceof Node?k:document.createTextNode(String(k))); });
  return el;
}

function totals(){
  const entries=(DATA.contributions&&DATA.contributions.entries)||[];
  const taka=entries.reduce((s,e)=>s+(Number(e.amount)||0),0);
  const copies=entries.reduce((s,e)=>s+(Number(e.quranCopies)||0),0);
  return {taka,copies};
}

function renderHero(){
  const av=$('avatarInner'); av.textContent='';
  if(DATA.person.photo) av.append(h('img',{src:DATA.person.photo,alt:T('person.name')}));
  else av.append(h('span',{class:'monogram'},T('person.monogram')));
}

function renderSummary(){
  const t=totals();
  $('figTaka').textContent=money(t.taka);
  $('figCopies').textContent=nfmt(t.copies);
}

function renderLedger(){
  const ol=$('ledger'); ol.textContent='';
  const entries=(DATA.contributions&&DATA.contributions.entries)||[];
  if(!entries.length){ ol.append(h('li',{class:'empty'},T('ui.noEntries'))); return; }
  entries.forEach(e=>{
    const parts=[];
    if(e.amount) parts.push(money(e.amount));
    if(e.quranCopies) parts.push(nfmt(e.quranCopies)+' '+T('ui.tiles.copiesShort'));
    ol.append(h('li',{class:'entry'},
      h('span',{class:'node','aria-hidden':'true'}),
      h('div',{class:'entry-head'}, h('h4',{},tr(e.title)), h('span',{class:'entry-amt'},parts.join(' + '))),
      h('p',{class:'entry-when'}, e.date ? fmtDate(when(e.date)) : (e.dateLabel ? tr(e.dateLabel) : '')),
      e.note?h('p',{class:'entry-note'}, fill(tr(e.note),vars())):null));
  });
}

function renderDistribution(){
  const D=DATA.distribution;
  const section=$('distSection');
  if(!D || (!D.mode && (!D.entries || !D.entries.length))){ section.classList.add('hidden'); return; }
  section.classList.remove('hidden');
  $('distMode').textContent = D.mode ? T('ui.distModes.'+D.mode) : '';
  $('distNote').textContent = D.note ? fill(tr(D.note),vars()) : '';
  const ol=$('distLedger'); ol.textContent='';
  const entries=D.entries||[];
  if(!entries.length){ return; }
  entries.forEach(e=>{
    ol.append(h('li',{class:'entry'},
      h('span',{class:'node','aria-hidden':'true'}),
      h('div',{class:'entry-head'}, h('h4',{},tr(e.area)), h('span',{class:'entry-amt'}, nfmt(e.copies)+' '+T('ui.tiles.copiesShort'))),
      h('p',{class:'entry-when'}, e.date ? fmtDate(when(e.date)) : (e.dateLabel ? tr(e.dateLabel) : '')),
      e.note?h('p',{class:'entry-note'}, fill(tr(e.note),vars())):null));
  });
}

function setLang(lang){
  if(!DATA)return;
  LANG = lang==='en'?'en':'bn';
  document.documentElement.lang=LANG;
  $('langBn').setAttribute('aria-pressed',String(LANG==='bn'));
  $('langEn').setAttribute('aria-pressed',String(LANG==='en'));
  applyBindings(); renderHero(); renderSummary(); renderLedger(); renderDistribution();
}

async function sha256Hex(text){
  const buf=await crypto.subtle.digest('SHA-256',new TextEncoder().encode(text));
  return Array.from(new Uint8Array(buf)).map(b=>b.toString(16).padStart(2,'0')).join('');
}

async function unlock(){
  if(!DATA)return;
  const msg=$('lockMsg');
  let ok=false;
  try{
    const hash=await sha256Hex($('passwordInput').value);
    ok = hash===String(DATA.security.passwordSha256||'').toLowerCase();
  }catch(e){ msg.textContent='Password check needs HTTPS or localhost.'; return; }
  if(!ok){ msg.textContent=T('lockScreen.wrongPassword'); return; }
  msg.textContent=''; $('passwordInput').value='';
  $('lockScreen').classList.add('hidden');
  $('app').classList.remove('hidden');
  window.scrollTo(0,0);
}

$('passwordInput').addEventListener('keydown', e=>{ if(e.key==='Enter') unlock(); });

(async function init(){
  try{
    const res=await fetch(DATA_URL,{cache:'no-store'});
    if(!res.ok) throw new Error('HTTP '+res.status);
    DATA=await res.json();
  }catch(err){
    $('lockCard').classList.add('hidden');
    const box=$('loadError');
    box.textContent='Could not load '+DATA_URL+' ('+err.message+'). Keep it in the same folder as this page and open it through a web server.';
    box.classList.remove('hidden');
    return;
  }
  TZ=DATA.site.timezone||'Asia/Dhaka';
  setLang(DATA.site.defaultLang||'bn');
  $('lockCard').classList.remove('invisible');
})();
</script>
</body>
</html>
QFEOF

cat > "supporter/rafika-sultana/data.json" << 'QFEOF'
{
  "_readme": "মোসাঃ রফিকা সুলতানার প্রকৃত প্রোফাইল। security.passwordSha256 এখনো ফাঁকা — hash-generator.html দিয়ে একটি পাসওয়ার্ড ঠিক করে হ্যাশ বসান, তারপর gateway এর data.json এ supporter role এর users[] এ username যোগ করুন।",
  "site": {
    "title": {
      "bn": "মোসাঃ রফিকা সুলতানার সহায়তা প্রোফাইল",
      "en": "Support profile of Mosammat Rafika Sultana"
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
    "gatewayUrl": "../../",
    "defaultLang": "bn",
    "timezone": "Asia/Dhaka",
    "currencySymbol": "৳",
    "currencyWord": {
      "bn": "টাকা",
      "en": "Tk."
    }
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
      "bn": "মোসাঃ রফিকা সুলতানার ব্যক্তিগত সহায়তা প্রোফাইল",
      "en": "Personal support profile of Mosammat Rafika Sultana"
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
  "person": {
    "photo": "",
    "monogram": {
      "bn": "র",
      "en": "R"
    },
    "name": {
      "bn": "মোসাঃ রফিকা সুলতানা",
      "en": "Mosammat Rafika Sultana"
    },
    "role": {
      "bn": "সাপোর্টার",
      "en": "Supporter"
    }
  },
  "contributions": {
    "entries": [
      {
        "type": "support",
        "dateLabel": {
          "bn": "গত মাসে",
          "en": "Last month"
        },
        "title": {
          "bn": "সহায়তা",
          "en": "Support"
        },
        "note": {
          "bn": "কোনো শর্ত ছাড়াই দেওয়া সহায়তা",
          "en": "Support given without any condition"
        },
        "amount": 2000
      }
    ]
  },
  "distribution": {
    "mode": "",
    "note": {
      "bn": "",
      "en": ""
    },
    "entries": []
  },
  "ui": {
    "summaryTitle": {
      "bn": "সহায়তার সারসংক্ষেপ",
      "en": "Support summary"
    },
    "tiles": {
      "taka": {
        "bn": "মোট সহায়তা (টাকা)",
        "en": "Total support (Tk.)"
      },
      "copies": {
        "bn": "মোট কোরআন (কপি)",
        "en": "Total Quran copies"
      },
      "copiesShort": {
        "bn": "কপি",
        "en": "copies"
      }
    },
    "ledgerTitle": {
      "bn": "সহায়তার ধারাবাহিকতা",
      "en": "Support timeline"
    },
    "noEntries": {
      "bn": "এখনো কোনো এন্ট্রি যুক্ত করা হয়নি।",
      "en": "No entries have been added yet."
    },
    "distTitle": {
      "bn": "বিতরণের হিসাব",
      "en": "Distribution record"
    },
    "distModes": {
      "organization": {
        "bn": "প্রতিষ্ঠানের মাধ্যমে বিতরণ",
        "en": "Distributed by the organization"
      },
      "self": {
        "bn": "নিজ হাতে বিতরণ করেছেন",
        "en": "Distributed personally by the donor"
      },
      "mixed": {
        "bn": "প্রতিষ্ঠান ও নিজে — উভয়ভাবে বিতরণ",
        "en": "Distributed both by the organization and personally"
      }
    },
    "thanksTitle": {
      "bn": "কৃতজ্ঞতা",
      "en": "With gratitude"
    },
    "thanksText": {
      "bn": "কোনো শর্ত বা প্রতিদানের প্রত্যাশা ছাড়াই আপনি পাশে থেকেছেন — এই আন্তরিকতা আমাদের সবচেয়ে বড় শক্তি। আল্লাহ আপনাকে উত্তম প্রতিদান দিন।",
      "en": "You stood beside us without any condition or expectation of return — that sincerity is our greatest strength. May Allah reward you well."
    },
    "recordNote": {
      "bn": "এই পাতার তথ্য সহায়তার রেকর্ড হিসেবে সংরক্ষিত। কোনো তথ্যে ভুল বা আপত্তি থাকলে জানান: {email}",
      "en": "The information on this page is kept as a record of the support given. If you find a mistake or have an objection, write to: {email}"
    },
    "switchGateway": {
      "bn": "অন্য পোর্টাল বেছে নিন",
      "en": "Choose a different portal"
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

cat > "supporter/rafika-sultana/index.html" << 'QFEOF'
<!DOCTYPE html>
<html lang="bn">
<head>
<meta charset="utf-8">
<title>সহযোগিতার প্রোফাইল</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta name="robots" content="noindex,nofollow">
<meta name="theme-color" content="#0a3a31">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Hind+Siliguri:wght@400;500;600;700&family=Tiro+Bangla:ital@0;1&display=swap" rel="stylesheet">
<style>
:root{
  --night:#0a3a31;--emerald:#136b55;--gold:#b8892d;--gold-deep:#83600f;--gold-soft:#ead9a6;
  --bg:#f1f5f0;--white:#ffffff;--ink:#15221d;--muted:#586a62;--line:#d5ddd3;
  --serif:'Tiro Bangla','Noto Serif Bengali',Georgia,serif;--sans:'Hind Siliguri','Noto Sans Bengali',system-ui,sans-serif;
  --star: polygon(50.00% 0.00%,64.64% 14.64%,85.36% 14.64%,85.36% 35.36%,100.00% 50.00%,85.36% 64.64%,85.36% 85.36%,64.64% 85.36%,50.00% 100.00%,35.36% 85.36%,14.64% 85.36%,14.64% 64.64%,0.00% 50.00%,14.64% 35.36%,14.64% 14.64%,35.36% 14.64%);
  --lattice:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='72' height='72' viewBox='0 0 72 72'%3E%3Cg fill='none' stroke='%23ead9a6' stroke-opacity='.12' stroke-width='1.2'%3E%3Crect x='16' y='16' width='40' height='40'/%3E%3Crect x='16' y='16' width='40' height='40' transform='rotate(45 36 36)'/%3E%3C/g%3E%3C/svg%3E");
}
*{box-sizing:border-box}
body{margin:0;background:var(--bg);color:var(--ink);font:16px/1.7 var(--sans)}
a{color:var(--emerald)}
img{max-width:100%}
.hidden{display:none!important}
.invisible{visibility:hidden}
:focus-visible{outline:3px solid var(--gold);outline-offset:2px}

.langbar{position:fixed;top:12px;right:12px;z-index:90;display:flex;gap:2px;padding:3px;background:rgba(10,58,49,.92);border:1px solid rgba(234,217,166,.5);border-radius:999px}
.langbar button{border:0;background:transparent;color:var(--gold-soft);border-radius:999px;padding:3px 12px;font-size:.9rem;cursor:pointer}
.langbar button[aria-pressed="true"]{background:var(--gold-soft);color:var(--night);font-weight:600}

#lockScreen{position:relative;min-height:100vh;min-height:100dvh;display:grid;place-items:center;padding:72px 20px 32px;background:radial-gradient(120% 90% at 50% 0%,#12604e 0%,var(--night) 62%)}
#lockScreen::before{content:"";position:absolute;inset:0;background-image:var(--lattice);pointer-events:none}
.lock-card{position:relative;width:100%;max-width:420px;text-align:center;background:var(--white);border-top:4px solid var(--gold);border-radius:4px;padding:30px 24px 24px;box-shadow:0 24px 60px rgba(0,0,0,.35)}
.lock-logo{width:56px;height:56px;border-radius:8px}
.lock-greet{margin-top:10px;font-family:var(--serif);color:var(--gold-deep);font-size:1.1rem}
.lock-card h1{margin:0;font-family:var(--serif);font-weight:400;font-size:1.9rem;line-height:1.3;color:var(--night)}
.lock-for{margin-top:6px;font-weight:600}
.lock-sub{margin-top:4px;color:var(--muted);font-size:.95rem}
.lock-card input{width:100%;margin-top:18px;padding:11px 14px;font:inherit;border:1px solid #b9c4bb;border-radius:4px;background:#fbfdfb}
.lock-card input:focus{border-color:var(--emerald);outline:3px solid rgba(19,107,85,.25);outline-offset:0}
.btn{display:inline-flex;align-items:center;justify-content:center;gap:10px;border:0;border-radius:4px;padding:12px 22px;font:600 1.05rem var(--sans);cursor:pointer}
.btn-solid{width:100%;margin-top:12px;background:var(--emerald);color:#fff}
.btn-solid:hover{background:var(--night)}
#lockMsg{min-height:1.7em;margin-top:10px;color:#a12b2b;font-size:.95rem}
.lock-contact{margin-top:10px;font-size:.82rem;color:var(--muted);border-top:1px solid var(--line);padding-top:12px}
#loadError{position:relative;max-width:420px;margin:60px auto;background:#fff;border-top:4px solid #a12b2b;border-radius:4px;padding:20px;color:#7a1f1f;font-size:.95rem}

.hero{position:relative;overflow:hidden;color:#fff;padding:18px 20px 44px;background:linear-gradient(180deg,var(--night),#0e4a3e)}
.hero::before{content:"";position:absolute;inset:0;background-image:var(--lattice);pointer-events:none}
.hero::after{content:"";position:absolute;left:0;right:0;bottom:0;height:4px;background:linear-gradient(90deg,transparent,var(--gold),transparent)}
.hero-inner{position:relative;max-width:820px;margin:0 auto}
.brandrow{display:inline-flex;align-items:center;gap:10px;max-width:calc(100% - 130px);color:var(--gold-soft);text-decoration:none;font-weight:600}
.brandrow img{width:36px;height:36px;border-radius:6px;background:#fff;flex:none}
.switch{display:flex;width:fit-content;margin-top:14px;padding:6px 16px;border:1px solid var(--gold-soft);border-radius:999px;background:rgba(234,217,166,.12);color:var(--gold-soft);text-decoration:none;font-weight:600;font-size:.95rem}
.switch:hover{background:var(--gold-soft);color:var(--night)}
.identity{margin-top:24px;text-align:center}
.avatar{width:120px;height:120px;margin:0 auto;background:var(--gold);clip-path:var(--star);display:grid;place-items:center}
.avatar-in{width:calc(100% - 10px);height:calc(100% - 10px);background:var(--emerald);clip-path:var(--star);display:grid;place-items:center;overflow:hidden}
.avatar-in img{width:100%;height:100%;object-fit:cover}
.monogram{font-family:var(--serif);font-size:2.9rem;line-height:1;color:var(--gold-soft)}
.name{margin-top:16px;font-family:var(--serif);font-weight:400;font-size:clamp(2rem,8vw,3rem);line-height:1.2}
.roleline{margin-top:4px;color:var(--gold-soft);font-size:.98rem}

main{max-width:820px;margin:0 auto;padding:0 18px 56px}
.sec{margin-top:32px}
.sec>h2{display:flex;align-items:center;gap:14px;font-family:var(--serif);font-weight:400;font-size:1.5rem;line-height:1.3;color:var(--night)}
.sec>h2::after{content:"";flex:1;height:1px;background:linear-gradient(90deg,var(--gold),transparent)}
.sheet{margin-top:14px;background:var(--white);border:1px solid var(--line);border-top:3px solid var(--gold);border-radius:4px;padding:22px 18px 18px}

.figures{display:grid;grid-template-columns:repeat(2,1fr);gap:12px}
.fig{border-top:3px solid var(--line);padding-top:8px;min-width:0}
.fig small{display:block;color:var(--muted);font-size:.85rem}
.fig strong{display:block;font-family:var(--serif);font-weight:400;font-size:clamp(1.15rem,4.6vw,1.9rem)}
.fig.taka{border-color:var(--gold)}
.fig.copies{border-color:var(--emerald)}
.fig.copies strong{color:var(--emerald)}

.ledger{position:relative;margin-top:6px;padding-left:36px}
.ledger::before{content:"";position:absolute;left:11px;top:8px;bottom:8px;width:2px;background:linear-gradient(var(--gold),var(--gold-soft))}
.entry{position:relative;padding-bottom:22px}
.entry:last-child{padding-bottom:0}
.node{position:absolute;left:-36px;top:1px;width:24px;height:24px;background:var(--emerald);clip-path:var(--star)}
.node::after{content:"";position:absolute;inset:4px;background:var(--bg);clip-path:var(--star)}
.entry-head{display:flex;justify-content:space-between;align-items:baseline;gap:12px}
.entry-head h4{margin:0;font-size:1.05rem;font-weight:600}
.entry-amt{font-family:var(--serif);font-size:1.15rem;white-space:nowrap;color:var(--emerald)}
.entry-when{color:var(--muted);font-size:.9rem}
.entry-note{margin-top:2px;font-size:.95rem}
.empty{color:var(--muted);font-size:.92rem;text-align:center;padding:8px 0}

.dist-mode{display:inline-block;margin-bottom:10px;padding:2px 12px;border-radius:999px;background:rgba(19,107,85,.1);color:var(--emerald);font-size:.85rem;font-weight:600}

.thanks{position:relative;overflow:hidden;margin-top:36px;padding:26px 22px 28px;background:var(--night);color:#fff;border-radius:4px}
.thanks::before{content:"";position:absolute;inset:0;background-image:var(--lattice);pointer-events:none}
.thanks>*{position:relative}
.thanks h2{font-family:var(--serif);font-weight:400;font-size:1.5rem;color:var(--gold-soft);margin:0}
.thanks p{margin-top:8px;max-width:62ch;color:#dbe8e2}
.note{margin-top:20px;font-size:.88rem;color:var(--muted)}
.foot{padding:22px 18px;text-align:center;background:var(--night);color:#cfe0d8;font-size:.88rem}
.foot p+p{margin-top:2px;opacity:.85}
</style>
</head>
<body>
<div class="langbar" role="group" aria-label="Language">
  <button id="langBn" type="button" onclick="setLang('bn')" aria-pressed="true">বাংলা</button>
  <button id="langEn" type="button" onclick="setLang('en')" aria-pressed="false">EN</button>
</div>

<div id="lockScreen">
  <div id="lockCard" class="lock-card invisible">
    <img class="lock-logo" data-bind-src="site.logo" data-bind-alt="site.logoAlt" alt="">
    <p class="lock-greet" data-bind="lockScreen.greeting"></p>
    <h1 data-bind="lockScreen.title"></h1>
    <p class="lock-for" data-bind="lockScreen.profileFor"></p>
    <p class="lock-sub" data-bind="lockScreen.subtitle"></p>
    <label for="passwordInput" class="sr-only" data-bind="lockScreen.passwordLabel"></label>
    <input id="passwordInput" type="password" autocomplete="current-password" data-bind-placeholder="lockScreen.placeholder">
    <button id="unlockBtn" type="button" class="btn btn-solid" onclick="unlock()" data-bind="lockScreen.button"></button>
    <p id="lockMsg" role="alert"></p>
    <p class="lock-contact"><span data-bind="lockScreen.contactNote"></span> <strong data-bind="lockScreen.contactEmail"></strong></p>
  </div>
  <div id="loadError" class="hidden" role="alert"></div>
</div>

<div id="app" class="hidden">
  <header class="hero"><div class="hero-inner">
    <a class="brandrow" data-bind-href="site.homeUrl">
      <img data-bind-src="site.logo" data-bind-alt="site.logoAlt" alt="">
      <span data-bind="site.brand"></span>
    </a>
    <a class="switch" data-bind-href="site.gatewayUrl" data-bind="ui.switchGateway"></a>
    <div class="identity">
      <div class="avatar"><div class="avatar-in" id="avatarInner"></div></div>
      <h1 class="name" data-bind="person.name"></h1>
      <p class="roleline" data-bind="person.role"></p>
    </div>
  </div></header>

  <main>
    <section class="sec">
      <h2 data-bind="ui.summaryTitle"></h2>
      <div class="sheet">
        <div class="figures">
          <div class="fig taka"><small data-bind="ui.tiles.taka"></small><strong id="figTaka"></strong></div>
          <div class="fig copies"><small data-bind="ui.tiles.copies"></small><strong id="figCopies"></strong></div>
        </div>
      </div>
    </section>

    <section class="sec">
      <h2 data-bind="ui.ledgerTitle"></h2>
      <ol class="ledger" id="ledger"></ol>
    </section>

    <section class="sec hidden" id="distSection">
      <h2 data-bind="ui.distTitle"></h2>
      <div class="sheet">
        <span class="dist-mode" id="distMode"></span>
        <p id="distNote"></p>
        <ol class="ledger" id="distLedger" style="margin-top:16px"></ol>
      </div>
    </section>

    <section class="thanks">
      <h2 data-bind="ui.thanksTitle"></h2>
      <p data-bind="ui.thanksText"></p>
    </section>

    <p class="note" data-bind="ui.recordNote"></p>
  </main>

  <footer class="foot">
    <p data-bind="footer.copyright"></p>
    <p data-bind="footer.tagline"></p>
  </footer>
</div>

<script>
const DATA_URL='data.json';
let DATA=null,LANG='bn',TZ='Asia/Dhaka';
const $=id=>document.getElementById(id);
const get=path=>path.split('.').reduce((o,k)=>(o==null?undefined:o[k]),DATA);
const tr=v=>(v!==null&&typeof v==='object')?(v[LANG]??v.en??v.bn??''):(v??'');
const T=path=>tr(get(path));
const fill=(tpl,vars)=>String(tpl).replace(/\{(\w+)\}/g,(_,k)=>(k in vars?vars[k]:''));

const LOC=()=>LANG==='bn'?{num:'bn-BD',date:'bn-BD'}:{num:'en-US',date:'en-GB'};
const nfmt=n=>new Intl.NumberFormat(LOC().num,{maximumFractionDigits:2}).format(n);
const money=n=>`${DATA.site.currencySymbol} ${nfmt(n)}`;
const emailVar=()=>DATA.lockScreen.contactEmail;
const when=s=>new Date(String(s).includes('T')?s:s+'T12:00:00+06:00');
const fmtDate=d=>new Intl.DateTimeFormat(LOC().date,{timeZone:TZ,day:'numeric',month:'long',year:'numeric'}).format(d);

function vars(){
  const t=totals();
  return { taka: money(t.taka), copies: nfmt(t.copies), email: emailVar() };
}
const TT=path=>fill(T(path),vars());

const BIND_ATTRS=['href','src','alt','placeholder','aria-label'];
function applyBindings(){
  document.querySelectorAll('[data-bind]').forEach(el=>{ el.textContent=TT(el.getAttribute('data-bind')); });
  BIND_ATTRS.forEach(attr=>{
    document.querySelectorAll('[data-bind-'+attr+']').forEach(el=>{
      const prefix=el.getAttribute('data-prefix')||'';
      el.setAttribute(attr, prefix+TT(el.getAttribute('data-bind-'+attr)));
    });
  });
  document.title=TT('site.title');
}

function h(tag,attrs,...kids){
  const el=document.createElement(tag);
  Object.entries(attrs||{}).forEach(([k,v])=>{ if(v===false||v==null)return; if(k==='class')el.className=v; else el.setAttribute(k,v===true?'':v); });
  kids.flat().forEach(k=>{ if(k==null||k===false)return; el.append(k instanceof Node?k:document.createTextNode(String(k))); });
  return el;
}

function totals(){
  const entries=(DATA.contributions&&DATA.contributions.entries)||[];
  const taka=entries.reduce((s,e)=>s+(Number(e.amount)||0),0);
  const copies=entries.reduce((s,e)=>s+(Number(e.quranCopies)||0),0);
  return {taka,copies};
}

function renderHero(){
  const av=$('avatarInner'); av.textContent='';
  if(DATA.person.photo) av.append(h('img',{src:DATA.person.photo,alt:T('person.name')}));
  else av.append(h('span',{class:'monogram'},T('person.monogram')));
}

function renderSummary(){
  const t=totals();
  $('figTaka').textContent=money(t.taka);
  $('figCopies').textContent=nfmt(t.copies);
}

function renderLedger(){
  const ol=$('ledger'); ol.textContent='';
  const entries=(DATA.contributions&&DATA.contributions.entries)||[];
  if(!entries.length){ ol.append(h('li',{class:'empty'},T('ui.noEntries'))); return; }
  entries.forEach(e=>{
    const parts=[];
    if(e.amount) parts.push(money(e.amount));
    if(e.quranCopies) parts.push(nfmt(e.quranCopies)+' '+T('ui.tiles.copiesShort'));
    ol.append(h('li',{class:'entry'},
      h('span',{class:'node','aria-hidden':'true'}),
      h('div',{class:'entry-head'}, h('h4',{},tr(e.title)), h('span',{class:'entry-amt'},parts.join(' + '))),
      h('p',{class:'entry-when'}, e.date ? fmtDate(when(e.date)) : (e.dateLabel ? tr(e.dateLabel) : '')),
      e.note?h('p',{class:'entry-note'}, fill(tr(e.note),vars())):null));
  });
}

function renderDistribution(){
  const D=DATA.distribution;
  const section=$('distSection');
  if(!D || (!D.mode && (!D.entries || !D.entries.length))){ section.classList.add('hidden'); return; }
  section.classList.remove('hidden');
  $('distMode').textContent = D.mode ? T('ui.distModes.'+D.mode) : '';
  $('distNote').textContent = D.note ? fill(tr(D.note),vars()) : '';
  const ol=$('distLedger'); ol.textContent='';
  const entries=D.entries||[];
  if(!entries.length){ return; }
  entries.forEach(e=>{
    ol.append(h('li',{class:'entry'},
      h('span',{class:'node','aria-hidden':'true'}),
      h('div',{class:'entry-head'}, h('h4',{},tr(e.area)), h('span',{class:'entry-amt'}, nfmt(e.copies)+' '+T('ui.tiles.copiesShort'))),
      h('p',{class:'entry-when'}, e.date ? fmtDate(when(e.date)) : (e.dateLabel ? tr(e.dateLabel) : '')),
      e.note?h('p',{class:'entry-note'}, fill(tr(e.note),vars())):null));
  });
}

function setLang(lang){
  if(!DATA)return;
  LANG = lang==='en'?'en':'bn';
  document.documentElement.lang=LANG;
  $('langBn').setAttribute('aria-pressed',String(LANG==='bn'));
  $('langEn').setAttribute('aria-pressed',String(LANG==='en'));
  applyBindings(); renderHero(); renderSummary(); renderLedger(); renderDistribution();
}

async function sha256Hex(text){
  const buf=await crypto.subtle.digest('SHA-256',new TextEncoder().encode(text));
  return Array.from(new Uint8Array(buf)).map(b=>b.toString(16).padStart(2,'0')).join('');
}

async function unlock(){
  if(!DATA)return;
  const msg=$('lockMsg');
  let ok=false;
  try{
    const hash=await sha256Hex($('passwordInput').value);
    ok = hash===String(DATA.security.passwordSha256||'').toLowerCase();
  }catch(e){ msg.textContent='Password check needs HTTPS or localhost.'; return; }
  if(!ok){ msg.textContent=T('lockScreen.wrongPassword'); return; }
  msg.textContent=''; $('passwordInput').value='';
  $('lockScreen').classList.add('hidden');
  $('app').classList.remove('hidden');
  window.scrollTo(0,0);
}

$('passwordInput').addEventListener('keydown', e=>{ if(e.key==='Enter') unlock(); });

(async function init(){
  try{
    const res=await fetch(DATA_URL,{cache:'no-store'});
    if(!res.ok) throw new Error('HTTP '+res.status);
    DATA=await res.json();
  }catch(err){
    $('lockCard').classList.add('hidden');
    const box=$('loadError');
    box.textContent='Could not load '+DATA_URL+' ('+err.message+'). Keep it in the same folder as this page and open it through a web server.';
    box.classList.remove('hidden');
    return;
  }
  TZ=DATA.site.timezone||'Asia/Dhaka';
  setLang(DATA.site.defaultLang||'bn');
  $('lockCard').classList.remove('invisible');
})();
</script>
</body>
</html>
QFEOF

cat > "supporter/arefa-begum/data.json" << 'QFEOF'
{
  "_readme": "মোসাঃ আরেফা বেগমের প্রকৃত প্রোফাইল — এর মধ্যে একটি এন্ট্রি অনুদান (গত বছর) ও একটি নিঃশর্ত সহায়তা (গত মাসে)। security.passwordSha256 এখনো ফাঁকা — hash-generator.html দিয়ে একটি পাসওয়ার্ড ঠিক করে হ্যাশ বসান, তারপর gateway এর data.json এ supporter role এর users[] এ username যোগ করুন।",
  "site": {
    "title": {
      "bn": "মোসাঃ আরেফা বেগমর সহায়তা প্রোফাইল",
      "en": "Support profile of Mosammat Arefa Begum"
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
    "gatewayUrl": "../../",
    "defaultLang": "bn",
    "timezone": "Asia/Dhaka",
    "currencySymbol": "৳",
    "currencyWord": {
      "bn": "টাকা",
      "en": "Tk."
    }
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
      "bn": "মোসাঃ আরেফা বেগমর ব্যক্তিগত সহায়তা প্রোফাইল",
      "en": "Personal support profile of Mosammat Arefa Begum"
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
  "person": {
    "photo": "",
    "monogram": {
      "bn": "আ",
      "en": "A"
    },
    "name": {
      "bn": "মোসাঃ আরেফা বেগম",
      "en": "Mosammat Arefa Begum"
    },
    "role": {
      "bn": "সাপোর্টার",
      "en": "Supporter"
    }
  },
  "contributions": {
    "entries": [
      {
        "type": "donation",
        "dateLabel": {
          "bn": "গত বছর",
          "en": "Last year"
        },
        "title": {
          "bn": "অনুদান",
          "en": "Donation"
        },
        "note": {
          "bn": "বিতরণ কার্যক্রমে অনুদান",
          "en": "Donation to the distribution effort"
        },
        "amount": 1000
      },
      {
        "type": "support",
        "dateLabel": {
          "bn": "গত মাসে",
          "en": "Last month"
        },
        "title": {
          "bn": "সহায়তা",
          "en": "Support"
        },
        "note": {
          "bn": "কোনো শর্ত ছাড়াই দেওয়া সহায়তা",
          "en": "Support given without any condition"
        },
        "amount": 1000
      }
    ]
  },
  "distribution": {
    "mode": "",
    "note": {
      "bn": "",
      "en": ""
    },
    "entries": []
  },
  "ui": {
    "summaryTitle": {
      "bn": "সহায়তার সারসংক্ষেপ",
      "en": "Support summary"
    },
    "tiles": {
      "taka": {
        "bn": "মোট সহায়তা (টাকা)",
        "en": "Total support (Tk.)"
      },
      "copies": {
        "bn": "মোট কোরআন (কপি)",
        "en": "Total Quran copies"
      },
      "copiesShort": {
        "bn": "কপি",
        "en": "copies"
      }
    },
    "ledgerTitle": {
      "bn": "সহায়তার ধারাবাহিকতা",
      "en": "Support timeline"
    },
    "noEntries": {
      "bn": "এখনো কোনো এন্ট্রি যুক্ত করা হয়নি।",
      "en": "No entries have been added yet."
    },
    "distTitle": {
      "bn": "বিতরণের হিসাব",
      "en": "Distribution record"
    },
    "distModes": {
      "organization": {
        "bn": "প্রতিষ্ঠানের মাধ্যমে বিতরণ",
        "en": "Distributed by the organization"
      },
      "self": {
        "bn": "নিজ হাতে বিতরণ করেছেন",
        "en": "Distributed personally by the donor"
      },
      "mixed": {
        "bn": "প্রতিষ্ঠান ও নিজে — উভয়ভাবে বিতরণ",
        "en": "Distributed both by the organization and personally"
      }
    },
    "thanksTitle": {
      "bn": "কৃতজ্ঞতা",
      "en": "With gratitude"
    },
    "thanksText": {
      "bn": "কোনো শর্ত বা প্রতিদানের প্রত্যাশা ছাড়াই আপনি পাশে থেকেছেন — এই আন্তরিকতা আমাদের সবচেয়ে বড় শক্তি। আল্লাহ আপনাকে উত্তম প্রতিদান দিন।",
      "en": "You stood beside us without any condition or expectation of return — that sincerity is our greatest strength. May Allah reward you well."
    },
    "recordNote": {
      "bn": "এই পাতার তথ্য সহায়তার রেকর্ড হিসেবে সংরক্ষিত। কোনো তথ্যে ভুল বা আপত্তি থাকলে জানান: {email}",
      "en": "The information on this page is kept as a record of the support given. If you find a mistake or have an objection, write to: {email}"
    },
    "switchGateway": {
      "bn": "অন্য পোর্টাল বেছে নিন",
      "en": "Choose a different portal"
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

cat > "supporter/arefa-begum/index.html" << 'QFEOF'
<!DOCTYPE html>
<html lang="bn">
<head>
<meta charset="utf-8">
<title>সহযোগিতার প্রোফাইল</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta name="robots" content="noindex,nofollow">
<meta name="theme-color" content="#0a3a31">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Hind+Siliguri:wght@400;500;600;700&family=Tiro+Bangla:ital@0;1&display=swap" rel="stylesheet">
<style>
:root{
  --night:#0a3a31;--emerald:#136b55;--gold:#b8892d;--gold-deep:#83600f;--gold-soft:#ead9a6;
  --bg:#f1f5f0;--white:#ffffff;--ink:#15221d;--muted:#586a62;--line:#d5ddd3;
  --serif:'Tiro Bangla','Noto Serif Bengali',Georgia,serif;--sans:'Hind Siliguri','Noto Sans Bengali',system-ui,sans-serif;
  --star: polygon(50.00% 0.00%,64.64% 14.64%,85.36% 14.64%,85.36% 35.36%,100.00% 50.00%,85.36% 64.64%,85.36% 85.36%,64.64% 85.36%,50.00% 100.00%,35.36% 85.36%,14.64% 85.36%,14.64% 64.64%,0.00% 50.00%,14.64% 35.36%,14.64% 14.64%,35.36% 14.64%);
  --lattice:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='72' height='72' viewBox='0 0 72 72'%3E%3Cg fill='none' stroke='%23ead9a6' stroke-opacity='.12' stroke-width='1.2'%3E%3Crect x='16' y='16' width='40' height='40'/%3E%3Crect x='16' y='16' width='40' height='40' transform='rotate(45 36 36)'/%3E%3C/g%3E%3C/svg%3E");
}
*{box-sizing:border-box}
body{margin:0;background:var(--bg);color:var(--ink);font:16px/1.7 var(--sans)}
a{color:var(--emerald)}
img{max-width:100%}
.hidden{display:none!important}
.invisible{visibility:hidden}
:focus-visible{outline:3px solid var(--gold);outline-offset:2px}

.langbar{position:fixed;top:12px;right:12px;z-index:90;display:flex;gap:2px;padding:3px;background:rgba(10,58,49,.92);border:1px solid rgba(234,217,166,.5);border-radius:999px}
.langbar button{border:0;background:transparent;color:var(--gold-soft);border-radius:999px;padding:3px 12px;font-size:.9rem;cursor:pointer}
.langbar button[aria-pressed="true"]{background:var(--gold-soft);color:var(--night);font-weight:600}

#lockScreen{position:relative;min-height:100vh;min-height:100dvh;display:grid;place-items:center;padding:72px 20px 32px;background:radial-gradient(120% 90% at 50% 0%,#12604e 0%,var(--night) 62%)}
#lockScreen::before{content:"";position:absolute;inset:0;background-image:var(--lattice);pointer-events:none}
.lock-card{position:relative;width:100%;max-width:420px;text-align:center;background:var(--white);border-top:4px solid var(--gold);border-radius:4px;padding:30px 24px 24px;box-shadow:0 24px 60px rgba(0,0,0,.35)}
.lock-logo{width:56px;height:56px;border-radius:8px}
.lock-greet{margin-top:10px;font-family:var(--serif);color:var(--gold-deep);font-size:1.1rem}
.lock-card h1{margin:0;font-family:var(--serif);font-weight:400;font-size:1.9rem;line-height:1.3;color:var(--night)}
.lock-for{margin-top:6px;font-weight:600}
.lock-sub{margin-top:4px;color:var(--muted);font-size:.95rem}
.lock-card input{width:100%;margin-top:18px;padding:11px 14px;font:inherit;border:1px solid #b9c4bb;border-radius:4px;background:#fbfdfb}
.lock-card input:focus{border-color:var(--emerald);outline:3px solid rgba(19,107,85,.25);outline-offset:0}
.btn{display:inline-flex;align-items:center;justify-content:center;gap:10px;border:0;border-radius:4px;padding:12px 22px;font:600 1.05rem var(--sans);cursor:pointer}
.btn-solid{width:100%;margin-top:12px;background:var(--emerald);color:#fff}
.btn-solid:hover{background:var(--night)}
#lockMsg{min-height:1.7em;margin-top:10px;color:#a12b2b;font-size:.95rem}
.lock-contact{margin-top:10px;font-size:.82rem;color:var(--muted);border-top:1px solid var(--line);padding-top:12px}
#loadError{position:relative;max-width:420px;margin:60px auto;background:#fff;border-top:4px solid #a12b2b;border-radius:4px;padding:20px;color:#7a1f1f;font-size:.95rem}

.hero{position:relative;overflow:hidden;color:#fff;padding:18px 20px 44px;background:linear-gradient(180deg,var(--night),#0e4a3e)}
.hero::before{content:"";position:absolute;inset:0;background-image:var(--lattice);pointer-events:none}
.hero::after{content:"";position:absolute;left:0;right:0;bottom:0;height:4px;background:linear-gradient(90deg,transparent,var(--gold),transparent)}
.hero-inner{position:relative;max-width:820px;margin:0 auto}
.brandrow{display:inline-flex;align-items:center;gap:10px;max-width:calc(100% - 130px);color:var(--gold-soft);text-decoration:none;font-weight:600}
.brandrow img{width:36px;height:36px;border-radius:6px;background:#fff;flex:none}
.switch{display:flex;width:fit-content;margin-top:14px;padding:6px 16px;border:1px solid var(--gold-soft);border-radius:999px;background:rgba(234,217,166,.12);color:var(--gold-soft);text-decoration:none;font-weight:600;font-size:.95rem}
.switch:hover{background:var(--gold-soft);color:var(--night)}
.identity{margin-top:24px;text-align:center}
.avatar{width:120px;height:120px;margin:0 auto;background:var(--gold);clip-path:var(--star);display:grid;place-items:center}
.avatar-in{width:calc(100% - 10px);height:calc(100% - 10px);background:var(--emerald);clip-path:var(--star);display:grid;place-items:center;overflow:hidden}
.avatar-in img{width:100%;height:100%;object-fit:cover}
.monogram{font-family:var(--serif);font-size:2.9rem;line-height:1;color:var(--gold-soft)}
.name{margin-top:16px;font-family:var(--serif);font-weight:400;font-size:clamp(2rem,8vw,3rem);line-height:1.2}
.roleline{margin-top:4px;color:var(--gold-soft);font-size:.98rem}

main{max-width:820px;margin:0 auto;padding:0 18px 56px}
.sec{margin-top:32px}
.sec>h2{display:flex;align-items:center;gap:14px;font-family:var(--serif);font-weight:400;font-size:1.5rem;line-height:1.3;color:var(--night)}
.sec>h2::after{content:"";flex:1;height:1px;background:linear-gradient(90deg,var(--gold),transparent)}
.sheet{margin-top:14px;background:var(--white);border:1px solid var(--line);border-top:3px solid var(--gold);border-radius:4px;padding:22px 18px 18px}

.figures{display:grid;grid-template-columns:repeat(2,1fr);gap:12px}
.fig{border-top:3px solid var(--line);padding-top:8px;min-width:0}
.fig small{display:block;color:var(--muted);font-size:.85rem}
.fig strong{display:block;font-family:var(--serif);font-weight:400;font-size:clamp(1.15rem,4.6vw,1.9rem)}
.fig.taka{border-color:var(--gold)}
.fig.copies{border-color:var(--emerald)}
.fig.copies strong{color:var(--emerald)}

.ledger{position:relative;margin-top:6px;padding-left:36px}
.ledger::before{content:"";position:absolute;left:11px;top:8px;bottom:8px;width:2px;background:linear-gradient(var(--gold),var(--gold-soft))}
.entry{position:relative;padding-bottom:22px}
.entry:last-child{padding-bottom:0}
.node{position:absolute;left:-36px;top:1px;width:24px;height:24px;background:var(--emerald);clip-path:var(--star)}
.node::after{content:"";position:absolute;inset:4px;background:var(--bg);clip-path:var(--star)}
.entry-head{display:flex;justify-content:space-between;align-items:baseline;gap:12px}
.entry-head h4{margin:0;font-size:1.05rem;font-weight:600}
.entry-amt{font-family:var(--serif);font-size:1.15rem;white-space:nowrap;color:var(--emerald)}
.entry-when{color:var(--muted);font-size:.9rem}
.entry-note{margin-top:2px;font-size:.95rem}
.empty{color:var(--muted);font-size:.92rem;text-align:center;padding:8px 0}

.dist-mode{display:inline-block;margin-bottom:10px;padding:2px 12px;border-radius:999px;background:rgba(19,107,85,.1);color:var(--emerald);font-size:.85rem;font-weight:600}

.thanks{position:relative;overflow:hidden;margin-top:36px;padding:26px 22px 28px;background:var(--night);color:#fff;border-radius:4px}
.thanks::before{content:"";position:absolute;inset:0;background-image:var(--lattice);pointer-events:none}
.thanks>*{position:relative}
.thanks h2{font-family:var(--serif);font-weight:400;font-size:1.5rem;color:var(--gold-soft);margin:0}
.thanks p{margin-top:8px;max-width:62ch;color:#dbe8e2}
.note{margin-top:20px;font-size:.88rem;color:var(--muted)}
.foot{padding:22px 18px;text-align:center;background:var(--night);color:#cfe0d8;font-size:.88rem}
.foot p+p{margin-top:2px;opacity:.85}
</style>
</head>
<body>
<div class="langbar" role="group" aria-label="Language">
  <button id="langBn" type="button" onclick="setLang('bn')" aria-pressed="true">বাংলা</button>
  <button id="langEn" type="button" onclick="setLang('en')" aria-pressed="false">EN</button>
</div>

<div id="lockScreen">
  <div id="lockCard" class="lock-card invisible">
    <img class="lock-logo" data-bind-src="site.logo" data-bind-alt="site.logoAlt" alt="">
    <p class="lock-greet" data-bind="lockScreen.greeting"></p>
    <h1 data-bind="lockScreen.title"></h1>
    <p class="lock-for" data-bind="lockScreen.profileFor"></p>
    <p class="lock-sub" data-bind="lockScreen.subtitle"></p>
    <label for="passwordInput" class="sr-only" data-bind="lockScreen.passwordLabel"></label>
    <input id="passwordInput" type="password" autocomplete="current-password" data-bind-placeholder="lockScreen.placeholder">
    <button id="unlockBtn" type="button" class="btn btn-solid" onclick="unlock()" data-bind="lockScreen.button"></button>
    <p id="lockMsg" role="alert"></p>
    <p class="lock-contact"><span data-bind="lockScreen.contactNote"></span> <strong data-bind="lockScreen.contactEmail"></strong></p>
  </div>
  <div id="loadError" class="hidden" role="alert"></div>
</div>

<div id="app" class="hidden">
  <header class="hero"><div class="hero-inner">
    <a class="brandrow" data-bind-href="site.homeUrl">
      <img data-bind-src="site.logo" data-bind-alt="site.logoAlt" alt="">
      <span data-bind="site.brand"></span>
    </a>
    <a class="switch" data-bind-href="site.gatewayUrl" data-bind="ui.switchGateway"></a>
    <div class="identity">
      <div class="avatar"><div class="avatar-in" id="avatarInner"></div></div>
      <h1 class="name" data-bind="person.name"></h1>
      <p class="roleline" data-bind="person.role"></p>
    </div>
  </div></header>

  <main>
    <section class="sec">
      <h2 data-bind="ui.summaryTitle"></h2>
      <div class="sheet">
        <div class="figures">
          <div class="fig taka"><small data-bind="ui.tiles.taka"></small><strong id="figTaka"></strong></div>
          <div class="fig copies"><small data-bind="ui.tiles.copies"></small><strong id="figCopies"></strong></div>
        </div>
      </div>
    </section>

    <section class="sec">
      <h2 data-bind="ui.ledgerTitle"></h2>
      <ol class="ledger" id="ledger"></ol>
    </section>

    <section class="sec hidden" id="distSection">
      <h2 data-bind="ui.distTitle"></h2>
      <div class="sheet">
        <span class="dist-mode" id="distMode"></span>
        <p id="distNote"></p>
        <ol class="ledger" id="distLedger" style="margin-top:16px"></ol>
      </div>
    </section>

    <section class="thanks">
      <h2 data-bind="ui.thanksTitle"></h2>
      <p data-bind="ui.thanksText"></p>
    </section>

    <p class="note" data-bind="ui.recordNote"></p>
  </main>

  <footer class="foot">
    <p data-bind="footer.copyright"></p>
    <p data-bind="footer.tagline"></p>
  </footer>
</div>

<script>
const DATA_URL='data.json';
let DATA=null,LANG='bn',TZ='Asia/Dhaka';
const $=id=>document.getElementById(id);
const get=path=>path.split('.').reduce((o,k)=>(o==null?undefined:o[k]),DATA);
const tr=v=>(v!==null&&typeof v==='object')?(v[LANG]??v.en??v.bn??''):(v??'');
const T=path=>tr(get(path));
const fill=(tpl,vars)=>String(tpl).replace(/\{(\w+)\}/g,(_,k)=>(k in vars?vars[k]:''));

const LOC=()=>LANG==='bn'?{num:'bn-BD',date:'bn-BD'}:{num:'en-US',date:'en-GB'};
const nfmt=n=>new Intl.NumberFormat(LOC().num,{maximumFractionDigits:2}).format(n);
const money=n=>`${DATA.site.currencySymbol} ${nfmt(n)}`;
const emailVar=()=>DATA.lockScreen.contactEmail;
const when=s=>new Date(String(s).includes('T')?s:s+'T12:00:00+06:00');
const fmtDate=d=>new Intl.DateTimeFormat(LOC().date,{timeZone:TZ,day:'numeric',month:'long',year:'numeric'}).format(d);

function vars(){
  const t=totals();
  return { taka: money(t.taka), copies: nfmt(t.copies), email: emailVar() };
}
const TT=path=>fill(T(path),vars());

const BIND_ATTRS=['href','src','alt','placeholder','aria-label'];
function applyBindings(){
  document.querySelectorAll('[data-bind]').forEach(el=>{ el.textContent=TT(el.getAttribute('data-bind')); });
  BIND_ATTRS.forEach(attr=>{
    document.querySelectorAll('[data-bind-'+attr+']').forEach(el=>{
      const prefix=el.getAttribute('data-prefix')||'';
      el.setAttribute(attr, prefix+TT(el.getAttribute('data-bind-'+attr)));
    });
  });
  document.title=TT('site.title');
}

function h(tag,attrs,...kids){
  const el=document.createElement(tag);
  Object.entries(attrs||{}).forEach(([k,v])=>{ if(v===false||v==null)return; if(k==='class')el.className=v; else el.setAttribute(k,v===true?'':v); });
  kids.flat().forEach(k=>{ if(k==null||k===false)return; el.append(k instanceof Node?k:document.createTextNode(String(k))); });
  return el;
}

function totals(){
  const entries=(DATA.contributions&&DATA.contributions.entries)||[];
  const taka=entries.reduce((s,e)=>s+(Number(e.amount)||0),0);
  const copies=entries.reduce((s,e)=>s+(Number(e.quranCopies)||0),0);
  return {taka,copies};
}

function renderHero(){
  const av=$('avatarInner'); av.textContent='';
  if(DATA.person.photo) av.append(h('img',{src:DATA.person.photo,alt:T('person.name')}));
  else av.append(h('span',{class:'monogram'},T('person.monogram')));
}

function renderSummary(){
  const t=totals();
  $('figTaka').textContent=money(t.taka);
  $('figCopies').textContent=nfmt(t.copies);
}

function renderLedger(){
  const ol=$('ledger'); ol.textContent='';
  const entries=(DATA.contributions&&DATA.contributions.entries)||[];
  if(!entries.length){ ol.append(h('li',{class:'empty'},T('ui.noEntries'))); return; }
  entries.forEach(e=>{
    const parts=[];
    if(e.amount) parts.push(money(e.amount));
    if(e.quranCopies) parts.push(nfmt(e.quranCopies)+' '+T('ui.tiles.copiesShort'));
    ol.append(h('li',{class:'entry'},
      h('span',{class:'node','aria-hidden':'true'}),
      h('div',{class:'entry-head'}, h('h4',{},tr(e.title)), h('span',{class:'entry-amt'},parts.join(' + '))),
      h('p',{class:'entry-when'}, e.date ? fmtDate(when(e.date)) : (e.dateLabel ? tr(e.dateLabel) : '')),
      e.note?h('p',{class:'entry-note'}, fill(tr(e.note),vars())):null));
  });
}

function renderDistribution(){
  const D=DATA.distribution;
  const section=$('distSection');
  if(!D || (!D.mode && (!D.entries || !D.entries.length))){ section.classList.add('hidden'); return; }
  section.classList.remove('hidden');
  $('distMode').textContent = D.mode ? T('ui.distModes.'+D.mode) : '';
  $('distNote').textContent = D.note ? fill(tr(D.note),vars()) : '';
  const ol=$('distLedger'); ol.textContent='';
  const entries=D.entries||[];
  if(!entries.length){ return; }
  entries.forEach(e=>{
    ol.append(h('li',{class:'entry'},
      h('span',{class:'node','aria-hidden':'true'}),
      h('div',{class:'entry-head'}, h('h4',{},tr(e.area)), h('span',{class:'entry-amt'}, nfmt(e.copies)+' '+T('ui.tiles.copiesShort'))),
      h('p',{class:'entry-when'}, e.date ? fmtDate(when(e.date)) : (e.dateLabel ? tr(e.dateLabel) : '')),
      e.note?h('p',{class:'entry-note'}, fill(tr(e.note),vars())):null));
  });
}

function setLang(lang){
  if(!DATA)return;
  LANG = lang==='en'?'en':'bn';
  document.documentElement.lang=LANG;
  $('langBn').setAttribute('aria-pressed',String(LANG==='bn'));
  $('langEn').setAttribute('aria-pressed',String(LANG==='en'));
  applyBindings(); renderHero(); renderSummary(); renderLedger(); renderDistribution();
}

async function sha256Hex(text){
  const buf=await crypto.subtle.digest('SHA-256',new TextEncoder().encode(text));
  return Array.from(new Uint8Array(buf)).map(b=>b.toString(16).padStart(2,'0')).join('');
}

async function unlock(){
  if(!DATA)return;
  const msg=$('lockMsg');
  let ok=false;
  try{
    const hash=await sha256Hex($('passwordInput').value);
    ok = hash===String(DATA.security.passwordSha256||'').toLowerCase();
  }catch(e){ msg.textContent='Password check needs HTTPS or localhost.'; return; }
  if(!ok){ msg.textContent=T('lockScreen.wrongPassword'); return; }
  msg.textContent=''; $('passwordInput').value='';
  $('lockScreen').classList.add('hidden');
  $('app').classList.remove('hidden');
  window.scrollTo(0,0);
}

$('passwordInput').addEventListener('keydown', e=>{ if(e.key==='Enter') unlock(); });

(async function init(){
  try{
    const res=await fetch(DATA_URL,{cache:'no-store'});
    if(!res.ok) throw new Error('HTTP '+res.status);
    DATA=await res.json();
  }catch(err){
    $('lockCard').classList.add('hidden');
    const box=$('loadError');
    box.textContent='Could not load '+DATA_URL+' ('+err.message+'). Keep it in the same folder as this page and open it through a web server.';
    box.classList.remove('hidden');
    return;
  }
  TZ=DATA.site.timezone||'Asia/Dhaka';
  setLang(DATA.site.defaultLang||'bn');
  $('lockCard').classList.remove('invisible');
})();
</script>
</body>
</html>
QFEOF

cat > "supporter/tarikul-haque/data.json" << 'QFEOF'
{
  "_readme": "মোঃ তরিকুল হকের প্রকৃত প্রোফাইল — দুটি ভিন্ন সময়ে দেওয়া সহায়তা। security.passwordSha256 এখনো ফাঁকা — hash-generator.html দিয়ে একটি পাসওয়ার্ড ঠিক করে হ্যাশ বসান, তারপর gateway এর data.json এ supporter role এর users[] এ username যোগ করুন।",
  "site": {
    "title": {
      "bn": "মোঃ তরিকুল হকর সহায়তা প্রোফাইল",
      "en": "Support profile of Md. Tarikul Haque"
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
    "gatewayUrl": "../../",
    "defaultLang": "bn",
    "timezone": "Asia/Dhaka",
    "currencySymbol": "৳",
    "currencyWord": {
      "bn": "টাকা",
      "en": "Tk."
    }
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
      "bn": "মোঃ তরিকুল হকর ব্যক্তিগত সহায়তা প্রোফাইল",
      "en": "Personal support profile of Md. Tarikul Haque"
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
  "person": {
    "photo": "",
    "monogram": {
      "bn": "ত",
      "en": "T"
    },
    "name": {
      "bn": "মোঃ তরিকুল হক",
      "en": "Md. Tarikul Haque"
    },
    "role": {
      "bn": "সাপোর্টার",
      "en": "Supporter"
    }
  },
  "contributions": {
    "entries": [
      {
        "type": "support",
        "dateLabel": {
          "bn": "পূর্বে একবার",
          "en": "On an earlier occasion"
        },
        "title": {
          "bn": "সহায়তা",
          "en": "Support"
        },
        "note": {
          "bn": "কোনো শর্ত ছাড়াই দেওয়া সহায়তা",
          "en": "Support given without any condition"
        },
        "amount": 5000
      },
      {
        "type": "support",
        "dateLabel": {
          "bn": "পরবর্তীতে আরেকবার",
          "en": "On a later occasion"
        },
        "title": {
          "bn": "সহায়তা",
          "en": "Support"
        },
        "note": {
          "bn": "কোনো শর্ত ছাড়াই দেওয়া সহায়তা",
          "en": "Support given without any condition"
        },
        "amount": 3000
      }
    ]
  },
  "distribution": {
    "mode": "",
    "note": {
      "bn": "",
      "en": ""
    },
    "entries": []
  },
  "ui": {
    "summaryTitle": {
      "bn": "সহায়তার সারসংক্ষেপ",
      "en": "Support summary"
    },
    "tiles": {
      "taka": {
        "bn": "মোট সহায়তা (টাকা)",
        "en": "Total support (Tk.)"
      },
      "copies": {
        "bn": "মোট কোরআন (কপি)",
        "en": "Total Quran copies"
      },
      "copiesShort": {
        "bn": "কপি",
        "en": "copies"
      }
    },
    "ledgerTitle": {
      "bn": "সহায়তার ধারাবাহিকতা",
      "en": "Support timeline"
    },
    "noEntries": {
      "bn": "এখনো কোনো এন্ট্রি যুক্ত করা হয়নি।",
      "en": "No entries have been added yet."
    },
    "distTitle": {
      "bn": "বিতরণের হিসাব",
      "en": "Distribution record"
    },
    "distModes": {
      "organization": {
        "bn": "প্রতিষ্ঠানের মাধ্যমে বিতরণ",
        "en": "Distributed by the organization"
      },
      "self": {
        "bn": "নিজ হাতে বিতরণ করেছেন",
        "en": "Distributed personally by the donor"
      },
      "mixed": {
        "bn": "প্রতিষ্ঠান ও নিজে — উভয়ভাবে বিতরণ",
        "en": "Distributed both by the organization and personally"
      }
    },
    "thanksTitle": {
      "bn": "কৃতজ্ঞতা",
      "en": "With gratitude"
    },
    "thanksText": {
      "bn": "কোনো শর্ত বা প্রতিদানের প্রত্যাশা ছাড়াই আপনি পাশে থেকেছেন — এই আন্তরিকতা আমাদের সবচেয়ে বড় শক্তি। আল্লাহ আপনাকে উত্তম প্রতিদান দিন।",
      "en": "You stood beside us without any condition or expectation of return — that sincerity is our greatest strength. May Allah reward you well."
    },
    "recordNote": {
      "bn": "এই পাতার তথ্য সহায়তার রেকর্ড হিসেবে সংরক্ষিত। কোনো তথ্যে ভুল বা আপত্তি থাকলে জানান: {email}",
      "en": "The information on this page is kept as a record of the support given. If you find a mistake or have an objection, write to: {email}"
    },
    "switchGateway": {
      "bn": "অন্য পোর্টাল বেছে নিন",
      "en": "Choose a different portal"
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

cat > "supporter/tarikul-haque/index.html" << 'QFEOF'
<!DOCTYPE html>
<html lang="bn">
<head>
<meta charset="utf-8">
<title>সহযোগিতার প্রোফাইল</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta name="robots" content="noindex,nofollow">
<meta name="theme-color" content="#0a3a31">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Hind+Siliguri:wght@400;500;600;700&family=Tiro+Bangla:ital@0;1&display=swap" rel="stylesheet">
<style>
:root{
  --night:#0a3a31;--emerald:#136b55;--gold:#b8892d;--gold-deep:#83600f;--gold-soft:#ead9a6;
  --bg:#f1f5f0;--white:#ffffff;--ink:#15221d;--muted:#586a62;--line:#d5ddd3;
  --serif:'Tiro Bangla','Noto Serif Bengali',Georgia,serif;--sans:'Hind Siliguri','Noto Sans Bengali',system-ui,sans-serif;
  --star: polygon(50.00% 0.00%,64.64% 14.64%,85.36% 14.64%,85.36% 35.36%,100.00% 50.00%,85.36% 64.64%,85.36% 85.36%,64.64% 85.36%,50.00% 100.00%,35.36% 85.36%,14.64% 85.36%,14.64% 64.64%,0.00% 50.00%,14.64% 35.36%,14.64% 14.64%,35.36% 14.64%);
  --lattice:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='72' height='72' viewBox='0 0 72 72'%3E%3Cg fill='none' stroke='%23ead9a6' stroke-opacity='.12' stroke-width='1.2'%3E%3Crect x='16' y='16' width='40' height='40'/%3E%3Crect x='16' y='16' width='40' height='40' transform='rotate(45 36 36)'/%3E%3C/g%3E%3C/svg%3E");
}
*{box-sizing:border-box}
body{margin:0;background:var(--bg);color:var(--ink);font:16px/1.7 var(--sans)}
a{color:var(--emerald)}
img{max-width:100%}
.hidden{display:none!important}
.invisible{visibility:hidden}
:focus-visible{outline:3px solid var(--gold);outline-offset:2px}

.langbar{position:fixed;top:12px;right:12px;z-index:90;display:flex;gap:2px;padding:3px;background:rgba(10,58,49,.92);border:1px solid rgba(234,217,166,.5);border-radius:999px}
.langbar button{border:0;background:transparent;color:var(--gold-soft);border-radius:999px;padding:3px 12px;font-size:.9rem;cursor:pointer}
.langbar button[aria-pressed="true"]{background:var(--gold-soft);color:var(--night);font-weight:600}

#lockScreen{position:relative;min-height:100vh;min-height:100dvh;display:grid;place-items:center;padding:72px 20px 32px;background:radial-gradient(120% 90% at 50% 0%,#12604e 0%,var(--night) 62%)}
#lockScreen::before{content:"";position:absolute;inset:0;background-image:var(--lattice);pointer-events:none}
.lock-card{position:relative;width:100%;max-width:420px;text-align:center;background:var(--white);border-top:4px solid var(--gold);border-radius:4px;padding:30px 24px 24px;box-shadow:0 24px 60px rgba(0,0,0,.35)}
.lock-logo{width:56px;height:56px;border-radius:8px}
.lock-greet{margin-top:10px;font-family:var(--serif);color:var(--gold-deep);font-size:1.1rem}
.lock-card h1{margin:0;font-family:var(--serif);font-weight:400;font-size:1.9rem;line-height:1.3;color:var(--night)}
.lock-for{margin-top:6px;font-weight:600}
.lock-sub{margin-top:4px;color:var(--muted);font-size:.95rem}
.lock-card input{width:100%;margin-top:18px;padding:11px 14px;font:inherit;border:1px solid #b9c4bb;border-radius:4px;background:#fbfdfb}
.lock-card input:focus{border-color:var(--emerald);outline:3px solid rgba(19,107,85,.25);outline-offset:0}
.btn{display:inline-flex;align-items:center;justify-content:center;gap:10px;border:0;border-radius:4px;padding:12px 22px;font:600 1.05rem var(--sans);cursor:pointer}
.btn-solid{width:100%;margin-top:12px;background:var(--emerald);color:#fff}
.btn-solid:hover{background:var(--night)}
#lockMsg{min-height:1.7em;margin-top:10px;color:#a12b2b;font-size:.95rem}
.lock-contact{margin-top:10px;font-size:.82rem;color:var(--muted);border-top:1px solid var(--line);padding-top:12px}
#loadError{position:relative;max-width:420px;margin:60px auto;background:#fff;border-top:4px solid #a12b2b;border-radius:4px;padding:20px;color:#7a1f1f;font-size:.95rem}

.hero{position:relative;overflow:hidden;color:#fff;padding:18px 20px 44px;background:linear-gradient(180deg,var(--night),#0e4a3e)}
.hero::before{content:"";position:absolute;inset:0;background-image:var(--lattice);pointer-events:none}
.hero::after{content:"";position:absolute;left:0;right:0;bottom:0;height:4px;background:linear-gradient(90deg,transparent,var(--gold),transparent)}
.hero-inner{position:relative;max-width:820px;margin:0 auto}
.brandrow{display:inline-flex;align-items:center;gap:10px;max-width:calc(100% - 130px);color:var(--gold-soft);text-decoration:none;font-weight:600}
.brandrow img{width:36px;height:36px;border-radius:6px;background:#fff;flex:none}
.switch{display:flex;width:fit-content;margin-top:14px;padding:6px 16px;border:1px solid var(--gold-soft);border-radius:999px;background:rgba(234,217,166,.12);color:var(--gold-soft);text-decoration:none;font-weight:600;font-size:.95rem}
.switch:hover{background:var(--gold-soft);color:var(--night)}
.identity{margin-top:24px;text-align:center}
.avatar{width:120px;height:120px;margin:0 auto;background:var(--gold);clip-path:var(--star);display:grid;place-items:center}
.avatar-in{width:calc(100% - 10px);height:calc(100% - 10px);background:var(--emerald);clip-path:var(--star);display:grid;place-items:center;overflow:hidden}
.avatar-in img{width:100%;height:100%;object-fit:cover}
.monogram{font-family:var(--serif);font-size:2.9rem;line-height:1;color:var(--gold-soft)}
.name{margin-top:16px;font-family:var(--serif);font-weight:400;font-size:clamp(2rem,8vw,3rem);line-height:1.2}
.roleline{margin-top:4px;color:var(--gold-soft);font-size:.98rem}

main{max-width:820px;margin:0 auto;padding:0 18px 56px}
.sec{margin-top:32px}
.sec>h2{display:flex;align-items:center;gap:14px;font-family:var(--serif);font-weight:400;font-size:1.5rem;line-height:1.3;color:var(--night)}
.sec>h2::after{content:"";flex:1;height:1px;background:linear-gradient(90deg,var(--gold),transparent)}
.sheet{margin-top:14px;background:var(--white);border:1px solid var(--line);border-top:3px solid var(--gold);border-radius:4px;padding:22px 18px 18px}

.figures{display:grid;grid-template-columns:repeat(2,1fr);gap:12px}
.fig{border-top:3px solid var(--line);padding-top:8px;min-width:0}
.fig small{display:block;color:var(--muted);font-size:.85rem}
.fig strong{display:block;font-family:var(--serif);font-weight:400;font-size:clamp(1.15rem,4.6vw,1.9rem)}
.fig.taka{border-color:var(--gold)}
.fig.copies{border-color:var(--emerald)}
.fig.copies strong{color:var(--emerald)}

.ledger{position:relative;margin-top:6px;padding-left:36px}
.ledger::before{content:"";position:absolute;left:11px;top:8px;bottom:8px;width:2px;background:linear-gradient(var(--gold),var(--gold-soft))}
.entry{position:relative;padding-bottom:22px}
.entry:last-child{padding-bottom:0}
.node{position:absolute;left:-36px;top:1px;width:24px;height:24px;background:var(--emerald);clip-path:var(--star)}
.node::after{content:"";position:absolute;inset:4px;background:var(--bg);clip-path:var(--star)}
.entry-head{display:flex;justify-content:space-between;align-items:baseline;gap:12px}
.entry-head h4{margin:0;font-size:1.05rem;font-weight:600}
.entry-amt{font-family:var(--serif);font-size:1.15rem;white-space:nowrap;color:var(--emerald)}
.entry-when{color:var(--muted);font-size:.9rem}
.entry-note{margin-top:2px;font-size:.95rem}
.empty{color:var(--muted);font-size:.92rem;text-align:center;padding:8px 0}

.dist-mode{display:inline-block;margin-bottom:10px;padding:2px 12px;border-radius:999px;background:rgba(19,107,85,.1);color:var(--emerald);font-size:.85rem;font-weight:600}

.thanks{position:relative;overflow:hidden;margin-top:36px;padding:26px 22px 28px;background:var(--night);color:#fff;border-radius:4px}
.thanks::before{content:"";position:absolute;inset:0;background-image:var(--lattice);pointer-events:none}
.thanks>*{position:relative}
.thanks h2{font-family:var(--serif);font-weight:400;font-size:1.5rem;color:var(--gold-soft);margin:0}
.thanks p{margin-top:8px;max-width:62ch;color:#dbe8e2}
.note{margin-top:20px;font-size:.88rem;color:var(--muted)}
.foot{padding:22px 18px;text-align:center;background:var(--night);color:#cfe0d8;font-size:.88rem}
.foot p+p{margin-top:2px;opacity:.85}
</style>
</head>
<body>
<div class="langbar" role="group" aria-label="Language">
  <button id="langBn" type="button" onclick="setLang('bn')" aria-pressed="true">বাংলা</button>
  <button id="langEn" type="button" onclick="setLang('en')" aria-pressed="false">EN</button>
</div>

<div id="lockScreen">
  <div id="lockCard" class="lock-card invisible">
    <img class="lock-logo" data-bind-src="site.logo" data-bind-alt="site.logoAlt" alt="">
    <p class="lock-greet" data-bind="lockScreen.greeting"></p>
    <h1 data-bind="lockScreen.title"></h1>
    <p class="lock-for" data-bind="lockScreen.profileFor"></p>
    <p class="lock-sub" data-bind="lockScreen.subtitle"></p>
    <label for="passwordInput" class="sr-only" data-bind="lockScreen.passwordLabel"></label>
    <input id="passwordInput" type="password" autocomplete="current-password" data-bind-placeholder="lockScreen.placeholder">
    <button id="unlockBtn" type="button" class="btn btn-solid" onclick="unlock()" data-bind="lockScreen.button"></button>
    <p id="lockMsg" role="alert"></p>
    <p class="lock-contact"><span data-bind="lockScreen.contactNote"></span> <strong data-bind="lockScreen.contactEmail"></strong></p>
  </div>
  <div id="loadError" class="hidden" role="alert"></div>
</div>

<div id="app" class="hidden">
  <header class="hero"><div class="hero-inner">
    <a class="brandrow" data-bind-href="site.homeUrl">
      <img data-bind-src="site.logo" data-bind-alt="site.logoAlt" alt="">
      <span data-bind="site.brand"></span>
    </a>
    <a class="switch" data-bind-href="site.gatewayUrl" data-bind="ui.switchGateway"></a>
    <div class="identity">
      <div class="avatar"><div class="avatar-in" id="avatarInner"></div></div>
      <h1 class="name" data-bind="person.name"></h1>
      <p class="roleline" data-bind="person.role"></p>
    </div>
  </div></header>

  <main>
    <section class="sec">
      <h2 data-bind="ui.summaryTitle"></h2>
      <div class="sheet">
        <div class="figures">
          <div class="fig taka"><small data-bind="ui.tiles.taka"></small><strong id="figTaka"></strong></div>
          <div class="fig copies"><small data-bind="ui.tiles.copies"></small><strong id="figCopies"></strong></div>
        </div>
      </div>
    </section>

    <section class="sec">
      <h2 data-bind="ui.ledgerTitle"></h2>
      <ol class="ledger" id="ledger"></ol>
    </section>

    <section class="sec hidden" id="distSection">
      <h2 data-bind="ui.distTitle"></h2>
      <div class="sheet">
        <span class="dist-mode" id="distMode"></span>
        <p id="distNote"></p>
        <ol class="ledger" id="distLedger" style="margin-top:16px"></ol>
      </div>
    </section>

    <section class="thanks">
      <h2 data-bind="ui.thanksTitle"></h2>
      <p data-bind="ui.thanksText"></p>
    </section>

    <p class="note" data-bind="ui.recordNote"></p>
  </main>

  <footer class="foot">
    <p data-bind="footer.copyright"></p>
    <p data-bind="footer.tagline"></p>
  </footer>
</div>

<script>
const DATA_URL='data.json';
let DATA=null,LANG='bn',TZ='Asia/Dhaka';
const $=id=>document.getElementById(id);
const get=path=>path.split('.').reduce((o,k)=>(o==null?undefined:o[k]),DATA);
const tr=v=>(v!==null&&typeof v==='object')?(v[LANG]??v.en??v.bn??''):(v??'');
const T=path=>tr(get(path));
const fill=(tpl,vars)=>String(tpl).replace(/\{(\w+)\}/g,(_,k)=>(k in vars?vars[k]:''));

const LOC=()=>LANG==='bn'?{num:'bn-BD',date:'bn-BD'}:{num:'en-US',date:'en-GB'};
const nfmt=n=>new Intl.NumberFormat(LOC().num,{maximumFractionDigits:2}).format(n);
const money=n=>`${DATA.site.currencySymbol} ${nfmt(n)}`;
const emailVar=()=>DATA.lockScreen.contactEmail;
const when=s=>new Date(String(s).includes('T')?s:s+'T12:00:00+06:00');
const fmtDate=d=>new Intl.DateTimeFormat(LOC().date,{timeZone:TZ,day:'numeric',month:'long',year:'numeric'}).format(d);

function vars(){
  const t=totals();
  return { taka: money(t.taka), copies: nfmt(t.copies), email: emailVar() };
}
const TT=path=>fill(T(path),vars());

const BIND_ATTRS=['href','src','alt','placeholder','aria-label'];
function applyBindings(){
  document.querySelectorAll('[data-bind]').forEach(el=>{ el.textContent=TT(el.getAttribute('data-bind')); });
  BIND_ATTRS.forEach(attr=>{
    document.querySelectorAll('[data-bind-'+attr+']').forEach(el=>{
      const prefix=el.getAttribute('data-prefix')||'';
      el.setAttribute(attr, prefix+TT(el.getAttribute('data-bind-'+attr)));
    });
  });
  document.title=TT('site.title');
}

function h(tag,attrs,...kids){
  const el=document.createElement(tag);
  Object.entries(attrs||{}).forEach(([k,v])=>{ if(v===false||v==null)return; if(k==='class')el.className=v; else el.setAttribute(k,v===true?'':v); });
  kids.flat().forEach(k=>{ if(k==null||k===false)return; el.append(k instanceof Node?k:document.createTextNode(String(k))); });
  return el;
}

function totals(){
  const entries=(DATA.contributions&&DATA.contributions.entries)||[];
  const taka=entries.reduce((s,e)=>s+(Number(e.amount)||0),0);
  const copies=entries.reduce((s,e)=>s+(Number(e.quranCopies)||0),0);
  return {taka,copies};
}

function renderHero(){
  const av=$('avatarInner'); av.textContent='';
  if(DATA.person.photo) av.append(h('img',{src:DATA.person.photo,alt:T('person.name')}));
  else av.append(h('span',{class:'monogram'},T('person.monogram')));
}

function renderSummary(){
  const t=totals();
  $('figTaka').textContent=money(t.taka);
  $('figCopies').textContent=nfmt(t.copies);
}

function renderLedger(){
  const ol=$('ledger'); ol.textContent='';
  const entries=(DATA.contributions&&DATA.contributions.entries)||[];
  if(!entries.length){ ol.append(h('li',{class:'empty'},T('ui.noEntries'))); return; }
  entries.forEach(e=>{
    const parts=[];
    if(e.amount) parts.push(money(e.amount));
    if(e.quranCopies) parts.push(nfmt(e.quranCopies)+' '+T('ui.tiles.copiesShort'));
    ol.append(h('li',{class:'entry'},
      h('span',{class:'node','aria-hidden':'true'}),
      h('div',{class:'entry-head'}, h('h4',{},tr(e.title)), h('span',{class:'entry-amt'},parts.join(' + '))),
      h('p',{class:'entry-when'}, e.date ? fmtDate(when(e.date)) : (e.dateLabel ? tr(e.dateLabel) : '')),
      e.note?h('p',{class:'entry-note'}, fill(tr(e.note),vars())):null));
  });
}

function renderDistribution(){
  const D=DATA.distribution;
  const section=$('distSection');
  if(!D || (!D.mode && (!D.entries || !D.entries.length))){ section.classList.add('hidden'); return; }
  section.classList.remove('hidden');
  $('distMode').textContent = D.mode ? T('ui.distModes.'+D.mode) : '';
  $('distNote').textContent = D.note ? fill(tr(D.note),vars()) : '';
  const ol=$('distLedger'); ol.textContent='';
  const entries=D.entries||[];
  if(!entries.length){ return; }
  entries.forEach(e=>{
    ol.append(h('li',{class:'entry'},
      h('span',{class:'node','aria-hidden':'true'}),
      h('div',{class:'entry-head'}, h('h4',{},tr(e.area)), h('span',{class:'entry-amt'}, nfmt(e.copies)+' '+T('ui.tiles.copiesShort'))),
      h('p',{class:'entry-when'}, e.date ? fmtDate(when(e.date)) : (e.dateLabel ? tr(e.dateLabel) : '')),
      e.note?h('p',{class:'entry-note'}, fill(tr(e.note),vars())):null));
  });
}

function setLang(lang){
  if(!DATA)return;
  LANG = lang==='en'?'en':'bn';
  document.documentElement.lang=LANG;
  $('langBn').setAttribute('aria-pressed',String(LANG==='bn'));
  $('langEn').setAttribute('aria-pressed',String(LANG==='en'));
  applyBindings(); renderHero(); renderSummary(); renderLedger(); renderDistribution();
}

async function sha256Hex(text){
  const buf=await crypto.subtle.digest('SHA-256',new TextEncoder().encode(text));
  return Array.from(new Uint8Array(buf)).map(b=>b.toString(16).padStart(2,'0')).join('');
}

async function unlock(){
  if(!DATA)return;
  const msg=$('lockMsg');
  let ok=false;
  try{
    const hash=await sha256Hex($('passwordInput').value);
    ok = hash===String(DATA.security.passwordSha256||'').toLowerCase();
  }catch(e){ msg.textContent='Password check needs HTTPS or localhost.'; return; }
  if(!ok){ msg.textContent=T('lockScreen.wrongPassword'); return; }
  msg.textContent=''; $('passwordInput').value='';
  $('lockScreen').classList.add('hidden');
  $('app').classList.remove('hidden');
  window.scrollTo(0,0);
}

$('passwordInput').addEventListener('keydown', e=>{ if(e.key==='Enter') unlock(); });

(async function init(){
  try{
    const res=await fetch(DATA_URL,{cache:'no-store'});
    if(!res.ok) throw new Error('HTTP '+res.status);
    DATA=await res.json();
  }catch(err){
    $('lockCard').classList.add('hidden');
    const box=$('loadError');
    box.textContent='Could not load '+DATA_URL+' ('+err.message+'). Keep it in the same folder as this page and open it through a web server.';
    box.classList.remove('hidden');
    return;
  }
  TZ=DATA.site.timezone||'Asia/Dhaka';
  setLang(DATA.site.defaultLang||'bn');
  $('lockCard').classList.remove('invisible');
})();
</script>
</body>
</html>
QFEOF

cat > "supporter/delowar-hossain/data.json" << 'QFEOF'
{
  "_readme": "মোঃ দেলোয়ার হোসাইনের প্রকৃত প্রোফাইল। security.passwordSha256 এখনো ফাঁকা — hash-generator.html দিয়ে একটি পাসওয়ার্ড ঠিক করে হ্যাশ বসান, তারপর gateway এর data.json এ supporter role এর users[] এ username যোগ করুন।",
  "site": {
    "title": {
      "bn": "মোঃ দেলোয়ার হোসাইনর সহায়তা প্রোফাইল",
      "en": "Support profile of Md. Delowar Hossain"
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
    "gatewayUrl": "../../",
    "defaultLang": "bn",
    "timezone": "Asia/Dhaka",
    "currencySymbol": "৳",
    "currencyWord": {
      "bn": "টাকা",
      "en": "Tk."
    }
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
      "bn": "মোঃ দেলোয়ার হোসাইনর ব্যক্তিগত সহায়তা প্রোফাইল",
      "en": "Personal support profile of Md. Delowar Hossain"
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
  "person": {
    "photo": "",
    "monogram": {
      "bn": "দ",
      "en": "D"
    },
    "name": {
      "bn": "মোঃ দেলোয়ার হোসাইন",
      "en": "Md. Delowar Hossain"
    },
    "role": {
      "bn": "সাপোর্টার",
      "en": "Supporter"
    }
  },
  "contributions": {
    "entries": [
      {
        "type": "support",
        "dateLabel": {
          "bn": "পূর্বে",
          "en": "Previously"
        },
        "title": {
          "bn": "সহায়তা",
          "en": "Support"
        },
        "note": {
          "bn": "কোনো শর্ত ছাড়াই দেওয়া সহায়তা",
          "en": "Support given without any condition"
        },
        "amount": 2000
      }
    ]
  },
  "distribution": {
    "mode": "",
    "note": {
      "bn": "",
      "en": ""
    },
    "entries": []
  },
  "ui": {
    "summaryTitle": {
      "bn": "সহায়তার সারসংক্ষেপ",
      "en": "Support summary"
    },
    "tiles": {
      "taka": {
        "bn": "মোট সহায়তা (টাকা)",
        "en": "Total support (Tk.)"
      },
      "copies": {
        "bn": "মোট কোরআন (কপি)",
        "en": "Total Quran copies"
      },
      "copiesShort": {
        "bn": "কপি",
        "en": "copies"
      }
    },
    "ledgerTitle": {
      "bn": "সহায়তার ধারাবাহিকতা",
      "en": "Support timeline"
    },
    "noEntries": {
      "bn": "এখনো কোনো এন্ট্রি যুক্ত করা হয়নি।",
      "en": "No entries have been added yet."
    },
    "distTitle": {
      "bn": "বিতরণের হিসাব",
      "en": "Distribution record"
    },
    "distModes": {
      "organization": {
        "bn": "প্রতিষ্ঠানের মাধ্যমে বিতরণ",
        "en": "Distributed by the organization"
      },
      "self": {
        "bn": "নিজ হাতে বিতরণ করেছেন",
        "en": "Distributed personally by the donor"
      },
      "mixed": {
        "bn": "প্রতিষ্ঠান ও নিজে — উভয়ভাবে বিতরণ",
        "en": "Distributed both by the organization and personally"
      }
    },
    "thanksTitle": {
      "bn": "কৃতজ্ঞতা",
      "en": "With gratitude"
    },
    "thanksText": {
      "bn": "কোনো শর্ত বা প্রতিদানের প্রত্যাশা ছাড়াই আপনি পাশে থেকেছেন — এই আন্তরিকতা আমাদের সবচেয়ে বড় শক্তি। আল্লাহ আপনাকে উত্তম প্রতিদান দিন।",
      "en": "You stood beside us without any condition or expectation of return — that sincerity is our greatest strength. May Allah reward you well."
    },
    "recordNote": {
      "bn": "এই পাতার তথ্য সহায়তার রেকর্ড হিসেবে সংরক্ষিত। কোনো তথ্যে ভুল বা আপত্তি থাকলে জানান: {email}",
      "en": "The information on this page is kept as a record of the support given. If you find a mistake or have an objection, write to: {email}"
    },
    "switchGateway": {
      "bn": "অন্য পোর্টাল বেছে নিন",
      "en": "Choose a different portal"
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

cat > "supporter/delowar-hossain/index.html" << 'QFEOF'
<!DOCTYPE html>
<html lang="bn">
<head>
<meta charset="utf-8">
<title>সহযোগিতার প্রোফাইল</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta name="robots" content="noindex,nofollow">
<meta name="theme-color" content="#0a3a31">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Hind+Siliguri:wght@400;500;600;700&family=Tiro+Bangla:ital@0;1&display=swap" rel="stylesheet">
<style>
:root{
  --night:#0a3a31;--emerald:#136b55;--gold:#b8892d;--gold-deep:#83600f;--gold-soft:#ead9a6;
  --bg:#f1f5f0;--white:#ffffff;--ink:#15221d;--muted:#586a62;--line:#d5ddd3;
  --serif:'Tiro Bangla','Noto Serif Bengali',Georgia,serif;--sans:'Hind Siliguri','Noto Sans Bengali',system-ui,sans-serif;
  --star: polygon(50.00% 0.00%,64.64% 14.64%,85.36% 14.64%,85.36% 35.36%,100.00% 50.00%,85.36% 64.64%,85.36% 85.36%,64.64% 85.36%,50.00% 100.00%,35.36% 85.36%,14.64% 85.36%,14.64% 64.64%,0.00% 50.00%,14.64% 35.36%,14.64% 14.64%,35.36% 14.64%);
  --lattice:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='72' height='72' viewBox='0 0 72 72'%3E%3Cg fill='none' stroke='%23ead9a6' stroke-opacity='.12' stroke-width='1.2'%3E%3Crect x='16' y='16' width='40' height='40'/%3E%3Crect x='16' y='16' width='40' height='40' transform='rotate(45 36 36)'/%3E%3C/g%3E%3C/svg%3E");
}
*{box-sizing:border-box}
body{margin:0;background:var(--bg);color:var(--ink);font:16px/1.7 var(--sans)}
a{color:var(--emerald)}
img{max-width:100%}
.hidden{display:none!important}
.invisible{visibility:hidden}
:focus-visible{outline:3px solid var(--gold);outline-offset:2px}

.langbar{position:fixed;top:12px;right:12px;z-index:90;display:flex;gap:2px;padding:3px;background:rgba(10,58,49,.92);border:1px solid rgba(234,217,166,.5);border-radius:999px}
.langbar button{border:0;background:transparent;color:var(--gold-soft);border-radius:999px;padding:3px 12px;font-size:.9rem;cursor:pointer}
.langbar button[aria-pressed="true"]{background:var(--gold-soft);color:var(--night);font-weight:600}

#lockScreen{position:relative;min-height:100vh;min-height:100dvh;display:grid;place-items:center;padding:72px 20px 32px;background:radial-gradient(120% 90% at 50% 0%,#12604e 0%,var(--night) 62%)}
#lockScreen::before{content:"";position:absolute;inset:0;background-image:var(--lattice);pointer-events:none}
.lock-card{position:relative;width:100%;max-width:420px;text-align:center;background:var(--white);border-top:4px solid var(--gold);border-radius:4px;padding:30px 24px 24px;box-shadow:0 24px 60px rgba(0,0,0,.35)}
.lock-logo{width:56px;height:56px;border-radius:8px}
.lock-greet{margin-top:10px;font-family:var(--serif);color:var(--gold-deep);font-size:1.1rem}
.lock-card h1{margin:0;font-family:var(--serif);font-weight:400;font-size:1.9rem;line-height:1.3;color:var(--night)}
.lock-for{margin-top:6px;font-weight:600}
.lock-sub{margin-top:4px;color:var(--muted);font-size:.95rem}
.lock-card input{width:100%;margin-top:18px;padding:11px 14px;font:inherit;border:1px solid #b9c4bb;border-radius:4px;background:#fbfdfb}
.lock-card input:focus{border-color:var(--emerald);outline:3px solid rgba(19,107,85,.25);outline-offset:0}
.btn{display:inline-flex;align-items:center;justify-content:center;gap:10px;border:0;border-radius:4px;padding:12px 22px;font:600 1.05rem var(--sans);cursor:pointer}
.btn-solid{width:100%;margin-top:12px;background:var(--emerald);color:#fff}
.btn-solid:hover{background:var(--night)}
#lockMsg{min-height:1.7em;margin-top:10px;color:#a12b2b;font-size:.95rem}
.lock-contact{margin-top:10px;font-size:.82rem;color:var(--muted);border-top:1px solid var(--line);padding-top:12px}
#loadError{position:relative;max-width:420px;margin:60px auto;background:#fff;border-top:4px solid #a12b2b;border-radius:4px;padding:20px;color:#7a1f1f;font-size:.95rem}

.hero{position:relative;overflow:hidden;color:#fff;padding:18px 20px 44px;background:linear-gradient(180deg,var(--night),#0e4a3e)}
.hero::before{content:"";position:absolute;inset:0;background-image:var(--lattice);pointer-events:none}
.hero::after{content:"";position:absolute;left:0;right:0;bottom:0;height:4px;background:linear-gradient(90deg,transparent,var(--gold),transparent)}
.hero-inner{position:relative;max-width:820px;margin:0 auto}
.brandrow{display:inline-flex;align-items:center;gap:10px;max-width:calc(100% - 130px);color:var(--gold-soft);text-decoration:none;font-weight:600}
.brandrow img{width:36px;height:36px;border-radius:6px;background:#fff;flex:none}
.switch{display:flex;width:fit-content;margin-top:14px;padding:6px 16px;border:1px solid var(--gold-soft);border-radius:999px;background:rgba(234,217,166,.12);color:var(--
