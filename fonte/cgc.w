      *===============================================
      *                                              *
      *     PARAMETROS PARA CONSISTIR O CGC / CPF    *
      *                                              *
      *===============================================
      * Variaveis de verificacao do digito verificador CGC ou CPF
       01 WK-DV-NUMERO             PIC 9(04) VALUE ZEROS.
       01 WK-DV-TOTAL1             PIC 9(05) VALUE ZEROS.
       01 WK-DV-RESTO1             PIC 9(05) VALUE ZEROS.
       01 WK-DV-NR-DV1             PIC 9(01) VALUE ZEROS.
       01 WK-DV-TOT                PIC 9(05) VALUE ZEROS.
      /                   
       01 WK-DV-TOTAL2             PIC 9(05) VALUE ZEROS.
       01 WK-DV-RESTO2             PIC 9(05) VALUE ZEROS.
       01 WK-DV-NR-DV2             PIC 9(01) VALUE ZEROS.
      /
       01 WK-DV-CGC.
          02 WK-DV-CGC1            PIC 9(01) VALUE ZEROS.
          02 WK-DV-CGC2            PIC 9(01) VALUE ZEROS.
          02 WK-DV-CGC3            PIC 9(01) VALUE ZEROS.
          02 WK-DV-CGC4            PIC 9(01) VALUE ZEROS.
          02 WK-DV-CGC5            PIC 9(01) VALUE ZEROS.
          02 WK-DV-CGC6            PIC 9(01) VALUE ZEROS.
          02 WK-DV-CGC7            PIC 9(01) VALUE ZEROS.
          02 WK-DV-CGC8            PIC 9(01) VALUE ZEROS.
          02 WK-DV-CGC9            PIC 9(01) VALUE ZEROS.
          02 WK-DV-ORDEM.
             03 WK-DV-ORDEM1       PIC 9(01) VALUE ZEROS.
             03 WK-DV-ORDEM2       PIC 9(01) VALUE ZEROS.
             03 WK-DV-ORDEM3       PIC 9(01) VALUE ZEROS.
             03 WK-DV-ORDEM4       PIC 9(01) VALUE ZEROS.
       01 WK-DV-CPF.
          02 WK-DV-CPF1            PIC 9(01) VALUE ZEROS.
          02 WK-DV-CPF2            PIC 9(01) VALUE ZEROS.
          02 WK-DV-CPF3            PIC 9(01) VALUE ZEROS.
          02 WK-DV-CPF4            PIC 9(01) VALUE ZEROS.
          02 WK-DV-CPF5            PIC 9(01) VALUE ZEROS.
          02 WK-DV-CPF6            PIC 9(01) VALUE ZEROS.
          02 WK-DV-CPF7            PIC 9(01) VALUE ZEROS.
          02 WK-DV-CPF8            PIC 9(01) VALUE ZEROS.
          02 WK-DV-CPF9            PIC 9(01) VALUE ZEROS.
       01 WK-DV-DIGITO.
          02 WK-DV-DIGITO1         PIC 9(01) VALUE ZEROS.
          02 WK-DV-DIGITO2         PIC 9(01) VALUE ZEROS.
       01 WS-CGC                                        .
          02  WS-CGC-NUM           PIC 9(09)            .
          02  WS-CGC-SEQ           PIC 9(04)            .
          02  WS-CGC-DIG           PIC 9(02)            .
       01 WS-CPF                                        .
          02  WS-CPF-NUM           PIC 9(09)            .
          02  WS-CPF-DIG           PIC 9(02)            .
       01 WS-PESSOA                PIC X(01) VALUE SPACE.
       01 WS-CONSISTENCIA          PIC 9(01) VALUE 0    .
