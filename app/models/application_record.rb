class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def render_error(status, errors)
    render json: { error: errors }, status: status
  end
end
