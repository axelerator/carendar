module Carendar
  module CarendarHelper
    def carendar(calendar)
      render partial: 'carendar/carendar', locals: {calendar: calendar}
    end
  end
end
