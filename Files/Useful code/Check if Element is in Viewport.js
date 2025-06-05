function isInViewport(element) {
  const rect = element.getBoundingClientRect();
  return (
    rect.top >= 0 &&
    rect.left >= 0 &&
    rect.bottom <= window.innerHeight &&
    rect.right <= window.innerWidth
  );
}

// Example:
const myElement = document.getElementById('myDiv');
if (isInViewport(myElement)) {
  console.log('Element is in view!');
}
