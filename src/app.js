// src/app.js
const express = require('express');
const path = require('path');
const fs = require('fs');

const app = express();
const PORT = process.env.PORT || 3000;

// Função para carregar os dados do JSON
const loadStockData = () => {
    const filePath = path.join(__dirname, '..', 'data', 'produtos_estoque.json');
    try {
        const data = fs.readFileSync(filePath, 'utf8');
        return JSON.parse(data);
    } catch (error) {
        console.error("Erro ao carregar dados de estoque:", error);
        return [];
    }
};

// Rota GET /status 
app.get('/status', (req, res) => {
    res.status(200).json({ status: 'API de Gestão de Estoque está online!' });
});

// Rota GET /produtos_estoque 
app.get('/produtos_estoque', (req, res) => {
    const data = loadStockData();
    res.status(200).json(data);
});

// Exporta o 'app' para ser usado nos testes
module.exports = app;

// Inicia o servidor se o arquivo for executado diretamente
if (require.main === module) {
    app.listen(PORT, () => {
        console.log(`Servidor rodando em http://localhost:${PORT}`);
    });
}
