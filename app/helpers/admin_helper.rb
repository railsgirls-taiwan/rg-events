module AdminHelper
  def nav_li_for model, match: model.table_name
    content_tag :li, link_to(model.model_name.human, model),
                class: request.path[match] ? 'active' : nil
  end

  def th_for model, *attributes
    attributes.map{ |attribute|
      content_tag :th, model.human_attribute_name(attribute)
    }.join.html_safe
  end

  def attribute_appearance record, attribute
    case attribute
    when Array
      association = record.send(attribute[0])
      link_to association.send(attribute[1]), association rescue association.send(attribute[1])
    when Symbol
      case val = record.send(attribute)
      when TrueClass, FalseClass
        val ? t('true') : t('false')
      when CarrierWave::Uploader::Base
        uploader = if val.version_exists?(:preview) && val.preview.present? then val.preview
                   elsif val.version_exists?(:thumb) && val.thumb.present? then val.thumb
                   else val end
        link_to image_tag(uploader, height: 100), val.url
      when ActiveSupport::TimeWithZone
        val = val.strftime('%Y-%m-%d %H:%M')
      else val
      end
    end
  end

  def td_for record, *attributes
    attributes.map{ |attribute|
      text = attribute_appearance record, attribute
      content_tag :td, text
    }.join.html_safe
  end

  def tr_for record, *attributes
    attributes.map{ |attribute|
      text = attribute_appearance record, attribute
      content_tag(:tr, content_tag(:td, record.class.human_attribute_name(Array === attribute ? attribute[0] : attribute)) + content_tag(:td, text))
    }.join.html_safe
  end

  def td_action_for record
    content_tag(:td, link_to(t('crud.show'), record)) +
    content_tag(:td, link_to(t('crud.edit'), [:edit, record])) +
    content_tag(:td, link_to(t('crud.destroy'), record, method: :delete, data: { confirm: t('message.are_you_sure') }))
  end

  def notice_message
  end

  def build_input attendee, field, as: :admin_attendee
    id = SecureRandom.random_number(9999999999999)
    ret = hidden_field_tag "#{as}[field_values_attributes][#{id}][field_id]", field.id
    field_value = attendee.field_values.select{|v| v.field_id == field.id }.first
    if field_value
      ret += hidden_field_tag "#{as}[field_values_attributes][#{id}][id]", field_value.id
    end
    input_name = "#{as}[field_values_attributes][#{id}][value]"
    input_value = field_value ? field_value.value : nil
    ret += case field.type
    when 'text'
      text_field_tag input_name, input_value, class: 'form-control'
    when 'textarea'
      text_area_tag input_name, input_value, class: 'form-control'
    when 'select'
      select_tag input_name, options_for_select(field.option_items, input_value), include_blank: false, multiple: field.multiple, class: 'form-control'
    when 'checkbox'
      if field.multiple
        input_name += '[]'
        ret2 = ''.html_safe
        field.option_items.each_with_index do |option, i|
          id = "check_#{i}"
          ret2 += content_tag :div, class: :radio do
            label_tag id, check_box_tag(input_name, option, Array(input_value).include?(option), id: id) + option
          end
        end
      else
        ret2 = ''.html_safe
        field.option_items.each_with_index do |option, i|
          id = "radio_#{i}"
          ret2 += content_tag :div, class: :radio do
            label_tag id, radio_button_tag(input_name, option, option == input_value, id: id) + option
          end
        end
      end
      ret2
    end

    if errors = has_error?(attendee, field)
      ret += content_tag(:p, errors.join(', '), class: 'help-block')
    end
    ret
  end

  def has_error_class attendee, field
    'has-error' if has_error? attendee, field
  end

  def has_error? attendee, field
    attendee.errors.messages[field.name.to_sym].presence
  end
end
