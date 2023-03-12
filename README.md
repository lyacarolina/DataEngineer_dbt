# Teste: Engenharia de Dados

Teste feito para apresentação de conhecimentos e experiências.

## Ferramentas:

1. AWS 
    * Redshift - Saiba mais acessando: [O que é o Amazon Redshift?](https://docs.aws.amazon.com/pt_br/redshift/latest/mgmt/welcome.html)
    * S3 - Saiba mais acessando: [O que é o Amazon S3?](https://docs.aws.amazon.com/pt_br/AmazonS3/latest/userguide/Welcome.html)
2. dbt Core
    * Para arquivos com menos de 500 linhas, pode ser utilizado o dbr Cloud
    * Para arquivos maiores que 500 linhas, é necessário utilizar o dbt Core, como é o caso deste projeto. Para informações de como utilizá-lo, consulte: [Quickstart for dbt Core](https://docs.getdbt.com/docs/quickstarts/dbt-core/quickstart)
3. VS Code
4. GitHub

## Processo:

1. Preparação do ambiente:

    * Criar conta no [AWS](https://aws.amazon.com/pt/)
    * Criar Cluster Redshift - Saiba como [aqui](https://docs.aws.amazon.com/pt_br/redshift/latest/dg/tutorial-loading-data-launch-cluster.html)
    * Criar Banco de Dados e Objetos 
    * Criar Bucket no S3 e fazer Upload de Arquivos para o S3 - Saiba como [aqui](https://docs.aws.amazon.com/pt_br/redshift/latest/dg/tutorial-loading-data-upload-files.html)
    * Criar credenciais
    * Importar Dados com Copy
