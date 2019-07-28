      ****************************************************************
      *      CADASTRO DE VENDEDORES
      ****************************************************************
       2000-cadastro-vendedor.
           perform 8100-abrir-io-vendedor.
       2001-posicionar-vendedor.
           start   vendedor            key not   less ch0-vendedor
           if      ws-status           not =     "00" and "02" and "23"
                   display "Erro na tentativa de posicionar registro."
                                       at        2413 ws-status
                   accept  ws-opcao    at        2480
                   go  2900-cadastro-vendedor-fim
           end-if           
           .
       2002-tela.    
           initialize variaveis-vendedor  reg-vendedor
           display spaces                 at    0201 
           display tela-vendedor.
           .
        
       2002-consulta.
           accept  ws-cod-vendedor        at    0737   
           move    ws-cod-vendedor        to    cod-vendedor
           read    vendedor
           if      ws-status           not =     "00" and "02" and "23"
                                                               and "22"  
                   display "Erro ao ler arquivo vendedor...."
                                          at    2413 ws-status
                   accept  ws-opcao       at    2480                                          
                   go  2900-cadastro-vendedor-fim                                                               
           end-if
           .
       2003-incluir-alterar.
           if      ws-status               =     "00"  or "02" or  "22"
                   display "[A]lterar     [E]xcluir ... [ ]" 
                                          at    2413
                   accept  ws-confirma    at    2452 
                   if      ws-confirma    =     "A"  or "a"                     
                           go 2003-alterar-registro
                   else 
                           if  ws-confirma =     "E" or "e"
                               go 2004-excluir-registro
                           end-if        
                   end-if        
           end-if
           display "[I]ncluir ................. [ ]"  at    2413
           .
           
       2003-incluir-registro.
           accept  ws-cpf-vendedor       at    0937.
           if      ws-cpf-vendedor       =     zeros
                   go      2900-cadastro-vendedor-fim
           end-if        
           move    ws-cpf-vendedor       to    ws-cpf 
           move    "F"                    to    ws-pessoa
           perform 000-MONTA-CGC-CPF THRU 006-SAIDA
           IF      WS-CONSISTENCIA        not = "00"
                   display "cnpj invalido ...."
                                          at    2413 ws-status
                   accept  ws-confirma    at    2444 
                   move    zeros          to    ws-cpf-vendedor
                   go      2003-incluir-registro
           end-if                                                  
           
           accept  ws-nome-vendedor       at    1137.
           accept  ws-latitude-vendedor   at    1337.
           accept  ws-longitude-vendedor  at    1537.
           
           display "Confirma inclusao ..........[ ]" 
                                          at    2413
                   accept  ws-confirma    at    2444 
                   if      ws-confirma    not = "S" and "s"                     
                           go      2900-cadastro-vendedor-fim
                   end-if        
       
           move    variaveis-vendedor     to reg-vendedor
           write   reg-vendedor
           if      ws-status           not =     "00" and "02"
                   display "Erro ao gravar registro cliente ...."
                                          at    2413 ws-status
           end-if        
           go      2900-cadastro-vendedor-fim
           .
       2003-alterar-registro.
           initialize variaveis-vendedor
           move    reg-vendedor           to variaveis-vendedor
           display ws-cod-vendedor        at    0737.
           display ws-cpf-vendedor        at    0937
           display ws-nome-vendedor       at    1137.
           display ws-latitude-vendedor   at    1337.
           display ws-longitude-vendedor  at    1537.
       2003-consistencia.
           accept  ws-cpf-vendedor        at    0937  
           if      ws-cpf-vendedor        =     zeros
                   go      2900-cadastro-vendedor-fim
           end-if        
           move    ws-cpf-vendedor        to    ws-cpf  
           move    "F"                    to    ws-pessoa
           perform 000-MONTA-CGC-CPF THRU 006-SAIDA 
           IF      WS-CONSISTENCIA        not = "00"
                   display "cnpj invalido ...."
                                          at    2413 ws-status
                   accept  ws-confirma    at    2444 
                   move    zeros          to    ws-cpf-vendedor
                   go      2003-consistencia
           end-if                                                  
           
           accept  ws-nome-vendedor       at    1137.
           accept  ws-latitude-vendedor   at    1337.
           accept  ws-longitude-vendedor  at    1537.
           
           display "Confirma Altercao ..........[ ]" 
                                          at    2413
                   accept  ws-confirma    at    2444 
                   if      ws-confirma    not = "S"  and "s"                     
                           go      2900-cadastro-vendedor-fim
                   end-if        
       
           rewrite reg-vendedor
           if      ws-status          not =     "00" and "02" and "22"
                   display "Erro ao regravar registro vendedor...."
                                          at    2413 ws-status
           end-if       
           go      2900-cadastro-vendedor-fim          
           .       
                     
       2004-excluir-registro.    
           initialize variaveis-vendedor
           move    reg-vendedor           to variaveis-vendedor.
           
           display ws-cod-vendedor        at    0737.
           display ws-cpf-vendedor        at    0937
           display ws-nome-vendedor       at    1137.
           display ws-latitude-vendedor   at    1337.
           display ws-longitude-vendedor  at    1537.
           
           display "Confirma Exclusao ..........[ ]" 
                                          at    2413
           accept  ws-confirma    at    2452 
           if      ws-confirma    not = "S"  and "s"                     
                   go      2900-cadastro-vendedor-fim
           end-if        
       
           delete  vendedor
           if      ws-status           not =     "00" and "02" and "22"
                   display "Erro ao ecluir registro vendedor......"
                                          at    2413 ws-status
           end-if       
           .
           
       2900-cadastro-vendedor-fim.
            perform 9000-fechar-arq-vendedor
                   thru    9000-fechar-arq-vendedor-fim
           exit.    


       8100-abrir-io-vendedor.
           open  i-o              vendedor         
           if    ws-status        not =     "00"
                 display "Erro na tentativa de abrir arquivo com INPUT."
                                       at 2413  
                 accept  ws-opcao      at 2442 
           end-if           
           .
       8900-abrir-io-vendedor-fim.
           exit.

       9000-fechar-arq-vendedor.
       9000-vendedor.
           close vendedor 
           if ws-status           not =     "00"
              display "Erro na tentativa de fechar arquivo."  at 2402                
              accept  ws-opcao         at       2442 
           end-if
           .    
       9000-fechar-arq-vendedor-fim.
           exit.          

