/* ===========================================================
   হিফজ খানা — app.js
   এই ফাইলটি data.json থেকে সকল কন্টেন্ট লোড করে HTML-এ বসায়।
   =========================================================== */

const ICONS = {
  student: "🎓",
  teacher: "🕌",
  director: "🗂️",
  parent: "👪",
  public: "🌍"
};

function el(tag, className, html) {
  const node = document.createElement(tag);
  if (className) node.className = className;
  if (html !== undefined) node.innerHTML = html;
  return node;
}

async function loadData() {
  try {
    const res = await fetch("data.json", { cache: "no-store" });
    if (!res.ok) throw new Error("HTTP " + res.status);
    return await res.json();
  } catch (err) {
    // fetch() ব্লক হয় সাধারণত file:// প্রোটোকলে সরাসরি খোলা হলে (CORS)।
    // এই পেজটি একটি ছোট লোকাল সার্ভার দিয়ে চালানোর পরামর্শ দেওয়া হচ্ছে।
    console.error("data.json লোড করা যায়নি:", err);
    document.getElementById("main").innerHTML =
      '<div class="container section">' +
      '<h2>ডাটা লোড করা যায়নি</h2>' +
      '<p>এই পেজটি সরাসরি ফাইল হিসেবে খুললে ব্রাউজার নিরাপত্তার কারণে data.json ফেচ করতে বাধা দিতে পারে। ' +
      'অনুগ্রহ করে একটি লোকাল সার্ভার দিয়ে চালান, যেমন টার্মিনালে এই ফোল্ডারে গিয়ে চালান: ' +
      '<code>python3 -m http.server 8000</code> — তারপর ব্রাউজারে <code>http://localhost:8000</code> খুলুন।</p>' +
      "</div>";
    return null;
  }
}

function renderTopbar(data) {
  document.getElementById("topbar-notice").textContent = data.topBar.notice;
  const langsWrap = document.getElementById("topbar-langs");
  data.topBar.languages.forEach((lang, i) => {
    const span = el("span", null, lang);
    if (i === 0) span.setAttribute("aria-current", "true");
    langsWrap.appendChild(span);
  });
}

function renderHeader(data) {
  const logoImg = document.getElementById("brand-logo");
  const logoLetter = document.getElementById("brand-mark-letter");
  logoLetter.textContent = data.site.logoLetter;

  if (data.site.logoUrl) {
    logoImg.alt = data.site.nameBn || data.site.shortName;
    logoImg.addEventListener("error", () => {
      logoImg.setAttribute("data-failed", "true");
    });
    logoImg.addEventListener("load", () => {
      logoLetter.setAttribute("data-hidden", "true");
    });
    logoImg.src = data.site.logoUrl;
  } else {
    logoImg.setAttribute("data-failed", "true");
  }

  document.getElementById("brand-name").textContent = data.site.nameBn || data.site.shortName;
  document.getElementById("brand-tag").textContent =
    (data.site.nameEn ? data.site.nameEn + " · " : "") + (data.site.nameAr || data.site.name);

  const navList = document.getElementById("navList");
  data.nav.forEach((item) => {
    const li = el("li");
    const a = el("a", null, item.title);
    a.href = item.href;
    li.appendChild(a);

    if (item.children && item.children.length) {
      const dropdown = el("div", "dropdown");
      item.children.forEach((child) => {
        const childA = el(
          "a",
          null,
          `<span class="d-title">${child.title}</span><span class="d-desc">${child.desc}</span>`
        );
        childA.href = child.href;
        dropdown.appendChild(childA);
      });
      li.appendChild(dropdown);
      li.addEventListener("click", (e) => {
        if (window.innerWidth <= 720 && e.target === a) {
          e.preventDefault();
          li.classList.toggle("is-open");
        }
      });
    }
    navList.appendChild(li);
  });

  const navToggle = document.getElementById("navToggle");
  const mainNav = document.getElementById("mainNav");
  navToggle.addEventListener("click", () => {
    const isOpen = mainNav.classList.toggle("is-open");
    navToggle.setAttribute("aria-expanded", String(isOpen));
  });
}

function renderHero(data) {
  document.getElementById("heroHeading").textContent = data.hero.heading;
  document.getElementById("heroSub").textContent = data.hero.sub;

  const primary = document.getElementById("heroPrimaryCta");
  primary.textContent = data.hero.primaryCta.label;
  primary.href = data.hero.primaryCta.href;

  const secondary = document.getElementById("heroSecondaryCta");
  secondary.textContent = data.hero.secondaryCta.label;
  secondary.href = data.hero.secondaryCta.href;

  document.getElementById("heroAyatArabic").textContent = data.hero.ayat.arabic;
  document.getElementById("heroAyatBangla").textContent = data.hero.ayat.bangla;
  document.getElementById("heroAyatRef").textContent = data.hero.ayat.ref;
}

function renderStats(data) {
  const grid = document.getElementById("statsGrid");
  data.stats.forEach((stat) => {
    const item = el(
      "div",
      "stat-item",
      `<div class="num">${stat.number}</div><div class="lbl">${stat.label}</div>`
    );
    grid.appendChild(item);
  });
}

