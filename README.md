# Projeto Cloud: API de Gestão de Estoque 📦

Este projeto simula um fluxo DevOps completo para uma API de gestão de estoque, desde o desenvolvimento inicial até a implantação automatizada na nuvem AWS.

## Etapa 1: Criação da API + Testes Locais + GitHub

### Visão Geral da API

Esta API RESTful fornece endpoints para consultar o status da aplicação e listar produtos em estoque.
* **Tema:** Sistema de Gestão de Estoque para uma Loja.
* **Linguagem/Framework:** Node.js com Express.js.
* **Dados:** Os dados de estoque são simulados e armazenados em um arquivo JSON (`data/produtos_estoque.json`).

### Rotas Disponíveis

* [cite_start]`GET /status` [cite: 7]
    * **Descrição:** Retorna o status da API.
    * **Exemplo de Resposta:** `{"status": "API de Gestão de Estoque está online!"}`

* [cite_start]`GET /produtos_estoque` [cite: 8]
    * **Descrição:** Retorna uma lista de produtos em estoque com seus detalhes.
    * **Exemplo de Resposta:**
        ```json
        [
          {
            "id_produto": "SKU00123",
            "nome": "Monitor LED 24 polegadas",
            "quantidade_disponivel": 35,
            "localizacao_armazem": "Corredor A, Prateleira 3",
            "preco_custo": 350.00,
            "preco_venda": 599.90,
            "fornecedor": "TechDistribuidora Ltda."
          },
          // ...outros produtos
        ]
        ```

### Pré-requisitos

* Node.js (versão 14 ou superior recomendada)
* npm (gerenciador de pacotes do Node.js)

### Configuração do Ambiente e Execução Local

Siga os passos abaixo para configurar e executar a API em sua máquina local:

1.  **Clone o Repositório:**
    ```bash
    git clone [https://github.com/seu-usuario/seu-repositorio.git](https://github.com/seu-usuario/seu-repositorio.git)
    cd seu-repositorio
    ```

2.  **Instale as Dependências:**
    ```bash
    npm install
    ```

3.  **Execute a API:**
    ```bash
    npm start
    # Ou se você instalou nodemon para desenvolvimento:
    # npm run dev
    ```
    A API será iniciada e estará disponível em `http://localhost:3000` (ou a porta que você configurou no `app.js`).

### Executando os Testes Unitários

Para executar os testes unitários da API:

1.  Certifique-se de que as dependências, incluindo `jest` e `supertest`, estão instaladas (`npm install`).
2.  Execute os testes via npm script:
    ```bash
    npm test
    ```
    Você deverá ver a saída do Jest indicando que os testes foram executados e passaram.

### Versionamento no GitHub

Todo o código-fonte da API e dos testes está publicado neste repositório do GitHub.

---
