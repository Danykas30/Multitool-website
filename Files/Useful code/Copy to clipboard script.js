function copyToClipboard(text) {
  navigator.clipboard.writeText(text)
    .then(() => alert('Copied to clipboard!'))
    .catch(err => console.error('Error:', err));
}

// Example usage:
copyToClipboard('Hello, world!');
