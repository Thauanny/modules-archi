# flutter_application_1

Projeto examplo para fins de sugestão de modelo arquitetural escalável utilizando clean architecture e design system proprio com arquitetura proposta no seguinte link: https://github.com/Thauanny/view-archi

## desenho da arquitetura final

![arquitetura_mobile_clean_arch drawio](https://github.com/Thauanny/modules-archi/assets/44787914/6978516b-de61-4afe-ba31-2d6ca3f1f711)



## Firebase configuration

Mude o nome do pacote da sua aplicação para um nome aceitavel de pacote.

Abra o terminal e execute:

1. ``npm install -g firebase-tools``, para instalar as ferramentos na maquina.
2. ``firebase login``. para sincronizar com a conta do console da aplicação
3. ``flutter pub global activate flutterfire_cli``, para instalar a ferramenta cli do flutter firebase e adicione no PATH da maquina
4. ``flutterfire configure``, selecione o projeto do console e a plataforma desejada.
5. adicione os pacotes desejados do firebase no pubspec e rode ``flutter pub get``.

