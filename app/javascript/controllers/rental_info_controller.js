import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="rental-info"
export default class extends Controller {
  static targets = ["from", "to", "text", "days", "price", "button", "rule"]

  connect() {
    console.log("Rental info connected")
    console.log("Day rate :", this.element.getAttribute("data-rental-info-dayrate"))
  }

  update () {
    console.log("Update triggered")
    const from = this.stringToDate(this.fromTarget.value)
    const to = this.stringToDate(this.toTarget.value)
    const dayrate = this.element.getAttribute("data-rental-info-dayrate")
    console.log("From :", from)
    console.log("To :", to)
    console.log("Dayrate :", dayrate)
    if (!isNaN(from) && !isNaN(to) && to >= from ) {
      this.buttonTarget.disabled = false;
      this.ruleTarget.classList.add("d-none")
      const days = this.rentalDays(from, to)
      console.log(days)
      this.textTarget.classList.remove("d-none")
      this.daysTarget.innerText = days
      this.priceTarget.innerText = Math.round(days * dayrate*100) / 100
    } else if (!isNaN(from) && !isNaN(to) && from > to) {
      this.buttonTarget.disabled = true;
      this.ruleTarget.classList.remove("d-none")
    }

  }

  stringToDate(strDate) {
    const splitStrDate = strDate.split("-")
    const year = parseInt(splitStrDate[0])
    const month = parseInt(splitStrDate[1]) - 1
    const day = parseInt(splitStrDate[2])

    return new Date(Date.UTC(year, month, day))
  }

  rentalDays(from, to) {
    const diffInMilliseconds = Math.abs(to - from);
    return Math.ceil(1 + diffInMilliseconds / (1000 * 60 * 60 * 24));
  }
}
