import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="indexform"
export default class extends Controller {
  connect() {
    console.log('hello from indexform stimulus controller')
  }

  static targets = ["endDate", "startDate"]

  update(event) {
    this.endDateTarget.min = this.startDateTarget.value;
    console.log("min end date updated")
  }
}
