/* js/script.js
   Polished donation flow with manual payment UX
   - localStorage keys: qf_cart_v2, qf_last_order
   - Exposes showToast globally for inline scripts
*/

(() => {
  'use strict';

  const CONFIG = {
    CART_KEY: 'qf_cart_v2',
    LAST_ORDER_KEY: 'qf_last_order',
    TOAST_MS: 2200,
    DEBUG: false
  };

  const $ = (s, r = document) => r.querySelector(s);
  const $$ = (s, r = document) => Array.from(r.querySelectorAll(s));
  const id = (n) => document.getElementById(n);

  const log = (...a) => { if (CONFIG.DEBUG) console.log('[qf]', ...a); };
  const warn = (...a) => { if (CONFIG.DEBUG) console.warn('[qf]', ...a); };

  const safeParse = (v, fallback = null) => { try { return JSON.parse(v); } catch { return fallback; } };
  const formatCurrency = (n) => { const num = Number(n || 0); if (!Number.isFinite(num)) return '$0.00'; return '$' + num.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 }); };
  const escapeHtml = (s = '') => String(s).replace(/[&<>"']/g, (m) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[m]));

  // Storage helpers
  const loadCart = () => safeParse(localStorage.getItem(CONFIG.CART_KEY), []) || [];
  const saveCart = (cart) => { try { localStorage.setItem(CONFIG.CART_KEY, JSON.stringify(cart)); } catch (e) { warn('saveCart', e); } };

  // Toast
  function showToast(msg, ms = CONFIG.TOAST_MS) {
    try {
      let container = id('qf-toast');
      if (!container) {
        container = document.createElement('div');
        container.id = 'qf-toast';
        Object.assign(container.style, { position: 'fixed', top: '1rem', right: '1rem', zIndex: '9999', display: 'flex', flexDirection: 'column', gap: '0.5rem' });
        document.body.appendChild(container);
      }
      const el = document.createElement('div');
      el.textContent = msg;
      Object.assign(el.style, { background: 'rgba(2,6,23,0.04)', color: 'var(--fg)', padding: '0.6rem 0.9rem', borderRadius: '8px', boxShadow: '0 8px 24px rgba(2,6,23,0.06)', transition: 'opacity 180ms ease' });
      container.appendChild(el);
      setTimeout(() => { el.style.opacity = '0'; setTimeout(() => el.remove(), 220); }, ms);
    } catch (e) { log('toast error', e); }
  }
  window.showToast = showToast;

  // Render cart UI
  function renderCart() {
    const cart = loadCart();
    const itemsEl = id('cart-items');
    const totalEl = id('cart-total');
    const countEl = id('header-cart-count');
    if (!itemsEl || !totalEl || !countEl) return;

    itemsEl.innerHTML = '';
    if (!cart.length) {
      itemsEl.innerHTML = '<div class="small" style="padding:0.6rem 0">Your cart is empty.</div>';
    } else {
      cart.forEach((it, idx) => {
        const row = document.createElement('div');
        row.style.display = 'flex';
        row.style.justifyContent = 'space-between';
        row.style.padding = '8px 0';
        row.innerHTML = `<div><div style="font-weight:700">${escapeHtml(it.title)}</div><div class="small">${it.custom ? 'Custom donation' : ''}</div></div>
                         <div style="text-align:right"><div style="font-weight:800">${formatCurrency(it.price)}</div><div style="margin-top:6px"><button data-idx="${idx}" class="small remove-item" style="background:transparent;border:0;color:var(--muted);cursor:pointer">Remove</button></div></div>`;
        itemsEl.appendChild(row);
      });
    }

    const total = cart.reduce((s, i) => s + Number(i.price || 0), 0);
    totalEl.textContent = formatCurrency(total);
    countEl.textContent = String(cart.length);
  }

  // Add buttons
  function bindAddButtons() {
    const buttons = $$('.add-to-cart');
    buttons.forEach(btn => {
      if (btn.dataset.bound === 'true') return;
      btn.dataset.bound = 'true';
      btn.addEventListener('click', (e) => {
        e.preventDefault();
        try {
          const title = btn.getAttribute('data-title') || (btn.closest('.card')?.querySelector('h3')?.textContent?.trim()) || 'Donation';
          const priceRaw = btn.getAttribute('data-price') || btn.closest('.card')?.querySelector('.price')?.textContent || '0';
          const price = Number(String(priceRaw).replace(/[^0-9.]/g, '')) || 0;
          const cart = loadCart();
          cart.push({ title: title.trim(), price: Number(price), addedAt: new Date().toISOString() });
          saveCart(cart);
          renderCart();
          showToast(`Added to cart: ${title}`);
        } catch (err) { warn('add error', err); showToast('Could not add item'); }
      });
    });
  }

  // Custom donation
  function bindCustomDonation() {
    const input = id('custom-amount');
    const addBtn = id('custom-add');
    if (!input || !addBtn) return;
    input.addEventListener('input', () => {
      const v = Number(input.value);
      const ok = Number.isFinite(v) && v >= 1;
      addBtn.disabled = !ok;
      if (!ok) addBtn.setAttribute('aria-disabled', 'true'); else addBtn.removeAttribute('aria-disabled');
    });
    addBtn.addEventListener('click', (e) => {
      e.preventDefault();
      const v = Number(input.value);
      if (!Number.isFinite(v) || v < 1) { showToast('Enter a valid amount (minimum $1)'); return; }
      const cart = loadCart();
      cart.push({ title: 'Custom Donation', price: Number(v), custom: true, addedAt: new Date().toISOString() });
      saveCart(cart);
      renderCart();
      showToast('Custom donation added');
      input.value = '';
      addBtn.disabled = true;
      addBtn.setAttribute('aria-disabled', 'true');
    });
  }

  // Cart interactions
  function bindCartInteractions() {
    const headerCart = id('header-cart');
    const cartModal = id('cart-modal');
    const cartClear = id('cart-clear');
    const cartItems = id('cart-items');

    if (headerCart && cartModal) {
      headerCart.addEventListener('click', () => {
        const open = cartModal.classList.toggle('open');
        cartModal.style.display = open ? 'block' : 'none';
        cartModal.setAttribute('aria-hidden', open ? 'false' : 'true');
      });
    }

    if (cartClear) {
      cartClear.addEventListener('click', () => {
        if (!confirm('Clear all items from cart?')) return;
        saveCart([]);
        renderCart();
        showToast('Cart cleared');
      });
    }

    if (cartItems) {
      cartItems.addEventListener('click', (e) => {
        const btn = e.target.closest('button.remove-item');
        if (!btn) return;
        const idx = Number(btn.getAttribute('data-idx'));
        const cart = loadCart();
        if (Number.isInteger(idx) && idx >= 0 && idx < cart.length) {
          cart.splice(idx, 1);
          saveCart(cart);
          renderCart();
          showToast('Item removed');
        } else warn('invalid index', idx);
      });
    }
  }

  // Checkout modal and form (if present)
  function bindCheckout() {
    const checkoutBtn = id('checkout');
    const modalBackdrop = id('modal-backdrop');
    const checkoutForm = id('checkout-form');
    const checkoutStatus = id('checkout-status');
    const cancelBtn = id('cancel-checkout');

    if (checkoutBtn && modalBackdrop) {
      checkoutBtn.addEventListener('click', () => {
        const cart = loadCart();
        if (!cart.length) { showToast('Your cart is empty'); return; }
        modalBackdrop.classList.add('open');
        modalBackdrop.style.display = 'flex';
        modalBackdrop.setAttribute('aria-hidden', 'false');
      });
    }

    if (cancelBtn && modalBackdrop) {
      cancelBtn.addEventListener('click', () => {
        modalBackdrop.classList.remove('open');
        modalBackdrop.style.display = 'none';
        modalBackdrop.setAttribute('aria-hidden', 'true');
      });
    }

    if (modalBackdrop) {
      modalBackdrop.addEventListener('click', (e) => {
        if (e.target === modalBackdrop) {
          modalBackdrop.classList.remove('open');
          modalBackdrop.style.display = 'none';
          modalBackdrop.setAttribute('aria-hidden', 'true');
        }
      });
    }

    if (checkoutForm) {
      checkoutForm.addEventListener('submit', (e) => {
        e.preventDefault();
        const name = id('payer-name')?.value.trim() || '';
        const email = id('payer-email')?.value.trim() || '';
        if (!name || !email) { showToast('Please provide name and email'); return; }
        // Demo: immediate paid flow (kept for backward compatibility)
        checkoutForm.style.display = 'none';
        if (checkoutStatus) { checkoutStatus.style.display = ''; checkoutStatus.innerHTML = '<div class="small">Processing…</div>'; }
        setTimeout(() => {
          const cart = loadCart();
          const total = cart.reduce((s, i) => s + Number(i.price || 0), 0);
          const order = {
            id: 'QF-' + Math.random().toString(36).slice(2, 9).toUpperCase(),
            items: cart,
            donor: { name, email },
            total: Number(total),
            status: 'paid',
            createdAt: new Date().toISOString(),
            paidAt: new Date().toISOString()
          };
          try { localStorage.setItem(CONFIG.LAST_ORDER_KEY, JSON.stringify(order)); } catch (e) { warn(e); }
          saveCart([]);
          renderCart();
          if (checkoutStatus) checkoutStatus.innerHTML = '<div class="small" style="background:linear-gradient(90deg,#10b981,#06b6d4);color:#042;padding:0.6rem;border-radius:8px;font-weight:800">Payment successful — thank you.</div>';
          showToast('Payment completed. Receipt saved locally.');
          setTimeout(() => { if (modalBackdrop) { modalBackdrop.classList.remove('open'); modalBackdrop.style.display = 'none'; modalBackdrop.setAttribute('aria-hidden', 'true'); } location.href = './thankyou.html'; }, 900);
        }, 900);
      });
    }
  }

  // Mobile menu
  function bindMobileMenu() {
    const toggle = id('mobile-toggle');
    const mobileMenu = id('mobile-menu');
    const primaryNav = id('primary-nav');
    if (!toggle) return;
    const update = () => { toggle.style.display = window.innerWidth <= 768 ? 'inline-flex' : 'none'; };
    update();
    window.addEventListener('resize', update);
    toggle.addEventListener('click', (e) => {
      e.preventDefault();
      const expanded = toggle.getAttribute('aria-expanded') === 'true';
      toggle.setAttribute('aria-expanded', String(!expanded));
      if (mobileMenu) mobileMenu.style.display = expanded ? 'none' : 'block';
      else if (primaryNav) { primaryNav.style.display = expanded ? 'none' : 'flex'; primaryNav.style.flexDirection = 'column'; primaryNav.style.gap = '0.5rem'; }
    });
    document.addEventListener('click', (ev) => {
      if (!mobileMenu) return;
      if (!mobileMenu.contains(ev.target) && !toggle.contains(ev.target)) { mobileMenu.style.display = 'none'; toggle.setAttribute('aria-expanded', 'false'); }
    });
  }

  // Invoice rendering (status-aware)
  function renderInvoicePage() {
    const el = id('invoice-content');
    if (!el) return;
    const order = safeParse(localStorage.getItem(CONFIG.LAST_ORDER_KEY), null);
    if (!order) { el.innerHTML = '<p class="small">No invoice found. Complete a donation to generate an invoice.</p>'; return; }
    const status = (order.status || 'unpaid').toLowerCase();
    const badgeClass = status === 'paid' ? 'badge badge-paid' : 'badge badge-unpaid';
    const itemsHtml = (order.items || []).map(it => `<div style="display:flex;justify-content:space-between;padding:6px 0"><div>${escapeHtml(it.title)}</div><div>${formatCurrency(it.price)}</div></div>`).join('');
    const txHtml = order.txId ? `<div class="small">Transaction ID: <strong>${escapeHtml(order.txId)}</strong></div>` : '';
    const paidAtHtml = order.paidAt ? `<div class="small">Paid at: ${new Date(order.paidAt).toLocaleString()}</div>` : '';
    el.innerHTML = `
      <div style="display:flex;justify-content:space-between;align-items:center;gap:1rem">
        <div>
          <div><strong>Order ID:</strong> ${escapeHtml(order.id)}</div>
          <div class="small">Donor: ${escapeHtml(order.donor?.name || '')} • ${escapeHtml(order.donor?.email || '')}</div>
          ${txHtml}
          ${paidAtHtml}
        </div>
        <div style="text-align:right">
          <div style="font-weight:800">${formatCurrency(order.total)}</div>
          <div style="margin-top:6px"><span class="${badgeClass}">${status === 'paid' ? 'Paid' : 'Unpaid'}</span></div>
        </div>
      </div>
      <div style="margin-top:12px">${itemsHtml}</div>
    `;
  }

  // Payment confirmation binding for payment.html
  function bindPaymentPage() {
    const confirmBtn = id('confirm-payment');
    if (!confirmBtn) return;
    confirmBtn.addEventListener('click', () => {
      const order = safeParse(localStorage.getItem(CONFIG.LAST_ORDER_KEY), null);
      if (!order) { showToast('No order found to confirm'); return; }
      // Ask for transaction id
      const tx = prompt('Enter transaction/reference ID (optional). Paste the ID from your payment receipt.');
      if (tx === null) return; // cancelled
      order.status = 'paid';
      order.txId = tx ? String(tx).trim() : '';
      order.paidAt = new Date().toISOString();
      try { localStorage.setItem(CONFIG.LAST_ORDER_KEY, JSON.stringify(order)); } catch (e) { warn(e); showToast('Could not save confirmation'); return; }
      showToast('Payment confirmed — thank you.');
      setTimeout(() => { location.href = './invoice.html'; }, 700);
    });
  }

  // Copy helpers for payment details
  function bindCopyButtons() {
    const copyButtons = $$('.copy-btn');
    copyButtons.forEach(btn => {
      if (btn.dataset.bound === 'true') return;
      btn.dataset.bound = 'true';
      btn.addEventListener('click', async () => {
        const target = btn.getAttribute('data-copy') || '';
        try {
          await navigator.clipboard.writeText(target);
          showToast('Copied to clipboard');
        } catch {
          showToast('Copy failed — please select and copy manually');
        }
      });
    });
  }

  // Tracing
  function bindTracing() {
    const btn = id('trace-btn');
    if (!btn) return;
    btn.addEventListener('click', () => {
      const q = (id('trace-input')?.value || '').trim();
      const out = id('trace-result');
      if (!out) return;
      if (!q) { out.innerHTML = '<div class="small">Enter order id, email or phone</div>'; return; }
      const order = safeParse(localStorage.getItem(CONFIG.LAST_ORDER_KEY), null);
      if (!order) { out.innerHTML = '<div class="small">No orders found (demo).</div>'; return; }
      const qLower = q.toLowerCase();
      const matches = (q === order.id) || (qLower === (order.donor?.email || '').toLowerCase()) || (q === (order.donor?.phone || ''));
      if (matches) {
        out.innerHTML = `<div><strong>Status:</strong> ${escapeHtml(order.status)}</div>
                         <div class="small">Order ID: ${escapeHtml(order.id)}</div>
                         <div class="small">Donor: ${escapeHtml(order.donor?.name || '')} • ${escapeHtml(order.donor?.phone || '')}</div>
                         <div style="margin-top:8px"><a class="full-btn" href="./invoice.html">View Invoice</a></div>`;
      } else out.innerHTML = '<div class="small">No matching order found in demo data.</div>';
    });
  }

  // Diagnostics
  function diagnosticLog() {
    if (!CONFIG.DEBUG) return;
    log('diagnostic', {
      addToCart: $$('.add-to-cart').length,
      headerCart: !!id('header-cart'),
      cartModal: !!id('cart-modal'),
      invoice: !!id('invoice-content'),
      confirmPayment: !!id('confirm-payment')
    });
  }

  // Init
  function init() {
    try {
      bindAddButtons();
      bindCustomDonation();
      bindCartInteractions();
      bindCheckout();
      bindMobileMenu();
      renderCart();
      renderInvoicePage();
      bindPaymentPage();
      bindCopyButtons();
      bindTracing();
      diagnosticLog();
      log('init complete');
    } catch (e) { warn('init error', e); }
  }

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', init); else init();

})();
