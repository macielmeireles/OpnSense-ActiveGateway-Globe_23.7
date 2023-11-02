# OpnSense-ActiveGateway-Globe
Script for OpnSense | Add a globe icon to the right of the active gateway name in the widget


## Donation | Doações
(En)      Support our project via Pix or PayPal. <br />
(Pt-Br) Apoie nosso projeto via Pix ou PayPal: <br />

- Brazilian Pix: d56da244-4dc5-4f77-be6d-28e94fdd46b2 <br />
- Paypal:  https://bit.ly/MonitTelegram <br /><br />

## Screenshot
![Screenshot](https://github.com/macielmeireles/OpnSense-ActiveGateway-Globe/blob/main/screenshot.jpg)


## Overview (En)
“This project provides two scripts. One to get the active gateway information and another to modify the OPNsense “Gateways” widget file, and add a globe icon to the right of the active gateway name.”


## Requirements
- OPNsense Firewall
- SSH terminal
- Download the `install.sh` from this GitHub repository (last stable version) to your machine with OPNsense



## Quick Installation Guide (En)
1. Enable SSH on OpnSense
2. Download the file `install.sh`
3. Set Permission
4. Run the script
5. Test


## Detailed Installation Guide (En)

1. Enable SSH on OpnSense and access SSH<br />
   1.1 Enable SSH on OpnSense: System > Settings > Administration <br />
   1.2 Access OpnSense via SSH from terminal: ssh root@192.168.1.1. Replace root with your username and 192.168.1.1 with your OpnSense IP address.<br />

2. Download the file `install.sh` <br />
   2.1 In terminal, navigate to the Widgets folder: `cd /usr/local/www/widgets/widgets/`<br />
   2.2 Use fetch to download "install.sh" from GitHub:<br /> 
    `fetch https://raw.githubusercontent.com/macielmeireles/OpnSense-ActiveGateway-Globe/main/install.sh`<br />

3. Set Permissions:<br />
   3.1 Set +x permission on the file:<br /> `chmod +x install.sh`<br />

4. Run the script  <br />
   4.1 In terminal, run the command to run the installion: `./install.sh`<br />

5. Test:<br />
   5.1 Open your opnSense in your Browser<br />
   



## Quick Installation Guide (pt-Br)
1. Ative o SSH no OpnSense
2. Baixe o arquivo `install.sh`
3. Defina a permissão
4. Execute o script
5. Teste


## Detailed Installation Guide (pt-Br)

1. Ative o SSH no OpnSense e acesse via SSH<br />
   1.1 Ative o SSH no OpnSense: System > Settings > Administration <br />
   1.2 Acesse o OpnSense via SSH pelo terminal: ssh root@192.168.1.1. Substitua “root” pelo seu nome de usuário e “192.168.1.1” pelo endereço IP do seu OpnSense.<br />

2. Baixe o arquivo `install.sh` <br />
   2.1 No terminal, navegue até a pasta Widgets: `cd /usr/local/www/widgets/widgets/`<br />
   2.2 Use o comando fetch para baixar o arquivo “install.sh” do GitHub: <br /> 
    `fetch https://raw.githubusercontent.com/macielmeireles/OpnSense-ActiveGateway-Globe/main/install.sh`<br />

3. Defina a permissão: <br />
   3.1 Defina a permissão +x no arquivo:<br /> `chmod +x install.sh`<br />

4. Execute o Script  <br />
   4.1 No terminal, execute o comando para iniciar a instalação: `./install.sh`<br />

5. Teste:<br />
   5.1 Abra o OpnSense no seu navegador <br />







