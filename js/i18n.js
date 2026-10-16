/*
 * QuranerFariwala — shared EN | BN language toggle
 *
 * Works on any page that uses:
 *   - text:         data-bn="..." data-en="..."
 *   - placeholders: data-bn-placeholder="..." data-en-placeholder="..."
 *   - buttons:      <button data-lang-button="bn"> / <button data-lang-button="en">
 *   - footer year:  <span id="footerYear"></span> (optional)
 *
 * The chosen language is stored in localStorage under "qf-lang" so every
 * page remembers it. Loaded as a classic <script>, so it can be included
 * at the end of <body> on any page.
 */
(function () {
  'use strict';

  // Guard against double initialisation if the script is included twice.
  if (window.qfI18n) return;

  var STORAGE_KEY = 'qf-lang';
  var DEFAULT_LANG = 'bn';

  function normalise(lang) {
    return lang === 'en' ? 'en' : 'bn';
  }

  function getStoredLang() {
    try {
      return normalise(localStorage.getItem(STORAGE_KEY) || DEFAULT_LANG);
    } catch (e) {
      return DEFAULT_LANG;
    }
  }

  function saveLang(lang) {
    try {
      localStorage.setItem(STORAGE_KEY, lang);
    } catch (e) {
      /* storage unavailable (private mode etc.) — language still applies for this page */
    }
  }

  // Replace an element's text without destroying child elements (icons, links, spans).
  function setElementText(el, text) {
    if (el.children.length === 0) {
      el.textContent = text;
      return;
    }
    // Element has child tags: update only its first direct, non-empty text node.
    for (var i = 0; i < el.childNodes.length; i++) {
      var node = el.childNodes[i];
      if (node.nodeType === Node.TEXT_NODE && node.nodeValue.trim() !== '') {
        node.nodeValue = text;
        return;
      }
    }
  }

  function applyLang(lang) {
    lang = normalise(lang);

    document.querySelectorAll('[data-bn][data-en]').forEach(function (el) {
      var text = el.getAttribute(lang === 'en' ? 'data-en' : 'data-bn');
      if (text !== null) setElementText(el, text);
    });

    document.querySelectorAll('[data-bn-placeholder][data-en-placeholder]').forEach(function (el) {
      var ph = el.getAttribute(lang === 'en' ? 'data-en-placeholder' : 'data-bn-placeholder');
      if (ph !== null) el.setAttribute('placeholder', ph);
    });

    document.documentElement.setAttribute('lang', lang);
    document.documentElement.setAttribute('data-lang', lang);

    document.querySelectorAll('[data-lang-button]').forEach(function (btn) {
      btn.setAttribute('aria-pressed', String(btn.getAttribute('data-lang-button') === lang));
    });

    saveLang(lang);
  }

  function init() {
    applyLang(getStoredLang());

    document.querySelectorAll('[data-lang-button]').forEach(function (btn) {
      btn.addEventListener('click', function () {
        applyLang(btn.getAttribute('data-lang-button'));
      });
    });

    var year = document.getElementById('footerYear');
    if (year) year.textContent = new Date().getFullYear();
  }

  // Works whether this script loads before or after the DOM is parsed.
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

  window.qfI18n = { setLang: applyLang, getLang: getStoredLang };
})();
