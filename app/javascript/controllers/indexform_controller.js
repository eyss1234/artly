import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="indexform"
export default class extends Controller {
  connect() {
    console.log('hello from indexform stimulus controller')
  }
}
