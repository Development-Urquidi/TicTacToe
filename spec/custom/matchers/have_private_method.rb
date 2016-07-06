RSpec::Matchers.define :have_private_method do |method|
  match do |object_instance|
    object_instance.private_methods.include? method
  end

  failure_message do |object_instance|
    "expected private method #{method} for #{object_instance}"
  end

  failure_message_when_negated do |object_instance|
    "expected private method #{method} not to be defined for #{object_instance}"
  end

  description do
    'checks to see if there is a private method for the supplied object'
  end
end