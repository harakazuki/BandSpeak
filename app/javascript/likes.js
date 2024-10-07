document.addEventListener('DOMContentLoaded', function() {
  document.querySelectorAll('.like-button, .unlike-button').forEach(function(button) {
    button.addEventListener('click', function(event) {
      event.preventDefault();

      const url = button.closest('form').action;
      const method = button.closest('form').method;
      
      fetch(url, {
        method: method,
        headers: {
          'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content,
          'Content-Type': 'application/json'
        },
      }).then(response => response.json())
        .then(data => {
          document.querySelector(`#like-count-${data.post_id}`).innerText = data.like_count;
          document.querySelector(`#like-button-${data.post_id}`).innerHTML = data.button_html;
        });
    });
  });
});