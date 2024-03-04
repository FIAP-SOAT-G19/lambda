#!/bin/bash

echo "Iniciando atualização da lambda ..."

sleep 2

echo "Empacotando arquivos"

sleep 2
npm run build
rm -rf fiap-auth.zip
zip -r fiap-auth.zip dist/index.js dist/response.js node_modules

if [ $? -eq 0 ]; then
    echo "Concluído!"
else
    echo "Erro ao empacotar lambda. Saindo..."
    exit 1
fi

# echo "Enviando arquivos para o bucket S3"

# sleep 2

# aws s3 cp fiap-auth.zip s3://fiap-lambda-auth-bucket/fiap-auth.zip

# if [ $? -eq 0 ]; then
#     echo "Concluído!"
# else
#     echo "Erro ao enviar os arquivos para o S3. Saindo..."
#     exit 1
# fi

echo "Atualizando a lambda na AWS ..."

sleep 2

aws lambda update-function-code \
    --function-name fiap-auth-lambda \
    --zip-file fileb://fiap-auth.zip > /dev/null

if [ $? -eq 0 ]; then
    echo "Concluído!"
else
    echo "Erro ao atualizar lambda na AWS. Saindo..."
    exit 1
fi

rm -rf fiap-auth.zip