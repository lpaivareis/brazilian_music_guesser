import { Controller } from "@hotwired/stimulus"

let apiPromise = null

function loadYouTubeIframeAPI() {
  if (apiPromise) return apiPromise
  apiPromise = new Promise((resolve) => {
    if (window.YT && window.YT.Player) {
      resolve(window.YT)
      return
    }
    const previous = window.onYouTubeIframeAPIReady
    window.onYouTubeIframeAPIReady = () => {
      if (previous) previous()
      resolve(window.YT)
    }
    const tag = document.createElement("script")
    tag.src = "https://www.youtube.com/iframe_api"
    document.head.appendChild(tag)
  })
  return apiPromise
}

export default class extends Controller {
  static targets = ["mount", "startButton"]
  static values = { videoId: String, clipStart: Number, clipEnd: Number }

  connect() {
    this.player = null
    this.checkInterval = null
  }

  disconnect() {
    this.clearCheckInterval()
    if (this.player && this.player.destroy) this.player.destroy()
  }

  async start() {
    if (this.hasStartButtonTarget) this.startButtonTarget.disabled = true

    const YT = await loadYouTubeIframeAPI()

    this.player = new YT.Player(this.mountTarget, {
      videoId: this.videoIdValue,
      playerVars: {
        start: this.clipStartValue,
        autoplay: 1,
        controls: 0,
        modestbranding: 1
      },
      events: {
        onStateChange: (event) => this.handleStateChange(event),
        onError: () => this.handleError()
      }
    })
  }

  handleStateChange(event) {
    if (event.data === window.YT.PlayerState.PLAYING) {
      this.clearCheckInterval()
      this.checkInterval = setInterval(() => {
        if (this.player.getCurrentTime() >= this.clipEndValue) {
          this.player.pauseVideo()
          this.clearCheckInterval()
        }
      }, 250)
    }
  }

  handleError() {
    this.clearCheckInterval()
    // Video unavailable/blocked: skip this round automatically by submitting the
    // nearest form so the game can move on without requiring user interaction.
    const container = this.element.closest("[data-round-container]") || this.element.closest("turbo-frame") || this.element
    const form = container && container.querySelector("form")
    if (form) form.requestSubmit()
  }

  clearCheckInterval() {
    if (this.checkInterval) {
      clearInterval(this.checkInterval)
      this.checkInterval = null
    }
  }
}
