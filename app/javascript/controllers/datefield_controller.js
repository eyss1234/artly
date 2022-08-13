import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="datefield"
export default class extends Controller {
  connect() {
    console.log('hello from datefield stimulus controller')
  }

  static targets = ["endDate", "startDate"]

  update(event) {
    this.endDateTarget.min = this.startDateTarget.value;
  }
}
