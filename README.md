# Rails Real-Time Chat Application

A modern real-time chat application built with Rails 8.0.2, featuring instant messaging using **Turbo Streams** (no WebSockets!), user authentication, and a beautiful interface.

## ✨ Key Features

### 🔐 User Authentication
- Secure sign-up and sign-in with encrypted passwords
- Session-based authentication without external dependencies
- Custom authentication system using `has_secure_password`

### 💬 Real-Time Chat
- **Instant messaging** using Turbo Streams over HTTP
- **User-specific styling** - your messages on right (blue), others on left (gray)
- **Auto-scrolling** to latest messages
- **Form clearing** after message submission

### 🏠 Chat Room Management
- Create and join multiple chat rooms
- Member count display
- Clean navigation between rooms
- Join/leave functionality

### 🎨 Modern UI/UX
- **Responsive design** with TailwindCSS
- **Component architecture** using Phlex-rails
- **Progressive enhancement** - works without JavaScript
- **Minimal JavaScript** - only 15 lines for entire chat functionality

## 🛠 Technology Stack

- **Ruby** 3.4.5
- **Rails** 8.0.2
- **PostgreSQL** for database
- **Hotwire** (Turbo Streams + Stimulus)
- **TailwindCSS** for styling
- **Phlex-rails** for type-safe view components
- **RSpec** for comprehensive testing

## 🚀 Quick Start

### Prerequisites
- Ruby 3.4.5+
- PostgreSQL 12+
- Node.js & Yarn

### Installation

1. **Clone and setup**
   ```bash
   git clone https://github.com/yourusername/rails-chat-app.git
   cd rails-chat-app
   bundle install
   ```

2. **Database setup**
   ```bash
   rails db:create db:migrate db:seed
   ```

3. **Start the application**
   ```bash
   bin/dev
   ```
   This starts both Rails server and TailwindCSS watcher.

4. **Visit** http://localhost:3000

### 👥 Test Users
```
alice@example.com   / password123
bob@example.com     / password123
charlie@example.com / password123
```

## 🧪 Testing

```bash
# Run all tests
rspec

# Run specific tests
rspec spec/models/
rspec spec/controllers/
```

## 🏗 How It Works

### Turbo Streams Magic ✨

The real-time functionality works **without WebSockets**:

1. **User-Specific Channels**: Each user subscribes to their personalized channel
   ```erb
   <%= turbo_stream_from "chat_room_#{@chat_room.id}_messages_for_user_#{current_user.id}" %>
   ```

2. **Smart Broadcasting**: Messages broadcast with proper user context
   ```ruby
   # In Message model
   after_create_commit do
     chat_room.users.each do |user|
       broadcast_append_later_to(
         "chat_room_#{chat_room_id}_messages_for_user_#{user.id}",
         locals: { message: self, current_user: user }
       )
     end
   end
   ```

3. **Form Submission**: Standard Rails form with `local: false` for AJAX

### Stimulus Controllers 🎯

Minimal JavaScript for enhanced UX:

```javascript
// app/javascript/controllers/chat_room_controller.js
export default class extends Controller {
  static targets = ["messages", "form"]
  
  messageAdded() {
    this.formTarget.reset()        // Clear form
    this.scrollToBottom()          // Auto-scroll
  }
}
```

### Phlex Components 🧩

Type-safe view components:
```ruby
class Auth::SignInComponent < ApplicationComponent
  def view_template
    div(class: "max-w-md mx-auto bg-white rounded-lg shadow-md p-6") do
      # Component logic here
    end
  end
end
```

## 📁 Project Structure

```
app/
├── components/              # Phlex view components
│   ├── auth/               # Authentication forms
│   └── application_component.rb
├── controllers/
│   ├── concerns/           # Authentication logic
│   ├── chat_rooms_controller.rb
│   └── messages_controller.rb
├── javascript/controllers/ # Stimulus controllers
├── models/                 # ActiveRecord models
├── views/                  # ERB templates
└── assets/                 # Stylesheets and images
```

## 🔑 Key Technical Decisions

### Why Turbo Streams over Action Cable?
- ✅ **Simpler setup** - No Redis or WebSocket server needed
- ✅ **Better for this use case** - Perfect for broadcasting to specific users
- ✅ **Less overhead** - Works over standard HTTP connections
- ✅ **Rails native** - Deeply integrated with Rails conventions

### User-Specific Message Styling Solution
**Problem**: Messages need different styling based on who's viewing them
**Solution**: Each user gets their own broadcast channel with proper context

### Component Architecture Benefits
- **Type safety** - Phlex prevents view errors at compile time
- **Reusability** - Consistent form patterns across auth views
- **Maintainability** - Ruby-based components, no ERB mixing

## 🚦 Git Workflow

Atomic commits following professional practices:
```
95403b0 docs and config updates
34c1c43 tests
550fc90 real-time
bff810a views
a0a4780 models
7378404 auth
edca56f init
```

## 🌟 What Makes This Special

1. **Real-time without WebSockets** - Uses only HTTP
2. **User-context aware** - Each user sees messages styled correctly
3. **Minimal JavaScript** - Rich UX with just 15 lines of JS
4. **Type-safe views** - Phlex components prevent common view errors
5. **Modern Rails patterns** - Rails 8 best practices throughout

## 🚀 Deployment

Ready for production with:
- Docker configuration included
- Kamal deployment ready
- Environment variable management
- Asset precompilation setup

```bash
kamal deploy
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

---

**🎯 Live Demo**: [Coming Soon]
**📚 Technical Blog Post**: [Deep Dive into Turbo Streams](link-coming-soon)

*Built with Rails 8's powerful Hotwire framework - showcasing that you don't always need WebSockets for real-time features!*
