Terraform:

1 - Definir as chaves no terminal:

```bash
export AWS_ACCESS_KEY_ID=access_key_id
export AWS_SECRET_ACCESS_KEY=secret_access_key
```

2 - Rodar terraform:

```bash
terraform init
terraform apply
```

3 - Verificar a lambda no AWS:
Colocar na região us-east-1 e conferir a lambda criada na lista de lambdas