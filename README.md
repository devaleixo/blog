Blog Devaleixo

Este projeto foi desenvolvido como parte de um desafio técnico para conseguir uma vaga em uma empresa. A solução inclui funcionalidades básicas solicitadas, que estão disponíveis após o login na barra de navegação (navbar), incluindo a funcionalidade de importação de artigos, sem estar logado o usuário pode ver os artigos publicados em ordem crescente, com paginação, selecionar um artigo e fazer comentários.

Eu poderia ter construido um modelo para lidar com as importações, com um import_type, permitindo o import tanto de tags como de artigos, porém não tive disponibilidade de tempo para tal feito.

O projeto foi hospedado em um servidor VPS, como não tive tempo de configurar um reverse proxy com o kamal-proxy e solucionar o problema de portas deixei a seguinte configuração:

* Portfólio: http://devaleixo.com:82
 * O portfólio está com a porta 9443 para ssl
* Blog Devaleixo: https://blog.devaleixo.com

  Tive alguns problemas que atrasaram bastante o desenvolvimento, como:
1)Tive um problema no meu WSL com a versão de outra biblioteca para começar o projeto utilizando o rails 8, até identificar e começar o projeto levei algumas horas.
2) Dockerfile do projeto com uma versão antiga do Debian, o thruster exige o libc6 com a versão 2.34, e o meu Dockerfile estava puxando a versão 10 do Debian, a biblioteca estava na versão 2.31, demorei bastante até perceber que isso não poderia ser atualizado na mão e que deveria fazer o meu Dockerfile from RubyVersion_bookworm(versão 11 do Debian)

Tive que consiliar a construção do projeto com meu trabalho e ifood, estou esperando um filho em Abril e trabalhando bastante!
Mas claro, caso seja contratado, meu tempo estará disponível para vocês rsrsrsrsrsrsrsrrs.
Espero que gostem, fiz o que pude com o tempo que tive.

Acessa ai acessa aiiii (meme):  https://blog.devaleixo.com
