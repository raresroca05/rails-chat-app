import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["messages", "form"]

  connect() {
    this.scrollToBottom()
  }

  messageAdded() {
    // Clear the form after message is sent
    this.formTarget.reset()
    
    // Scroll to bottom to show new message
    this.scrollToBottom()
  }

  scrollToBottom() {
    if (this.hasMessagesTarget) {
      this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight
    }
  }
}