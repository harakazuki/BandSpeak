// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"; 

Rails.start()
Turbolinks.start()
ActiveStorage.start()

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.like-button').forEach(button => {
    button.addEventListener('click', event => {
      event.preventDefault();

      const form = button.closest('form');

      fetch(form.action, {
        method: 'POST',
        headers: {
          'X-CSRF-Token': form.querySelector('input[name="authenticity_token"]').value,
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ post_id: form.dataset.postId })
      })
      .then(response => response.json())
      .then(data => {
        button.innerHTML = data.button_html; 
        const likeCount = button.querySelector('.like-count');
        if (likeCount) {
          likeCount.innerText = data.like_count;
        }
      })
      .catch(error => console.error('Error:', error));
    });
  });
});