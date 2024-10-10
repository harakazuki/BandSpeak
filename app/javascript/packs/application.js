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

/*global fetch*/

document.addEventListener('turbolinks:load', () => {
  document.querySelectorAll('.like-button form').forEach(form => {
    form.addEventListener('submit', event => {
      event.preventDefault();

      const likeButton = form.querySelector('button');
      const action = form.action;
      const method = form.querySelector('input[name="_method"]') ? 'DELETE' : 'POST'; // DELETE method if "_method" is present

      fetch(action, {
        method: method,
        headers: {
          'X-CSRF-Token': form.querySelector('input[name="authenticity_token"]').value,
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ post_id: form.dataset.postId })
      })
      .then(response => response.json())
      .then(data => {
        likeButton.innerHTML = data.button_html;
        const likeCount = likeButton.querySelector('.like-count');
        if (likeCount) {
          likeCount.innerText = data.like_count;
        }
      })
      .catch(error => console.error('Error:', error));
    });
  });
});
