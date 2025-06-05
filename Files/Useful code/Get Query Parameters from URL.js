function getQueryParam(param) {
  const urlParams = new URLSearchParams(window.location.search);
  return urlParams.get(param);
}

// Example: If URL is ?name=danykas
console.log(getQueryParam('name')); // Outputs: danykas
