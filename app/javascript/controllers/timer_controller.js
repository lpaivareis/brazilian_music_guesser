import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["wrapper", "display", "autosubmitForm"]
  static values = { seconds: Number }

  connect() {
    this.remaining = this.hasSecondsValue ? this.secondsValue : 15
    this.updateDisplay()
    this.interval = setInterval(() => this.tick(), 1000)
  }

  disconnect() {
    this.clearInterval()
  }

  tick() {
    this.remaining -= 1
    this.updateDisplay()

    if (this.remaining <= 0) {
      this.clearInterval()
      this.submitAutosubmitForm()
    }
  }

  updateDisplay() {
    if (this.hasDisplayTarget) this.displayTarget.textContent = Math.max(this.remaining, 0)
  }

  submitAutosubmitForm() {
    if (!this.hasAutosubmitFormTarget) return

    const element = this.autosubmitFormTarget
    const form = element.tagName === "FORM" ? element : element.closest("form")
    if (form) form.requestSubmit()
  }

  clearInterval() {
    if (this.interval) {
      clearInterval(this.interval)
      this.interval = null
    }
  }
}
