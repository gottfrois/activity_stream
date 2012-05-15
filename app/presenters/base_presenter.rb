class BasePresenter
  def initialize(object, template)
    @object = object
    @template = template
  end

private

  def self.presents(name)
    define_method(name) do
      @object
    end
  end

  def h
    @template
  end

  def handle_none(value)
    yield if value.present?
  end

  def method_missing(*args, &block)
    @template.send(*args, &block)
  end
end