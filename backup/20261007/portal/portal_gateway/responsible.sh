#!/usr/bin/env bash
# responsible.sh
# portal_gateway/ লোকেশন থেকে রান করুন: bash responsible.sh
# এটি responsible/ ফোল্ডার ও তার ভেতরের সবগুলো টেমপ্লেট + বাস্তব প্রোফাইল ফাইল তৈরি করবে।
set -e

echo "responsible/ ফোল্ডার তৈরি করা হচ্ছে..."

mkdir -p "responsible/_template"

cat > "responsible/_template/data.json" << 'QFEOF'
{
  "_readme": "এই ফাইলটি টেমপ্লেট। নতুন ব্যবহারকারীর ফোল্ডার তৈরি করার সময় (যেমন portal_gateway/hifz_student/karim123/) এই পুরো _template_user ফোল্ডারটি কপি করে সেই নামে রাখুন, তারপর নিচের সবগুলো ফিল্ডে প্রকৃত তথ্য বসান।",

  "site": {
    "brand": { "bn": "কোরআনের ফেরিওয়ালা", "en": "Quraner Fariwala" },
    "logo": "https://mj-ahmad.github.io/qf/assets/logo.png",
    "gatewayUrl": "../../",
    "homeUrl": "/qf/home/index.html",
    "defaultLang": "bn"
  },

  "user": {
    "username": "",
    "name": { "bn": "", "en": "" },
    "role": { "bn": "", "en": "" },
    "joined": ""
  },

  "notices": [],

  "sections": [],

  "support": { "email": "quranerfariwala@gmail.com" },

  "ui": {
    "welcome": { "bn": "স্বাগতম, {name}", "en": "Welcome, {name}" },
    "roleLabel": { "bn": "ভূমিকা", "en": "Role" },
    "joinedLabel": { "bn": "যুক্ত হয়েছেন", "en": "Joined" },
    "noticesHeading": { "bn": "নোটিশ", "en": "Notices" },
    "noNotices": { "bn": "এখনো কোনো নোটিশ নেই।", "en": "No notices yet." },
    "sectionsHeading": { "bn": "আপনার তথ্য", "en": "Your information" },
    "noSections": { "bn": "শীঘ্রই এখানে আরও তথ্য যুক্ত করা হবে।", "en": "More information will be added here soon." },
    "supportLabel": { "bn": "পাসওয়ার্ড পরিবর্তন বা কোনো প্রশ্ন থাকলে যোগাযোগ করুন:", "en": "For a password change or any question, contact:" },
    "backGateway": { "bn": "পোর্টাল প্রবেশদ্বারে ফিরুন", "en": "Back to portal gateway" },
    "backHome": { "bn": "হোমপেজে ফিরুন", "en": "Back to homepage" },
    "loadError": { "bn": "তথ্য ফাইল লোড করা যায়নি।", "en": "Could not load the data file." }
  }
}
QFEOF

