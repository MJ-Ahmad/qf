// js/script.js
// Tab switching, simple form handling, and small UX helpers

document.addEventListener("DOMContentLoaded", () => {
  // Tabs
  const tabButtons = document.querySelectorAll(".tab-btn");
  const tabContents = document.querySelectorAll(".tab-content");

  function showTab(tabId) {
    tabButtons.forEach(btn => {
      btn.classList.toggle("active", btn.dataset.tab === tabId);
    });
    tabContents.forEach(content => {
      content.classList.toggle("hidden", content.id !== tabId);
    });
    // Move focus to the first focusable element in the shown tab for accessibility
    const activeContent = document.getElementById(tabId);
    if (activeContent) {
      const focusable = activeContent.querySelector("input, textarea, button, a");
      if (focusable) focusable.focus();
    }
  }

  tabButtons.forEach(btn => {
    btn.addEventListener("click", () => {
      showTab(btn.dataset.tab);
    });
    // keyboard support
    btn.addEventListener("keydown", (e) => {
      if (e.key === "Enter" || e.key === " ") {
        e.preventDefault();
        showTab(btn.dataset.tab);
      }
    });
  });

  // Initialize default tab (first with .active or fallback to first button)
  const initial = document.querySelector(".tab-btn.active") || tabButtons[0];
  if (initial) showTab(initial.dataset.tab);

  // Contact form handling
  const form = document.querySelector(".contact-form");
  if (form) {
    form.addEventListener("submit", (e) => {
      e.preventDefault();

      const name = form.querySelector('input[type="text"]')?.value.trim() || "";
      const email = form.querySelector('input[type="email"]')?.value.trim() || "";
      const message = form.querySelector("textarea")?.value.trim() || "";

      // Basic validation
      if (!name) {
        alert("Please enter your name.");
        form.querySelector('input[type="text"]').focus();
        return;
      }
      if (!email || !/^\S+@\S+\.\S+$/.test(email)) {
        alert("Please enter a valid email address.");
        form.querySelector('input[type="email"]').focus();
        return;
      }
      if (!message) {
        alert("Please enter a message.");
        form.querySelector("textarea").focus();
        return;
      }

      // Simulate submission (replace with real request in production)
      const submitBtn = form.querySelector('button[type="submit"]');
      const originalText = submitBtn.textContent;
      submitBtn.disabled = true;
      submitBtn.textContent = "Sending...";

      // Fake network delay
      setTimeout(() => {
        submitBtn.disabled = false;
        submitBtn.textContent = originalText;
        form.reset();
        // Show a friendly confirmation
        const confirmation = document.createElement("div");
        confirmation.className = "form-confirmation";
        confirmation.style.cssText = "margin-top:12px;padding:12px;border-radius:6px;background:#ecfdf5;color:#065f46;border:1px solid #bbf7d0;";
        confirmation.textContent = "Thanks — your message has been sent. We'll get back to you soon.";
        form.appendChild(confirmation);
        // Remove confirmation after a short time
        setTimeout(() => {
          confirmation.remove();
        }, 6000);
      }, 900);
    });
  }

  // Enhance external links to open in new tab safely (already set in HTML, this is a fallback)
  document.querySelectorAll('a[target="_blank"]').forEach(a => {
    a.setAttribute("rel", "noopener noreferrer");
  });
});

// Set current year in footer
document.addEventListener("DOMContentLoaded", () => {
  const yearEl = document.getElementById("current-year");
  if (yearEl) {
    yearEl.textContent = new Date().getFullYear();
  }
});
