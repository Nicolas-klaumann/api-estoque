// ecosystem.config.js
module.exports = {
    apps : [{
      name: "api-estoque", // Nome da sua aplicação
      script: "./src/app.js", // Caminho para o seu arquivo principal da API
      instances: "max", // Inicia o máximo de instâncias para aproveitar todos os cores da CPU
      exec_mode: "cluster", // Modo cluster para balanceamento de carga entre as instâncias
      watch: false, // Não monitorar arquivos para reiniciar em produção
      env: {
        NODE_ENV: "development",
        PORT: 3000
      },
      env_production: {
        NODE_ENV: "production",
        PORT: 3000
      }
    }]
  };
