class Auth::SignInComponent < ApplicationComponent
  def initialize(user: User.new, url: nil)
    @user = user
    @url = url
  end

  def view_template
    div(class: "max-w-md mx-auto bg-white rounded-lg shadow-md p-6") do
      h2(class: "text-2xl font-bold mb-6 text-center") { "Sign In" }

      form_with(url: @url, local: false, class: "space-y-4") do |form|
        render_email_field(form)
        render_password_field(form)
        render_submit_button(form)
      end

      render_signup_link
    end
  end

  private

  def render_email_field(form)
    div do
      form.label :email, class: "block text-sm font-medium text-gray-700"
      form.email_field :email,
        class: "mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
    end
  end

  def render_password_field(form)
    div do
      form.label :password, class: "block text-sm font-medium text-gray-700"
      form.password_field :password,
        class: "mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
    end
  end

  def render_submit_button(form)
    div do
      form.submit "Sign In",
        class: "w-full bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-4 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2"
    end
  end

  def render_signup_link
    div(class: "mt-4 text-center") do
      p(class: "text-sm text-gray-600") do
        plain "Don't have an account? "
        link_to "Sign up", new_registration_path,
          class: "text-blue-600 hover:text-blue-800"
      end
    end
  end
end
