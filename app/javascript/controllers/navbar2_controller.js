import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  connect() {
    olsole.log("Hello from the navbar controller")
  }
  updateNavbar() {
    if (window.scrollY >= window.innerHeight) {
      this.element.classList.add("navbar-artly-orange")
    } else {
      this.element.classList.remove("navbar-artly-orange")
    }
  }
}
