(function () {
  'use strict';

  const STORAGE_KEY = 'qfLang';
  const DEFAULT_LANGUAGE = 'bn';
  const SUPPORTED_LANGUAGES = ['bn', 'en'];

  let currentLanguage = DEFAULT_LANGUAGE;

  function getSavedLanguage() {
    try {
      const savedLanguage = localStorage.getItem(STORAGE_KEY);

      if (SUPPORTED_LANGUAGES.includes(savedLanguage)) {
        return savedLanguage;
      }
    } catch (error) {
      console.warn('Language preference could not be read.', error);
    }

    return DEFAULT_LANGUAGE;
  }

  function saveLanguage(language) {
    try {
      localStorage.setItem(STORAGE_KEY, language);
    } catch (error) {
      console.warn('Language preference could not be saved.', error);
    }
  }

  function getText(element, language) {
    const value = element.getAttribute(`data-${language}`);

    return value !== null ? value : '';
  }

  function applyTextTranslations(language) {
    document
      .querySelectorAll('[data-bn][data-en]')
      .forEach(function (element) {
        element.textContent = getText(element, language);
      });
  }

  function applyHtmlTranslations(language) {
    document
      .querySelectorAll('[data-bn-html][data-en-html]')
      .forEach(function (element) {
        const attributeName =
          language === 'en'
            ? 'data-en-html'
            : 'data-bn-html';

        element.innerHTML =
          element.getAttribute(attributeName) || '';
      });
  }

  function applyAttributeTranslations(language) {
    document
      .querySelectorAll('[data-bn-placeholder][data-en-placeholder]')
      .forEach(function (element) {
        const attributeName =
          language === 'en'
            ? 'data-en-placeholder'
            : 'data-bn-placeholder';

        element.setAttribute(
          'placeholder',
          element.getAttribute(attributeName) || ''
        );
      });

    document
      .querySelectorAll('[data-bn-title][data-en-title]')
      .forEach(function (element) {
        const attributeName =
          language === 'en'
            ? 'data-en-title'
            : 'data-bn-title';

        element.setAttribute(
          'title',
          element.getAttribute(attributeName) || ''
        );
      });

    document
      .querySelectorAll('[data-bn-aria-label][data-en-aria-label]')
      .forEach(function (element) {
        const attributeName =
          language === 'en'
            ? 'data-en-aria-label'
            : 'data-bn-aria-label';

        element.setAttribute(
          'aria-label',
          element.getAttribute(attributeName) || ''
        );
      });

    document
      .querySelectorAll('[data-bn-alt][data-en-alt]')
      .forEach(function (element) {
        const attributeName =
          language === 'en'
            ? 'data-en-alt'
            : 'data-bn-alt';

        element.setAttribute(
          'alt',
          element.getAttribute(attributeName) || ''
        );
      });
  }

  function applyDocumentLanguage(language) {
    document.documentElement.lang = language;

    if (language === 'bn') {
      document.documentElement.dir = 'ltr';
    } else {
      document.documentElement.dir = 'ltr';
    }
  }

  function applyLanguageButtons(language) {
    document
      .querySelectorAll('[data-lang-button]')
      .forEach(function (button) {
        const buttonLanguage =
          button.getAttribute('data-lang-button');

        const isActive = buttonLanguage === language;

        button.setAttribute(
          'aria-pressed',
          String(isActive)
        );

        button.classList.toggle('active', isActive);
      });
  }

  function applyPageTitle(language) {
    const titleElement = document.querySelector('title');

    if (!titleElement) return;

    const translatedTitle =
      language === 'en'
        ? titleElement.getAttribute('data-en')
        : titleElement.getAttribute('data-bn');

    if (translatedTitle) {
      document.title = translatedTitle;
    }
  }

  function applyLanguage(language) {
    if (!SUPPORTED_LANGUAGES.includes(language)) {
      language = DEFAULT_LANGUAGE;
    }

    currentLanguage = language;

    applyDocumentLanguage(language);
    applyTextTranslations(language);
    applyHtmlTranslations(language);
    applyAttributeTranslations(language);
    applyLanguageButtons(language);
    applyPageTitle(language);

    document.dispatchEvent(
      new CustomEvent('qf:languagechange', {
        detail: {
          language: currentLanguage
        }
      })
    );
  }

  function setLanguage(language) {
    if (!SUPPORTED_LANGUAGES.includes(language)) {
      language = DEFAULT_LANGUAGE;
    }

    saveLanguage(language);
    applyLanguage(language);
  }

  function setupLanguageButtons() {
    document
      .querySelectorAll('[data-lang-button]')
      .forEach(function (button) {
        button.addEventListener('click', function () {
          const language =
            button.getAttribute('data-lang-button');

          setLanguage(language);
        });
      });
  }

  function setupAutomaticLanguageLinks() {
    document
      .querySelectorAll('[data-lang-href-bn][data-lang-href-en]')
      .forEach(function (element) {
        const language =
          currentLanguage === 'en' ? 'en' : 'bn';

        const attributeName =
          language === 'en'
            ? 'data-lang-href-en'
            : 'data-lang-href-bn';

        const href = element.getAttribute(attributeName);

        if (href) {
          element.setAttribute('href', href);
        }
      });
  }

  function initialize() {
    currentLanguage = getSavedLanguage();

    setupLanguageButtons();
    applyLanguage(currentLanguage);
    setupAutomaticLanguageLinks();
  }

  window.qfI18n = {
    getLanguage: function () {
      return currentLanguage;
    },

    setLanguage: function (language) {
      setLanguage(language);
      setupAutomaticLanguageLinks();
    },

    refresh: function () {
      applyLanguage(currentLanguage);
      setupAutomaticLanguageLinks();
    }
  };

  if (document.readyState === 'loading') {
    document.addEventListener(
      'DOMContentLoaded',
      initialize
    );
  } else {
    initialize();
  }
})();
