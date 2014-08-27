$(document).on 'nested:fieldAdded:fields', (event) ->
  field = event.field
  field.find('.select2-tags-array').select2
    tags: []
    width: '100%'
    initSelection: (element, callback) ->
      $(element).val('')
      callback $(element).data('init').map (value) ->
        id: value, text: value
    createSearchChoice: (term) ->
      id: term, text: term