function renderModules(data) {
  document.getElementById("modulesHeading").textContent = data.hifzModules.heading;
  document.getElementById("modulesSub").textContent = data.hifzModules.sub;

  const grid = document.getElementById("modulesGrid");
  data.hifzModules.items.forEach((mod) => {
    const card = el(
      "article",
      "card",
      `<span class="tag">${mod.tag}</span>
       <h3>${mod.title}</h3>
       <p>${mod.desc}</p>
       <a class="card-link" href="${mod.href}">বিস্তারিত দেখুন →</a>`
    );
    grid.appendChild(card);
  });
}

function findAccount(data, roleId) {
  return (data.security && data.security.demoAccounts || []).find((a) => a.role === roleId);
}

function isLoggedIn(roleId) {
  return sessionStorage.getItem("hifz_gate_" + roleId) === "true";
}

function setLoggedIn(roleId, value) {
  if (value) sessionStorage.setItem("hifz_gate_" + roleId, "true");
  else sessionStorage.removeItem("hifz_gate_" + roleId);
}

function buildLinksMarkup(role) {
  const linksHtml = role.links
    .map((link) => `<li><a href="${link.href}">${link.title}</a></li>`)
    .join("");
  return `
    <div class="role-panel-inner">
      <div class="desc-box">
        <div style="font-size:1.8rem;margin-bottom:8px;">${ICONS[role.icon] || "📘"}</div>
        <h3>${role.title}</h3>
        <p>${role.desc}</p>
      </div>
      <div>
        <div class="logged-in-bar">
          <span>✅ ${role.title} হিসেবে প্রবেশ করা হয়েছে</span>
          <button type="button" class="logout-btn">লগআউট</button>
        </div>
        <ul class="role-link-list">${linksHtml}</ul>
      </div>
    </div>
  `;
}

function buildGateMarkup(data, role, account) {
  return `
    <div class="role-panel-inner">
      <div class="desc-box">
        <div style="font-size:1.8rem;margin-bottom:8px;">${ICONS[role.icon] || "📘"}</div>
        <h3>${role.title}</h3>
        <p>${role.desc}</p>
      </div>
      <form class="login-gate" data-role="${role.id}">
        <h4>${data.security.gateHeading}</h4>
        <div class="gate-note">${data.security.gateNote}</div>
        <label for="user-${role.id}">ইউজারনেম</label>
        <input type="text" id="user-${role.id}" autocomplete="username" required>
        <label for="pass-${role.id}">পাসওয়ার্ড</label>
        <input type="password" id="pass-${role.id}" autocomplete="current-password" required>
        <div class="gate-error"></div>
        <button type="submit" class="btn btn--primary" style="width:100%;justify-content:center;">প্রবেশ করুন</button>
        <div class="gate-demo">ডেমো: ইউজারনেম <strong>${account.username}</strong>, পাসওয়ার্ড <strong>${account.password}</strong></div>
      </form>
    </div>
  `;
}

function renderRolePanelContent(data, role, panel) {
  const account = findAccount(data, role.id);

  if (!account) {
    // Public panel or any role without a demo account: no gate needed
    panel.innerHTML = buildLinksMarkup(role);
    return;
  }

  if (isLoggedIn(role.id)) {
    panel.innerHTML = buildLinksMarkup(role);
    panel.querySelector(".logout-btn").addEventListener("click", () => {
      setLoggedIn(role.id, false);
      renderRolePanelContent(data, role, panel);
    });
    return;
  }

  panel.innerHTML = buildGateMarkup(data, role, account);
  const form = panel.querySelector(".login-gate");
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    const user = form.querySelector(`#user-${role.id}`).value.trim();
    const pass = form.querySelector(`#pass-${role.id}`).value;
    const errorBox = form.querySelector(".gate-error");
    if (user === account.username && pass === account.password) {
      setLoggedIn(role.id, true);
      renderRolePanelContent(data, role, panel);
    } else {
      errorBox.textContent = "ইউজারনেম বা পাসওয়ার্ড সঠিক নয়। আবার চেষ্টা করুন।";
    }
  });
}

function renderRolePanels(data) {
  const tabsWrap = document.getElementById("roleTabs");
  const panelsWrap = document.getElementById("rolePanels");

  data.roleDashboards.forEach((role, index) => {
    // Tab button
    const tab = el("button", "role-tab", role.title);
    tab.setAttribute("role", "tab");
    tab.setAttribute("aria-selected", index === 0 ? "true" : "false");
    tab.setAttribute("data-target", role.id);
    tabsWrap.appendChild(tab);

    // Panel content
    const panel = el("div", "role-panel" + (index === 0 ? " is-active" : ""));
    panel.id = "rp-" + role.id;
    panelsWrap.appendChild(panel);
    renderRolePanelContent(data, role, panel);

    tab.addEventListener("click", () => {
      tabsWrap.querySelectorAll(".role-tab").forEach((t) => t.setAttribute("aria-selected", "false"));
      panelsWrap.querySelectorAll(".role-panel").forEach((p) => p.classList.remove("is-active"));
      tab.setAttribute("aria-selected", "true");
      panel.classList.add("is-active");
      // Also jump to the matching anchor id for deep-linking (e.g. #panel-student)
      history.replaceState(null, "", "#" + role.id);
    });
  });

  // Deep-link support: if URL hash matches a role id on load, activate it
  const hash = window.location.hash.replace("#", "");
  const matchIndex = data.roleDashboards.findIndex((r) => r.id === hash);
  if (matchIndex > 0) {
    tabsWrap.children[matchIndex].click();
  }
}

