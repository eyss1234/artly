import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="total-price"
export default class extends Controller {
  connect() {
    console.log('Hello from total_price controller')
  }

  static targets = ["secondDate", "firstDate"]

  update(event) {
    const date1 = this.firstDateTarget.value;
    const date2 = this.secondDateTarget.value;
    const this.firstDateTarget.dataset.cost;
    if (date2 === "") {
      return 1
    } else {
      fstDate = Date.new(date1)
      sndDate = Date.new(date2)
      const diffTime = Math.abs(fstDate - sndDate);
      const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
      console.log(diffDays)
      return diffDays
    }
  }
}
