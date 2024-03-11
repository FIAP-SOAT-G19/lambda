#!/bin/bash

echo "Iniciando criação da lambda ..."

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

echo "Criando a lambda na AWS ..."

sleep 2

aws lambda create-function \
    --function-name fiap-auth-lambda \
    --runtime nodejs20.x \
    --role arn:aws:iam::654654179704:role/fiap-auth-role \
    --handler dist/index.handler \
    --environment Variables="{TABLE_USERS=users}" \
    --timeout 120 \
    --zip-file fileb://fiap-auth.zip > /dev/null

if [ $? -eq 0 ]; then
    echo "Concluído!"
else
    echo "Erro ao criar lambda na AWS. Saindo..."
    exit 1
fi

rm -rf fiap-auth.zip