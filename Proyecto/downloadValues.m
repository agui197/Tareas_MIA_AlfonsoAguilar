
function response=downloadValues(subyacente, start_date,end_date,fr,data_type)
%DOWNLOADVALUES es una funcion encargada de bajar datos de yahoo finance
% Los parametros son SUBYACENTE
%                    FECHA DE INICIO
%                    FECHA FINAL
%                    FR = frecuencia de los datos
%                    DATA_TYPE = para regresar datos historicos 'history'
%res=downloadValues('grumab.mx','2016-05-26', '2017-07-05','d','history');
%res.Close ejm. para llamar la columna Close
t = datetime(start_date);
start_date=posixtime(t);
t = datetime(end_date);
end_date=posixtime(t);

url=['https://query1.finance.yahoo.com/v7/finance/download/',subyacente,'?period1=',num2str(start_date),'&period2=',num2str(end_date),'&interval=1',fr,'&events=',data_type,'&crumb=WoTu8cwg8VU'];

response = webwrite(url,'api_key');

end