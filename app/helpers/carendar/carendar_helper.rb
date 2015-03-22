module Carendar
  module CarendarHelper
    def carendar(calendar, options = {}, &blk)
      render partial: 'carendar/carendar', locals: {calendar: calendar, options: options, block: blk}
    end
  end
end
