# Teste para contratação de analista / desenvolvedor(a) SQL

Realize um `fork` e suba o código desenvolvido dentro deste repositório.

### Introdução
  - Cria a base de dados no seu SQL local usando o script `database-script.sql`;
  - Verifique se todo o schema, tabelas e dados foram criados;
  - Construa os scripts, queries e procedures para cada questão abaixo:
    - Armazene os scripts em um novo arquivo `.sql` com as construções.

### Questões para construir
  01. Crie uma query que obtenha a lista de produtos (ProductName), e a quantidade por unidade (QuantityPerUnit);
  02. Crie uma query que obtenha a lista de produtos ativos (ProductID e ProductName);
  03. Crie uma query que obtenha a lista de produtos descontinuados (ProductID e ProductName);
  04. Crie uma query que obtenha a lista de produtos (ProductID, ProductName, UnitPrice) ativos, onde o custo dos produtos são menores que $20;
  05. Crie uma query que obtenha a lista de produtos (ProductID, ProductName, UnitPrice) ativos, onde o custo dos produtos são entre $15 e $25;
  06. Crie uma query que obtenha a lista de produtos (ProductName, UnitPrice) que tem preço acima da média;
  07. Crie uma procedure que retorne cada produto e seu preço;
      - Adicione à procedure, criada na questão anterior, os parâmetros 'Codigo_Fornecedor' (permitindo escolher 1 ou mais) e 'Codigo_Categoria' (permitindo escolher 1 ou mais) e altere-a para atender a passagem desses parâmetros;
      - Adicione à procedure, criada na questão anterior, o parâmetro 'Codigo_Transportadora' (permitindo escolher 1 ou mais) e um outro parâmetro 'Tipo_Saida' para se optar por uma saída OLTP (Transacional) ou OLAP (Pivot).
  08. Crie uma query que obtenha a lista de empregados e seus liderados, caso o empregado não possua liderado, informar 'Não possui liderados'.
  09. Crie uma query que obtenha o(s) produto(s) mais caro(s) e o(s) mais barato(s) da lista (ProductName e UnitPrice);
  10. Crie uma query que obtenha a lista de pedidos dos funcionários da região 'Western';
  11. Crie uma query que obtenha os números de pedidos e a lista de clientes (CompanyName, ContactName, Address e Phone), que possuam 171 como código de área do telefone e que o frete dos pedidos custem entre $6.00 e $13.00;
  14. Crie uma query que obtenha todos os dados de pedidos (Orders) que envolvam os fornecedores da cidade 'Manchester' e foram enviados pela empresa 'Speedy Express';
  15. Crie uma query que obtenha a lista de Produtos (ProductName) constantes nos Detalhe dos Pedidos (Order Details), calculando o valor total de cada produto já aplicado o desconto % (se tiver algum);

### Modelo de Dados:
<img width="1121" alt="Modelo de Dados" src="https://github.com/targetsoftware/teste-contratacao-sql/assets/9052611/bc869bf2-615e-4619-a017-1aebc5ea11f8">

### Questões complementares:
  1. Tem conhecimento em processos e ferramentas de ETL? Quantos anos de experiência? Quais cases foram aplicados?
  R: Sim, tenho 6 anos de experiência de criação de ETL no SSIS utilizando a ferramenta SSDT (SQL Server Data Tools). Possuo vários cases sendo o principal a carga de dados diária, nosso pipeline de dados, ele se conecta com vários arquivos txt gerados através da plataforma Magellan (O Sistema principal é bem antigo, essa plataforma extrai os dados em txt) e se conecta também com uma base em oracle. Temos mais algumas fontes de dados mas essa duas são as principais. Esse ETL faz toda a transformação necessária para popular nosso data warehouse e atualizar os cubos. Também já desenvolvi ETLs para diversas áreas da empresa, desde finanças com a automatização do GLP276 (demoravam 3 dias para analisar, tratar os dados e gerar uma planilha, todo o processo caiu para no máximo 4 horas) até processos de automatizações para equipe de marketing e vendas.
  2. Tem experiência com ferramental Azure Data Factory?
R: Conheço, mas não possuo experiência, porem não vejo dificuldade em aprender como a ferramenta funciona.
  3. Pode responder em um fluxograma (ou escrito em tópicos) um case de ETL onde:
      - Parte dos dados da origem estão em banco de dados Oracle e outra em CSV no Storage Bucket da AWS
      - O dado final deverá estar na base de dados SQL Server.
      - Deverá acontecer validação da entrada dos dados da origem.
      - Validação dos dados finais que foram processados.
      - Cálculos dos dados de origem, para geração de indicadores (que serão os dados finais).

![image](https://github.com/user-attachments/assets/92980a79-eba4-419b-921b-8252571e61e2)


### O que será avaliado:
  - Padrão utilizado de desenvolvimento;
  - Boas práticas aplicadas;
  - Aplicação de conceitos de performance;
  - Organização e desenho do processo de ETL.

### Diferenciais
  - Documentação
  - Azure DataFactory

Disponibilizar o código desenvolvido via GitHub (realize um `fork` deste repositório) para avaliação. 

Para comunicação, caso não tenha recebido algum contato, notifique rh@targetsoftware.com.br sobre a finalização do teste com o link do repositório.
