function debounce(func, delay) {
  let timeoutId;
  return function (...args) {
    clearTimeout(timeoutId);
    timeoutId = setTimeout(() => {
      func.apply(this, args);
    }, delay);
  };
}

const searchInput = document.getElementById("search");
searchInput.addEventListener("input", debounce(() => {
  console.log("Searching for:", searchInput.value);
}, 500));
