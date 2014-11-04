window.debug = ( msg )-> console.log msg

_sync = Backbone.sync

Backbone.sync = ( method, model, options = {} )->

  options.crossDomain = true
  options.xhrFields   = { withCredentials:true }

  _sync method, model, options


class Form extends Backbone.Model

  # token: "e110a94bd4b2dd82346bc9536d2962fa4837dff38c6cd62b42ef7b7e8de1d6b3"
  # endpoint: "https://apply.eada.edu/api/forms/542ecb4cd1b76440c6000073/submissions"

  token: "35c4bd5ce8612684e70757ed3d3161221b9c7365d70328ff255c95e79831bb00"
  endpoint: "http://tbs.fullfabric.dev:3000/api/forms/5446627ca68d608ba1000082/submissions"

  url: ->
    "#{ @endpoint }?external_domain_token=#{ @token }"


class FormView extends Backbone.View

  events:
    "submit" : "submit"

  handleSuccess: ( model, response, options )=>

    $( ".alert", @el ).addClass "hide"

    $( ".alert-success", @el ).html response.message
    $( ".alert-success", @el ).removeClass "hide"

    $( ".controls", @el ).hide()


  handleError: ( model, xhr, options )=>

    debug "================"
    debug model
    debug xhr
    debug xhr.statusText
    debug options
    debug "================"

    $( ".alert", @el ).addClass "hide"

    if xhr && xhr.responseJSON

      $( ".alert-danger", @el ).html xhr.responseJSON.message
      $( ".alert-danger", @el ).removeClass "hide"

    else

      $( ".alert-danger", @el ).html "Hmmm... it seems something went wrong. Please try again! (#{ xhr.statusText })"
      $( ".alert-danger", @el ).removeClass "hide"


  submit: ( e )->

    e.preventDefault()

    data = _( $( "form" ).serializeArray() ).reduce ( ( o, field )-> o[ field.name ] = field.value; o ), {}

    debug "Preparing data"
    debug data

    debug "POSTing to #{ @model.url() }"

    @model.save { data: data }, { success: @handleSuccess, error: @handleError }


$ ->

  model = new Form
  view = new FormView el: $( "form" ), model: model