require 'pg'
require 'aws-sdk-dynamodb'

# this is a POC script to migrate dynamodb to postrges, asume that pg table has been created.
# configure you aws credentials: aws configure.
# field custom_field_type_ids is an ARRAY data type.

FILE_LOG = "lib/tasks/dynamodb_dump_log_#{Rails.env}.txt".freeze

check_log_exist
write_file("\nLOG:", '---------------------')
dynamo_account_settings = dynamodb_result('account_setting')
write_file('ACCOUNT_SETTING:', dynamo_account_settings)
account_setting = insert_account_settings(dynamo_account_settings,
                                          connect_to_postgres)
write_file('INSERT_PG:',account_setting)

def write_file(msg,text)
  File.open(FILE_LOG, 'ab') do |file|
    file.puts("#{msg} #{text} TIME: #{Time.now}")
  end
end

def check_log_exist
  File.new(FILE_LOG, 'w') unless File.exist?(FILE_LOG)
end

def dynamodb_result(table_name)
  dynamodb = Aws::DynamoDB::Client.new
  response = dynamodb.scan(table_name: table_name)
  response.items
end

def connect_to_postgres
  PG::Connection.new(host: 'host',
                     user: 'user',
                     dbname: 'dbname',
                     port: 5432,
                     password: 'password')
rescue PG::Error => e
  write_file("\nError to connect database", e)
  exit
end

def bool_insert(res)
  res.eql?(1) ? 'OK' : 'FAIL'
end

def insert_account_settings(data, pg_bd)
  result = []
  if data
    data.each do |el|
      account_id = el['account_id'].to_i
      preferent_cf_id = el['preferent_custom_field_type_id'].to_i
      c_field_type_ids = el['custom_field_type_ids'].try(:map){|x| x.to_i }.try(:to_json).try(:tr,'[','{').try(:tr,']','}')
      model_type = el['model_type']
      low_time = el['low_time'].to_i
      high_time = el['high_time'].to_i
      api_key = el['api_key']
      filter_by_cfield = el['filter_by_custom_field_type_id'].to_i
      created_at = Time.now
      updated_at = Time.now

      res = pg_bd.exec_params('INSERT
                              INTO account_settings
                              (account_id,
                                preferent_custom_field_type_id,
                                custom_field_type_ids,
                                model_type,
                                low_time,
                                high_time,
                                api_key,
                                filter_by_custom_field_type_id,
                                created_at,
                                updated_at)
                              VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)',
                              [account_id, preferent_cf_id,
                               c_field_type_ids,
                               model_type,
                               low_time,
                               high_time,
                               api_key,
                               filter_by_cfield,
                               created_at,
                               updated_at])
      result << {
        "Status": res.cmd_status,
        "insert": bool_insert(res.cmd_tuples)
      }
    end
  else
    write_file('Error', "not found records in #{data}")
  end
  result
rescue PG::Error => e
  write_file('Error to insert data', e)
  exit
end
