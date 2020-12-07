## Configuração

Clone o projeto

```sh
$ git clone https://github.com/pedrohcrisanto/igbe.git
```

Instale as dependências
```sh
$ cd /ibge/
$ bundle install
```

Crie o banco e migre as tabelas
```sh
$ rake db:create db:migrate 
```

Rode a aplicação
```sh
$ rails s
```

Abra o seu navegador(de preferência Chrome ou Firefox) e navegue para `localhost:3000`

Para realizar Testes
```sh
$ bundle exec rspec
```
## Deploy no Heroku

https://ibge-test.herokuapp.com/



