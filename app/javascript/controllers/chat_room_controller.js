import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["messages", "form", "messageInput"]

  connect() {
    this.scrollToBottom()
    
    // Set up observer to watch for new messages being added
    if (this.hasMessagesTarget) {
      this.observer = new MutationObserver(() => {
        this.scrollToBottom()
      })
      
      this.observer.observe(this.messagesTarget, {
        childList: true,
        subtree: true
      })
    }
  }

  disconnect() {
    if (this.observer) {
      this.observer.disconnect()
    }
  }

  messageAdded() {
    // Clear the form after message is sent
    this.formTarget.reset()
    
    // Scroll to bottom to show new message
    setTimeout(() => this.scrollToBottom(), 100)
  }

  // Called when a new message is appended via Turbo Stream
  messageAppended() {
    this.scrollToBottom()
  }

  handleKeydown(event) {
    // Check if Enter was pressed without Shift
    if (event.key === 'Enter' && !event.shiftKey) {
      event.preventDefault()
      this.submitForm()
    }
  }

  submitForm() {
    // Check if message has content
    const messageContent = this.messageInputTarget.value.trim()
    if (messageContent) {
      this.formTarget.requestSubmit()
    }
  }

  scrollToBottom() {
    if (this.hasMessagesTarget) {
      this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight
    }
  }
}