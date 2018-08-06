require 'net/http'
require 'uri'
require 'nokogiri'
require 'json'

class Patente

def initialize; end

def set_params(patente)
    uri = URI.parse("http://apps.mtt.cl/consultaweb/")
    request = Net::HTTP::Post.new(uri)

    request.set_form_data(
    "__EVENTARGUMENT" => "",
    "__EVENTTARGET" => "",
    "__EVENTVALIDATION" => "/wEdAASRSfq3eyzI+YEHoenGUM55IKnzPnVFgXAZ20CcrnWXzeHx18AZ0epHV1po9+JEZeBnTMb45aJIIeXNdhdxmB5yidp+Ol9X4zXVR14M0f85jB21fHLFcxYicG+dJXIdYIU=",
    "__VIEWSTATE" => "/wEPDwUKMTc0MTY3NTE3MWQYAQUeX19Db250cm9sc1JlcXVpcmVQb3N0QmFja0tleV9fFgEFIGN0bDAwJE1haW5Db250ZW50JGltZ0J0bkNvbnN1bHRhMZbeFY4YUowJrfpW/o4A6YnJXc5ditXNo7c9CDx75tY=",
    "__VIEWSTATEGENERATOR" => "522DF3F1",
    "ctl00$MainContent$btn_buscar" => "Buscar",
    "ctl00$MainContent$ppu" => patente,
    )
    req_options = {
        use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
    end
end

def get_data_patente(data)
  { status: 500,message:'Error interno en el servidor!'}.to_json unless data.code.eql?("200")
  page = Nokogiri::HTML(data.body)

  #datos vehiculo
  fecha_informe =  page.css('div.fecha #MainContent_fechaInforme').text.rstrip
  patente_vehiculo =  page.css('#MainContent_patenteT').text.rstrip
  fecha_entrada_RNT =  page.css('#MainContent_FechaIngresoRNT').text.rstrip
  tipo_servicio =  page.css('#MainContent_tipo_servicio').text.rstrip
  capacidad = page.css('#MainContent_capacidad').text.rstrip
  estado_vehiculo = page.css('#MainContent_estado_vehiculo').text.rstrip
  region = page.css('#MainContent_region').text.rstrip
  year_fabricacion = page.css('#MainContent_anio_fabricacion').text.rstrip
  cinturon_seguridad_obligatorio  = page.css('#MainContent_cinturon').text.rstrip
  antiguedad  = page.css('#MainContent_antiguedad_vehiculo').text.rstrip
  marca  = page.css('#MainContent_marca').text.rstrip
  modelo  = page.css('#MainContent_modelo').text.rstrip

  #datos servicio asociado
  folio_servicio  = page.css('#MainContent_folio_servicio').text.rstrip
  flota_asociada  = page.css('#MainContent_flota_servicio').text.rstrip
  nombre_responsable_servicio = page.css('#MainContent_responsable_servicio').text.rstrip
  estado_servicio = page.css('#MainContent_lblEstadoServicio').text.rstrip

  datos_vehiculo = {
    Placa_patente: patente_vehiculo,
    Fecha_entrada_RNT: fecha_entrada_RNT,
    Tipo_servicio: tipo_servicio,
    Capacidad: capacidad,
    Estado_vehiculo: estado_vehiculo,
    Region: region,
    Año_fabricacion: year_fabricacion,
    Cinturo_seguridad_obligatorio: cinturon_seguridad_obligatorio,
    Antiguedad_vehiculo: antiguedad,
    Marca_vehiculo: marca,
    Modelo_vehiculo: modelo
  }
  datos_servicio = {
    Folio_servicio: folio_servicio,
    Flota_asociada: flota_asociada,
    Nombre_responsable_servicio: nombre_responsable_servicio,
    Estado_servicio: estado_servicio
  }

  r_cancelacion = page.css('#MainContent_reemplazadoPor').text
  conductores = page.css('#MainContent_conductores span').text.rstrip

  if fecha_informe.empty?
  { status: 404,message:'Patente no encontrada!'}.to_json
    else
  JSON.pretty_generate('Resultado Patente' =>
                           [Vehiculo: datos_vehiculo,
                            Datos_Servicio: datos_servicio,
                            Estado: r_cancelacion,
                            Conductores: conductores]
  )
    end
end
end

