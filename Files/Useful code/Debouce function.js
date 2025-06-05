function debounce(func, delay) {
  let timer;
  return (...args) => {
    clearTimeout(timer);
    timer = setTimeout(() => func.apply(this, args), delay);
  };
}

// Example:
window.addEventListener('resize', debounce(() => {
  console.log('Window resized');
}, 300));
