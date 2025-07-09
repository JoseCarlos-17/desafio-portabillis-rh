# Sistema RH - Desafio Portabillis

API em Ruby on Rails para gerenciamento de usuários do sistema RH, com níveis de acesso diferenciados (clients e managers), filtros, ordenação e autenticação básica.

## Sobre

Este projeto foi desenvolvido para atender ao desafio da Portabillis, criando uma API que gerencia usuários com níveis de acesso distintos. Usuários do tipo *manager* são responsáveis por gerenciar clientes (*clients*). A API oferece cadastro, inativação e listagem de usuários, incluindo filtros e ordenação. Também foram feitos os webhooks, endpoints que receberão requisições externas.

---

## Tecnologias

- Ruby 3.x  
- Ruby on Rails 7.x  
- RSpec para testes automatizados  
- FactoryBot para dados de teste  
- ActiveModelSerializers para renderização JSON  

---

## Funcionalidades

- Cadastro de usuários *clients* via webhook RH.  
- Listagem de clientes para usuários *managers*, com filtros por nome, email e ordenação por esses campos.  
- Inativação de clientes.  
- Autenticação de usuários (via Devise e Devise Token Auth).  
- Autorização simples via `before_action` garantindo que apenas *managers* acessam endpoints específicos.  

---

## Setup / Instalação

Clone o repositório e instale as dependências:

```bash
  git clone <url-do-repo>
  cd nome-do-projeto
  bundle install
  rails db:create db:migrate db:seed
  rails server
```

---

# Endpoints

  Foram feitos endpoints para manager (admin), clientes e os webhooks para requisições externas.
  Os headers que devem ser passados após fazer o login são: access-token, client, uid, expiry e token-type.

## Endpoints para Manager (admin)

### listar usuários
path: "/internal/manager/users"

verbo http: GET

No endpoint de listagem, você pode passar parâmetros para ativar filtros para buscar usuários. Os parâmetros
que você pode passar na listagem para filtrar usuários são:

- by_name: para filtrar usuários pelo nome
- by_email: para filtrar usuários pelo email
- order_by: aqui é para você ordenar a lista, passando "name" ou "email" como valor, e a listagem com este
            ordenador fica em ordem descrescente, do mais recente até o mais antigo.
- show_inactive: serve para mostrar os usuários que foram inativados pelo manager.
                Ele deve receber o valor booleano "true" para que os usuários inativados sejam filtrados.

  #### response
  status: 200 OK
  
    body:
     ```
        [
          {
            "id": 1,
            "name": "João da Silva",
            "email": "joao@email.com"
          },
    
          {
            "id": 2,
            "name": "José da Silva",
            "email": "josé@email.com"
          }
        ]
    ```

### Visualizar usuário
path: "/internal/manager/users/:id"

verbo http: GET

  #### response
  status: 200 OK
  
  body:
   ```
      {
        "id": 1,
        "name": "João da Silva",
        "email": "joao@email.com"
      }
   ```

### Deletar usuário
path: "/internal/manager/users/:id"

verbo http: DELETE

  #### response
  status: 204 NO CONTENT

### Inativar usuário
path: "/internal/manager/users/:id/inactivate"

status: 204 NO CONTENT

## Endpoints para cliente
  ### Visualizar usuário

  path: "/clients/users/:id"

  verbo http: GET

  #### response
  status: 200 OK
  
  body:
   ```
        {
          "id": 1,
          "name": "João da Silva",
          "email": "joao@email.com"
        }
   ```

  ### Atualizar usuário
  path: "/clients/users/:id"

  verbo http: PUT
  
  request_body:
   ```
        {
          "client":  {
            "name": "João da Silva",
            "email": "joao@email.com"
          }
        }
   ```
  #### response
  status: 204 NO CONTENT

## Endpoints externos (webhooks)
  ### Cadastrar usuário
  path: "/webhooks/rh/users"

  verbo http: POST
  
  request_body:
   ```
         {
          "client":  {
            "name": "João da Silva",
            "email": "joao@email.com"
            "password": "123123123",
            "password_confirmation": "123123123",
          }
        }
   ```

  #### response
  status: 201 CREATED
  
  body:
   ```
      {
        "id": 1,
        "name": "João da Silva",
        "email": "joao@email.com",
        "access_level": "client"
      }
   ```

### Inativar usuário

path: "/webhooks/rh/users/:id/inactivate"

status: 204 NO CONTENT



  
