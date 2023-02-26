class EmailService
  class << self
    def send_email(to_address)
      puts "hey #{to_address}, Tropic is cool."
      return true
    rescue StandardError => e
      puts "Error sending email: #{e.message}"
      return false
    end
  end
end