import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="booking-status-update"
export default class extends Controller {
  connect() {
    console.log('Booking status update controller connected')
  }
}
