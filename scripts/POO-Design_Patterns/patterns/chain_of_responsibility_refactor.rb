# whitout pattern
module CustomSortBy
  include ActiveSupport::Concern

  def custom_sort_by(model, sort_direction, preferent)
    return all unless model.present?

    case model
    when TruckDriver.name.underscore
      merge(TruckDriver.sort_by_name(sort_direction))
    when CustomField.name.underscore
      merge(CustomField.sort_by_value_same_type(preferent, sort_direction))
    when Address.name.underscore
      merge(Address.sort_by_name(sort_direction))
    when GuideItem.name.underscore
      merge(GuideItem.sort_by_total_quantity(sort_direction))
    when Contact.name.underscore
      merge(Contact.sort_by_name(sort_direction))
    when Dispatch.name.underscore
      order(status_id: sort_direction)
    when 'guide'
      merge(DispatchGuide.sort_by_max_delivery_time(sort_direction))
    else
      merge(DispatchGuide.sort_by_max_delivery_time(:desc))
    end
  end

  def can_search?(params)
    permit = JSON.parse(params).keys.each{ |k| permitted_searches[k] }
    permit.exclude?(false)
  end
end

# with pattern

module CustomSortBy
  include ActiveSupport::Concern

  def custom_sort_by(model, sort_direction, preferent)
    return all unless model.present?

    models = %w[truck_driver custom_field address guide_item contact dispatch guide]
    if models.include? model
      chain_of_responsability = GenericSortDirectionHandler.new(
        CustomFieldHandler.new(
          GuideItemHandler.new(
            DispatchHandler.new(
              GuideHandler.new
            )
          )
        )
      )
      merge(chain_of_responsability.process_sort(model, sort_direction, preferent))
    else
      merge(DispatchGuide.sort_by_max_delivery_time(:desc))
    end
  end

  def can_search?(params)
    permit = JSON.parse(params).keys.each{ |k| permitted_searches[k] }
    permit.exclude?(false)
  end
end

class BaseChain
  GENERIC_MODELS = %w[truck_driver address contact].freeze
  HANDLER_NAME = 'EntityHandler'

  attr_reader :successor

  def initialize(successor = nil)
    @successor = successor
  end

  def parse_model_name(model)
    model.classify.constantize
  end

  def process_sort(model, sort_direction, preferent)
    res = match_handler(model)
    if res.present?
      custom_sort_by(model, sort_direction, preferent)
    elsif @successor
      @successor.process_sort(model, sort_direction, preferent)
    else
      not_matches(model)
    end
  end

  def custom_sort_by(*)
    raise 'method must be implemented.'
  end

  def match_handler(model)
    handler_name = HANDLER_NAME.gsub('Entity', model.classify)
    handler_name == self.class.name || model.in?(GENERIC_MODELS)
  end

  def not_matches(model)
    raise "not matches #{model}"
  end
end

class GenericSortDirectionHandler < BaseChain
  def custom_sort_by(model, sort_direction, _preferent)
    parse_model_name(model).sort_by_name(sort_direction)
  end
end

class GuideItemHandler < BaseChain
  def custom_sort_by(model, sort_direction, _preferent)
    parse_model_name(model).sort_by_total_quantity(sort_direction)
  end
end

class CustomFieldHandler < BaseChain
  def custom_sort_by(model, sort_direction, preferent)
    parse_model_name(model).sort_by_value_same_type(preferent, sort_direction)
  end
end

class DispatchHandler < BaseChain
  def custom_sort_by(model, sort_direction, _preferent)
    parse_model_name(model).order(status_id: sort_direction)
  end
end

class GuideHandler < BaseChain
  def custom_sort_by(_model, sort_direction, _preferent)
    DispatchGuide.sort_by_max_delivery_time(sort_direction)
  end
end


