      *===============================================
      *    CGC = ROTINA PARA CONSISTIR O CGC / CPF   *
      *===============================================
      *
       000-MONTA-CGC-CPF.
           IF WS-PESSOA = "F"
              MOVE WS-CGC-NUM TO WS-CPF-NUM
              MOVE WS-CGC-DIG TO WS-CPF-DIG
              GO TO 001-LE-CADASTRO .

           IF WS-PESSOA = "J"
              MOVE WS-CGC-NUM TO WS-CGC-NUM
              MOVE WS-CGC-SEQ TO WS-CGC-SEQ
              MOVE WS-CGC-DIG TO WS-CGC-DIG
              MOVE  0 to WS-CONSISTENCIA .
      /

       001-LE-CADASTRO.
           MOVE 0 TO WS-CONSISTENCIA.
      /
      * CALCULA PRIMEIRO DIGITO DO DIGITO VERIFICADOR - CGC.
       IA000-DV1-CGC.
           IF WS-CONSISTENCIA NOT = ZEROS
                 GO 006-SAIDA.

           IF WS-PESSOA = "F"
                 MOVE WS-CGC-NUM TO WK-DV-CPF
                 GO 005-DV1-CPF.

           MOVE WS-CGC-NUM TO WK-DV-CGC.
           MOVE WS-CGC-SEQ TO WK-DV-ORDEM.

           COMPUTE WK-DV-TOTAL1 = (WK-DV-CGC2 * 5) + (WK-DV-CGC3 * 4) +
                                  (WK-DV-CGC4 * 3) + (WK-DV-CGC5 * 2) +
                                  (WK-DV-CGC6 * 9) + (WK-DV-CGC7 * 8) +
                                  (WK-DV-CGC8 * 7) + (WK-DV-CGC9 * 6).
           MOVE WK-DV-ORDEM TO WK-DV-NUMERO.
           IF WK-DV-NUMERO < 10
                 COMPUTE WK-DV-TOTAL1 = WK-DV-TOTAL1 + WK-DV-ORDEM4 * 2
                 GO 002-DV1-CGC.
           IF WK-DV-NUMERO < 100
                 COMPUTE WK-DV-TOTAL1 = WK-DV-TOTAL1 +
                 (WK-DV-ORDEM3 * 3) + (WK-DV-ORDEM4 * 2)
                 GO 002-DV1-CGC.
           IF WK-DV-NUMERO < 1000
                 COMPUTE WK-DV-TOTAL1 = WK-DV-TOTAL1 +
                 (WK-DV-ORDEM2 * 4) + (WK-DV-ORDEM3 * 3) +
                 (WK-DV-ORDEM4 * 2)
                 GO 002-DV1-CGC.
           IF WK-DV-NUMERO > 1000
                 COMPUTE WK-DV-TOTAL1 = WK-DV-TOTAL1 +
                 (WK-DV-ORDEM1 * 5) + (WK-DV-ORDEM2 * 4) +
                 (WK-DV-ORDEM3 * 3) + (WK-DV-ORDEM4 * 2).
       002-DV1-CGC.
           DIVIDE WK-DV-TOTAL1 BY 11
           GIVING WK-DV-TOT REMAINDER WK-DV-RESTO1.
           IF WK-DV-RESTO1 = 0 OR WK-DV-RESTO1 = 1
                 MOVE 0 TO WK-DV-NR-DV1
           ELSE
                 COMPUTE WK-DV-NR-DV1 = 11 - WK-DV-RESTO1.
      
      * CALCULA SEGUNDO DIGITO DO DIGITO VERIFICADOR - CGC.
      *
       003-DV2-CGC.
           COMPUTE WK-DV-TOTAL2 = (WK-DV-CGC2 * 6) + (WK-DV-CGC3 * 5) +
                                  (WK-DV-CGC4 * 4) + (WK-DV-CGC5 * 3) +
                                  (WK-DV-CGC6 * 2) + (WK-DV-CGC7 * 9) +
                                  (WK-DV-CGC8 * 8) + (WK-DV-CGC9 * 7).
           MOVE WK-DV-ORDEM TO WK-DV-NUMERO.
           IF WK-DV-NUMERO < 10
              COMPUTE WK-DV-TOTAL2 = WK-DV-TOTAL2 + WK-DV-ORDEM4 * 3
           GO 004-DV2-CGC.
           IF WK-DV-NUMERO < 100
              COMPUTE WK-DV-TOTAL2 = WK-DV-TOTAL2 +
              (WK-DV-ORDEM3 * 4) + (WK-DV-ORDEM4 * 3)
              GO 004-DV2-CGC.
           IF WK-DV-NUMERO < 1000
              COMPUTE WK-DV-TOTAL2 = WK-DV-TOTAL2 +
              (WK-DV-ORDEM2 * 5) + (WK-DV-ORDEM3 * 4) +
              (WK-DV-ORDEM4 * 3)
              GO 004-DV2-CGC.
           IF WK-DV-NUMERO > 1000
                      COMPUTE WK-DV-TOTAL2 = WK-DV-TOTAL2 +
                      (WK-DV-ORDEM1 * 6) + (WK-DV-ORDEM2 * 5) +
                      (WK-DV-ORDEM3 * 4) + (WK-DV-ORDEM4 * 3).
       004-DV2-CGC.
           COMPUTE WK-DV-TOTAL2 = WK-DV-TOTAL2 + (WK-DV-NR-DV1 * 2).
           DIVIDE WK-DV-TOTAL2 BY 11
           GIVING WK-DV-TOT REMAINDER WK-DV-RESTO2.
           IF WK-DV-RESTO2 = 0 OR WK-DV-RESTO2 = 1
                    MOVE 0 TO WK-DV-NR-DV2
           ELSE
                    COMPUTE WK-DV-NR-DV2 = 11 - WK-DV-RESTO2.

           MOVE WK-DV-NR-DV1 TO WK-DV-DIGITO1.
           MOVE WK-DV-NR-DV2 TO WK-DV-DIGITO2.
           IF WK-DV-DIGITO = WS-CGC-DIG
                    MOVE 00 TO WS-CONSISTENCIA
           ELSE
                    MOVE 08 TO WS-CONSISTENCIA.

           GO 006-SAIDA.

      * CALCULA PRIMEIRO DIGITO DO DIGITO VERIFICADOR - CPF
       005-DV1-CPF.
            COMPUTE WK-DV-TOTAL1 = (WK-DV-CPF1 * 10) +
            (WK-DV-CPF2 * 09) + (WK-DV-CPF3 * 08) +
            (WK-DV-CPF4 * 07) + (WK-DV-CPF5 * 06) +
            (WK-DV-CPF6 * 05) + (WK-DV-CPF7 * 04) +
            (WK-DV-CPF8 * 03) + (WK-DV-CPF9 * 02).
            DIVIDE WK-DV-TOTAL1 BY 11
            GIVING WK-DV-TOT REMAINDER WK-DV-RESTO1.
            IF WK-DV-RESTO1 = 0 OR WK-DV-RESTO1 = 1
                     MOVE 0 TO WK-DV-NR-DV1
            ELSE
                     COMPUTE WK-DV-NR-DV1 = 11 - WK-DV-RESTO1.

      * CALCULA SEGUNDO DIGITO DO DIGITO VERIFICADOR - CGF.
            COMPUTE WK-DV-TOTAL2 = (WK-DV-CPF1 * 11) +
               (WK-DV-CPF2 * 10) + (WK-DV-CPF3 * 09) +
               (WK-DV-CPF4 * 08) + (WK-DV-CPF5 * 07) +
               (WK-DV-CPF6 * 06) + (WK-DV-CPF7 * 05) +
               (WK-DV-CPF8 * 04) + (WK-DV-CPF9 * 03).
            COMPUTE WK-DV-TOTAL2 = WK-DV-TOTAL2 + (WK-DV-NR-DV1 * 2).
            DIVIDE WK-DV-TOTAL2 BY 11
            GIVING WK-DV-TOT REMAINDER WK-DV-RESTO2.
            IF WK-DV-RESTO2 = 0 OR WK-DV-RESTO2 = 1
                     MOVE 0 TO WK-DV-NR-DV2
            ELSE
                     COMPUTE WK-DV-NR-DV2 = 11 - WK-DV-RESTO2.
       
            MOVE WK-DV-NR-DV1 TO WK-DV-DIGITO1.
            MOVE WK-DV-NR-DV2 TO WK-DV-DIGITO2.
            IF WK-DV-DIGITO = WS-CGC-DIG
                     MOVE 00 TO WS-CONSISTENCIA
            ELSE
                     MOVE 07 TO WS-CONSISTENCIA.
            .
       006-SAIDA.
             EXIT   .