function renderHierarchy(data) {
  document.getElementById("hierarchyHeading").textContent = data.hierarchy.heading;
  document.getElementById("hierarchySub").textContent = data.hierarchy.sub;

  const wrap = document.getElementById("pyramidWrap");
  const detail = document.getElementById("hierarchyDetail");
  detail.innerHTML = '<p class="h-placeholder">বিস্তারিত জানতে উপরের যেকোনো স্তরে ক্লিক করুন।</p>';

  const total = data.hierarchy.levels.length;
  data.hierarchy.levels.forEach((lvl, i) => {
    const step = el(
      "button",
      `pyramid-step pyramid-step--${lvl.level}`,
      `<div class="p-title">স্তর ${lvl.level}: ${lvl.title}</div><div class="p-scope">${lvl.scope}</div>`
    );
    step.type = "button";
    step.style.setProperty("--w", 30 + (i * (65 / (total - 1))) + "%");
    step.setAttribute("aria-pressed", "false");

    step.addEventListener("click", () => {
      wrap.querySelectorAll(".pyramid-step").forEach((s) => s.setAttribute("aria-pressed", "false"));
      step.setAttribute("aria-pressed", "true");
      detail.innerHTML = `<div class="h-title">স্তর ${lvl.level}: ${lvl.title} (${lvl.scope})</div><div class="h-desc">${lvl.desc}</div>`;
    });
    wrap.appendChild(step);
  });
}

function renderTestimonials(data) {
  const grid = document.getElementById("testiGrid");
  data.testimonials.forEach((t) => {
    const card = el(
      "div",
      "testi-card",
      `<p class="quote">"${t.quote}"</p>
       <div class="who"><span class="name">${t.name}</span> · <span class="role">${t.role}</span></div>`
    );
    grid.appendChild(card);
  });
}

function renderCta(data) {
  document.getElementById("ctaHeading").textContent = data.cta.heading;
  document.getElementById("ctaSub").textContent = data.cta.sub;
  const btn = document.getElementById("ctaButton");
  btn.textContent = data.cta.cta.label;
  btn.href = data.cta.cta.href;
}

function renderContact(data) {
  document.getElementById("contactInfo").innerHTML =
    `হেল্পলাইন: <strong>${data.site.helpline}</strong> &nbsp;|&nbsp; ইমেইল: <strong>${data.site.email}</strong> &nbsp;|&nbsp; ঠিকানা: ${data.site.address}`;
}

function renderSitemap(data) {
  const grid = document.getElementById("sitemapGrid");
  data.sitemap.forEach((group) => {
    const col = el(
      "div",
      "sitemap-col",
      `<h4>${group.section}</h4><ul>${group.pages.map((p) => `<li>${p}</li>`).join("")}</ul>`
    );
    grid.appendChild(col);
  });
}

function renderFooter(data) {
  const top = document.getElementById("footerTop");

  const about = el(
    "div",
    "footer-about",
    `<div class="brand-text"><span class="name">${data.site.shortName}</span></div>
     <p>${data.footer.about}</p>`
  );
  top.appendChild(about);

  data.footer.columns.forEach((col) => {
    const colEl = el(
      "div",
      "footer-col",
      `<h4>${col.title}</h4><ul>${col.links
        .map((l) => `<li><a href="${l.href}">${l.title}</a></li>`)
        .join("")}</ul>`
    );
    top.appendChild(colEl);
  });

  document.getElementById("footerCopyright").textContent = data.footer.copyright;

  const legalWrap = document.getElementById("footerLegal");
  data.footer.legal.forEach((item) => {
    const a = el("a", null, item.title);
    a.href = item.href;
    legalWrap.appendChild(a);
  });

  const socialWrap = document.getElementById("footerSocials");
  data.footer.socials.forEach((item) => {
    const a = el("a", null, item.title);
    a.href = item.href;
    socialWrap.appendChild(a);
  });
}

async function init() {
  const data = await loadData();
  if (!data) return;

  renderTopbar(data);
  renderHeader(data);
  renderHero(data);
  renderStats(data);
  renderModules(data);
  renderHierarchy(data);
  renderRolePanels(data);
  renderTestimonials(data);
  renderCta(data);
  renderContact(data);
  renderSitemap(data);
  renderFooter(data);
}

document.addEventListener("DOMContentLoaded", init);
