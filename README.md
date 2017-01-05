# Apresentando BuilderGen #

BuilderGen é um gerador de versões para projetos de software. Seu uso é simples e fácil, e é dedicado para projetos pequenos.

BuilderGen não é um repositório Git nem SVN. BuilderGen é um gerador de versões que segue o [http://semver.org]

## Qualquer projeto pode utilizar o BuilderGen ##

BuilderGen gera versões sequenciais de builds number. Por exemplo, em builds da Microsoft você sabe que 1109 é bem antes da 14563. Contudo, a 14573 tem poucas diferenças para a 14563.

##Versão atual##

1.3.5-20170105_183729

##Requisitos##

*Java na versão 1.8
*Linux
***Não testado em Mac**

##Recomendações##

Recomendamos que o projeto utilize Git, Composer e Linux.

##Formatação##

O formato atual das versões é ```1.0.{build}-{yyyyMMdd}_{HHmmss}```
O suporte a edição do formato será liberado em breve.

##Problemas e Sugestões##

Repositório BuilderGen no Github

Leia nosso Guia de Usuário. (Ainda)