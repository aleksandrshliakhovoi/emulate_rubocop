# frozen_string_literal: true

module ErrorHandler
  class RubocopBaseError < StandardError
    self
  end

  class BindingError < RubocopBaseError; end

  class SendMethodError < RubocopBaseError; end

  class NotFoundError < StandardError
    def initialize(file_path)
      message = "File not found by path '#{file_path}'"
      super(message)
    end
  end
end
