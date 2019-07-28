       identification division.
       program-id.    modelo.
      *----------------------------------------------------------------*
      *        Dados  referentes  ao  Sistema  de  Documentacao        *
      *----------------------------------------------------------------*
      *                                                                *
      * 1.Descricao..: Gerenciar Carteira de Clientes para Vendedores  *
      *                                                                *
      * 2.Sistema....: ?????????     Subsistema..: ???????????         *
      *                                                                *
      * 3.Area Fonte.: ???????????                                     *
      *                                                                *
      * 4.Alteracao..:                                                 *
      *   Nome Versao    Data    Descricao                             *
      *   xxx  001/19  20/07/19  xxxxxxxxxxxxxxxxxxxxxx                *
      *----------------------------------------------------------------*
       environment    division.
       configuration  section.
       special-names. decimal-point is comma.
       input-output   section.
       file-control.

       select vendedor        assign to disk
              organization    is indexed
              access mode     is dynamic
              record key      is ch0-vendedor = cod-vendedor
                              in vendedor 
              alternate key   is ch1-vendedor = cpf-vendedor
                              in vendedor             
              lock mode       is manual 
              file status     is ws-status.
              
       select cliente         assign to disk
              organization    is indexed
              access mode     is dynamic
              record key      is ch0-cliente = cod-cliente
                              in cliente
              alternate key   is ch1-cliente = cnpj-cliente
                              in cliente              
              lock mode       is manual 
              file status     is ws-status.              
              
       select arqclie         assign to disk
              organization    is line sequential
              access mode     is sequential
              file   status   is ws-status.
              
              
              
       select impressora      assign to disk.              

       data           division.
       file           section.
       FD  cliente
           LABEL RECORD IS STANDARD
           VALUE OF FILE-ID IS lb-cliente.
     
       01  reg-cliente.
           05  cl-chave.
               10  cod-cliente         pic  9(007).
               10  cnpj-cliente        pic  9(014).
           05  razao-cliente           pic  x(040).
           05  Latitude-cliente        pic s9(003)v9(008).
           05  Longitude-cliente       pic s9(003)v9(008).
           
       FD  vendedor
           LABEL RECORD IS STANDARD
           VALUE OF FILE-ID IS lb-vendedor.           

       01  reg-vendedor.
           05  vd-chave.
               10  cod-vendedor        pic  9(003).
               10  cpf-vendedor        pic  9(011).
           05  nome-vendedor           pic  x(040).
           05  Latitude-vendedor       pic s9(003)v9(008).
           05  Longitude-vendedor      pic s9(003)v9(008).

       fd  impressora  
           label record     is omitted
           record contains  230 characters
           data record      is regsai
           value of file-id is ws-impress.
     
       01  regsai                           pic x(230).

       FD  arqclie
           LABEL RECORD IS STANDARD
           VALUE OF FILE-ID IS ex-arqclie.
     
       01  reg-arqclie.
           05  ar-chave.
               10  cod-arqclie         pic  9(007).
               10  cnpj-arqclie        pic  9(014).
           05  razao-arqclie           pic  x(040).
           05  Latitude-arqclie        pic s9(003)v9(008).
           05  Longitude-arqclie       pic s9(003)v9(008).

       working-storage section.
       copy  "c:\teste\fonte\cgc.w".        
       01  variaveis-gerais.
           02 ws-tela               pic  x(10)     value spaces.
           02 ws-opcao              pic  9(03)     value zeros.
           02 ws-confirma           pic  x(01)     value spaces. 
           02 ws-data.
              03 ws-ano             pic  9(002).
              03 ws-mes             pic  9(002).
              03 ws-dia             pic  9(002).
           02 ws-status             PIC  X(002)    value "00".
           02 lb-cliente   PIC X(050) value "c:\teste\arq\cliente.arq".              
           02 lb-vendedor  PIC X(050) value "c:\teste\arq\vendedor.arq".
           02 ws-impress            pic  x(080)    value spaces.
           02 ws-filename           pic  x(040)    value spaces. 
           02 ws-nome-externo       pic  x(020)    value spaces.           
           02 WS-CONTLIN            pic  999       value zeros.
           02 WS-CONTPAG            pic  999       value zeros.
           02 WS-RIMPRE             pic  999999    value zeros. 
           
       01  variaveis-cliente.
           02  ws-cod-cliente         pic  9(007) value zeros.
           02  ws-cnpj-cliente        pic  9(014) value zeros.
           02  ws-razao-cliente       pic  x(040) value spaces.
           02  ws-latitude-cliente    pic s9(003)v9(008) value zeros.
           02  ws-longitude-cliente   pic s9(003)v9(008) value zeros.       
       
       01  variaveis-vendedor.
           02  ws-cod-vendedor        pic  9(003) value zeros.
           02  ws-cpf-vendedor        pic  9(011) value zeros.
           02  ws-nome-vendedor       pic  x(040) value spaces.
           02  ws-latitude-vendedor   pic s9(003)v9(008) value zeros.
           02  ws-longitude-vendedor  pic s9(003)v9(008) value zeros.       

       01  CABECALHOS-cliente.
           02 CL-CAB-00.
              03 FILLER              PIC X(004) VALUE SPACES.
              03 FILLER              PIC X(111) VALUE ALL "-".
 
           02 CL-CAB-01.
              03 FILLER              PIC X(04) VALUE SPACES.
              03 FILLEr              PIC X(46) value "Teste".     
              03 filler              pic x(38) value spaces.
              03 FILLER              PIC X(10) VALUE "PAG. :".
              03 CL-CAB-CONTPAG      PIC ZZZZ9.
 
           02 CL-CAB-02.
              03 FILLER              PIC X(04) VALUE SPACES.
              03 FILLER              PIC X(46) value spaces.
              03 FILLER              PIC X(38) VALUE SPACES.
              03 FILLER              PIC X(07) VALUE "DATA :".
              03 CL-CAB-DATA         PIC 99/99/9999.
 
           02 CL-CAB-DET.
              03 FILLER              PIC X(007)  VALUE "Cliente".
              03 FILLER              PIC X(002)  VALUE SPACES.
              03 FILLER              PIC X(010)  VALUE "CNPJ".
              03 FILLER              PIC X(002)  VALUE SPACES.
              03 FILLER              pic x(040)  value "Razao".
              03 FILLER              PIC x(002)  value spaces.
              03 FILLER              pic x(015)  value "Latitude".
              03 FILLER              pic x(002)  value spaces.
              03 FILLER              pic x(015)  value "Longitude".
              03 FILLER              PIC x(002)  value spaces.
              
           02 CL-DET.   
              03 DT-cod-cliente      PIC 9(007)  value zeros.
              03 FILLER              PIC X(002)  VALUE SPACES.
              03 DT-cnpj-cliente     pic 9(014)  value zeros.
              03 FILLER              PIC x(002)  value spaces.
              03 DT-razao-cliente    pic x(040)  value spaces.
              03 FILLER              pic x(002)  value spaces.
              03 DT-latitude-cliente pic s9(003)v9(008) value zeros.
              03 FILLER              PIC x(002)  value spaces.
              03 DT-longitude-cliente pic s9(003)v9(008) value zeros.
              03 FILLER              PIC x(002)  value spaces.

       linkage section.                                       
       01  lk-PESSOA                  pic  x(001) value spaces.
       01  lk-cnpj                    pic  9(014) value zeros.
       01  lk-cpf                     pic  9(011) value zeros.
                  
       screen  section.
           
       01  tela-opcao.
           05 line 03 col 25 value " M E N U   D E   O P C O E S      ".
           05 line 06 col 20 value "                                  ".
           05 line 07 col 20 value "Cadastro             Relatorios   ".
           05 line 09 col 20 value "[1]-Clientes         [5]-Clientes ".
           05 line 10 col 20 value "[2]-Vendedores       [6]-Vededores".
           05 line 11 col 20 value "[3]-Imp. Cliente                  ".
           05 line 12 col 20 value "[4]-Imp. Vendedor                 ".     
           05 line 14 col 20 value "Executar        ".
           05 line 15 col 20 value "[7]-Distribuicao de Cliente ".
           05 line 18 col 20 value "[ESC]- Sair                 ".  
           05 line 23 col 01 value "----------------------------------".
           05 line 24 col 01 value "Mensagem :".
      
       01  tela-cliente.
           05 line 03 col 25 value "        C L I E N T E S           ".
           05 line 06 col 20 value "                                  ".
           05 line 07 col 20 value "Codigo Cliente :                  ".
           05 line 09 col 20 value "CNPJ           :                  ".
           05 line 11 col 20 value "Razao Social   :                  ".
           05 line 13 col 20 value "Latitude       :                  ".
           05 line 15 col 20 value "Longitude      :                  ".
           05 line 20 col 20 value "[ESC]- Voltar Menu                ".  
           05 line 23 col 01 value "----------------------------------".
           05 line 24 col 01 value "Mensagem :".
       
       01  tela-vendedor.
           05 line 03 col 25 value "      V E N D E D O R E S         ". 
           05 line 06 col 20 value "                                  ".
           05 line 07 col 20 value "Codigo Vendedor:                  ".
           05 line 09 col 20 value "CPF            :                  ".
           05 line 11 col 20 value "Nome   Vendedor:                  ".
           05 line 13 col 20 value "Latitude       :                  ".
           05 line 15 col 20 value "Longitude      :                  ".
           05 line 20 col 20 value "[ESC]- Voltar Menu                ".  
           05 line 23 col 01 value "----------------------------------".
           05 line 24 col 01 value "Mensagem :".
           
       01  tela-relatorio.
           05 line 03 col 25 value "      R E L A T O R I O S         ". 
           05 line 06 col 20 value "         C L I E N T E S          ".
           05 line 07 col 20 value "                                  ".
           05 line 09 col 20 value "[1]Ordem A-Z                      ".
           05 line 11 col 20 value "[2]Ordem Z-A                      ".
           05 line 13 col 20 value "[3]Codigo do Cliente              ".
           05 line 15 col 20 value "[4]Razao Social                   ".
           05 line 20 col 20 value "[ESC]- Voltar Menu                ".  
           05 line 23 col 01 value "----------------------------------".
           05 line 24 col 01 value "Mensagem :".
           
           
       procedure   division .
       
       0000-principal.
          
           accept  ws-data             from      date.
           display spaces              at        2401 
           display spaces              at        0101 
           display "DATA : "           at        0101 
                    ws-dia "/"
                    ws-mes "/"
                    ws-ano   
           display spaces              at        0201 
           .
       0000-menu.    
           display spaces              at        0201
           display tela-opcao
           
           move    zeros              to        ws-opcao    
           Display "Qual Opcao [ ]"   at  2413
           accept  ws-opcao           at  2424        
           evaluate ws-opcao
           when   0
               GO 0000-finaliza 
           when   1
               perform 1000-cadastro-cliente
                       thru  1900-cadastro-cliente-fim
           when   2 
               perform 2000-cadastro-vendedor
                       thru  2900-cadastro-vendedor-fim
           when   3 
               perform 3000-importar-cliente 
                       thru  3900-importar-cliente-fim
           when   4 
               perform 4000-importar-vendedor
                       thru  4900-importar-vendedor-fim
           when   5
               perform 000-REL-CLIENTE
                       thru  000-REL-CLIENTE-FIM
           when   6
               perform 6000-relatorio-vendedor
                       thru  6900-relatorio-vendedor-fim
           when   7               
               perform 7000-distribuicao        
           when other
               display "MENSAGEM : OPCAO IVALIDA <enter>" at 2401
               accept  ws-opcao           at    2479
               display spaces             at    2401
           end-evaluate.    
           
           go 0000-menu
           .
           
       0000-finaliza.
           exit    program
           stop    run
           .

       1000-cadastro-cliente.
           perform 8100-abrir-io-cliente.
       1001-posicionar-cliente.
           start   cliente             key not   less ch0-cliente
           if      ws-status           not =     "00" and "02" and "23"
                   display "Erro na tentativa de posicionar registro."
                                       at        2413 ws-status
                   accept  ws-opcao    at        2480
                   go  1900-cadastro-cliente-fim
           end-if           
           .
       1002-tela.    
           initialize variaveis-cliente   reg-cliente
           display spaces                 at    0201 
           display tela-cliente.
           .
        
       1002-consulta.
           accept  ws-cod-cliente         at    0737   
           move    ws-cod-cliente         to    cod-cliente
           read    cliente
           if      ws-status           not =     "00" and "02" and "23"
                                                               and "22"  
                   display "Erro ao ler arquivo Cliente ...."
                                          at    2413 ws-status
                   accept  ws-opcao       at    2480                                          
                   go  1900-cadastro-cliente-fim                                                               
           end-if
           .
       1003-incluir-alterar.
           if      ws-status               =     "00"  or "02" or  "22"
                   display "[A]lterar     [E]xcluir ... [ ]" 
                                          at    2413
                   accept  ws-confirma    at    2452 
                   if      ws-confirma    =     "A"  or "a"                     
                           go 1003-alterar-registro
                   else 
                           if  ws-confirma =     "E" or "e"
                               go 1004-excluir-registro
                           end-if        
                   end-if        
           end-if
           display "[I]ncluir ................. [ ]"  at    2413
           .
           
       1003-incluir-registro.
           accept  ws-cnpj-cliente        at    0937.
           if      ws-cnpj-cliente        =     zeros
                   go      1900-cadastro-cliente-fim
           end-if        
           move    ws-cnpj-cliente        to    ws-cgc 
           move    "J"                    to    ws-pessoa
           perform 000-MONTA-CGC-CPF THRU 006-SAIDA
           IF      WS-CONSISTENCIA        not = "00"
                   display "cnpj invalido ...."
                                          at    2413 ws-status
                   accept  ws-confirma    at    2444 
                   move    zeros          to    ws-cnpj-cliente
                   go      1003-incluir-registro
           end-if                                                  
           
           accept  ws-razao-cliente       at    1137.
           accept  ws-latitude-cliente    at    1337.
           accept  ws-longitude-cliente   at    1537.
           
           display "Confirma inclusao ..........[ ]" 
                                          at    2413
                   accept  ws-confirma    at    2444 
                   if      ws-confirma    not = "S" and "s"                     
                           go      1900-cadastro-cliente-fim
                   end-if        
       
           move    variaveis-cliente      to reg-cliente
           write   reg-cliente
           if      ws-status           not =     "00" and "02"
                   display "Erro ao gravar registro cliente ...."
                                          at    2413 ws-status
           end-if        
           go      1900-cadastro-cliente-fim
           .
       1003-alterar-registro.
           initialize variaveis-cliente
           move    reg-cliente            to variaveis-cliente
           display ws-cod-cliente         at    0737.
           display ws-cnpj-cliente        at    0937
           display ws-razao-cliente       at    1137.
           display ws-latitude-cliente    at    1337.
           display ws-longitude-cliente   at    1537.
       1003-consistencia.
           accept  ws-cnpj-cliente        at    0937  
           if      ws-cnpj-cliente        =     zeros
                   go      1900-cadastro-cliente-fim
           end-if        
           move    ws-cnpj-cliente        to    ws-cgc  
           move    "J"                    to    ws-pessoa
           perform 000-MONTA-CGC-CPF THRU 006-SAIDA 
           IF      WS-CONSISTENCIA        not = "00"
                   display "cnpj invalido ...."
                                          at    2413 ws-status
                   accept  ws-confirma    at    2444 
                   move    zeros          to    ws-cnpj-cliente
                   go      1003-consistencia
           end-if                                                  
           
           accept  ws-razao-cliente       at    1137.
           accept  ws-latitude-cliente    at    1337.
           accept  ws-longitude-cliente   at    1537.
           
           display "Confirma Altercao ..........[ ]" 
                                          at    2413
                   accept  ws-confirma    at    2444 
                   if      ws-confirma    not = "S"  and "s"                     
                           go      1900-cadastro-cliente-fim
                   end-if        
       
           rewrite reg-cliente
           if      ws-status          not =     "00" and "02" and "22"
                   display "Erro ao regravar registro cliente ...."
                                          at    2413 ws-status
           end-if       
           go      1900-cadastro-cliente-fim           
           .       
                     
       1004-excluir-registro.    
           initialize variaveis-cliente
           move    reg-cliente            to variaveis-cliente
           
           display ws-cod-cliente         at    0737.
           display ws-cnpj-cliente        at    0937
           display ws-razao-cliente       at    1137.
           display ws-latitude-cliente    at    1337.
           display ws-longitude-cliente   at    1537.
           
           display "Confirma Exclusao ..........[ ]" 
                                          at    2413
           accept  ws-confirma    at    2452 
           if      ws-confirma    not = "S"  and "s"                     
                   go      1900-cadastro-cliente-fim
           end-if        
       
           delete  cliente
           if      ws-status           not =     "00" and "02" and "22"
                   display "Erro ao ecluir registro cliente ......"
                                          at    2413 ws-status
           end-if       
           .
           
       1900-cadastro-cliente-fim.
           perform 9000-fechar-arq-cliente
                   thru    9000-fechar-arq-cliente-fim

           exit.    
            
           
       3000-importar-cliente.
       3100-inicio.
           display "Informe o nome do arq :"  at 2413
           accept  ws-nome-externo       at 2452 
           move spaces to ws-filename
           string 'c:\teste\arq\'        delimited by size
                  ws-nome-externo        delimited by spaces
                  '.txt'                 delimited by size
           into   ws-filename
           move   ws-filename            to ex-arqclie
           open   input   ARQCLIE.
           if     ws-status          not =     "00" 
                   display "Aquivo nao encontrado  ..............."
                                          at    2413 ws-status
                   accept   ws-opcao    at        2480
                   go  3900-importar-cliente-fim
           end-if       
           .
       3200-abre-arquivo.
           perform 8100-abrir-io-cliente.
       3300-posicionar-cliente.
           start   cliente             key not   less ch0-cliente
           if      ws-status           not =     "00" and "02" and "23"
                   display "Erro na tentativa de posicionar registro."
                                       at        2413 ws-status
                   accept  ws-opcao    at        2480
                   go  3900-importar-cliente-fim
           end-if                      
           .
           
       3400-leitura-externo.
           read arqclie at end
              go 3900-importar-cliente-fim.
            
           move cod-arqclie(1:7)         to   ws-cod-cliente      
           move cnpj-arqclie(1:14)       to   ws-cnpj-cliente 

           initialize ws-cgc ws-pessoa  
           move    ws-cnpj-cliente        to    ws-cgc  
           move    "J"                    to    ws-pessoa
           perform 000-MONTA-CGC-CPF THRU 006-SAIDA 
           IF      WS-CONSISTENCIA        not = "00"
                   go      3400-leitura-externo
           end-if                                                  
           
           move razao-arqclie(1:40)      to   ws-razao-cliente       
           move latitude-arqclie(1:15)   to   ws-latitude-cliente         
           move longitude-arqclie(1:15)  to   ws-longitude-cliente
           .
           
        3500-grava-registro.   
           move    variaveis-cliente      to   reg-cliente
           write   reg-cliente
           if      ws-status           not =     "00" and "02"
                   display "Erro ao gravar registro cliente ...."
                                          at    2413 ws-status
           end-if        
           go   3400-leitura-externo
           .
           
       3900-importar-cliente-fim.
           close arqclie cliente
           exit.    
           
       4000-importar-vendedor.
           .
           
       4900-importar-vendedor-fim.
           exit.    


       6000-relatorio-vendedor.
           .
           
       6900-relatorio-vendedor-fim.
           exit.    
              
           
       7000-distribuicao.
           .
           
       7900-distribuicao-fim.
           exit.          

           

       8000-abrir-arquivos.

       8000-abrir-input-cliente.
           open  input           cliente
           if    ws-status        not =     "00"
                 display "Erro na tentativa de abrir arquivo com INPUT."
                                       at 2413  
                 accept  ws-opcao      at 2442 
           end-if
           
           open  input        vendedor
           if    ws-status        not =     "00"
                 display "Erro na tentativa de abrir arquivo com INPUT."
                                       at 2413   
                 accept  ws-opcao      at 2442 
           end-if           
           .
          
       8000-abrir-input-fim.
           exit.
           
       8100-abrir-io-cliente.
           open  i-o        cliente 
           if    ws-status        not =     "00"
                 display "Erro na tentativa de abrir arquivo com INPUT."
                                       at 2413 
                 accept  ws-opcao      at 2442 
           end-if
           .
       8900-abrir-io-cliente-fim.   
           exit.  

       9000-fechar-arq-cliente.
       9000-cliente.
           close cliente 
           if ws-status           not =     "00"
              display "Erro na tentativa de fechar arquivo."  at 2402                
              accept  ws-opcao         at       2442 
           end-if
           .    
       9000-fechar-arq-cliente-fim.
           exit.          
           


       copy  "c:\teste\fonte\cgc.p". 
       copy  "c:\teste\fonte\vendedor.p".
       copy  "c:\teste\fonte\rel-cliente.p".
              
