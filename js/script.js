(function () {
  var ICONS = {
    gift: '<path d="M20 12v9H4v-9"/><path d="M2 7h20v5H2z"/><path d="M12 22V7"/><path d="M12 7H7.5A2.5 2.5 0 1 1 10 4.5"/><path d="M12 7h4.5A2.5 2.5 0 1 0 14 4.5"/>',
    sprout: '<path d="M7 20h10"/><path d="M10 20c0-4 2-6 2-10"/><path d="M12 10c-4 0-6-2-6-6 4 0 6 2 6 6z"/><path d="M12 10c4 0 6-3 6-7-4 0-6 3-6 7z"/>',
    handshake: '<path d="m11 17 2 2a1 1 0 1 0 3-3"/><path d="m14 14 2.5 2.5a1 1 0 1 0 3-3l-3.88-3.88a3 3 0 0 0-4.24 0l-.88.88a1 1 0 1 1-3-3l2.81-2.81a5.79 5.79 0 0 1 7.06-.87l.47.28"/><path d="m21 3 1 11h-2"/><path d="M3 3 2 14l6.5 6.5a1 1 0 1 0 3-3"/><path d="M3 4h8"/>'
  };

  var STATIC = document.querySelectorAll('[data-i18n]');
  var lang = localStorage.getItem('qf-lang') || 'bn';
  var DATA = null;

  fetch('data.json')
    .then(function (r) { if (!r.ok) throw new Error('missing data.json'); return r.json(); })
    .then(function (data) { DATA = data; applyLang(lang); })
    .catch(function (e) {
      console.error(e);
      document.getElementById('hero').innerHTML =
        '<p style="color:#7A2E2E">data.json লোড করা যায়নি — ফাইলটি একই ফোল্ডারে আছে কিনা যাচাই করুন। / Could not load data.json.</p>';
    });

  function esc(s) { var d = document.createElement('div'); d.textContent = s == null ? '' : String(s); return d.innerHTML; }
  function t(field) { return field[lang] || field.bn; }

  function render(data) {
    var h = data.hero;
    document.getElementById('epigraph').textContent = h.epigraph;
    document.getElementById('epigraphRef').textContent = t(h.epigraphRef);
    document.getElementById('heroTitle').textContent = t(h.title);
    document.getElementById('heroLead').textContent = t(h.lead);
    var cta = document.getElementById('heroCta');
    cta.textContent = t(h.cta);
    cta.href = h.cta.link;

    document.getElementById('ledgerStrip').innerHTML = data.ledger.map(function (l) {
      var val = lang === 'en' ? l.valueEn : l.value;
      return '<div class="ledger-item"><div class="val">' + esc(val) + '</div><div class="lbl">' + esc(t(l.label)) + '</div></div>';
    }).join('');

    document.getElementById('chaptersHeadBn').textContent = t(data.chaptersHead);

    document.getElementById('chapters').innerHTML = data.chapters.map(function (c) {
      var mark = lang === 'en' ? c.markEn : c.markBn;
      return '<div class="chapter">' +
        '<div class="medallion"><span>' + esc(mark) + '</span></div>' +
        '<div class="chapter-body">' +
        '<h3>' + esc(t(c.title)) + '</h3>' +
        '<span class="en">' + esc(lang === 'bn' ? c.title.en : c.title.bn) + '</span>' +
        '<p>' + esc(t(c.text)) + '</p>' +
        '<a href="' + esc(c.link) + '">' + (lang === 'en' ? 'Read more' : 'বিস্তারিত পড়ুন') + '</a>' +
        '</div></div>';
    }).join('');

    document.getElementById('supportHead').textContent = t(data.supportHead);
    document.getElementById('supportLead').textContent = t(data.supportLead);

    document.getElementById('supportGrid').innerHTML = data.ledgerEntries.map(function (e) {
      return '<div class="support-card">' +
        '<div class="icon"><svg viewBox="0 0 24 24" fill="none" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round">' + ICONS[e.icon] + '</svg></div>' +
        '<h3>' + esc(t(e.title)) + '</h3>' +
        '<span class="en">' + esc(lang === 'bn' ? e.title.en : e.title.bn) + '</span>' +
        '<p>' + esc(t(e.note)) + '</p>' +
        '<a href="' + esc(e.link) + '">' + esc(t(e.title)) + ' →</a>' +
        '</div>';
    }).join('');

    var p = data.portal;
    document.getElementById('portalTitle').textContent = t(p.title);
    document.getElementById('portalTitleEn').textContent = lang === 'bn' ? p.title.en : p.title.bn;
    document.getElementById('portalDesc').textContent = t(p.desc);
    var pcta = document.getElementById('portalCta');
    pcta.textContent = t(p.cta);
    pcta.href = p.cta.link;

    var f = data.footer;
    document.getElementById('footerNote').innerHTML =
      esc(t(f.note)) + ' — <a href="' + esc(f.creditLink) + '">' + esc(f.credit) + '</a>';
    document.getElementById('footerLinks').innerHTML = f.links.map(function (l) {
      return '<a href="' + esc(l.link) + '">' + esc(t(l.label)) + '</a>';
    }).join('');

    STATIC.forEach(function (el) {
      var key = 'i18n' + (lang === 'en' ? 'En' : 'Bn');
      if (el.dataset[key]) el.textContent = el.dataset[key];
    });

    document.documentElement.lang = lang === 'en' ? 'en' : 'bn';
    document.getElementById('langBn').classList.toggle('active', lang === 'bn');
    document.getElementById('langEn').classList.toggle('active', lang === 'en');
  }

  function applyLang(newLang) {
    lang = newLang;
    localStorage.setItem('qf-lang', lang);
    if (DATA) render(DATA);
  }

  document.getElementById('langBn').addEventListener('click', function () { applyLang('bn'); });
  document.getElementById('langEn').addEventListener('click', function () { applyLang('en'); });

  var toggleBtn = document.getElementById('navToggle');
  var navEl = document.getElementById('mainNav');
  toggleBtn.addEventListener('click', function () {
    var open = navEl.classList.toggle('open');
    toggleBtn.setAttribute('aria-expanded', open ? 'true' : 'false');
  });
})();
