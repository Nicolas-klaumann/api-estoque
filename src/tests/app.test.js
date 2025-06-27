// src/tests/app.test.js
const request = require('supertest');
const app = require('../app'); // Importa o app que foi exportado

describe('API de Gestão de Estoque', () => {
    // Teste 1: Verificar se a rota /status retorna status 200 e mensagem correta
    test('GET /status deve retornar status 200 e mensagem de online', async () => {
        const response = await request(app).get('/status');
        expect(response.statusCode).toBe(200);
        expect(response.body).toEqual({ status: 'API de Gestão de Estoque está online!' });
    });

    // Teste 2: Verificar se a rota /produtos_estoque retorna dados e pelo menos 10 registros
    test('GET /produtos_estoque deve retornar uma lista de produtos com pelo menos 10 itens', async () => {
        const response = await request(app).get('/produtos_estoque');
        expect(response.statusCode).toBe(200);
        expect(Array.isArray(response.body)).toBe(true); // Verifica se o retorno é um array
        expect(response.body.length).toBeGreaterThanOrEqual(10); // Verifica se tem pelo menos 10 registros
        
        // Opcional: testar a estrutura de um item específico
        if (response.body.length > 0) {
            const firstItem = response.body[0];
            expect(firstItem).toHaveProperty('id_produto');
            expect(firstItem).toHaveProperty('nome');
            expect(firstItem).toHaveProperty('quantidade_disponivel');
            expect(typeof firstItem.quantidade_disponivel).toBe('number');
        }
    });

    // Teste 3: Verificar se os dados carregados têm as propriedades esperadas
    test('Cada produto em /produtos_estoque deve ter as propriedades essenciais', async () => {
        const response = await request(app).get('/produtos_estoque');
        expect(response.statusCode).toBe(200);
        response.body.forEach(product => {
            expect(product).toHaveProperty('id_produto');
            expect(product).toHaveProperty('nome');
            expect(product).toHaveProperty('quantidade_disponivel');
            expect(product).toHaveProperty('localizacao_armazem');
            expect(product).toHaveProperty('preco_custo');
            expect(product).toHaveProperty('preco_venda');
            expect(product).toHaveProperty('fornecedor');
        });
    });
});
