# 💬 Tech Challenge - Postgres RDS

## ✳️ Sobre
O **Tech Challenge** é um projeto de um sistema de autoatendimento de fast food, que é composto por uma série de dispositivos e interfaces que permitem aos clientes selecionar e fazer pedidos sem precisar interagir com um atendente. Esse repositório contém a IAC(Infraestrutura com código) do cluster AWS-EKS para utilização da aplicação.

---

## 🛠 Ferramentas Utilizadas
- [Terraform](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
---

## 💻 Clonando o repositório

- Clone o projeto

  ```bash
  git clone https://github.com/FIAP-SOAT-G19/db-tf.git
  ````
---

## Arquitetura do projeto
![Arquitetura do Projeto](assets/images/architecture.jpg)

## ▶️ Executando o projeto
- Execute os seguintes comandos:
  ```bash
    #inicia o backend terraform
      terraform init
    
    #formata os arquivos terraform
      terraform fmt
    
    #valida o código terraform
      terraform validate
      
    #faz um plano do deploy
      terraform plan
    
    #aplica o deploy
        terraform apply -auto-approve
    
    #destroi o deploy
      terraform destroy -auto-approve
  ```