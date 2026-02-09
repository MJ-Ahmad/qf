// script.js
// Mobile menu toggle for a static HTML header.
// Usage: include <script src="script.js"></script> before </body>.

(function () {
  'use strict';

  // Config: IDs used in the HTML
  const TOGGLE_ID = 'mobile-toggle';
  const MENU_ID = 'mobile-menu';
  const OPEN_CLASS = 'block';
  const CLOSED_CLASS = 'hidden';
  const NO_SCROLL_CLASS = 'overflow-hidden';
  const ANIMATION_MS = 220; // optional animation duration for max-height approach

  // Utility: safe query
  function $(id) {
    return document.getElementById(id);
  }

  // Initialize after DOM ready
  function init() {
    const btn = $(TOGGLE_ID);
    const menu = $(MENU_ID);

    if (!btn || !menu) {
      // Nothing to do if elements are missing
      return;
    }

    // Ensure initial ARIA state
    if (!btn.hasAttribute('aria-expanded')) btn.setAttribute('aria-expanded', 'false');
    btn.setAttribute('aria-controls', MENU_ID);

    // Optional: prepare menu for smooth open/close using max-height
    // If you prefer simple display toggle, comment out the block below.
    if (!menu.dataset.jsPrepared) {
      menu.style.overflow = 'hidden';
      menu.style.transition = `max-height ${ANIMATION_MS}ms ease`;
      // Set initial max-height to 0 if hidden, otherwise to scrollHeight
      if (menu.classList.contains(CLOSED_CLASS)) {
        menu.style.maxHeight = '0px';
      } else {
        menu.style.maxHeight = menu.scrollHeight + 'px';
      }
      menu.dataset.jsPrepared = 'true';
    }

    function openMenu() {
      btn.setAttribute('aria-expanded', 'true');
      document.documentElement.classList.add(NO_SCROLL_CLASS);

      // Animated open
      menu.classList.remove(CLOSED_CLASS);
      menu.classList.add(OPEN_CLASS);
      // allow layout to update then set maxHeight
      requestAnimationFrame(() => {
        menu.style.maxHeight = menu.scrollHeight + 'px';
      });
    }

    function closeMenu() {
      btn.setAttribute('aria-expanded', 'false');
      document.documentElement.classList.remove(NO_SCROLL_CLASS);

      // Animated close
      menu.style.maxHeight = menu.scrollHeight + 'px';
      // force reflow then collapse
      requestAnimationFrame(() => {
        menu.style.maxHeight = '0px';
      });
      // after animation, hide with display class to remove from flow
      setTimeout(() => {
        if (btn.getAttribute('aria-expanded') === 'false') {
          menu.classList.remove(OPEN_CLASS);
          menu.classList.add(CLOSED_CLASS);
        }
      }, ANIMATION_MS + 20);
    }

    function toggleMenu(e) {
      e && e.preventDefault();
      const isOpen = btn.getAttribute('aria-expanded') === 'true';
      if (isOpen) closeMenu(); else openMenu();
    }

    // Attach events
    btn.addEventListener('click', toggleMenu);

    // Close when clicking outside (but ignore clicks inside the menu or button)
    document.addEventListener('click', function (ev) {
      if (btn.contains(ev.target) || menu.contains(ev.target)) return;
      if (btn.getAttribute('aria-expanded') === 'true') closeMenu();
    });

    // Close on Escape
    document.addEventListener('keydown', function (ev) {
      if (ev.key === 'Escape' && btn.getAttribute('aria-expanded') === 'true') {
        closeMenu();
        btn.focus();
      }
    });

    // Optional: close on navigation link click (useful for single-page nav)
    menu.addEventListener('click', function (ev) {
      const target = ev.target.closest('a');
      if (!target) return;
      // If the link is internal (same origin) or has a hash, close the menu
      closeMenu();
    });

    // Recompute maxHeight on resize (so animation works after orientation change)
    window.addEventListener('resize', function () {
      if (menu.dataset.jsPrepared === 'true' && btn.getAttribute('aria-expanded') === 'true') {
        menu.style.maxHeight = menu.scrollHeight + 'px';
      }
    });
  }

  // Run on DOMContentLoaded or immediately if already ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