cat > "responsible/_template/index.html" << 'QFEOF'
<!DOCTYPE html>
<html lang="bn">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="noindex,nofollow">
<meta name="theme-color" content="#0a3a31">
<title>Dashboard — Quraner Fariwala</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+Bengali:wght@400;600;700&family=Noto+Sans+Bengali:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
:root{--night:#16241E;--em:#3F6B52;--gold:#A9812F;--gsoft:#E4D6A8;--bg:#EDE7D3;--card:#F4EFDE;--ink:#16241E;--muted:rgba(22,36,30,.68);--line:rgba(22,36,30,.18);--warn:#7A2E2E;--serif:'Noto Serif Bengali',Georgia,serif;--sans:'Noto Sans Bengali',system-ui,sans-serif}
@media(prefers-color-scheme:dark){:root{--bg:#141d19;--card:#1c2822;--ink:#EDE7D3;--muted:#a8b3ac;--line:#31413a;--warn:#e3a89f}}
*{box-sizing:border-box}
body{margin:0;background:var(--bg);color:var(--ink);font:16px/1.7 var(--sans)}
.hidden{display:none!important}
a{color:inherit}
:focus-visible{outline:3px solid var(--gold);outline-offset:2px}
.langbar{position:fixed;top:12px;right:12px;z-index:90;display:flex;gap:2px;padding:3px;background:rgba(10,58,49,.92);border:1px solid rgba(234,217,166,.5);border-radius:999px}
.langbar button{border:0;background:none;color:var(--gsoft);border-radius:999px;padding:3px 12px;font:.9rem var(--sans);cursor:pointer}
.langbar button[aria-pressed="true"]{background:var(--gsoft);color:var(--night);font-weight:600}
.hero{background:radial-gradient(120% 90% at 50% 0,#12604e,var(--night) 68%);color:#fff;padding:50px 18px 30px;text-align:center}
.hero .top{display:flex;align-items:center;justify-content:center;gap:10px;margin-bottom:16px}
.hero .top img{width:34px;height:34px;border-radius:8px;background:#fff;padding:3px}
.hero .top span{font:600 1rem var(--sans);color:var(--gsoft)}
.hero h1{margin:0 0 6px;font:400 clamp(1.5rem,4vw,2.1rem)/1.35 var(--serif)}
.hero .roleline{color:var(--gsoft);font-size:.92rem}
main{max-width:820px;margin:-20px auto 0;padding:0 18px 40px;position:relative}
.panel{background:var(--card);border:1px solid var(--line);border-top:4px solid var(--gold);border-radius:8px;padding:22px 20px;margin-top:22px}
.panel h2{margin:0 0 12px;font:600 1.05rem var(--sans);color:var(--em)}
.meta{display:flex;gap:24px;flex-wrap:wrap;font-size:.92rem;color:var(--muted)}
.meta b{color:var(--ink)}
ul.plain{list-style:none;margin:0;padding:0}
ul.plain li{padding:10px 0;border-bottom:1px solid var(--line);font-size:.94rem}
ul.plain li:last-child{border-bottom:0}
.empty{color:var(--muted);font-size:.92rem}
.support{margin-top:10px;font-size:.9rem;color:var(--muted)}
.support a{color:var(--em);font-weight:600;text-decoration:none}
.support a:hover{text-decoration:underline}
.linkrow{display:flex;justify-content:center;gap:18px;flex-wrap:wrap;margin-top:26px;font-size:.9rem}
.linkrow a{color:var(--em);text-decoration:none;font-weight:600}
.linkrow a:hover{text-decoration:underline}
#err{max-width:420px;margin:60px auto;background:var(--card);border-top:4px solid var(--warn);padding:20px;color:var(--warn);border-radius:6px}
</style>
</head>
<body>
<div class="langbar" role="group" aria-label="Language">
  <button id="lBn" type="button" aria-pressed="true">বাংলা</button>
  <button id="lEn" type="button" aria-pressed="false">EN</button>
</div>

<div id="err" class="hidden" role="alert"></div>

<div id="app" class="hidden">
  <header class="hero">
    <div class="top"><img id="hLogo" alt=""><span id="brand"></span></div>
    <h1 id="welcome"></h1>
    <div class="roleline" id="roleline"></div>
  </header>

  <main>
    <section class="panel">
      <div class="meta">
        <div><b id="mRole"></b><br><span id="lblRole"></span></div>
        <div><b id="mJoined"></b><br><span id="lblJoined"></span></div>
      </div>
    </section>

    <section class="panel">
      <h2 id="noticesHeading"></h2>
      <ul class="plain" id="noticesList"></ul>
    </section>

    <section class="panel">
      <h2 id="sectionsHeading"></h2>
      <ul class="plain" id="sectionsList"></ul>
      <div class="support" id="supportNote"></div>
    </section>

    <div class="linkrow">
      <a id="backGateway" href="../../">←</a>
      <a id="backHome" href="/qf/home/index.html">←</a>
    </div>
  </main>
</div>

<script>
let D=null,lang='bn';
const $=id=>document.getElementById(id);
const T=v=>v==null?'':typeof v==='object'?(v[lang]??v.bn??''):v;
const fill=(s,o)=>T(s).replace(/\{(\w+)\}/g,(m,k)=>o[k]);
const esc=s=>String(s??'').replace(/[&<>"]/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'}[c]));

function render(){
  const S=D.site,U=D.ui,Us=D.user,SUP=D.support||{};
  document.documentElement.lang=lang;
  $('lBn').setAttribute('aria-pressed',lang==='bn');$('lEn').setAttribute('aria-pressed',lang==='en');
  $('hLogo').src=S.logo;
  $('brand').textContent=T(S.brand);
  $('welcome').textContent=fill(U.welcome,{name:T(Us.name)||Us.username||''});
  $('roleline').textContent=T(Us.role);
  $('lblRole').textContent=T(U.roleLabel);
  $('mRole').textContent=T(Us.role);
  $('lblJoined').textContent=T(U.joinedLabel);
  $('mJoined').textContent=Us.joined||'—';

  $('noticesHeading').textContent=T(U.noticesHeading);
  const notices=D.notices||[];
  $('noticesList').innerHTML=notices.length
    ? notices.map(n=>`<li>${esc(T(n))}</li>`).join('')
    : `<li class="empty">${esc(T(U.noNotices))}</li>`;

  $('sectionsHeading').textContent=T(U.sectionsHeading);
  const sections=D.sections||[];
  $('sectionsList').innerHTML=sections.length
    ? sections.map(s=>`<li><b>${esc(T(s.label))}:</b> ${esc(T(s.value))}</li>`).join('')
    : `<li class="empty">${esc(T(U.noSections))}</li>`;

  if(SUP.email){
    $('supportNote').innerHTML=`${esc(T(U.supportLabel))} <a href="mailto:${esc(SUP.email)}">${esc(SUP.email)}</a>`;
  }
  $('backGateway').innerHTML=`← ${esc(T(U.backGateway))}`;
  $('backGateway').href=S.gatewayUrl||'../../';
  $('backHome').innerHTML=`← ${esc(T(U.backHome))}`;
  $('backHome').href=S.homeUrl||'/qf/home/index.html';
}

function setLang(l){lang=l;try{localStorage.setItem('qfPortalLang',l)}catch(e){}render()}

async function init(){
  let saved=null;try{saved=localStorage.getItem('qfPortalLang')}catch(e){}
  try{ const r=await fetch('data.json',{cache:'no-store'}); if(!r.ok)throw 0; D=await r.json(); }
  catch(e){ $('err').textContent='তথ্য ফাইল লোড করা যায়নি / Could not load data.json.'; $('err').classList.remove('hidden'); return; }
  lang=saved==='en'||saved==='bn'?saved:(D.site.defaultLang||'bn');
  render();
  $('app').classList.remove('hidden');
}
$('lBn').onclick=()=>setLang('bn');$('lEn').onclick=()=>setLang('en');
init();
</script>
</body>
</html>
QFEOF

echo "সম্পন্ন — responsible/ এর ভেতরে তৈরি হয়েছে:"
find "responsible" -type f | sort
