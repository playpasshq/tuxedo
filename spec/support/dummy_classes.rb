class Dummy
  def to_param
    2
  end
end

class DummyPresenter
  include Tuxedo

  def name
    'hello'
  end

  def name_with_args(name, surname: '')
    "hello #{name}, #{surname}"
  end
end

class Dummy2Presenter
  include Tuxedo
end

class ApplicationPresenter
  include Tuxedo
end

class OverwriteNamePresenter < ApplicationPresenter
end
