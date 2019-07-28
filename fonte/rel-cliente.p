       000-REL-CLIENTE.
           open  input            cliente
           if    ws-status        not =     "00"
                 display "Erro na tentativa de abrir arquivo com INPUT."
                                       at 2413 
                 accept  ws-opcao      at 2442 
           end-if
       
           start   cliente             key not   less ch0-cliente
           if      ws-status           not =     "00" and "02" and "23"
                   display "Erro na tentativa de posicionar registro."
                                       at        2413 ws-status
                   accept  ws-opcao    at        2480
                   go  3900-importar-cliente-fim
           end-if                      
           MOVE    80                  TO     ws-contlin
           open   output impressora
           .
       0000-REL-MENU.    
           display spaces              at        0201
           display tela-relatorio
           
           move    zeros              to        ws-opcao    
           Display "Qual Opcao [ ]"   at  2413
           accept  ws-opcao           at  2425        
           evaluate ws-opcao
           when   0
               GO 000-REL-CLIENTE-FIM 
           when   1
               perform 1000-REL-AZ
                       thru  1900-REL-AZ-fim
           when   2 
               perform 1000-REL-ZA
                       thru  1900-REL-ZA-fim
           when   3 
               perform 1000-REL-CODIGO 
                       thru  1900-REL-CODIGO-fim
           when   4 
               perform 1000-REL-RAZAO
                       thru  1900-REL-RAZAO-fim
           when other
               display "MENSAGEM : OPCAO IVALIDA <enter>" at 2401
               accept  ws-opcao           at    2479
               display spaces             at    2401
           end-evaluate.    
           
           go 0000-REL-MENU
           .
            

       000-REL-CLIENTE-FIM.
           CLOSE CLIENTE IMPRESSORA.
           EXIT.    

     
     
     
       1000-REL-AZ.
       1000-REL-LEITURA.
           read    cliente         next
           if      ws-status       not =     "00" and "02" and 
                                                 "10" and "46"
                   display "Erro na tentativa de leitura do registro."
                                       at        2413 ws-status
                   accept  ws-opcao    at        2480
                   go 1900-REL-AZ-fim
           end-if
           
           IF      WS-STATUS               =     "46"
                   GO 1900-REL-AZ-fim
           END-IF        

           move cod-arqclie              to   dt-cod-cliente      
           move cnpj-arqclie             to   dt-cnpj-cliente 
           move razao-arqclie            to   dt-razao-cliente       
           move latitude-arqclie         to   dt-latitude-cliente         
           move longitude-arqclie        to   dt-longitude-cliente
           .
       
       1000-grava.
       
           IF  WS-CONTLIN > 65
               ADD  1                  TO        WS-CONTPAG
               MOVE WS-CONTPAG         TO        CL-CAB-CONTPAG
               WRITE REGSAI FROM CL-CAB-00       AFTER PAGE
               WRITE REGSAI FROM CL-CAB-01       AFTER 1
               WRITE REGSAI FROM CL-CAB-02       AFTER 1
               WRITE REGSAI FROM CL-CAB-DET      AFTER 1
               WRITE REGSAI FROM CL-CAB-00       AFTER 1
               MOVE  SPACES             TO       REGSAI
               WRITE REGSAI AFTER 1
               MOVE 7                  TO        WS-CONTLIN
           end-if
           WRITE REGSAI FROM CL-DET    AFTER 1
           ADD 1                       TO        WS-CONTLIN
           ADD 1                       TO        WS-RIMPRE
           DISPLAY WS-RIMPRE           AT        2413 
           GO  1000-REL-LEITURA
           .
       1900-REL-AZ-fim.
           EXIT
           .
           
           
       1000-REL-ZA.
           .
       1900-REL-ZA-fim.
           exit
           .
           
       1000-REL-CODIGO.
           .
       1900-REL-CODIGO-fim.
           exit
           .
           
       1000-REL-RAZAO.
           .
       1900-REL-RAZAO-fim.
           exit
           .           
           