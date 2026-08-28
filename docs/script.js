(() => {
  const status = document.querySelector(".copy-status");
  let statusTimer;

  const showStatus = (message) => {
    if (!status) return;

    window.clearTimeout(statusTimer);
    status.textContent = message;
    status.classList.add("is-visible");
    statusTimer = window.setTimeout(() => {
      status.classList.remove("is-visible");
    }, 1800);
  };

  const copyText = async (text) => {
    if (navigator.clipboard && window.isSecureContext) {
      await navigator.clipboard.writeText(text);
      return;
    }

    const textarea = document.createElement("textarea");
    textarea.value = text;
    textarea.setAttribute("readonly", "");
    textarea.style.position = "fixed";
    textarea.style.opacity = "0";
    document.body.appendChild(textarea);
    textarea.select();
    const succeeded = document.execCommand("copy");
    textarea.remove();

    if (!succeeded) {
      throw new Error("Copy command was unavailable");
    }
  };

  document.querySelectorAll("[data-copy-target]").forEach((button) => {
    button.addEventListener("click", async () => {
      const targetId = button.getAttribute("data-copy-target");
      const target = targetId ? document.getElementById(targetId) : null;

      if (!target) return;

      const original = button.innerHTML;

      try {
        await copyText(target.textContent.trim());
        button.textContent = "Copied!";
        showStatus("Copied to clipboard");
      } catch {
        button.textContent = "Select to copy";
        showStatus("Clipboard unavailable — select the code instead");
        target.focus();
      }

      window.setTimeout(() => {
        button.innerHTML = original;
      }, 1800);
    });
  });

  const year = document.getElementById("copyright-year");
  if (year) year.textContent = String(new Date().getFullYear());
})();
