import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="total-price"
export default class extends Controller {
  connect() {
    console.log('Hello from total_price controller')
  }

  static targets = ["secondDate", "firstDate", "price"]

  update(event) {
    const date1 = new Date(this.firstDateTarget.value);
    const date2 = new Date(this.secondDateTarget.value);
    if (date2 === NaN) {
      return 1
    } else {
      const diffTime = Math.abs(date2 - date1);
      const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
      console.log(diffDays)
      return diffDays
    }
  }
}
