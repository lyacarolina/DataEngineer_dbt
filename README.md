# Teste: Engenharia de Dados

Teste feito para apresentação de conhecimentos e experiências.

## Ferramentas:

1. AWS 
    * Redshift - Saiba mais acessando: [O que é o Amazon Redshift?](https://docs.aws.amazon.com/pt_br/redshift/latest/mgmt/welcome.html)
    * S3 - Saiba mais acessando: [O que é o Amazon S3?](https://docs.aws.amazon.com/pt_br/AmazonS3/latest/userguide/Welcome.html)
2. dbt
    * Saiba mais sobre a ferramenta acessando este artigo da [RoxPartner](https://roxpartner.com/dbt-como-ferramenta-aceleradora-da-jornada-data-driven/)
    * Para arquivos com menos de 500 linhas, pode ser utilizado o dbr Cloud
    * Para arquivos maiores que 500 linhas, é necessário utilizar o dbt Core, como é o caso deste projeto.
3. VS Code
4. GitHub

## Processo:

1. Preparação do ambiente:

    * Criar conta no [AWS](https://aws.amazon.com/pt/)
    * Criar Cluster Redshift - Saiba como [aqui](https://docs.aws.amazon.com/pt_br/redshift/latest/dg/tutorial-loading-data-launch-cluster.html)
    * Criar Banco de Dados e Objetos (Estruturando o bando de dados)
    * Criar Bucket no S3 e fazer Upload de Arquivos para o S3 - Saiba como [aqui](https://docs.aws.amazon.com/pt_br/redshift/latest/dg/tutorial-loading-data-upload-files.html)
    * Criar credenciais - Na lateral direita da página inicial do seu [console AWS](https://us-east-1.console.aws.amazon.com/console/home?region=us-east-1#), clique em seu nome de usuário, em seguida em Security credentials e no campo Chaves de acesso crie sua chave. Salve a chave de acesso e a senha criada para utilizá-la no próximo passo. 
    * Importar Dados com Copy
    * Conectar o banco com o dbt - [Quickstart for dbt Core](https://docs.getdbt.com/docs/quickstarts/dbt-core/quickstart)


   ### 1.1 Criando Banco de Dados e Objetos utilizando editor de consultas do Redshift
   
      Na página [Editor de consultas v2](https://us-east-2.console.aws.amazon.com/sqlworkbench/home?region=us-east-2#/client) do Redshift, clique em <b>Create a tab</b> <br>
      ![image](https://user-images.githubusercontent.com/38046847/224581222-0e178a3a-6a38-46c9-bd44-8116e615c562.png)
e com seu cluster selecionado crie seu banco de dados digitando: <br>
> create database your_database_name

![image](https://user-images.githubusercontent.com/38046847/224581566-9a842915-2171-40e4-af67-3aebaa9de667.png) 
<br>Neste projeto, o cluster é <b>"engenharia_dados"</b> e o banco de dados é o <b>mongodb</b>. É possível escolher o nome que desejar ao criar.

Com o banco de dados feito, agora podemos construir nossos schemas e nossas tabelas. Um modo mais prático para isso é acessar o menu <b>Create<b>, selecionar a opção <b>schema<b> ou <b>table</b>, e realizar a ação desejada.

Schema: <br>
![image](https://user-images.githubusercontent.com/38046847/224581919-490d8fca-83f6-4edf-aeb8-5dc5abdf778d.png)<br>

Tabela:<br>
![image](https://user-images.githubusercontent.com/38046847/224581994-65b4ded4-c1c8-47a9-ab99-73f8b45a98f0.png)<br>
Dica: você pode importar o arquivo .csv e as colunas automaticamente são puxadas, precisando apenas fazer as configurações para cada uma delas através das opções laterais.
   
   
   ### 1.2 Importando dados do s3 para o banco de dados criado
   
   Novamente no editor de consultas, execute o código abaixo adaptado conforme suas necessidades:
   
>copy categories

>from 's3://meubucket/meuarquivo.csv' 

>CREDENTIALS 'aws_access_key_id=???;aws_secret_access_key=###' 

>delimiter ';' 

>region 'sa-east-1'

>IGNOREHEADER 1

>DATEFORMAT AS 'YYYY-MM-DD HH:MI:SS'

>removequotes;


2. Criando modelos:

Conforme descrito no artigo acima, o dbt é uma ferramenta de transformação dentro do processo de ELT/ETL. Para conseguirmos utilizar os dados do banco, primeiro temos que criar uma Source, um arquivo .yml criado dentro de models, que é o caminho que torna possível utilizar os dados para as consultas SQL.

Neste projeto tínhamos três schemas diferentes: person, sales e production. Então foram criadas três sources para cada schema, conforme exemplo abaixo:<br>
![image](https://user-images.githubusercontent.com/38046847/224584479-5b148147-6efa-4dd4-a4cb-26dfdb4cc4c7.png)

Para saber se o processo deu certo, vamos rodar o dbt.

Primeiro, crie um arquivo .sql onde poderá executar o comando select. Neste arquivo, para utilizar a tabela que deseja vamos usar o conceito de referência. Isso porque a source, nossa conexão, faz uma referência a tabela ao banco de dados. Como exemplo, vamos utilizar a tabela person. O comando é o seguinte:

> select * from {{source('sources', 'person')}}

Para rodar o dbt, no terminal, utilize o comando, utilizando o arquivo .sql criado (sem adicionar a extensão): 

> dbt run - s nomearquivo 

Se rodou com sucesso, aparecerá no terminal: <br>
![image](https://user-images.githubusercontent.com/38046847/224585228-ec145880-76ed-4757-a1c0-51a9e1543cbc.png)

Com isso, todas as consultas SQL pode ser geradas!

Importante: quando executado o comando run, uma view é criada no Redshift, no schema do dbt, se baseando no modelo .sql rodado. Ali é possível consultar a tabela com os resultados da query.<br>
![image](https://user-images.githubusercontent.com/38046847/224585651-bf62a8f1-5e42-410a-b44b-8366b607b75c.png)



2. Resolução:

Para esse projeto, foram gerados 5 arquivos .sql para construção das queries pedidas, ou seja, a nossa análise de dados:
* [count_sales_order_detail](https://github.com/lyacarolina/DataEngineer_dbt/blob/main/test_dataengineer/models/count_sales_order_detail.sql)
* [top_3_products](https://github.com/lyacarolina/DataEngineer_dbt/blob/main/test_dataengineer/models/top_3_products.sql)
* [clients_count_order](https://github.com/lyacarolina/DataEngineer_dbt/blob/main/test_dataengineer/models/clients_count_order.sql)
* [total_products](https://github.com/lyacarolina/DataEngineer_dbt/blob/main/test_dataengineer/models/total_products.sql)
* [values_order_header](https://github.com/lyacarolina/DataEngineer_dbt/blob/main/test_dataengineer/models/values_order_header.sql)

E, para finalizar, é possível ver o relatório final através do Dashboard [Relatório Final](https://lookerstudio.google.com/u/0/reporting/95c2d443-c0af-47b2-b722-46a3d79f03bb/page/3HQID). É possível também extrair o resultado em .csv através do próprio relatório.
