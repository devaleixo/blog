Blog Devaleixo

Este projeto foi desenvolvido como parte de um desafio técnico para uma vaga em uma empresa. A solução inclui as funcionalidades básicas solicitadas, disponíveis após o login na barra de navegação (navbar). O usuário pode importar artigos, visualizar artigos publicados em ordem crescente com paginação e, sem estar logado, pode selecionar um artigo e fazer comentários.

Embora eu tenha considerado construir um modelo para lidar com as importações (incluindo tipos de importação como tags e artigos), além de implementar Action Cable para adicionar tags dinamicamente, e internacionalização com a gem i18n, esses recursos não foram implementados devido à falta de tempo. No entanto, já utilizei essas técnicas em outros projetos.

Infraestrutura e Desafios

O projeto foi hospedado em um servidor VPS. Como não tive tempo para configurar o reverse proxy com o kamal-proxy e resolver problemas de portas, deixei a seguinte configuração:

Portfólio: http://devaleixo.com:82
(Porta 9443 configurada para SSL)

Blog Devaleixo: https://blog.devaleixo.com

Enfrentei alguns desafios que atrasaram o desenvolvimento:

Problemas com o WSL: Tive dificuldades com a versão de uma biblioteca necessária para começar o projeto com o Rails 8. Identificar e resolver esse problema levou algumas horas.

Problema no Dockerfile: O Dockerfile estava configurado com uma versão antiga do Debian (versão 10), o que gerou incompatibilidade com o thruster devido à versão do libc6 (2.31, enquanto era necessário a versão 2.34). Depois de muitas horas tentando resolver manualmente, percebi que precisava ajustar a base do Dockerfile para RubyVersion_bookworm (versão 11 do Debian). Isso me levou o sábado inteiro, até a 1:30 da madrugada, para concluir o deploy.

Além disso, tive que conciliar o desenvolvimento com meu trabalho, o iFood e o fato de que estou esperando um filho em abril, o que deixou meu tempo ainda mais apertado.

Mensagem Final

Mesmo com as dificuldades, fiz o meu melhor dentro do tempo disponível. Caso seja contratado, poderei dedicar mais tempo e recursos para os projetos Mainô!

Acesse o blog e confira: https://blog.devaleixo.com
Aproveite também o meme de acesso: Acessa aí, acessa aiiii (cara chato fazendo tatuagem) 😄
