require 'sinatra'
require 'sinatra/namespace'
require './patente.rb'

#routing
get '/' do
  endpoint = {status:200,
              busca_patente: '/api/v1/consultar_patente/:patente',
              ejemplo: '/api/v1/consultar_patente/gpwf15'}
  endpoint.to_json
end

namespace '/api/v1' do

  before do
    content_type 'application/json'
  end

  get '/consultar_patente/:patente' do
    patente = params[:patente].upcase
    if patente !~ /^[A-Z0-9]{6}$/
         halt(404, { status: 404,message:'Error en el formato de patente!'}.to_json)
    else
        patente_object = Patente.new
        response = patente_object.set_params(patente)
        patente_object.get_data_patente(response)
    end
  end
  get '*path' do
     redirect('/')
  end
end

get '*unmatched_route' do
    redirect('/')
end
set :bind, '0.0.0.0'
