(function () {
  'use strict';

  /* ---------- Helpers ---------- */
  const $ = (sel, root = document) => root.querySelector(sel);
  const $$ = (sel, root = document) => Array.from(root.querySelectorAll(sel));
  const CART_KEY = 'qf_cart_v1';

  function parsePrice(v) {
    const n = Number(String(v).replace(/[^0-9.]/g, ''));
    return Number.isFinite(n) ? n : 0;
  }
  function formatCurrency(n) {
    return '$' + Number(n).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 });
  }

  /* ---------- Toast ---------- */
  function showToast(msg, ms = 2000) {
    const container = document.getElementById('qf-toast');
    if (!container) return;
    const el = document.createElement('div');
    el.textContent = msg;
    el.style.background = 'rgba(255,255,255,0.06)';
    el.style.color = getComputedStyle(document.body).backgroundImage.includes('fafafa') ? '#0b1220' : 'var(--fg)';
    el.style.padding = '0.6rem 0.9rem';
    el.style.borderRadius = '8px';
    el.style.boxShadow = '0 8px 24px rgba(2,6,23,0.6)';
    el.style.opacity = '0';
    el.style.transform = 'translateY(-6px)';
    el.style.transition = 'opacity 180ms ease, transform 180ms ease';
    container.appendChild(el);
    requestAnimationFrame(() => { el.style.opacity = '1'; el.style.transform = 'translateY(0)'; });
    setTimeout(() => {
      el.style.opacity = '0'; el.style.transform = 'translateY(-6px)';
      setTimeout(() => el.remove(), 220);
    }, ms);
  }

  /* ---------- Cart storage ---------- */
  function loadCart() {
    try {
      const raw = localStorage.getItem(CART_KEY);
      return raw ? JSON.parse(raw) : [];
    } catch (e) {
      return [];
    }
  }
  function saveCart(cart) {
    try { localStorage.setItem(CART_KEY, JSON.stringify(cart)); } catch (e) {}
  }

  /* ---------- Cart UI ---------- */
  const cartFab = document.getElementById('cart-fab');
  const cartCountEl = document.getElementById('cart-count');
  const cartModal = document.getElementById('cart-modal');
  const cartItemsEl = document.getElementById('cart-items');
  const cartTotalEl = document.getElementById('cart-total');
  const cartClearBtn = document.getElementById('cart-clear');
  const checkoutBtn = document.getElementById('checkout');

  function renderCart() {
    const cart = loadCart();
    if (!cartItemsEl) return;
    cartItemsEl.innerHTML = '';
    if (!cart.length) {
      cartItemsEl.innerHTML = '<div class="small cart-empty" style="padding:0.6rem 0">Your cart is empty.</div>';
    } else {
      cart.forEach((it, idx) => {
        const row = document.createElement('div');
        row.className = 'cart-item';
        const meta = document.createElement('div');
        meta.className = 'meta';
        meta.innerHTML = '<div style="font-weight:700">' + escapeHtml(it.title) + '</div><div class="small">' + (it.custom ? 'Custom donation' : '') + '</div>';
        const right = document.createElement('div');
        right.style.textAlign = 'right';
        right.innerHTML = '<div style="font-weight:800">' + formatCurrency(it.price) + '</div><div style="margin-top:6px"><button data-idx="' + idx + '" class="small remove-item" style="background:transparent;border:0;color:var(--muted);cursor:pointer">Remove</button></div>';
        row.appendChild(meta);
        row.appendChild(right);
        cartItemsEl.appendChild(row);
      });
    }
    const total = cart.reduce((s, i) => s + Number(i.price || 0), 0);
    if (cartTotalEl) cartTotalEl.textContent = formatCurrency(total);
    if (cartCountEl) cartCountEl.textContent = String(cart.length);
  }

  function escapeHtml(s){ return String(s).replace(/[&<>"']/g, function(m){ return {'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[m]; }); }

  if (cartFab) {
    cartFab.addEventListener('click', () => {
      // If on donate page with modal, toggle modal (existing behavior)
      if (cartModal) {
        cartModal.classList.toggle('open');
      } else {
        // If no modal on this page, navigate to cart.html
        window.location.href = 'cart.html';
      }
    });
  }

  if (cartClearBtn) {
    cartClearBtn.addEventListener('click', () => {
      if (!confirm('Clear all items from cart?')) return;
      saveCart([]);
      renderCart();
      showToast('Cart cleared');
    });
  }

  if (cartItemsEl) {
    cartItemsEl.addEventListener('click', (e) => {
      const btn = e.target.closest('button.remove-item');
      if (!btn) return;
      const idx = Number(btn.getAttribute('data-idx'));
      const cart = loadCart();
      if (idx >= 0 && idx < cart.length) {
        cart.splice(idx, 1);
        saveCart(cart);
        renderCart();
        showToast('Item removed');
      }
    });
  }

  if (checkoutBtn) {
    checkoutBtn.addEventListener('click', () => {
      const cart = loadCart();
      if (!cart.length) { showToast('Your cart is empty'); return; }
      // Navigate to checkout page for full flow
      window.location.href = 'checkout.html';
    });
  }

  /* ---------- Add to cart bindings ---------- */
  function bindAddButtons() {
    const addBtns = Array.from(document.querySelectorAll('.add-to-cart'));
    addBtns.forEach(btn => {
      if (btn.dataset.bound === 'true') return;
      btn.dataset.bound = 'true';
      btn.addEventListener('click', (e) => {
        e.preventDefault();
        const title = btn.getAttribute('data-title') || btn.closest('.card')?.querySelector('h3')?.textContent?.trim() || 'Support item';
        const price = parsePrice(btn.getAttribute('data-price') || btn.closest('.card')?.querySelector('.price')?.textContent || '0');
        const item = { title: title, price: Number(price), addedAt: new Date().toISOString() };
        const cart = loadCart();
        cart.push(item);
        saveCart(cart);
        renderCart();
        showToast('Added to cart: ' + title);
      });
    });
  }

  /* ---------- Custom donation ---------- */
  const customInput = document.getElementById('custom-amount');
  const customAdd = document.getElementById('custom-add');
  if (customInput && customAdd) {
    customInput.addEventListener('input', () => {
      const v = Number(customInput.value);
      if (Number.isFinite(v) && v >= 1) {
        customAdd.disabled = false;
        customAdd.removeAttribute('aria-disabled');
      } else {
        customAdd.disabled = true;
        customAdd.setAttribute('aria-disabled', 'true');
      }
    });
    customAdd.addEventListener('click', (e) => {
      e.preventDefault();
      const v = Number(customInput.value);
      if (!Number.isFinite(v) || v < 1) { showToast('Enter a valid amount (minimum $1)'); return; }
      const item = { title: 'Custom Donation', price: Number(v), custom: true, addedAt: new Date().toISOString() };
      const cart = loadCart();
      cart.push(item);
      saveCart(cart);
      renderCart();
      showToast('Custom donation added');
      customInput.value = '';
      customAdd.disabled = true;
    });
  }

  /* ---------- Mobile menu toggle ---------- */
  const mobileToggle = document.getElementById('mobile-toggle');
  const mobileMenu = document.getElementById('mobile-menu');
  if (mobileToggle && mobileMenu) {
    mobileToggle.addEventListener('click', (e) => {
      e.preventDefault();
      const open = mobileToggle.getAttribute('aria-expanded') === 'true';
      if (open) {
        mobileMenu.style.display = 'none';
        mobileToggle.setAttribute('aria-expanded', 'false');
      } else {
        mobileMenu.style.display = 'block';
        mobileToggle.setAttribute('aria-expanded', 'true');
      }
    });
    // Close on outside click
    document.addEventListener('click', (ev) => {
      if (!mobileMenu.contains(ev.target) && !mobileToggle.contains(ev.target)) {
        mobileMenu.style.display = 'none';
        mobileToggle.setAttribute('aria-expanded', 'false');
      }
    });
  }

  /* ---------- Init ---------- */
  function init() {
    renderCart();
    bindAddButtons();

    // If donate page has a cart modal, add "Open full cart page" link at bottom
    if (cartModal && !cartModal.querySelector('.open-full-cart')) {
      const openFull = document.createElement('div');
      openFull.style.marginTop = '0.6rem';
      openFull.innerHTML = '<button class="full-btn open-full-cart" style="padding:0.45rem 0.6rem">Open full cart page</button>';
      cartModal.appendChild(openFull);
      openFull.querySelector('.open-full-cart').addEventListener('click', () => {
        window.location.href = 'cart.html';
      });
    }
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

  // Expose renderCart for manual calls (optional)
  window.qfRenderCart = renderCart;
})();
