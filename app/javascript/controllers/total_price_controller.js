import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="total-price"
export default class extends Controller {
  connect() {
    console.log('Hello from total_price controller')
  }

  static targets = ["secondDate", "firstDate", "total"]

  update(event) {
    const date1 = this.firstDateTarget.value;
    const date2 = this.secondDateTarget.value;
    const cost = Number.parseInt(document.getElementById("cost").dataset.cost);
    
    if (date2 && date1) {
      const fstDate = new Date(date1);
      const sndDate = new Date(date2);
      const diffTime = Math.abs(fstDate - sndDate);
      const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
      const totalCost = cost + cost * diffDays;
      this.totalTarget.innerHTML = `<strong>Total price: £${totalCost}</strong>`
      this.totalTarget.style = "display: block;"
    }
  }

}
