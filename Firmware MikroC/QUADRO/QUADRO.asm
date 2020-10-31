
_F00_BIT_ON_OFF:

;QUADRO.c,242 :: 		short F00_BIT_ON_OFF(char endereco, char campo)//PESQUISA POR BIT HABILITADO NA EEPROM
;QUADRO.c,244 :: 		if (campo &= EEPROM_Read(endereco))//de onde até onde?
	MOVF        FARG_F00_BIT_ON_OFF_endereco+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        FARG_F00_BIT_ON_OFF_campo+0, 0 
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       FARG_F00_BIT_ON_OFF_campo+0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F00_BIT_ON_OFF0
;QUADRO.c,246 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_F00_BIT_ON_OFF
;QUADRO.c,247 :: 		}
L_F00_BIT_ON_OFF0:
;QUADRO.c,248 :: 		return 0;
	CLRF        R0 
;QUADRO.c,249 :: 		}
L_end_F00_BIT_ON_OFF:
	RETURN      0
; end of _F00_BIT_ON_OFF

_F01_IMPRIME_TPIC:

;QUADRO.c,251 :: 		void F01_IMPRIME_TPIC(unsigned short F01ee)
;QUADRO.c,254 :: 		for (F01aa = 0; F01aa != 8; F01aa++)
	CLRF        R3 
L_F01_IMPRIME_TPIC1:
	MOVF        R3, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_F01_IMPRIME_TPIC2
;QUADRO.c,256 :: 		if (0 == (F01ee & _8Bit))
	MOVLW       128
	ANDWF       FARG_F01_IMPRIME_TPIC_F01ee+0, 0 
	MOVWF       R1 
	MOVLW       0
	ANDLW       0
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__F01_IMPRIME_TPIC672
	MOVF        R1, 0 
	XORLW       0
L__F01_IMPRIME_TPIC672:
	BTFSS       STATUS+0, 2 
	GOTO        L_F01_IMPRIME_TPIC4
;QUADRO.c,257 :: 		rd1_DADOS_TPIC = 0;
	BCF         RD1_bit+0, BitPos(RD1_bit+0) 
	GOTO        L_F01_IMPRIME_TPIC5
L_F01_IMPRIME_TPIC4:
;QUADRO.c,259 :: 		rd1_DADOS_TPIC = 1;
	BSF         RD1_bit+0, BitPos(RD1_bit+0) 
L_F01_IMPRIME_TPIC5:
;QUADRO.c,260 :: 		F01ee = F01ee << 1;
	RLCF        FARG_F01_IMPRIME_TPIC_F01ee+0, 1 
	BCF         FARG_F01_IMPRIME_TPIC_F01ee+0, 0 
;QUADRO.c,261 :: 		rc1_PHOTO_TPIC = 1;
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;QUADRO.c,262 :: 		rc1_PHOTO_TPIC = 0;
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
;QUADRO.c,254 :: 		for (F01aa = 0; F01aa != 8; F01aa++)
	INCF        R3, 1 
;QUADRO.c,263 :: 		}
	GOTO        L_F01_IMPRIME_TPIC1
L_F01_IMPRIME_TPIC2:
;QUADRO.c,264 :: 		}
L_end_F01_IMPRIME_TPIC:
	RETURN      0
; end of _F01_IMPRIME_TPIC

_F02_LE_TECLADO:

;QUADRO.c,266 :: 		void F02_LE_TECLADO(void)
;QUADRO.c,268 :: 		unsigned short F02aa = 2;
	MOVLW       ?ICSF02_LE_TECLADO_F02aa_L0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICSF02_LE_TECLADO_F02aa_L0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICSF02_LE_TECLADO_F02aa_L0+0)
	MOVWF       TBLPTRU 
	MOVLW       F02_LE_TECLADO_F02aa_L0+0
	MOVWF       FSR1 
	MOVLW       hi_addr(F02_LE_TECLADO_F02aa_L0+0)
	MOVWF       FSR1H 
	MOVLW       19
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
;QUADRO.c,274 :: 		while (F02stgTeclaValida[0] != F02stgTeclaValida[1])
L_F02_LE_TECLADO6:
	MOVF        F02_LE_TECLADO_F02stgTeclaValida_L0+0, 0 
	XORWF       F02_LE_TECLADO_F02stgTeclaValida_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_F02_LE_TECLADO7
;QUADRO.c,276 :: 		F02aa++;
	INCF        F02_LE_TECLADO_F02aa_L0+0, 1 
;QUADRO.c,277 :: 		if (F02aa > 1)
	MOVF        F02_LE_TECLADO_F02aa_L0+0, 0 
	SUBLW       1
	BTFSC       STATUS+0, 0 
	GOTO        L_F02_LE_TECLADO8
;QUADRO.c,279 :: 		F02aa = 0;
	CLRF        F02_LE_TECLADO_F02aa_L0+0 
;QUADRO.c,280 :: 		}
L_F02_LE_TECLADO8:
;QUADRO.c,281 :: 		delay_ms(2);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_F02_LE_TECLADO9:
	DECFSZ      R13, 1, 1
	BRA         L_F02_LE_TECLADO9
	DECFSZ      R12, 1, 1
	BRA         L_F02_LE_TECLADO9
	NOP
	NOP
;QUADRO.c,282 :: 		adcon0 = 0b00011001;
	MOVLW       25
	MOVWF       ADCON0+0 
;QUADRO.c,283 :: 		delay_ms(2);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_F02_LE_TECLADO10:
	DECFSZ      R13, 1, 1
	BRA         L_F02_LE_TECLADO10
	DECFSZ      R12, 1, 1
	BRA         L_F02_LE_TECLADO10
	NOP
	NOP
;QUADRO.c,284 :: 		GO_bit = 1;
	BSF         GO_bit+0, BitPos(GO_bit+0) 
;QUADRO.c,285 :: 		while (GO_bit);
L_F02_LE_TECLADO11:
	BTFSS       GO_bit+0, BitPos(GO_bit+0) 
	GOTO        L_F02_LE_TECLADO12
	GOTO        L_F02_LE_TECLADO11
L_F02_LE_TECLADO12:
;QUADRO.c,286 :: 		F02KeyAdc[0] = ADRESH;
	MOVF        ADRESH+0, 0 
	MOVWF       R5 
;QUADRO.c,287 :: 		adcon0 = 0b00010001;
	MOVLW       17
	MOVWF       ADCON0+0 
;QUADRO.c,288 :: 		delay_ms(2);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_F02_LE_TECLADO13:
	DECFSZ      R13, 1, 1
	BRA         L_F02_LE_TECLADO13
	DECFSZ      R12, 1, 1
	BRA         L_F02_LE_TECLADO13
	NOP
	NOP
;QUADRO.c,289 :: 		GO_bit = 1;
	BSF         GO_bit+0, BitPos(GO_bit+0) 
;QUADRO.c,290 :: 		while (GO_bit);
L_F02_LE_TECLADO14:
	BTFSS       GO_bit+0, BitPos(GO_bit+0) 
	GOTO        L_F02_LE_TECLADO15
	GOTO        L_F02_LE_TECLADO14
L_F02_LE_TECLADO15:
;QUADRO.c,291 :: 		F02KeyAdc[1] = ADRESH;
	MOVF        ADRESH+0, 0 
	MOVWF       R6 
;QUADRO.c,292 :: 		adcon0 = 0b00001001;
	MOVLW       9
	MOVWF       ADCON0+0 
;QUADRO.c,293 :: 		delay_ms(2);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_F02_LE_TECLADO16:
	DECFSZ      R13, 1, 1
	BRA         L_F02_LE_TECLADO16
	DECFSZ      R12, 1, 1
	BRA         L_F02_LE_TECLADO16
	NOP
	NOP
;QUADRO.c,294 :: 		GO_bit = 1;
	BSF         GO_bit+0, BitPos(GO_bit+0) 
;QUADRO.c,295 :: 		while (GO_bit);
L_F02_LE_TECLADO17:
	BTFSS       GO_bit+0, BitPos(GO_bit+0) 
	GOTO        L_F02_LE_TECLADO18
	GOTO        L_F02_LE_TECLADO17
L_F02_LE_TECLADO18:
;QUADRO.c,296 :: 		F02KeyAdc[2] = ADRESH;
	MOVF        ADRESH+0, 0 
	MOVWF       R7 
;QUADRO.c,297 :: 		adcon0 = 0b00000001;
	MOVLW       1
	MOVWF       ADCON0+0 
;QUADRO.c,298 :: 		delay_ms(2);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_F02_LE_TECLADO19:
	DECFSZ      R13, 1, 1
	BRA         L_F02_LE_TECLADO19
	DECFSZ      R12, 1, 1
	BRA         L_F02_LE_TECLADO19
	NOP
	NOP
;QUADRO.c,299 :: 		GO_bit = 1;
	BSF         GO_bit+0, BitPos(GO_bit+0) 
;QUADRO.c,300 :: 		while (GO_bit);
L_F02_LE_TECLADO20:
	BTFSS       GO_bit+0, BitPos(GO_bit+0) 
	GOTO        L_F02_LE_TECLADO21
	GOTO        L_F02_LE_TECLADO20
L_F02_LE_TECLADO21:
;QUADRO.c,301 :: 		F02KeyAdc[3] = ADRESH;
	MOVF        ADRESH+0, 0 
	MOVWF       R8 
;QUADRO.c,302 :: 		F02uu = 0;
	CLRF        R4 
;QUADRO.c,303 :: 		F02stgTeclaValida[F02aa]=tecla_nenhuma;//se nenhum valor for encontrado, ha situaCAo para igualar e sair do while
	MOVLW       F02_LE_TECLADO_F02stgTeclaValida_L0+0
	MOVWF       FSR1 
	MOVLW       hi_addr(F02_LE_TECLADO_F02stgTeclaValida_L0+0)
	MOVWF       FSR1H 
	MOVF        F02_LE_TECLADO_F02aa_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       70
	MOVWF       POSTINC1+0 
;QUADRO.c,304 :: 		for (F02ee = 0; F02ee != 4; F02ee++)
	CLRF        R3 
L_F02_LE_TECLADO22:
	MOVF        R3, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_F02_LE_TECLADO23
;QUADRO.c,306 :: 		if (F02KeyAdc[F02ee] > 40 & F02KeyAdc[F02ee] < 60)
	MOVLW       F02_LE_TECLADO_F02KeyAdc_L0+0
	MOVWF       FSR0 
	MOVLW       hi_addr(F02_LE_TECLADO_F02KeyAdc_L0+0)
	MOVWF       FSR0H 
	MOVF        R3, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	SUBLW       40
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       60
	SUBWF       R2, 0 
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F02_LE_TECLADO25
;QUADRO.c,308 :: 		F02stgTeclaValida[F02aa] = TeclaPressionadaF02[F02uu];
	MOVLW       F02_LE_TECLADO_F02stgTeclaValida_L0+0
	MOVWF       FSR1 
	MOVLW       hi_addr(F02_LE_TECLADO_F02stgTeclaValida_L0+0)
	MOVWF       FSR1H 
	MOVF        F02_LE_TECLADO_F02aa_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       F02_LE_TECLADO_TeclaPressionadaF02_L0+0
	MOVWF       FSR0 
	MOVLW       hi_addr(F02_LE_TECLADO_TeclaPressionadaF02_L0+0)
	MOVWF       FSR0H 
	MOVF        R4, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;QUADRO.c,309 :: 		}
L_F02_LE_TECLADO25:
;QUADRO.c,310 :: 		F02uu++;
	INCF        R4, 1 
;QUADRO.c,311 :: 		if (F02KeyAdc[F02ee] > 90 & F02KeyAdc[F02ee] < 110)
	MOVLW       F02_LE_TECLADO_F02KeyAdc_L0+0
	MOVWF       FSR0 
	MOVLW       hi_addr(F02_LE_TECLADO_F02KeyAdc_L0+0)
	MOVWF       FSR0H 
	MOVF        R3, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	SUBLW       90
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       110
	SUBWF       R2, 0 
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F02_LE_TECLADO26
;QUADRO.c,313 :: 		F02stgTeclaValida[F02aa] = TeclaPressionadaF02[F02uu];
	MOVLW       F02_LE_TECLADO_F02stgTeclaValida_L0+0
	MOVWF       FSR1 
	MOVLW       hi_addr(F02_LE_TECLADO_F02stgTeclaValida_L0+0)
	MOVWF       FSR1H 
	MOVF        F02_LE_TECLADO_F02aa_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       F02_LE_TECLADO_TeclaPressionadaF02_L0+0
	MOVWF       FSR0 
	MOVLW       hi_addr(F02_LE_TECLADO_TeclaPressionadaF02_L0+0)
	MOVWF       FSR0H 
	MOVF        R4, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;QUADRO.c,314 :: 		}
L_F02_LE_TECLADO26:
;QUADRO.c,315 :: 		F02uu++;
	INCF        R4, 1 
;QUADRO.c,316 :: 		if (F02KeyAdc[F02ee] > 140 & F02KeyAdc[F02ee] < 160)
	MOVLW       F02_LE_TECLADO_F02KeyAdc_L0+0
	MOVWF       FSR0 
	MOVLW       hi_addr(F02_LE_TECLADO_F02KeyAdc_L0+0)
	MOVWF       FSR0H 
	MOVF        R3, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	SUBLW       140
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       160
	SUBWF       R2, 0 
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F02_LE_TECLADO27
;QUADRO.c,318 :: 		F02stgTeclaValida[F02aa] = TeclaPressionadaF02[F02uu];
	MOVLW       F02_LE_TECLADO_F02stgTeclaValida_L0+0
	MOVWF       FSR1 
	MOVLW       hi_addr(F02_LE_TECLADO_F02stgTeclaValida_L0+0)
	MOVWF       FSR1H 
	MOVF        F02_LE_TECLADO_F02aa_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       F02_LE_TECLADO_TeclaPressionadaF02_L0+0
	MOVWF       FSR0 
	MOVLW       hi_addr(F02_LE_TECLADO_TeclaPressionadaF02_L0+0)
	MOVWF       FSR0H 
	MOVF        R4, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;QUADRO.c,319 :: 		}
L_F02_LE_TECLADO27:
;QUADRO.c,320 :: 		F02uu++;
	INCF        R4, 1 
;QUADRO.c,321 :: 		if (F02KeyAdc[F02ee] > 190 & F02KeyAdc[F02ee] < 210)
	MOVLW       F02_LE_TECLADO_F02KeyAdc_L0+0
	MOVWF       FSR0 
	MOVLW       hi_addr(F02_LE_TECLADO_F02KeyAdc_L0+0)
	MOVWF       FSR0H 
	MOVF        R3, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	SUBLW       190
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       210
	SUBWF       R2, 0 
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F02_LE_TECLADO28
;QUADRO.c,323 :: 		F02stgTeclaValida[F02aa] = TeclaPressionadaF02[F02uu];
	MOVLW       F02_LE_TECLADO_F02stgTeclaValida_L0+0
	MOVWF       FSR1 
	MOVLW       hi_addr(F02_LE_TECLADO_F02stgTeclaValida_L0+0)
	MOVWF       FSR1H 
	MOVF        F02_LE_TECLADO_F02aa_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       F02_LE_TECLADO_TeclaPressionadaF02_L0+0
	MOVWF       FSR0 
	MOVLW       hi_addr(F02_LE_TECLADO_TeclaPressionadaF02_L0+0)
	MOVWF       FSR0H 
	MOVF        R4, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;QUADRO.c,324 :: 		}
L_F02_LE_TECLADO28:
;QUADRO.c,325 :: 		F02uu++;
	INCF        R4, 1 
;QUADRO.c,304 :: 		for (F02ee = 0; F02ee != 4; F02ee++)
	INCF        R3, 1 
;QUADRO.c,326 :: 		}
	GOTO        L_F02_LE_TECLADO22
L_F02_LE_TECLADO23:
;QUADRO.c,327 :: 		}
	GOTO        L_F02_LE_TECLADO6
L_F02_LE_TECLADO7:
;QUADRO.c,328 :: 		if ((BitKeyAvaliar) & (F02stgTeclaValida[0] < tecla_nenhuma))
	MOVLW       128
	MOVWF       R1 
	MOVLW       128
	XORLW       0
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__F02_LE_TECLADO674
	MOVLW       70
	SUBWF       F02_LE_TECLADO_F02stgTeclaValida_L0+0, 0 
L__F02_LE_TECLADO674:
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R1 
	CLRF        R0 
	BTFSC       _BitKeyAvaliar+0, BitPos(_BitKeyAvaliar+0) 
	INCF        R0, 1 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F02_LE_TECLADO29
;QUADRO.c,330 :: 		BitKeyAvaliar = 0;
	BCF         _BitKeyAvaliar+0, BitPos(_BitKeyAvaliar+0) 
;QUADRO.c,331 :: 		GteclaPress = F02stgTeclaValida[0];
	MOVF        F02_LE_TECLADO_F02stgTeclaValida_L0+0, 0 
	MOVWF       _GteclaPress+0 
;QUADRO.c,332 :: 		}
L_F02_LE_TECLADO29:
;QUADRO.c,333 :: 		if (tecla_nenhuma == F02stgTeclaValida[0])
	MOVLW       0
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__F02_LE_TECLADO675
	MOVF        F02_LE_TECLADO_F02stgTeclaValida_L0+0, 0 
	XORLW       70
L__F02_LE_TECLADO675:
	BTFSS       STATUS+0, 2 
	GOTO        L_F02_LE_TECLADO30
;QUADRO.c,335 :: 		BitKeyAvaliar = 1;
	BSF         _BitKeyAvaliar+0, BitPos(_BitKeyAvaliar+0) 
;QUADRO.c,336 :: 		GteclaPress = tecla_nenhuma;
	MOVLW       70
	MOVWF       _GteclaPress+0 
;QUADRO.c,337 :: 		}
L_F02_LE_TECLADO30:
;QUADRO.c,339 :: 		switch (GloginState)
	GOTO        L_F02_LE_TECLADO31
;QUADRO.c,341 :: 		case def1PWDDESLOGADO:
L_F02_LE_TECLADO33:
;QUADRO.c,343 :: 		if (rb7_SOBE)
	BTFSS       RB7_bit+0, BitPos(RB7_bit+0) 
	GOTO        L_F02_LE_TECLADO34
;QUADRO.c,345 :: 		Tecla.Sobe = 0;
	BCF         _Tecla+0, 0 
;QUADRO.c,346 :: 		LastTecla.Sobe = 1;
	BSF         _LastTecla+0, 0 
;QUADRO.c,347 :: 		}
	GOTO        L_F02_LE_TECLADO35
L_F02_LE_TECLADO34:
;QUADRO.c,350 :: 		Tecla.Sobe = 1;//tecla está pressionada
	BSF         _Tecla+0, 0 
;QUADRO.c,351 :: 		}
L_F02_LE_TECLADO35:
;QUADRO.c,352 :: 		if (rb5_DESCE)
	BTFSS       RB5_bit+0, BitPos(RB5_bit+0) 
	GOTO        L_F02_LE_TECLADO36
;QUADRO.c,354 :: 		Tecla.Desce = 0;
	BCF         _Tecla+0, 1 
;QUADRO.c,355 :: 		LastTecla.Desce = 1;//bit é armado para poder posteriormente ser abilitado quando for apertado
	BSF         _LastTecla+0, 1 
;QUADRO.c,356 :: 		}
	GOTO        L_F02_LE_TECLADO37
L_F02_LE_TECLADO36:
;QUADRO.c,359 :: 		Tecla.Desce = 1;//tecla está pressionada
	BSF         _Tecla+0, 1 
;QUADRO.c,360 :: 		}
L_F02_LE_TECLADO37:
;QUADRO.c,361 :: 		if (rb4_NIVEL)
	BTFSS       RB4_bit+0, BitPos(RB4_bit+0) 
	GOTO        L_F02_LE_TECLADO38
;QUADRO.c,363 :: 		GprotNivela=0;
	CLRF        _GprotNivela+0 
;QUADRO.c,364 :: 		Tecla.Nivela = 0;
	BCF         _Tecla+0, 3 
;QUADRO.c,365 :: 		}
	GOTO        L_F02_LE_TECLADO39
L_F02_LE_TECLADO38:
;QUADRO.c,368 :: 		GprotNivela++;
	INCF        _GprotNivela+0, 1 
;QUADRO.c,369 :: 		if (GprotNivela<50)
	MOVLW       50
	SUBWF       _GprotNivela+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_F02_LE_TECLADO40
;QUADRO.c,371 :: 		Tecla.Nivela = 1;
	BSF         _Tecla+0, 3 
;QUADRO.c,372 :: 		}
	GOTO        L_F02_LE_TECLADO41
L_F02_LE_TECLADO40:
;QUADRO.c,375 :: 		GprotNivela=50;
	MOVLW       50
	MOVWF       _GprotNivela+0 
;QUADRO.c,376 :: 		Tecla.Nivela = 0;
	BCF         _Tecla+0, 3 
;QUADRO.c,377 :: 		}
L_F02_LE_TECLADO41:
;QUADRO.c,378 :: 		}
L_F02_LE_TECLADO39:
;QUADRO.c,379 :: 		break;
	GOTO        L_F02_LE_TECLADO32
;QUADRO.c,381 :: 		default:
L_F02_LE_TECLADO42:
;QUADRO.c,383 :: 		GstateELEVA = def1STOPPED;
	CLRF        _GstateELEVA+0 
;QUADRO.c,384 :: 		Tecla.Sobe = 0;
	BCF         _Tecla+0, 0 
;QUADRO.c,385 :: 		Tecla.Desce = 0;
	BCF         _Tecla+0, 1 
;QUADRO.c,386 :: 		Tecla.Nivela = 0;
	BCF         _Tecla+0, 3 
;QUADRO.c,387 :: 		break;
	GOTO        L_F02_LE_TECLADO32
;QUADRO.c,389 :: 		}
L_F02_LE_TECLADO31:
	MOVF        _GloginState+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_F02_LE_TECLADO33
	GOTO        L_F02_LE_TECLADO42
L_F02_LE_TECLADO32:
;QUADRO.c,391 :: 		if (rb6_PARA)
	BTFSS       RB6_bit+0, BitPos(RB6_bit+0) 
	GOTO        L_F02_LE_TECLADO43
;QUADRO.c,393 :: 		Tecla.Para = 0;
	BCF         _Tecla+0, 2 
;QUADRO.c,394 :: 		}
	GOTO        L_F02_LE_TECLADO44
L_F02_LE_TECLADO43:
;QUADRO.c,397 :: 		Tecla.Para = 1;//tecla está pressionada
	BSF         _Tecla+0, 2 
;QUADRO.c,398 :: 		}
L_F02_LE_TECLADO44:
;QUADRO.c,400 :: 		if (rb3_AUDIO)
	BTFSS       RB3_bit+0, BitPos(RB3_bit+0) 
	GOTO        L_F02_LE_TECLADO45
;QUADRO.c,402 :: 		Tecla.Audio = 0;
	BCF         _Tecla+0, 4 
;QUADRO.c,403 :: 		}
	GOTO        L_F02_LE_TECLADO46
L_F02_LE_TECLADO45:
;QUADRO.c,406 :: 		Tecla.Audio = 1;//tecla está pressionada
	BSF         _Tecla+0, 4 
;QUADRO.c,407 :: 		}
L_F02_LE_TECLADO46:
;QUADRO.c,409 :: 		if (rb2_IRate)
	BTFSS       RB2_bit+0, BitPos(RB2_bit+0) 
	GOTO        L_F02_LE_TECLADO47
;QUADRO.c,411 :: 		Tecla.IrAte = 0;
	BCF         _Tecla+0, 5 
;QUADRO.c,412 :: 		}
	GOTO        L_F02_LE_TECLADO48
L_F02_LE_TECLADO47:
;QUADRO.c,415 :: 		Tecla.IrAte = 1;//tecla está pressionada
	BSF         _Tecla+0, 5 
;QUADRO.c,416 :: 		}
L_F02_LE_TECLADO48:
;QUADRO.c,417 :: 		}
L_end_F02_LE_TECLADO:
	RETURN      0
; end of _F02_LE_TECLADO

_F03_UPDATE_DS1307:

;QUADRO.c,419 :: 		void F03_UPDATE_DS1307(void)
;QUADRO.c,425 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;QUADRO.c,426 :: 		I2C1_Wr(0xD0);
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;QUADRO.c,427 :: 		I2C1_Wr(0);
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;QUADRO.c,428 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;QUADRO.c,429 :: 		I2C1_Wr(0xD1);
	MOVLW       209
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;QUADRO.c,430 :: 		GF03segundos = I2C1_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _GF03segundos+0 
;QUADRO.c,431 :: 		GF03minutos = I2C1_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _GF03minutos+0 
;QUADRO.c,432 :: 		F03hora = I2C1_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       F03_UPDATE_DS1307_F03hora_L0+0 
;QUADRO.c,433 :: 		F03dia = I2C1_Rd(1);//semana
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       F03_UPDATE_DS1307_F03dia_L0+0 
;QUADRO.c,434 :: 		F03dia = I2C1_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       F03_UPDATE_DS1307_F03dia_L0+0 
;QUADRO.c,435 :: 		F03mes = I2C1_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       F03_UPDATE_DS1307_F03mes_L0+0 
;QUADRO.c,436 :: 		F03ano = I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       F03_UPDATE_DS1307_F03ano_L0+0 
;QUADRO.c,437 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;QUADRO.c,438 :: 		stgFormatedTime[0] = ((F03hora & 0x30) >> 4) + 48;
	MOVLW       48
	ANDWF       F03_UPDATE_DS1307_F03hora_L0+0, 0 
	MOVWF       _stgFormatedTime+0 
	RRCF        _stgFormatedTime+0, 1 
	BCF         _stgFormatedTime+0, 7 
	RRCF        _stgFormatedTime+0, 1 
	BCF         _stgFormatedTime+0, 7 
	RRCF        _stgFormatedTime+0, 1 
	BCF         _stgFormatedTime+0, 7 
	RRCF        _stgFormatedTime+0, 1 
	BCF         _stgFormatedTime+0, 7 
	MOVLW       48
	ADDWF       _stgFormatedTime+0, 1 
;QUADRO.c,439 :: 		stgFormatedTime[1] = (F03hora & 0x0f) + 48;
	MOVLW       15
	ANDWF       F03_UPDATE_DS1307_F03hora_L0+0, 0 
	MOVWF       _stgFormatedTime+1 
	MOVLW       48
	ADDWF       _stgFormatedTime+1, 1 
;QUADRO.c,440 :: 		stgFormatedTime[2] = ':';
	MOVLW       58
	MOVWF       _stgFormatedTime+2 
;QUADRO.c,441 :: 		stgFormatedTime[3] = ((GF03minutos & 0x70) >> 4) + 48;
	MOVLW       112
	ANDWF       _GF03minutos+0, 0 
	MOVWF       _stgFormatedTime+3 
	RRCF        _stgFormatedTime+3, 1 
	BCF         _stgFormatedTime+3, 7 
	RRCF        _stgFormatedTime+3, 1 
	BCF         _stgFormatedTime+3, 7 
	RRCF        _stgFormatedTime+3, 1 
	BCF         _stgFormatedTime+3, 7 
	RRCF        _stgFormatedTime+3, 1 
	BCF         _stgFormatedTime+3, 7 
	MOVLW       48
	ADDWF       _stgFormatedTime+3, 1 
;QUADRO.c,442 :: 		stgFormatedTime[4] = (GF03minutos & 0x0f) + 48;
	MOVLW       15
	ANDWF       _GF03minutos+0, 0 
	MOVWF       _stgFormatedTime+4 
	MOVLW       48
	ADDWF       _stgFormatedTime+4, 1 
;QUADRO.c,443 :: 		stgFormatedTime[5] = ':';
	MOVLW       58
	MOVWF       _stgFormatedTime+5 
;QUADRO.c,444 :: 		stgFormatedTime[6] = ((GF03segundos & 0x70) >> 4) + 48;
	MOVLW       112
	ANDWF       _GF03segundos+0, 0 
	MOVWF       _stgFormatedTime+6 
	RRCF        _stgFormatedTime+6, 1 
	BCF         _stgFormatedTime+6, 7 
	RRCF        _stgFormatedTime+6, 1 
	BCF         _stgFormatedTime+6, 7 
	RRCF        _stgFormatedTime+6, 1 
	BCF         _stgFormatedTime+6, 7 
	RRCF        _stgFormatedTime+6, 1 
	BCF         _stgFormatedTime+6, 7 
	MOVLW       48
	ADDWF       _stgFormatedTime+6, 1 
;QUADRO.c,445 :: 		stgFormatedTime[7] = (GF03segundos & 0x0f) + 48;
	MOVLW       15
	ANDWF       _GF03segundos+0, 0 
	MOVWF       _stgFormatedTime+7 
	MOVLW       48
	ADDWF       _stgFormatedTime+7, 1 
;QUADRO.c,446 :: 		stgFormatedDate[0] = ((F03dia & 0x30) >> 4) + 48;
	MOVLW       48
	ANDWF       F03_UPDATE_DS1307_F03dia_L0+0, 0 
	MOVWF       _stgFormatedDate+0 
	RRCF        _stgFormatedDate+0, 1 
	BCF         _stgFormatedDate+0, 7 
	RRCF        _stgFormatedDate+0, 1 
	BCF         _stgFormatedDate+0, 7 
	RRCF        _stgFormatedDate+0, 1 
	BCF         _stgFormatedDate+0, 7 
	RRCF        _stgFormatedDate+0, 1 
	BCF         _stgFormatedDate+0, 7 
	MOVLW       48
	ADDWF       _stgFormatedDate+0, 1 
;QUADRO.c,447 :: 		stgFormatedDate[1] = (F03dia & 0x0f) + 48;
	MOVLW       15
	ANDWF       F03_UPDATE_DS1307_F03dia_L0+0, 0 
	MOVWF       _stgFormatedDate+1 
	MOVLW       48
	ADDWF       _stgFormatedDate+1, 1 
;QUADRO.c,448 :: 		stgFormatedDate[2] = '/';
	MOVLW       47
	MOVWF       _stgFormatedDate+2 
;QUADRO.c,449 :: 		stgFormatedDate[3] = ((F03mes & 0xf0) >> 4) + 48;
	MOVLW       240
	ANDWF       F03_UPDATE_DS1307_F03mes_L0+0, 0 
	MOVWF       _stgFormatedDate+3 
	RRCF        _stgFormatedDate+3, 1 
	BCF         _stgFormatedDate+3, 7 
	RRCF        _stgFormatedDate+3, 1 
	BCF         _stgFormatedDate+3, 7 
	RRCF        _stgFormatedDate+3, 1 
	BCF         _stgFormatedDate+3, 7 
	RRCF        _stgFormatedDate+3, 1 
	BCF         _stgFormatedDate+3, 7 
	MOVLW       48
	ADDWF       _stgFormatedDate+3, 1 
;QUADRO.c,450 :: 		stgFormatedDate[4] = (F03mes & 0x0f) + 48;
	MOVLW       15
	ANDWF       F03_UPDATE_DS1307_F03mes_L0+0, 0 
	MOVWF       _stgFormatedDate+4 
	MOVLW       48
	ADDWF       _stgFormatedDate+4, 1 
;QUADRO.c,451 :: 		stgFormatedDate[5] = '/';
	MOVLW       47
	MOVWF       _stgFormatedDate+5 
;QUADRO.c,452 :: 		stgFormatedDate[6] = ((F03ano & 0xf0) >> 4) + 48;
	MOVLW       240
	ANDWF       F03_UPDATE_DS1307_F03ano_L0+0, 0 
	MOVWF       _stgFormatedDate+6 
	RRCF        _stgFormatedDate+6, 1 
	BCF         _stgFormatedDate+6, 7 
	RRCF        _stgFormatedDate+6, 1 
	BCF         _stgFormatedDate+6, 7 
	RRCF        _stgFormatedDate+6, 1 
	BCF         _stgFormatedDate+6, 7 
	RRCF        _stgFormatedDate+6, 1 
	BCF         _stgFormatedDate+6, 7 
	MOVLW       48
	ADDWF       _stgFormatedDate+6, 1 
;QUADRO.c,453 :: 		stgFormatedDate[7] = (F03ano & 0x0f) + 48;
	MOVLW       15
	ANDWF       F03_UPDATE_DS1307_F03ano_L0+0, 0 
	MOVWF       _stgFormatedDate+7 
	MOVLW       48
	ADDWF       _stgFormatedDate+7, 1 
;QUADRO.c,454 :: 		}
L_end_F03_UPDATE_DS1307:
	RETURN      0
; end of _F03_UPDATE_DS1307

_F04_ENCHE_CG_RAM:

;QUADRO.c,456 :: 		void F04_ENCHE_CG_RAM(void)//enche a cg ram do lcd//
;QUADRO.c,460 :: 		for (F04ee = 0; F04ee != 8; F04ee++)
	CLRF        F04_ENCHE_CG_RAM_F04ee_L0+0 
L_F04_ENCHE_CG_RAM49:
	MOVF        F04_ENCHE_CG_RAM_F04ee_L0+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_F04_ENCHE_CG_RAM50
;QUADRO.c,462 :: 		lcd_cmd(0x40 + (F04ee * 8));
	MOVF        F04_ENCHE_CG_RAM_F04ee_L0+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	ADDLW       64
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;QUADRO.c,463 :: 		for (F04aa = 0; F04aa != 8; F04aa++)
	CLRF        F04_ENCHE_CG_RAM_F04aa_L0+0 
L_F04_ENCHE_CG_RAM52:
	MOVF        F04_ENCHE_CG_RAM_F04aa_L0+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_F04_ENCHE_CG_RAM53
;QUADRO.c,465 :: 		lcd_chr_cp(charactes[F04ee][F04aa]);
	MOVLW       3
	MOVWF       R4 
	MOVF        F04_ENCHE_CG_RAM_F04ee_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        R4, 0 
L__F04_ENCHE_CG_RAM678:
	BZ          L__F04_ENCHE_CG_RAM679
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__F04_ENCHE_CG_RAM678
L__F04_ENCHE_CG_RAM679:
	MOVLW       _charactes+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_charactes+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(_charactes+0)
	ADDWFC      R2, 1 
	MOVF        F04_ENCHE_CG_RAM_F04aa_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_Lcd_Chr_CP_out_char+0
	CALL        _Lcd_Chr_CP+0, 0
;QUADRO.c,463 :: 		for (F04aa = 0; F04aa != 8; F04aa++)
	INCF        F04_ENCHE_CG_RAM_F04aa_L0+0, 1 
;QUADRO.c,466 :: 		}
	GOTO        L_F04_ENCHE_CG_RAM52
L_F04_ENCHE_CG_RAM53:
;QUADRO.c,460 :: 		for (F04ee = 0; F04ee != 8; F04ee++)
	INCF        F04_ENCHE_CG_RAM_F04ee_L0+0, 1 
;QUADRO.c,467 :: 		}
	GOTO        L_F04_ENCHE_CG_RAM49
L_F04_ENCHE_CG_RAM50:
;QUADRO.c,468 :: 		}
L_end_F04_ENCHE_CG_RAM:
	RETURN      0
; end of _F04_ENCHE_CG_RAM

_F05_UART_WRITE:

;QUADRO.c,470 :: 		void F05_UART_WRITE(char* Text)
;QUADRO.c,472 :: 		rc5_FALAR_OUVIR = 1; //rc5_FALAR_OUVIR at rc5_bit ;
	BSF         RC5_bit+0, BitPos(RC5_bit+0) 
;QUADRO.c,473 :: 		while(*Text)UART1_Write(*Text++);
L_F05_UART_WRITE55:
	MOVFF       FARG_F05_UART_WRITE_Text+0, FSR0
	MOVFF       FARG_F05_UART_WRITE_Text+1, FSR0H
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F05_UART_WRITE56
	MOVFF       FARG_F05_UART_WRITE_Text+0, FSR0
	MOVFF       FARG_F05_UART_WRITE_Text+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	INFSNZ      FARG_F05_UART_WRITE_Text+0, 1 
	INCF        FARG_F05_UART_WRITE_Text+1, 1 
	GOTO        L_F05_UART_WRITE55
L_F05_UART_WRITE56:
;QUADRO.c,474 :: 		delay_us(255);
	MOVLW       2
	MOVWF       R12, 0
	MOVLW       166
	MOVWF       R13, 0
L_F05_UART_WRITE57:
	DECFSZ      R13, 1, 1
	BRA         L_F05_UART_WRITE57
	DECFSZ      R12, 1, 1
	BRA         L_F05_UART_WRITE57
	NOP
	NOP
;QUADRO.c,475 :: 		delay_us(255);
	MOVLW       2
	MOVWF       R12, 0
	MOVLW       166
	MOVWF       R13, 0
L_F05_UART_WRITE58:
	DECFSZ      R13, 1, 1
	BRA         L_F05_UART_WRITE58
	DECFSZ      R12, 1, 1
	BRA         L_F05_UART_WRITE58
	NOP
	NOP
;QUADRO.c,476 :: 		RCREG=0;
	CLRF        RCREG+0 
;QUADRO.c,477 :: 		rcif_bit = 0;
	BCF         RCIF_bit+0, BitPos(RCIF_bit+0) 
;QUADRO.c,478 :: 		rc5_FALAR_OUVIR = 0; //rc5_FALAR_OUVIR at rc5_bit ;
	BCF         RC5_bit+0, BitPos(RC5_bit+0) 
;QUADRO.c,479 :: 		rcie_bit = 1;//liga int recepção
	BSF         RCIE_bit+0, BitPos(RCIE_bit+0) 
;QUADRO.c,480 :: 		delay_ms(3); //TEMPO PARA RX RECEBER DADOS
	MOVLW       20
	MOVWF       R12, 0
	MOVLW       121
	MOVWF       R13, 0
L_F05_UART_WRITE59:
	DECFSZ      R13, 1, 1
	BRA         L_F05_UART_WRITE59
	DECFSZ      R12, 1, 1
	BRA         L_F05_UART_WRITE59
	NOP
	NOP
;QUADRO.c,481 :: 		rcie_bit = 0;//desliga int recepção
	BCF         RCIE_bit+0, BitPos(RCIE_bit+0) 
;QUADRO.c,482 :: 		}
L_end_F05_UART_WRITE:
	RETURN      0
; end of _F05_UART_WRITE

_F06_VERIFICA_SITUACAO:

;QUADRO.c,484 :: 		void F06_VERIFICA_SITUACAO(void)
;QUADRO.c,486 :: 		unsigned short F06MaiorPlaca=0;
	CLRF        F06_VERIFICA_SITUACAO_F06MaiorPlaca_L0+0 
	CLRF        F06_VERIFICA_SITUACAO_F06audioIndex_L0+0 
	CLRF        F06_VERIFICA_SITUACAO_F06cancelaIndex_L0+0 
	MOVLW       255
	MOVWF       F06_VERIFICA_SITUACAO_F06stgAudio_L0+0 
	MOVLW       255
	MOVWF       F06_VERIFICA_SITUACAO_F06stgAudio_L0+1 
	MOVLW       255
	MOVWF       F06_VERIFICA_SITUACAO_F06stgAudio_L0+2 
	MOVLW       255
	MOVWF       F06_VERIFICA_SITUACAO_F06stgAudio_L0+3 
	MOVLW       255
	MOVWF       F06_VERIFICA_SITUACAO_F06stgCancela_L0+0 
	MOVLW       255
	MOVWF       F06_VERIFICA_SITUACAO_F06stgCancela_L0+1 
	MOVLW       255
	MOVWF       F06_VERIFICA_SITUACAO_F06stgCancela_L0+2 
	MOVLW       255
	MOVWF       F06_VERIFICA_SITUACAO_F06stgCancela_L0+3 
;QUADRO.c,497 :: 		tmr0ie_bit = 0;
	BCF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;QUADRO.c,498 :: 		tmr0if_bit = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;QUADRO.c,499 :: 		if (rb0_CABINE)//rb0_CABINE at rb0_bit ;
	BTFSS       RB0_bit+0, BitPos(RB0_bit+0) 
	GOTO        L_F06_VERIFICA_SITUACAO60
;QUADRO.c,501 :: 		BitCancelaCloseOpen = 1; //PORTA CABINE ABERTA
	BSF         _BitCancelaCloseOpen+0, BitPos(_BitCancelaCloseOpen+0) 
;QUADRO.c,502 :: 		GstateELEVA = def1STOPPED;
	CLRF        _GstateELEVA+0 
;QUADRO.c,503 :: 		}
	GOTO        L_F06_VERIFICA_SITUACAO61
L_F06_VERIFICA_SITUACAO60:
;QUADRO.c,506 :: 		BitCancelaCloseOpen = 0; //sinaliza como fechada
	BCF         _BitCancelaCloseOpen+0, BitPos(_BitCancelaCloseOpen+0) 
;QUADRO.c,507 :: 		}
L_F06_VERIFICA_SITUACAO61:
;QUADRO.c,508 :: 		BitStopUp = 0;
	BCF         _BitStopUp+0, BitPos(_BitStopUp+0) 
;QUADRO.c,509 :: 		BitStopDown = 0;
	BCF         _BitStopDown+0, BitPos(_BitStopDown+0) 
;QUADRO.c,510 :: 		GF94naoRESPONDE=0;
	CLRF        _GF94naoRESPONDE+0 
;QUADRO.c,511 :: 		GF94erroCancela=0;
	CLRF        _GF94erroCancela+0 
;QUADRO.c,512 :: 		GF94quatID=0;
	CLRF        _GF94quatID+0 
;QUADRO.c,513 :: 		BitNaoSobreEscrever=1;
	BSF         _BitNaoSobreEscrever+0, BitPos(_BitNaoSobreEscrever+0) 
;QUADRO.c,514 :: 		GF94erroIDcolado=0;
	CLRF        _GF94erroIDcolado+0 
;QUADRO.c,515 :: 		GF94erroIDcoladoLast=0;
	CLRF        _GF94erroIDcoladoLast+0 
;QUADRO.c,517 :: 		for (F06lasso = 0;F00_BIT_ON_OFF(F06lasso, _6Bit); F06lasso++)//dentro do for está a condição encerrar
	CLRF        F06_VERIFICA_SITUACAO_F06lasso_L0+0 
L_F06_VERIFICA_SITUACAO62:
	MOVF        F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	MOVWF       FARG_F00_BIT_ON_OFF_endereco+0 
	MOVLW       32
	MOVWF       FARG_F00_BIT_ON_OFF_campo+0 
	CALL        _F00_BIT_ON_OFF+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO63
;QUADRO.c,519 :: 		F06stg[0]=244;//inicio da transmissão
	MOVLW       244
	MOVWF       F06_VERIFICA_SITUACAO_F06stg_L0+0 
;QUADRO.c,520 :: 		F06stg[1] = F06lasso + 10;
	MOVLW       10
	ADDWF       F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       F06_VERIFICA_SITUACAO_F06stg_L0+1 
;QUADRO.c,521 :: 		if (GfaleAqui == F06stg[1])
	MOVF        _GfaleAqui+0, 0 
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO65
;QUADRO.c,523 :: 		F06stg[2]=0b00000001;//abrir audio
	MOVLW       1
	MOVWF       F06_VERIFICA_SITUACAO_F06stg_L0+2 
;QUADRO.c,524 :: 		}
	GOTO        L_F06_VERIFICA_SITUACAO66
L_F06_VERIFICA_SITUACAO65:
;QUADRO.c,527 :: 		F06stg[2] = 0b00000100;//para não ser vazio - zero para a transmissão
	MOVLW       4
	MOVWF       F06_VERIFICA_SITUACAO_F06stg_L0+2 
;QUADRO.c,528 :: 		}
L_F06_VERIFICA_SITUACAO66:
;QUADRO.c,529 :: 		F06stg[3]=F06stg[2]+F06stg[1];
	MOVF        F06_VERIFICA_SITUACAO_F06stg_L0+1, 0 
	ADDWF       F06_VERIFICA_SITUACAO_F06stg_L0+2, 0 
	MOVWF       F06_VERIFICA_SITUACAO_F06stg_L0+3 
;QUADRO.c,530 :: 		F06stg[4]=0;//fim da transmissão
	CLRF        F06_VERIFICA_SITUACAO_F06stg_L0+4 
;QUADRO.c,532 :: 		Bitindice=0;
	BCF         _Bitindice+0, BitPos(_Bitindice+0) 
;QUADRO.c,533 :: 		do
L_F06_VERIFICA_SITUACAO67:
;QUADRO.c,535 :: 		F05_UART_WRITE(F06stg);//enviar e receber situação dos sensores
	MOVLW       F06_VERIFICA_SITUACAO_F06stg_L0+0
	MOVWF       FARG_F05_UART_WRITE_Text+0 
	MOVLW       hi_addr(F06_VERIFICA_SITUACAO_F06stg_L0+0)
	MOVWF       FARG_F05_UART_WRITE_Text+1 
	CALL        _F05_UART_WRITE+0, 0
;QUADRO.c,536 :: 		stgMemorias[Bitindice][F06lasso]=GidCRC;
	CLRF        R3 
	BTFSC       _Bitindice+0, BitPos(_Bitindice+0) 
	INCF        R3, 1 
	MOVLW       5
	MOVWF       R2 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__F06_VERIFICA_SITUACAO682:
	BZ          L__F06_VERIFICA_SITUACAO683
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__F06_VERIFICA_SITUACAO682
L__F06_VERIFICA_SITUACAO683:
	MOVLW       _stgMemorias+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_stgMemorias+0)
	ADDWFC      R1, 1 
	MOVF        F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        _GidCRC+0, 0 
	MOVWF       POSTINC1+0 
;QUADRO.c,537 :: 		Bitindice=~Bitindice;
	BTG         _Bitindice+0, BitPos(_Bitindice+0) 
;QUADRO.c,539 :: 		while (stgMemorias[0][F06lasso]!=stgMemorias[1][F06lasso]);
	MOVLW       _stgMemorias+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_stgMemorias+0)
	MOVWF       FSR0H 
	MOVF        F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVLW       _stgMemorias+32
	MOVWF       FSR2 
	MOVLW       hi_addr(_stgMemorias+32)
	MOVWF       FSR2H 
	MOVF        F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	ADDWF       FSR2, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR2H, 1 
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO67
;QUADRO.c,541 :: 		if (GidRecebido == F06stg[1])//andar respondeu?
	MOVF        _GidRecebido+0, 0 
	XORWF       F06_VERIFICA_SITUACAO_F06stg_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO70
;QUADRO.c,543 :: 		F06MaiorPlaca = F06lasso; //vai guardar a maior placa a responder
	MOVF        F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	MOVWF       F06_VERIFICA_SITUACAO_F06MaiorPlaca_L0+0 
;QUADRO.c,545 :: 		if (F00_BIT_ON_OFF(F06lasso, _1Bit))//tecla um no menu jump [id]ignora sensor cancela?
	MOVF        F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	MOVWF       FARG_F00_BIT_ON_OFF_endereco+0 
	MOVLW       1
	MOVWF       FARG_F00_BIT_ON_OFF_campo+0 
	CALL        _F00_BIT_ON_OFF+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO71
;QUADRO.c,547 :: 		if (0b00000011 == (GidSensorRX&3))//ha cancela aberta
	MOVLW       3
	ANDWF       _GidSensorRX+0, 0 
	MOVWF       R1 
	MOVLW       3
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO72
;QUADRO.c,549 :: 		BitCancelaCloseOpen = 1;
	BSF         _BitCancelaCloseOpen+0, BitPos(_BitCancelaCloseOpen+0) 
;QUADRO.c,550 :: 		GstateELEVA = def1STOPPED;
	CLRF        _GstateELEVA+0 
;QUADRO.c,551 :: 		F06stgCancela[F06cancelaIndex] = F06lasso;//anota qual andar isso aconteceu
	MOVLW       F06_VERIFICA_SITUACAO_F06stgCancela_L0+0
	MOVWF       FSR1 
	MOVLW       hi_addr(F06_VERIFICA_SITUACAO_F06stgCancela_L0+0)
	MOVWF       FSR1H 
	MOVF        F06_VERIFICA_SITUACAO_F06cancelaIndex_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	MOVWF       POSTINC1+0 
;QUADRO.c,552 :: 		F06cancelaIndex++;
	INCF        F06_VERIFICA_SITUACAO_F06cancelaIndex_L0+0, 1 
;QUADRO.c,553 :: 		if (F06cancelaIndex > 3)//nAo deixa passar desse valor
	MOVF        F06_VERIFICA_SITUACAO_F06cancelaIndex_L0+0, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_F06_VERIFICA_SITUACAO73
;QUADRO.c,555 :: 		F06cancelaIndex = 3;
	MOVLW       3
	MOVWF       F06_VERIFICA_SITUACAO_F06cancelaIndex_L0+0 
;QUADRO.c,556 :: 		}
L_F06_VERIFICA_SITUACAO73:
;QUADRO.c,557 :: 		}
L_F06_VERIFICA_SITUACAO72:
;QUADRO.c,558 :: 		if (0b00000001 == (GidSensorRX&3))//NORMALMENTE, NÃO DEVE ISSO ACONTECER
	MOVLW       3
	ANDWF       _GidSensorRX+0, 0 
	MOVWF       R1 
	MOVLW       1
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO74
;QUADRO.c,560 :: 		GF94erroCancela=GidRecebido;
	MOVF        _GidRecebido+0, 0 
	MOVWF       _GF94erroCancela+0 
;QUADRO.c,561 :: 		}
L_F06_VERIFICA_SITUACAO74:
;QUADRO.c,562 :: 		if (0b00000010 == (GidSensorRX&3))//NORMALMENTE, NÃO DEVE ISSO ACONTECER
	MOVLW       3
	ANDWF       _GidSensorRX+0, 0 
	MOVWF       R1 
	MOVLW       2
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO75
;QUADRO.c,564 :: 		GF94erroCancela=GidRecebido;
	MOVF        _GidRecebido+0, 0 
	MOVWF       _GF94erroCancela+0 
;QUADRO.c,565 :: 		}
L_F06_VERIFICA_SITUACAO75:
;QUADRO.c,566 :: 		}
L_F06_VERIFICA_SITUACAO71:
;QUADRO.c,568 :: 		if (F00_BIT_ON_OFF(F06lasso, _2Bit))//tecla dois no menu jump [id]ignora audio
	MOVF        F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	MOVWF       FARG_F00_BIT_ON_OFF_endereco+0 
	MOVLW       2
	MOVWF       FARG_F00_BIT_ON_OFF_campo+0 
	CALL        _F00_BIT_ON_OFF+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO76
;QUADRO.c,570 :: 		if (GidSensorRX & _5Bit)//ha chamada de audio
	BTFSS       _GidSensorRX+0, 4 
	GOTO        L_F06_VERIFICA_SITUACAO77
;QUADRO.c,572 :: 		BitAudioOn = 1;
	BSF         _BitAudioOn+0, BitPos(_BitAudioOn+0) 
;QUADRO.c,573 :: 		F06stgAudio[F06audioIndex] = F06lasso;//vai inserindo na F06stgAudio onde houve chamada de audio
	MOVLW       F06_VERIFICA_SITUACAO_F06stgAudio_L0+0
	MOVWF       FSR1 
	MOVLW       hi_addr(F06_VERIFICA_SITUACAO_F06stgAudio_L0+0)
	MOVWF       FSR1H 
	MOVF        F06_VERIFICA_SITUACAO_F06audioIndex_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	MOVWF       POSTINC1+0 
;QUADRO.c,574 :: 		F06audioIndex++;
	INCF        F06_VERIFICA_SITUACAO_F06audioIndex_L0+0, 1 
;QUADRO.c,575 :: 		if (F06audioIndex > 3)//nAo deixa passar desse valor
	MOVF        F06_VERIFICA_SITUACAO_F06audioIndex_L0+0, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_F06_VERIFICA_SITUACAO78
;QUADRO.c,577 :: 		F06audioIndex = 3;
	MOVLW       3
	MOVWF       F06_VERIFICA_SITUACAO_F06audioIndex_L0+0 
;QUADRO.c,578 :: 		}
L_F06_VERIFICA_SITUACAO78:
;QUADRO.c,579 :: 		}
L_F06_VERIFICA_SITUACAO77:
;QUADRO.c,580 :: 		}
L_F06_VERIFICA_SITUACAO76:
;QUADRO.c,582 :: 		if (F00_BIT_ON_OFF(F06lasso, _3Bit))//tecla tres ignora sensor abaixo
	MOVF        F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	MOVWF       FARG_F00_BIT_ON_OFF_endereco+0 
	MOVLW       4
	MOVWF       FARG_F00_BIT_ON_OFF_campo+0 
	CALL        _F00_BIT_ON_OFF+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO79
;QUADRO.c,584 :: 		if (_3Bit == (GidSensorRX&12))//defSIMBABAIXO2
	MOVLW       12
	ANDWF       _GidSensorRX+0, 0 
	MOVWF       R1 
	MOVLW       0
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__F06_VERIFICA_SITUACAO684
	MOVF        R1, 0 
	XORLW       4
L__F06_VERIFICA_SITUACAO684:
	BTFSS       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO80
;QUADRO.c,586 :: 		GF94erroIDcolado=F06lasso;
	MOVF        F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	MOVWF       _GF94erroIDcolado+0 
;QUADRO.c,587 :: 		stgLcd1[0] = defSIMBABAIXO2;
	MOVLW       2
	MOVWF       _stgLcd1+0 
;QUADRO.c,588 :: 		GidOndeCabineEsta = F06lasso; //atualiza posiCAo do elevador
	MOVF        F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	MOVWF       _GidOndeCabineEsta+0 
;QUADRO.c,589 :: 		if (def2COMINGDOWN == GstateELEVA)//se estiver descendo
	MOVLW       2
	XORWF       _GstateELEVA+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO81
;QUADRO.c,591 :: 		if (0 == F06lasso)//fim de curso eletronico
	MOVLW       0
	XORWF       F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO82
;QUADRO.c,593 :: 		GstateELEVA = def1STOPPED; //PARA PORQUE ESTa NO FUNDO DO POCO
	CLRF        _GstateELEVA+0 
;QUADRO.c,594 :: 		}
L_F06_VERIFICA_SITUACAO82:
;QUADRO.c,595 :: 		if (BitPararAqui)
	BTFSS       _BitPararAqui+0, BitPos(_BitPararAqui+0) 
	GOTO        L_F06_VERIFICA_SITUACAO83
;QUADRO.c,597 :: 		if (GpareAqui>=GidOndeCabineEsta)
	MOVF        _GidOndeCabineEsta+0, 0 
	SUBWF       _GpareAqui+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_F06_VERIFICA_SITUACAO84
;QUADRO.c,599 :: 		GstateELEVA = def1STOPPED;
	CLRF        _GstateELEVA+0 
;QUADRO.c,600 :: 		GpareAqui=32;
	MOVLW       32
	MOVWF       _GpareAqui+0 
;QUADRO.c,601 :: 		BitPararAqui=0;
	BCF         _BitPararAqui+0, BitPos(_BitPararAqui+0) 
;QUADRO.c,602 :: 		}
L_F06_VERIFICA_SITUACAO84:
;QUADRO.c,603 :: 		}
L_F06_VERIFICA_SITUACAO83:
;QUADRO.c,604 :: 		}
L_F06_VERIFICA_SITUACAO81:
;QUADRO.c,605 :: 		if (0 == F06lasso)//fim de curso eletronico
	MOVLW       0
	XORWF       F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO85
;QUADRO.c,607 :: 		BitStopDown = 1;
	BSF         _BitStopDown+0, BitPos(_BitStopDown+0) 
;QUADRO.c,608 :: 		}
L_F06_VERIFICA_SITUACAO85:
;QUADRO.c,609 :: 		}
L_F06_VERIFICA_SITUACAO80:
;QUADRO.c,610 :: 		}
L_F06_VERIFICA_SITUACAO79:
;QUADRO.c,612 :: 		if (F00_BIT_ON_OFF(F06lasso, _4Bit))//tecla quatro ignora sensor acima
	MOVF        F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	MOVWF       FARG_F00_BIT_ON_OFF_endereco+0 
	MOVLW       8
	MOVWF       FARG_F00_BIT_ON_OFF_campo+0 
	CALL        _F00_BIT_ON_OFF+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO86
;QUADRO.c,614 :: 		if (_4Bit == (GidSensorRX&12))//defSIMBACIMA1
	MOVLW       12
	ANDWF       _GidSensorRX+0, 0 
	MOVWF       R1 
	MOVLW       0
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__F06_VERIFICA_SITUACAO685
	MOVF        R1, 0 
	XORLW       8
L__F06_VERIFICA_SITUACAO685:
	BTFSS       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO87
;QUADRO.c,616 :: 		GF94erroIDcolado=F06lasso;
	MOVF        F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	MOVWF       _GF94erroIDcolado+0 
;QUADRO.c,617 :: 		stgLcd1[0] = defSIMBACIMA1;
	MOVLW       1
	MOVWF       _stgLcd1+0 
;QUADRO.c,618 :: 		GidOndeCabineEsta = F06lasso; //atualiza posiCAo do elevador
	MOVF        F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	MOVWF       _GidOndeCabineEsta+0 
;QUADRO.c,619 :: 		if (GstateELEVA==def1COMINGUP)//se estiver subindo
	MOVF        _GstateELEVA+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO88
;QUADRO.c,621 :: 		if (GbiggerPID == F06lasso)//fim de curso eletronico
	MOVF        _GbiggerPID+0, 0 
	XORWF       F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO89
;QUADRO.c,623 :: 		GstateELEVA = def1STOPPED; //PARA PORQUE ESTa ACIMA DE TUDO
	CLRF        _GstateELEVA+0 
;QUADRO.c,624 :: 		}
L_F06_VERIFICA_SITUACAO89:
;QUADRO.c,625 :: 		if (BitPararAqui)
	BTFSS       _BitPararAqui+0, BitPos(_BitPararAqui+0) 
	GOTO        L_F06_VERIFICA_SITUACAO90
;QUADRO.c,627 :: 		if (GpareAqui<=GidOndeCabineEsta)
	MOVF        _GpareAqui+0, 0 
	SUBWF       _GidOndeCabineEsta+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_F06_VERIFICA_SITUACAO91
;QUADRO.c,629 :: 		GstateELEVA = def1STOPPED;
	CLRF        _GstateELEVA+0 
;QUADRO.c,630 :: 		GpareAqui=32;
	MOVLW       32
	MOVWF       _GpareAqui+0 
;QUADRO.c,631 :: 		BitPararAqui=0;
	BCF         _BitPararAqui+0, BitPos(_BitPararAqui+0) 
;QUADRO.c,632 :: 		}
L_F06_VERIFICA_SITUACAO91:
;QUADRO.c,633 :: 		}
L_F06_VERIFICA_SITUACAO90:
;QUADRO.c,634 :: 		}
L_F06_VERIFICA_SITUACAO88:
;QUADRO.c,635 :: 		if (GbiggerPID == F06lasso)//fim de curso eletronico
	MOVF        _GbiggerPID+0, 0 
	XORWF       F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO92
;QUADRO.c,637 :: 		BitStopUp = 1;
	BSF         _BitStopUp+0, BitPos(_BitStopUp+0) 
;QUADRO.c,638 :: 		}
L_F06_VERIFICA_SITUACAO92:
;QUADRO.c,639 :: 		}
L_F06_VERIFICA_SITUACAO87:
;QUADRO.c,640 :: 		}
L_F06_VERIFICA_SITUACAO86:
;QUADRO.c,642 :: 		if (F00_BIT_ON_OFF(F06lasso, _5Bit))//tecla cinco ignora nivelado
	MOVF        F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	MOVWF       FARG_F00_BIT_ON_OFF_endereco+0 
	MOVLW       16
	MOVWF       FARG_F00_BIT_ON_OFF_campo+0 
	CALL        _F00_BIT_ON_OFF+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO93
;QUADRO.c,644 :: 		if (0 == (GidSensorRX&12))//nivelado
	MOVLW       12
	ANDWF       _GidSensorRX+0, 0 
	MOVWF       R1 
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO94
;QUADRO.c,646 :: 		GF94erroIDcolado=F06lasso;
	MOVF        F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	MOVWF       _GF94erroIDcolado+0 
;QUADRO.c,647 :: 		stgLcd1[0] = defSIMBPLACE3;//SIMBOLO DE NIVELADO NA STRING DO LCD
	MOVLW       3
	MOVWF       _stgLcd1+0 
;QUADRO.c,648 :: 		GidOndeCabineEsta = F06lasso; //atualiza posiCAo do elevador
	MOVF        F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	MOVWF       _GidOndeCabineEsta+0 
;QUADRO.c,649 :: 		if (BitPararAqui)
	BTFSS       _BitPararAqui+0, BitPos(_BitPararAqui+0) 
	GOTO        L_F06_VERIFICA_SITUACAO95
;QUADRO.c,651 :: 		if (GstateELEVA==def1COMINGUP)//se estiver subindo
	MOVF        _GstateELEVA+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO96
;QUADRO.c,653 :: 		if (GpareAqui<=GidOndeCabineEsta)//está mais alto do que o ponto marcado?
	MOVF        _GpareAqui+0, 0 
	SUBWF       _GidOndeCabineEsta+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_F06_VERIFICA_SITUACAO97
;QUADRO.c,655 :: 		GstateELEVA = def1STOPPED;
	CLRF        _GstateELEVA+0 
;QUADRO.c,656 :: 		GpareAqui=32;
	MOVLW       32
	MOVWF       _GpareAqui+0 
;QUADRO.c,657 :: 		BitPararAqui=0;
	BCF         _BitPararAqui+0, BitPos(_BitPararAqui+0) 
;QUADRO.c,658 :: 		}
L_F06_VERIFICA_SITUACAO97:
;QUADRO.c,659 :: 		}
L_F06_VERIFICA_SITUACAO96:
;QUADRO.c,660 :: 		if (GstateELEVA==def2COMINGDOWN)//se estiver descendo
	MOVF        _GstateELEVA+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO98
;QUADRO.c,662 :: 		if (GpareAqui>=GidOndeCabineEsta)//está mais baixo do que o ponto marcado?
	MOVF        _GidOndeCabineEsta+0, 0 
	SUBWF       _GpareAqui+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_F06_VERIFICA_SITUACAO99
;QUADRO.c,664 :: 		GstateELEVA = def1STOPPED;
	CLRF        _GstateELEVA+0 
;QUADRO.c,665 :: 		GpareAqui = 32;
	MOVLW       32
	MOVWF       _GpareAqui+0 
;QUADRO.c,666 :: 		BitPararAqui = 0;
	BCF         _BitPararAqui+0, BitPos(_BitPararAqui+0) 
;QUADRO.c,667 :: 		}
L_F06_VERIFICA_SITUACAO99:
;QUADRO.c,668 :: 		}
L_F06_VERIFICA_SITUACAO98:
;QUADRO.c,669 :: 		}
L_F06_VERIFICA_SITUACAO95:
;QUADRO.c,670 :: 		if (GstateELEVA==def1COMINGUP)//se estiver subindo
	MOVF        _GstateELEVA+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO100
;QUADRO.c,672 :: 		if (GbiggerPID == F06lasso)//fim de curso eletronico
	MOVF        _GbiggerPID+0, 0 
	XORWF       F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO101
;QUADRO.c,674 :: 		GstateELEVA = def1STOPPED; //PARA PORQUE ESTa ACIMA DE TUDO
	CLRF        _GstateELEVA+0 
;QUADRO.c,675 :: 		}
L_F06_VERIFICA_SITUACAO101:
;QUADRO.c,676 :: 		}
L_F06_VERIFICA_SITUACAO100:
;QUADRO.c,677 :: 		if (GstateELEVA==def2COMINGDOWN)//se estiver descendo
	MOVF        _GstateELEVA+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO102
;QUADRO.c,679 :: 		if (0 == F06lasso)//fim de curso eletronico
	MOVLW       0
	XORWF       F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO103
;QUADRO.c,681 :: 		GstateELEVA = def1STOPPED; //PARA PORQUE ESTa NO FUNDO DO POCO
	CLRF        _GstateELEVA+0 
;QUADRO.c,682 :: 		}
L_F06_VERIFICA_SITUACAO103:
;QUADRO.c,683 :: 		}
L_F06_VERIFICA_SITUACAO102:
;QUADRO.c,684 :: 		}
L_F06_VERIFICA_SITUACAO94:
;QUADRO.c,685 :: 		}
L_F06_VERIFICA_SITUACAO93:
;QUADRO.c,686 :: 		if (GF94erroIDcolado != GF94erroIDcoladoLast)
	MOVF        _GF94erroIDcolado+0, 0 
	XORWF       _GF94erroIDcoladoLast+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO104
;QUADRO.c,688 :: 		GF94erroIDcoladoLast = GF94erroIDcolado;
	MOVF        _GF94erroIDcolado+0, 0 
	MOVWF       _GF94erroIDcoladoLast+0 
;QUADRO.c,689 :: 		GF94quatID++;
	INCF        _GF94quatID+0, 1 
;QUADRO.c,690 :: 		}
L_F06_VERIFICA_SITUACAO104:
;QUADRO.c,691 :: 		}
	GOTO        L_F06_VERIFICA_SITUACAO105
L_F06_VERIFICA_SITUACAO70:
;QUADRO.c,695 :: 		if (BitNaoSobreEscrever)
	BTFSS       _BitNaoSobreEscrever+0, BitPos(_BitNaoSobreEscrever+0) 
	GOTO        L_F06_VERIFICA_SITUACAO106
;QUADRO.c,697 :: 		GF94naoRESPONDE = F06stg[1];
	MOVF        F06_VERIFICA_SITUACAO_F06stg_L0+1, 0 
	MOVWF       _GF94naoRESPONDE+0 
;QUADRO.c,698 :: 		BitNaoSobreEscrever = 0;
	BCF         _BitNaoSobreEscrever+0, BitPos(_BitNaoSobreEscrever+0) 
;QUADRO.c,699 :: 		}
L_F06_VERIFICA_SITUACAO106:
;QUADRO.c,700 :: 		if (F00_BIT_ON_OFF(defPAG1, _1Bit))//PARA TUDO quando não responde alguma placa de andar?
	MOVLW       96
	MOVWF       FARG_F00_BIT_ON_OFF_endereco+0 
	MOVLW       1
	MOVWF       FARG_F00_BIT_ON_OFF_campo+0 
	CALL        _F00_BIT_ON_OFF+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO107
;QUADRO.c,702 :: 		GstateELEVA = def1STOPPED;
	CLRF        _GstateELEVA+0 
;QUADRO.c,703 :: 		break;
	GOTO        L_F06_VERIFICA_SITUACAO63
;QUADRO.c,704 :: 		}
L_F06_VERIFICA_SITUACAO107:
;QUADRO.c,705 :: 		}
L_F06_VERIFICA_SITUACAO105:
;QUADRO.c,517 :: 		for (F06lasso = 0;F00_BIT_ON_OFF(F06lasso, _6Bit); F06lasso++)//dentro do for está a condição encerrar
	INCF        F06_VERIFICA_SITUACAO_F06lasso_L0+0, 1 
;QUADRO.c,706 :: 		}
	GOTO        L_F06_VERIFICA_SITUACAO62
L_F06_VERIFICA_SITUACAO63:
;QUADRO.c,708 :: 		F06ee = GidOndeCabineEsta * 2;
	MOVF        _GidOndeCabineEsta+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       F06_VERIFICA_SITUACAO_F06ee_L0+0 
;QUADRO.c,709 :: 		F06par = EEPROM_Read(F06ee+32);
	MOVLW       32
	ADDWF       R0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       F06_VERIFICA_SITUACAO_F06par_L0+0 
;QUADRO.c,710 :: 		F06impar = EEPROM_Read(F06ee+33);
	MOVLW       33
	ADDWF       F06_VERIFICA_SITUACAO_F06ee_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       F06_VERIFICA_SITUACAO_F06impar_L0+0 
;QUADRO.c,711 :: 		Gunidade7SEG = Num_Let_7Se[F06par];
	MOVLW       _Num_Let_7Se+0
	ADDWF       F06_VERIFICA_SITUACAO_F06par_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_7Se+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_7Se+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _Gunidade7SEG+0
;QUADRO.c,712 :: 		Gdezena7SEG = Num_Let_7Se[F06impar];
	MOVLW       _Num_Let_7Se+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_7Se+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_7Se+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _Gdezena7SEG+0
;QUADRO.c,713 :: 		stgLcd1[1] = Num_Let_LCD[F06par];//será isso necessário?
	MOVLW       _Num_Let_LCD+0
	ADDWF       F06_VERIFICA_SITUACAO_F06par_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _stgLcd1+1
;QUADRO.c,714 :: 		stgLcd1[2] = Num_Let_LCD[F06impar];//será isso necessário?
	MOVLW       _Num_Let_LCD+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _stgLcd1+2
;QUADRO.c,716 :: 		if ((Tecla.Audio) & (0 == BitAudioOn))//tecla audio e sem chamada ativa
	BTFSC       _BitAudioOn+0, BitPos(_BitAudioOn+0) 
	GOTO        L__F06_VERIFICA_SITUACAO686
	BSF         4056, 0 
	GOTO        L__F06_VERIFICA_SITUACAO687
L__F06_VERIFICA_SITUACAO686:
	BCF         4056, 0 
L__F06_VERIFICA_SITUACAO687:
	BTFSS       _Tecla+0, 4 
	GOTO        L__F06_VERIFICA_SITUACAO688
	BTFSS       4056, 0 
	GOTO        L__F06_VERIFICA_SITUACAO688
	BSF         R4, 0 
	GOTO        L__F06_VERIFICA_SITUACAO689
L__F06_VERIFICA_SITUACAO688:
	BCF         R4, 0 
L__F06_VERIFICA_SITUACAO689:
	BTFSS       R4, 0 
	GOTO        L_F06_VERIFICA_SITUACAO108
;QUADRO.c,718 :: 		GfaleAqui = GidOndeCabineEsta+10;
	MOVLW       10
	ADDWF       _GidOndeCabineEsta+0, 0 
	MOVWF       _GfaleAqui+0 
;QUADRO.c,719 :: 		Tecla.Audio = 0;
	BCF         _Tecla+0, 4 
;QUADRO.c,720 :: 		}
	GOTO        L_F06_VERIFICA_SITUACAO109
L_F06_VERIFICA_SITUACAO108:
;QUADRO.c,723 :: 		GfaleAqui = 42;
	MOVLW       42
	MOVWF       _GfaleAqui+0 
;QUADRO.c,724 :: 		}
L_F06_VERIFICA_SITUACAO109:
;QUADRO.c,726 :: 		if (BitCancelaCloseOpen)//ha cancela aberta
	BTFSS       _BitCancelaCloseOpen+0, BitPos(_BitCancelaCloseOpen+0) 
	GOTO        L_F06_VERIFICA_SITUACAO110
;QUADRO.c,728 :: 		stgLcd2[0] = defSIMBCANCELA;
	MOVLW       221
	MOVWF       _stgLcd2+0 
;QUADRO.c,729 :: 		if (rb0_CABINE)//rb0_CABINE at rb0_bit
	BTFSS       RB0_bit+0, BitPos(RB0_bit+0) 
	GOTO        L_F06_VERIFICA_SITUACAO111
;QUADRO.c,731 :: 		stgLcd2[1] = '.';
	MOVLW       46
	MOVWF       _stgLcd2+1 
;QUADRO.c,732 :: 		if (BitInverter)
	BTFSS       _BitInverter+0, BitPos(_BitInverter+0) 
	GOTO        L_F06_VERIFICA_SITUACAO112
;QUADRO.c,734 :: 		stgLcd2[2] = 'C';
	MOVLW       67
	MOVWF       _stgLcd2+2 
;QUADRO.c,735 :: 		stgLcd2[3] = 'a';
	MOVLW       97
	MOVWF       _stgLcd2+3 
;QUADRO.c,736 :: 		stgLcd2[4] = 'b';
	MOVLW       98
	MOVWF       _stgLcd2+4 
;QUADRO.c,737 :: 		stgLcd2[5] = 'i';
	MOVLW       105
	MOVWF       _stgLcd2+5 
;QUADRO.c,738 :: 		stgLcd2[6] = 'n';
	MOVLW       110
	MOVWF       _stgLcd2+6 
;QUADRO.c,739 :: 		stgLcd2[7] = 'e';
	MOVLW       101
	MOVWF       _stgLcd2+7 
;QUADRO.c,740 :: 		}
	GOTO        L_F06_VERIFICA_SITUACAO113
L_F06_VERIFICA_SITUACAO112:
;QUADRO.c,743 :: 		stgLcd2[2] = 'A';
	MOVLW       65
	MOVWF       _stgLcd2+2 
;QUADRO.c,744 :: 		stgLcd2[3] = 'b';
	MOVLW       98
	MOVWF       _stgLcd2+3 
;QUADRO.c,745 :: 		stgLcd2[4] = 'e';
	MOVLW       101
	MOVWF       _stgLcd2+4 
;QUADRO.c,746 :: 		stgLcd2[5] = 'r';
	MOVLW       114
	MOVWF       _stgLcd2+5 
;QUADRO.c,747 :: 		stgLcd2[6] = 't';
	MOVLW       116
	MOVWF       _stgLcd2+6 
;QUADRO.c,748 :: 		stgLcd2[7] = 'a';
	MOVLW       97
	MOVWF       _stgLcd2+7 
;QUADRO.c,749 :: 		}
L_F06_VERIFICA_SITUACAO113:
;QUADRO.c,750 :: 		F06oo = 8;
	MOVLW       8
	MOVWF       F06_VERIFICA_SITUACAO_F06oo_L0+0 
;QUADRO.c,751 :: 		}
	GOTO        L_F06_VERIFICA_SITUACAO114
L_F06_VERIFICA_SITUACAO111:
;QUADRO.c,754 :: 		F06oo = 1;
	MOVLW       1
	MOVWF       F06_VERIFICA_SITUACAO_F06oo_L0+0 
;QUADRO.c,755 :: 		}
L_F06_VERIFICA_SITUACAO114:
;QUADRO.c,756 :: 		for (F06lasso = 0;(F06stgCancela[F06lasso] != 255) && (F06oo<13);F06lasso++)//vai colocar no LCD os lugares onde há cancela aberta
	CLRF        F06_VERIFICA_SITUACAO_F06lasso_L0+0 
L_F06_VERIFICA_SITUACAO115:
	MOVLW       F06_VERIFICA_SITUACAO_F06stgCancela_L0+0
	MOVWF       FSR0 
	MOVLW       hi_addr(F06_VERIFICA_SITUACAO_F06stgCancela_L0+0)
	MOVWF       FSR0H 
	MOVF        F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO116
	MOVLW       13
	SUBWF       F06_VERIFICA_SITUACAO_F06oo_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_F06_VERIFICA_SITUACAO116
L__F06_VERIFICA_SITUACAO666:
;QUADRO.c,758 :: 		F06ee = F06stgCancela[F06lasso] * 2;
	MOVLW       F06_VERIFICA_SITUACAO_F06stgCancela_L0+0
	MOVWF       FSR0 
	MOVLW       hi_addr(F06_VERIFICA_SITUACAO_F06stgCancela_L0+0)
	MOVWF       FSR0H 
	MOVF        F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       F06_VERIFICA_SITUACAO_F06ee_L0+0 
;QUADRO.c,759 :: 		F06par = EEPROM_Read(F06ee+32);
	MOVLW       32
	ADDWF       R0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       F06_VERIFICA_SITUACAO_F06par_L0+0 
;QUADRO.c,760 :: 		F06impar = EEPROM_Read(F06ee+33);
	MOVLW       33
	ADDWF       F06_VERIFICA_SITUACAO_F06ee_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       F06_VERIFICA_SITUACAO_F06impar_L0+0 
;QUADRO.c,761 :: 		stgLcd2[F06oo] = '.';
	MOVLW       _stgLcd2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	MOVWF       FSR1H 
	MOVF        F06_VERIFICA_SITUACAO_F06oo_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       46
	MOVWF       POSTINC1+0 
;QUADRO.c,762 :: 		stgLcd2[F06oo + 1] = Num_Let_LCD[F06par];
	MOVF        F06_VERIFICA_SITUACAO_F06oo_L0+0, 0 
	ADDLW       1
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _stgLcd2+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       _Num_Let_LCD+0
	ADDWF       F06_VERIFICA_SITUACAO_F06par_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;QUADRO.c,763 :: 		stgLcd2[F06oo + 2] = Num_Let_LCD[F06impar];
	MOVLW       2
	ADDWF       F06_VERIFICA_SITUACAO_F06oo_L0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _stgLcd2+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       _Num_Let_LCD+0
	ADDWF       F06_VERIFICA_SITUACAO_F06impar_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;QUADRO.c,764 :: 		F06oo = F06oo + 3;
	MOVLW       3
	ADDWF       F06_VERIFICA_SITUACAO_F06oo_L0+0, 1 
;QUADRO.c,756 :: 		for (F06lasso = 0;(F06stgCancela[F06lasso] != 255) && (F06oo<13);F06lasso++)//vai colocar no LCD os lugares onde há cancela aberta
	INCF        F06_VERIFICA_SITUACAO_F06lasso_L0+0, 1 
;QUADRO.c,765 :: 		}
	GOTO        L_F06_VERIFICA_SITUACAO115
L_F06_VERIFICA_SITUACAO116:
;QUADRO.c,766 :: 		}
L_F06_VERIFICA_SITUACAO110:
;QUADRO.c,768 :: 		switch (GstateELEVA)//vai escrever no lcd o que isso implica
	GOTO        L_F06_VERIFICA_SITUACAO120
;QUADRO.c,770 :: 		case def1STOPPED:
L_F06_VERIFICA_SITUACAO122:
;QUADRO.c,772 :: 		if (!BitCancelaCloseOpen)
	BTFSC       _BitCancelaCloseOpen+0, BitPos(_BitCancelaCloseOpen+0) 
	GOTO        L_F06_VERIFICA_SITUACAO123
;QUADRO.c,774 :: 		stgLcd2[0] = 'O';
	MOVLW       79
	MOVWF       _stgLcd2+0 
;QUADRO.c,775 :: 		stgLcd2[1] = 'K';
	MOVLW       75
	MOVWF       _stgLcd2+1 
;QUADRO.c,776 :: 		if (BitStopUp)
	BTFSS       _BitStopUp+0, BitPos(_BitStopUp+0) 
	GOTO        L_F06_VERIFICA_SITUACAO124
;QUADRO.c,778 :: 		stgLcd2[2] = defSIMBNAOSOBE;
	MOVLW       186
	MOVWF       _stgLcd2+2 
;QUADRO.c,779 :: 		}
L_F06_VERIFICA_SITUACAO124:
;QUADRO.c,780 :: 		if (BitStopDown)
	BTFSS       _BitStopDown+0, BitPos(_BitStopDown+0) 
	GOTO        L_F06_VERIFICA_SITUACAO125
;QUADRO.c,782 :: 		stgLcd2[2] = defSIMBNAODESCE;
	MOVLW       185
	MOVWF       _stgLcd2+2 
;QUADRO.c,783 :: 		}
L_F06_VERIFICA_SITUACAO125:
;QUADRO.c,784 :: 		}
L_F06_VERIFICA_SITUACAO123:
;QUADRO.c,785 :: 		BitPararAquiOnce = 1;
	BSF         _BitPararAquiOnce+0, BitPos(_BitPararAquiOnce+0) 
;QUADRO.c,786 :: 		break;
	GOTO        L_F06_VERIFICA_SITUACAO121
;QUADRO.c,788 :: 		case def1COMINGUP:
L_F06_VERIFICA_SITUACAO126:
;QUADRO.c,790 :: 		stgLcd2[0] = defSIMBSUBINDO;
	MOVLW       179
	MOVWF       _stgLcd2+0 
;QUADRO.c,791 :: 		stgLcd2[1] = 'S';
	MOVLW       83
	MOVWF       _stgLcd2+1 
;QUADRO.c,792 :: 		stgLcd2[2] = 'o';
	MOVLW       111
	MOVWF       _stgLcd2+2 
;QUADRO.c,793 :: 		stgLcd2[3] = 'b';
	MOVLW       98
	MOVWF       _stgLcd2+3 
;QUADRO.c,794 :: 		stgLcd2[4] = 'e';
	MOVLW       101
	MOVWF       _stgLcd2+4 
;QUADRO.c,795 :: 		if (GidOndeCabineEstaVA != GidOndeCabineEsta)
	MOVF        _GidOndeCabineEstaVA+0, 0 
	XORWF       _GidOndeCabineEsta+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO127
;QUADRO.c,797 :: 		if (GidOndeCabineEstaVA != GidOndeCabineEsta-1)//chegou numa parada diferente
	DECF        _GidOndeCabineEsta+0, 0 
	MOVWF       R1 
	CLRF        R2 
	MOVLW       0
	SUBWFB      R2, 1 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__F06_VERIFICA_SITUACAO690
	MOVF        R1, 0 
	XORWF       _GidOndeCabineEstaVA+0, 0 
L__F06_VERIFICA_SITUACAO690:
	BTFSC       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO128
;QUADRO.c,799 :: 		BitErroIPD = 1;
	BSF         _BitErroIPD+0, BitPos(_BitErroIPD+0) 
;QUADRO.c,800 :: 		GerroIPD = GidOndeCabineEstaVA+1;
	MOVF        _GidOndeCabineEstaVA+0, 0 
	ADDLW       1
	MOVWF       _GerroIPD+0 
;QUADRO.c,801 :: 		}
L_F06_VERIFICA_SITUACAO128:
;QUADRO.c,802 :: 		}
L_F06_VERIFICA_SITUACAO127:
;QUADRO.c,803 :: 		break;
	GOTO        L_F06_VERIFICA_SITUACAO121
;QUADRO.c,805 :: 		case def2COMINGDOWN:
L_F06_VERIFICA_SITUACAO129:
;QUADRO.c,807 :: 		stgLcd2[0] = defSIMBDESCENDO;
	MOVLW       180
	MOVWF       _stgLcd2+0 
;QUADRO.c,808 :: 		stgLcd2[1] = 'D';
	MOVLW       68
	MOVWF       _stgLcd2+1 
;QUADRO.c,809 :: 		stgLcd2[2] = 'e';
	MOVLW       101
	MOVWF       _stgLcd2+2 
;QUADRO.c,810 :: 		stgLcd2[3] = 's';
	MOVLW       115
	MOVWF       _stgLcd2+3 
;QUADRO.c,811 :: 		stgLcd2[4] = 'c';
	MOVLW       99
	MOVWF       _stgLcd2+4 
;QUADRO.c,812 :: 		stgLcd2[5] = 'e';
	MOVLW       101
	MOVWF       _stgLcd2+5 
;QUADRO.c,813 :: 		if (GidOndeCabineEstaVA != GidOndeCabineEsta)
	MOVF        _GidOndeCabineEstaVA+0, 0 
	XORWF       _GidOndeCabineEsta+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO130
;QUADRO.c,815 :: 		if (GidOndeCabineEstaVA != GidOndeCabineEsta+1)
	MOVF        _GidOndeCabineEsta+0, 0 
	ADDLW       1
	MOVWF       R1 
	CLRF        R2 
	MOVLW       0
	ADDWFC      R2, 1 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__F06_VERIFICA_SITUACAO691
	MOVF        R1, 0 
	XORWF       _GidOndeCabineEstaVA+0, 0 
L__F06_VERIFICA_SITUACAO691:
	BTFSC       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO131
;QUADRO.c,817 :: 		BitErroIPD = 1;
	BSF         _BitErroIPD+0, BitPos(_BitErroIPD+0) 
;QUADRO.c,818 :: 		GerroIPD = GidOndeCabineEstaVA-1;
	DECF        _GidOndeCabineEstaVA+0, 0 
	MOVWF       _GerroIPD+0 
;QUADRO.c,819 :: 		}
L_F06_VERIFICA_SITUACAO131:
;QUADRO.c,820 :: 		}
L_F06_VERIFICA_SITUACAO130:
;QUADRO.c,821 :: 		GidOndeCabineEstaVA = GidOndeCabineEsta;
	MOVF        _GidOndeCabineEsta+0, 0 
	MOVWF       _GidOndeCabineEstaVA+0 
;QUADRO.c,822 :: 		break;
	GOTO        L_F06_VERIFICA_SITUACAO121
;QUADRO.c,824 :: 		case defLEVELING4:
L_F06_VERIFICA_SITUACAO132:
;QUADRO.c,826 :: 		stgLcd2[0] = defSIMBLEVELING;
	MOVLW       187
	MOVWF       _stgLcd2+0 
;QUADRO.c,827 :: 		stgLcd2[1] = 'N';
	MOVLW       78
	MOVWF       _stgLcd2+1 
;QUADRO.c,828 :: 		stgLcd2[2] = 'i';
	MOVLW       105
	MOVWF       _stgLcd2+2 
;QUADRO.c,829 :: 		stgLcd2[3] = 'v';
	MOVLW       118
	MOVWF       _stgLcd2+3 
;QUADRO.c,830 :: 		stgLcd2[4] = 'e';
	MOVLW       101
	MOVWF       _stgLcd2+4 
;QUADRO.c,831 :: 		stgLcd2[5] = 'l';
	MOVLW       108
	MOVWF       _stgLcd2+5 
;QUADRO.c,832 :: 		stgLcd2[6] = 'a';
	MOVLW       97
	MOVWF       _stgLcd2+6 
;QUADRO.c,833 :: 		GstateELEVA = def1STOPPED;//NAO PODE TRAVAR
	CLRF        _GstateELEVA+0 
;QUADRO.c,834 :: 		if (GidOndeCabineEstaVA != GidOndeCabineEsta)//chegou numa parada diferente
	MOVF        _GidOndeCabineEstaVA+0, 0 
	XORWF       _GidOndeCabineEsta+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO133
;QUADRO.c,836 :: 		if (GidOndeCabineEstaVA != GidOndeCabineEsta+1)
	MOVF        _GidOndeCabineEsta+0, 0 
	ADDLW       1
	MOVWF       R1 
	CLRF        R2 
	MOVLW       0
	ADDWFC      R2, 1 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__F06_VERIFICA_SITUACAO692
	MOVF        R1, 0 
	XORWF       _GidOndeCabineEstaVA+0, 0 
L__F06_VERIFICA_SITUACAO692:
	BTFSC       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO134
;QUADRO.c,838 :: 		BitErroIPD = 1;
	BSF         _BitErroIPD+0, BitPos(_BitErroIPD+0) 
;QUADRO.c,839 :: 		GerroIPD = GidOndeCabineEstaVA-1;
	DECF        _GidOndeCabineEstaVA+0, 0 
	MOVWF       _GerroIPD+0 
;QUADRO.c,840 :: 		}
L_F06_VERIFICA_SITUACAO134:
;QUADRO.c,841 :: 		}
L_F06_VERIFICA_SITUACAO133:
;QUADRO.c,842 :: 		break;
	GOTO        L_F06_VERIFICA_SITUACAO121
;QUADRO.c,844 :: 		}
L_F06_VERIFICA_SITUACAO120:
	MOVF        _GstateELEVA+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO122
	MOVF        _GstateELEVA+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO126
	MOVF        _GstateELEVA+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO129
	MOVF        _GstateELEVA+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO132
L_F06_VERIFICA_SITUACAO121:
;QUADRO.c,845 :: 		GidOndeCabineEstaVA = GidOndeCabineEsta;
	MOVF        _GidOndeCabineEsta+0, 0 
	MOVWF       _GidOndeCabineEstaVA+0 
;QUADRO.c,847 :: 		if (GpareAqui < 32)
	MOVLW       32
	SUBWF       _GpareAqui+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_F06_VERIFICA_SITUACAO135
;QUADRO.c,849 :: 		if (BitInverter)
	BTFSS       _BitInverter+0, BitPos(_BitInverter+0) 
	GOTO        L_F06_VERIFICA_SITUACAO136
;QUADRO.c,851 :: 		if (GpareAqui>GidOndeCabineEsta)
	MOVF        _GpareAqui+0, 0 
	SUBWF       _GidOndeCabineEsta+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_F06_VERIFICA_SITUACAO137
;QUADRO.c,853 :: 		stgLcd2[6] =  defSIMBSUBINDO;//MAIS TARDE FAZER TECLAS PISCAREM
	MOVLW       179
	MOVWF       _stgLcd2+6 
;QUADRO.c,854 :: 		}
L_F06_VERIFICA_SITUACAO137:
;QUADRO.c,855 :: 		if (GpareAqui<GidOndeCabineEsta)
	MOVF        _GidOndeCabineEsta+0, 0 
	SUBWF       _GpareAqui+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_F06_VERIFICA_SITUACAO138
;QUADRO.c,857 :: 		stgLcd2[6] = defSIMBDESCENDO;
	MOVLW       180
	MOVWF       _stgLcd2+6 
;QUADRO.c,858 :: 		}
L_F06_VERIFICA_SITUACAO138:
;QUADRO.c,859 :: 		}
L_F06_VERIFICA_SITUACAO136:
;QUADRO.c,860 :: 		stgLcd2[7] = 'I';
	MOVLW       73
	MOVWF       _stgLcd2+7 
;QUADRO.c,861 :: 		stgLcd2[8] = 'r';
	MOVLW       114
	MOVWF       _stgLcd2+8 
;QUADRO.c,862 :: 		stgLcd2[9] = ' ';
	MOVLW       32
	MOVWF       _stgLcd2+9 
;QUADRO.c,863 :: 		stgLcd2[10] = 'A';
	MOVLW       65
	MOVWF       _stgLcd2+10 
;QUADRO.c,864 :: 		stgLcd2[11] = 't';
	MOVLW       116
	MOVWF       _stgLcd2+11 
;QUADRO.c,865 :: 		stgLcd2[12] = defSIMBeh;
	MOVLW       150
	MOVWF       _stgLcd2+12 
;QUADRO.c,866 :: 		stgLcd2[13] = ':';
	MOVLW       58
	MOVWF       _stgLcd2+13 
;QUADRO.c,867 :: 		F06ee = GpareAqui * 2;
	MOVF        _GpareAqui+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       F06_VERIFICA_SITUACAO_F06ee_L0+0 
;QUADRO.c,868 :: 		F06par = EEPROM_Read(F06ee+32);
	MOVLW       32
	ADDWF       R0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       F06_VERIFICA_SITUACAO_F06par_L0+0 
;QUADRO.c,869 :: 		F06impar = EEPROM_Read(F06ee+33);
	MOVLW       33
	ADDWF       F06_VERIFICA_SITUACAO_F06ee_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       F06_VERIFICA_SITUACAO_F06impar_L0+0 
;QUADRO.c,870 :: 		stgLcd2[14] = Num_Let_LCD[F06par];
	MOVLW       _Num_Let_LCD+0
	ADDWF       F06_VERIFICA_SITUACAO_F06par_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _stgLcd2+14
;QUADRO.c,871 :: 		stgLcd2[15] = Num_Let_LCD[F06impar];
	MOVLW       _Num_Let_LCD+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _stgLcd2+15
;QUADRO.c,872 :: 		}
L_F06_VERIFICA_SITUACAO135:
;QUADRO.c,873 :: 		if (BitAudioOn)//ha audio aberto
	BTFSS       _BitAudioOn+0, BitPos(_BitAudioOn+0) 
	GOTO        L_F06_VERIFICA_SITUACAO139
;QUADRO.c,875 :: 		stgLcd1[4] = defSIMBAUDIO;
	MOVLW       244
	MOVWF       _stgLcd1+4 
;QUADRO.c,876 :: 		F06oo = 5;
	MOVLW       5
	MOVWF       F06_VERIFICA_SITUACAO_F06oo_L0+0 
;QUADRO.c,877 :: 		for (F06lasso = 0;(F06stgAudio[F06lasso] != 255) && (F06oo<13); F06lasso++)//vai colocar no LCD os lugares onde há cancela aberta
	CLRF        F06_VERIFICA_SITUACAO_F06lasso_L0+0 
L_F06_VERIFICA_SITUACAO140:
	MOVLW       F06_VERIFICA_SITUACAO_F06stgAudio_L0+0
	MOVWF       FSR0 
	MOVLW       hi_addr(F06_VERIFICA_SITUACAO_F06stgAudio_L0+0)
	MOVWF       FSR0H 
	MOVF        F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO141
	MOVLW       13
	SUBWF       F06_VERIFICA_SITUACAO_F06oo_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_F06_VERIFICA_SITUACAO141
L__F06_VERIFICA_SITUACAO665:
;QUADRO.c,879 :: 		F06ee = F06stgAudio[F06lasso] * 2;
	MOVLW       F06_VERIFICA_SITUACAO_F06stgAudio_L0+0
	MOVWF       FSR0 
	MOVLW       hi_addr(F06_VERIFICA_SITUACAO_F06stgAudio_L0+0)
	MOVWF       FSR0H 
	MOVF        F06_VERIFICA_SITUACAO_F06lasso_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       F06_VERIFICA_SITUACAO_F06ee_L0+0 
;QUADRO.c,880 :: 		F06par = EEPROM_Read(F06ee+32);
	MOVLW       32
	ADDWF       R0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       F06_VERIFICA_SITUACAO_F06par_L0+0 
;QUADRO.c,881 :: 		F06impar = EEPROM_Read(F06ee+33);
	MOVLW       33
	ADDWF       F06_VERIFICA_SITUACAO_F06ee_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       F06_VERIFICA_SITUACAO_F06impar_L0+0 
;QUADRO.c,882 :: 		stgLcd1[F06oo] = '.';
	MOVLW       _stgLcd1+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd1+0)
	MOVWF       FSR1H 
	MOVF        F06_VERIFICA_SITUACAO_F06oo_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       46
	MOVWF       POSTINC1+0 
;QUADRO.c,883 :: 		stgLcd1[F06oo + 1] = Num_Let_LCD[F06par];
	MOVF        F06_VERIFICA_SITUACAO_F06oo_L0+0, 0 
	ADDLW       1
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _stgLcd1+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd1+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       _Num_Let_LCD+0
	ADDWF       F06_VERIFICA_SITUACAO_F06par_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;QUADRO.c,884 :: 		stgLcd1[F06oo + 2] = Num_Let_LCD[F06impar];
	MOVLW       2
	ADDWF       F06_VERIFICA_SITUACAO_F06oo_L0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _stgLcd1+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd1+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       _Num_Let_LCD+0
	ADDWF       F06_VERIFICA_SITUACAO_F06impar_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;QUADRO.c,885 :: 		F06oo += 3;
	MOVLW       3
	ADDWF       F06_VERIFICA_SITUACAO_F06oo_L0+0, 1 
;QUADRO.c,877 :: 		for (F06lasso = 0;(F06stgAudio[F06lasso] != 255) && (F06oo<13); F06lasso++)//vai colocar no LCD os lugares onde há cancela aberta
	INCF        F06_VERIFICA_SITUACAO_F06lasso_L0+0, 1 
;QUADRO.c,886 :: 		}
	GOTO        L_F06_VERIFICA_SITUACAO140
L_F06_VERIFICA_SITUACAO141:
;QUADRO.c,887 :: 		}
L_F06_VERIFICA_SITUACAO139:
;QUADRO.c,888 :: 		if (F00_BIT_ON_OFF(defPAG1, _3Bit))//MOSTRA OCULTA RELÓGIO CALENDÁRIO
	MOVLW       96
	MOVWF       FARG_F00_BIT_ON_OFF_endereco+0 
	MOVLW       4
	MOVWF       FARG_F00_BIT_ON_OFF_campo+0 
	CALL        _F00_BIT_ON_OFF+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO145
;QUADRO.c,890 :: 		if (0 == BitAudioOn)
	BTFSC       _BitAudioOn+0, BitPos(_BitAudioOn+0) 
	GOTO        L_F06_VERIFICA_SITUACAO146
;QUADRO.c,892 :: 		for (F06oo = 0; F06oo != 8; F06oo++)
	CLRF        F06_VERIFICA_SITUACAO_F06oo_L0+0 
L_F06_VERIFICA_SITUACAO147:
	MOVF        F06_VERIFICA_SITUACAO_F06oo_L0+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO148
;QUADRO.c,894 :: 		stgLcd1[F06oo+8]=stgFormatedTime[F06oo];	//mostra hora se não houver chamda de audio
	MOVLW       8
	ADDWF       F06_VERIFICA_SITUACAO_F06oo_L0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _stgLcd1+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd1+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       _stgFormatedTime+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_stgFormatedTime+0)
	MOVWF       FSR0H 
	MOVF        F06_VERIFICA_SITUACAO_F06oo_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;QUADRO.c,892 :: 		for (F06oo = 0; F06oo != 8; F06oo++)
	INCF        F06_VERIFICA_SITUACAO_F06oo_L0+0, 1 
;QUADRO.c,895 :: 		}
	GOTO        L_F06_VERIFICA_SITUACAO147
L_F06_VERIFICA_SITUACAO148:
;QUADRO.c,896 :: 		}
L_F06_VERIFICA_SITUACAO146:
;QUADRO.c,897 :: 		if (GstateELEVA == def1STOPPED)//precisa estar parado
	MOVF        _GstateELEVA+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO150
;QUADRO.c,899 :: 		if ((0 == BitCancelaCloseOpen) && (GpareAqui==32))//cancela fechadas
	BTFSC       _BitCancelaCloseOpen+0, BitPos(_BitCancelaCloseOpen+0) 
	GOTO        L_F06_VERIFICA_SITUACAO153
	MOVF        _GpareAqui+0, 0 
	XORLW       32
	BTFSS       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO153
L__F06_VERIFICA_SITUACAO664:
;QUADRO.c,901 :: 		for (F06oo = 0; F06oo != 8; F06oo++)
	CLRF        F06_VERIFICA_SITUACAO_F06oo_L0+0 
L_F06_VERIFICA_SITUACAO154:
	MOVF        F06_VERIFICA_SITUACAO_F06oo_L0+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_F06_VERIFICA_SITUACAO155
;QUADRO.c,903 :: 		stgLcd2[F06oo+8]=stgFormatedDate[F06oo];	//mostra a data se tudo estiver ok
	MOVLW       8
	ADDWF       F06_VERIFICA_SITUACAO_F06oo_L0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _stgLcd2+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       _stgFormatedDate+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_stgFormatedDate+0)
	MOVWF       FSR0H 
	MOVF        F06_VERIFICA_SITUACAO_F06oo_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;QUADRO.c,901 :: 		for (F06oo = 0; F06oo != 8; F06oo++)
	INCF        F06_VERIFICA_SITUACAO_F06oo_L0+0, 1 
;QUADRO.c,904 :: 		}
	GOTO        L_F06_VERIFICA_SITUACAO154
L_F06_VERIFICA_SITUACAO155:
;QUADRO.c,905 :: 		}
L_F06_VERIFICA_SITUACAO153:
;QUADRO.c,906 :: 		}
L_F06_VERIFICA_SITUACAO150:
;QUADRO.c,907 :: 		}
L_F06_VERIFICA_SITUACAO145:
;QUADRO.c,909 :: 		if (rb1_FIM_INFERIOR)//rd0_FIM_SUPERIOR at rd0_bit
	BTFSS       RB1_bit+0, BitPos(RB1_bit+0) 
	GOTO        L_F06_VERIFICA_SITUACAO157
;QUADRO.c,911 :: 		stgLcd2[0] = defSIMBNAODESCE;
	MOVLW       185
	MOVWF       _stgLcd2+0 
;QUADRO.c,912 :: 		if (BitInverter)
	BTFSS       _BitInverter+0, BitPos(_BitInverter+0) 
	GOTO        L_F06_VERIFICA_SITUACAO158
;QUADRO.c,914 :: 		stgLcd2[1] = 	'F';
	MOVLW       70
	MOVWF       _stgLcd2+1 
;QUADRO.c,915 :: 		stgLcd2[2] = 	'i';
	MOVLW       105
	MOVWF       _stgLcd2+2 
;QUADRO.c,916 :: 		stgLcd2[3] = 	'm';
	MOVLW       109
	MOVWF       _stgLcd2+3 
;QUADRO.c,917 :: 		stgLcd2[4] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd2+4 
;QUADRO.c,918 :: 		stgLcd2[5] = 	'C';
	MOVLW       67
	MOVWF       _stgLcd2+5 
;QUADRO.c,919 :: 		stgLcd2[6] = 	'u';
	MOVLW       117
	MOVWF       _stgLcd2+6 
;QUADRO.c,920 :: 		stgLcd2[7] = 	'r';
	MOVLW       114
	MOVWF       _stgLcd2+7 
;QUADRO.c,921 :: 		stgLcd2[8] = 	's';
	MOVLW       115
	MOVWF       _stgLcd2+8 
;QUADRO.c,922 :: 		stgLcd2[9] = 	'o';
	MOVLW       111
	MOVWF       _stgLcd2+9 
;QUADRO.c,923 :: 		stgLcd2[10] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd2+10 
;QUADRO.c,924 :: 		stgLcd2[11] = 	'F';
	MOVLW       70
	MOVWF       _stgLcd2+11 
;QUADRO.c,925 :: 		stgLcd2[12] = 	'u';
	MOVLW       117
	MOVWF       _stgLcd2+12 
;QUADRO.c,926 :: 		stgLcd2[13] = 	'n';
	MOVLW       110
	MOVWF       _stgLcd2+13 
;QUADRO.c,927 :: 		stgLcd2[14] = 	'd';
	MOVLW       100
	MOVWF       _stgLcd2+14 
;QUADRO.c,928 :: 		stgLcd2[15] = 	'o';
	MOVLW       111
	MOVWF       _stgLcd2+15 
;QUADRO.c,929 :: 		}
	GOTO        L_F06_VERIFICA_SITUACAO159
L_F06_VERIFICA_SITUACAO158:
;QUADRO.c,932 :: 		stgLcd2[1] = 	'L';
	MOVLW       76
	MOVWF       _stgLcd2+1 
;QUADRO.c,933 :: 		stgLcd2[2] = 	'i';
	MOVLW       105
	MOVWF       _stgLcd2+2 
;QUADRO.c,934 :: 		stgLcd2[3] = 	'm';
	MOVLW       109
	MOVWF       _stgLcd2+3 
;QUADRO.c,935 :: 		stgLcd2[4] = 	'i';
	MOVLW       105
	MOVWF       _stgLcd2+4 
;QUADRO.c,936 :: 		stgLcd2[5] = 	't';
	MOVLW       116
	MOVWF       _stgLcd2+5 
;QUADRO.c,937 :: 		stgLcd2[6] = 	'e';
	MOVLW       101
	MOVWF       _stgLcd2+6 
;QUADRO.c,938 :: 		stgLcd2[7] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd2+7 
;QUADRO.c,939 :: 		stgLcd2[8] = 	'I';
	MOVLW       73
	MOVWF       _stgLcd2+8 
;QUADRO.c,940 :: 		stgLcd2[9] = 	'n';
	MOVLW       110
	MOVWF       _stgLcd2+9 
;QUADRO.c,941 :: 		stgLcd2[10] = 	'f';
	MOVLW       102
	MOVWF       _stgLcd2+10 
;QUADRO.c,942 :: 		stgLcd2[11] = 	'e';
	MOVLW       101
	MOVWF       _stgLcd2+11 
;QUADRO.c,943 :: 		stgLcd2[12] = 	'r';
	MOVLW       114
	MOVWF       _stgLcd2+12 
;QUADRO.c,944 :: 		stgLcd2[13] = 	'i';
	MOVLW       105
	MOVWF       _stgLcd2+13 
;QUADRO.c,945 :: 		stgLcd2[14] = 	'o';
	MOVLW       111
	MOVWF       _stgLcd2+14 
;QUADRO.c,946 :: 		stgLcd2[15] = 	'r';
	MOVLW       114
	MOVWF       _stgLcd2+15 
;QUADRO.c,947 :: 		}
L_F06_VERIFICA_SITUACAO159:
;QUADRO.c,948 :: 		}
L_F06_VERIFICA_SITUACAO157:
;QUADRO.c,950 :: 		if (rd0_FIM_SUPERIOR)//rd0_FIM_SUPERIOR at rd0_bit
	BTFSS       RD0_bit+0, BitPos(RD0_bit+0) 
	GOTO        L_F06_VERIFICA_SITUACAO160
;QUADRO.c,952 :: 		stgLcd2[0] = defSIMBNAOSOBE;
	MOVLW       186
	MOVWF       _stgLcd2+0 
;QUADRO.c,953 :: 		if (BitInverter)
	BTFSS       _BitInverter+0, BitPos(_BitInverter+0) 
	GOTO        L_F06_VERIFICA_SITUACAO161
;QUADRO.c,955 :: 		stgLcd2[1] = 	'F';
	MOVLW       70
	MOVWF       _stgLcd2+1 
;QUADRO.c,956 :: 		stgLcd2[2] = 	'i';
	MOVLW       105
	MOVWF       _stgLcd2+2 
;QUADRO.c,957 :: 		stgLcd2[3] = 	'm';
	MOVLW       109
	MOVWF       _stgLcd2+3 
;QUADRO.c,958 :: 		stgLcd2[4] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd2+4 
;QUADRO.c,959 :: 		stgLcd2[5] = 	'C';
	MOVLW       67
	MOVWF       _stgLcd2+5 
;QUADRO.c,960 :: 		stgLcd2[6] = 	'u';
	MOVLW       117
	MOVWF       _stgLcd2+6 
;QUADRO.c,961 :: 		stgLcd2[7] = 	'r';
	MOVLW       114
	MOVWF       _stgLcd2+7 
;QUADRO.c,962 :: 		stgLcd2[8] = 	's';
	MOVLW       115
	MOVWF       _stgLcd2+8 
;QUADRO.c,963 :: 		stgLcd2[9] = 	'o';
	MOVLW       111
	MOVWF       _stgLcd2+9 
;QUADRO.c,964 :: 		stgLcd2[10] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd2+10 
;QUADRO.c,965 :: 		stgLcd2[11] = 	'T';
	MOVLW       84
	MOVWF       _stgLcd2+11 
;QUADRO.c,966 :: 		stgLcd2[12] = 	'o';
	MOVLW       111
	MOVWF       _stgLcd2+12 
;QUADRO.c,967 :: 		stgLcd2[13] = 	'p';
	MOVLW       112
	MOVWF       _stgLcd2+13 
;QUADRO.c,968 :: 		stgLcd2[14] = 	'o';
	MOVLW       111
	MOVWF       _stgLcd2+14 
;QUADRO.c,969 :: 		stgLcd2[15] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd2+15 
;QUADRO.c,970 :: 		}
	GOTO        L_F06_VERIFICA_SITUACAO162
L_F06_VERIFICA_SITUACAO161:
;QUADRO.c,973 :: 		stgLcd2[1] = 	'L';
	MOVLW       76
	MOVWF       _stgLcd2+1 
;QUADRO.c,974 :: 		stgLcd2[2] = 	'i';
	MOVLW       105
	MOVWF       _stgLcd2+2 
;QUADRO.c,975 :: 		stgLcd2[3] = 	'm';
	MOVLW       109
	MOVWF       _stgLcd2+3 
;QUADRO.c,976 :: 		stgLcd2[4] = 	'i';
	MOVLW       105
	MOVWF       _stgLcd2+4 
;QUADRO.c,977 :: 		stgLcd2[5] = 	't';
	MOVLW       116
	MOVWF       _stgLcd2+5 
;QUADRO.c,978 :: 		stgLcd2[6] = 	'e';
	MOVLW       101
	MOVWF       _stgLcd2+6 
;QUADRO.c,979 :: 		stgLcd2[7] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd2+7 
;QUADRO.c,980 :: 		stgLcd2[8] = 	'S';
	MOVLW       83
	MOVWF       _stgLcd2+8 
;QUADRO.c,981 :: 		stgLcd2[9] = 	'u';
	MOVLW       117
	MOVWF       _stgLcd2+9 
;QUADRO.c,982 :: 		stgLcd2[10] = 	'p';
	MOVLW       112
	MOVWF       _stgLcd2+10 
;QUADRO.c,983 :: 		stgLcd2[11] = 	'e';
	MOVLW       101
	MOVWF       _stgLcd2+11 
;QUADRO.c,984 :: 		stgLcd2[12] = 	'r';
	MOVLW       114
	MOVWF       _stgLcd2+12 
;QUADRO.c,985 :: 		stgLcd2[13] = 	'i';
	MOVLW       105
	MOVWF       _stgLcd2+13 
;QUADRO.c,986 :: 		stgLcd2[14] = 	'o';
	MOVLW       111
	MOVWF       _stgLcd2+14 
;QUADRO.c,987 :: 		stgLcd2[15] = 	'r';
	MOVLW       114
	MOVWF       _stgLcd2+15 
;QUADRO.c,988 :: 		}
L_F06_VERIFICA_SITUACAO162:
;QUADRO.c,989 :: 		}
L_F06_VERIFICA_SITUACAO160:
;QUADRO.c,990 :: 		GbiggerPID = F06MaiorPlaca;
	MOVF        F06_VERIFICA_SITUACAO_F06MaiorPlaca_L0+0, 0 
	MOVWF       _GbiggerPID+0 
;QUADRO.c,991 :: 		tmr0ie_bit = 1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;QUADRO.c,992 :: 		BitAtualizarLcd = 1;
	BSF         _BitAtualizarLcd+0, BitPos(_BitAtualizarLcd+0) 
;QUADRO.c,993 :: 		}
L_end_F06_VERIFICA_SITUACAO:
	RETURN      0
; end of _F06_VERIFICA_SITUACAO

_F07_CONFIGURA_SISTEMA:

;QUADRO.c,995 :: 		void F07_CONFIGURA_SISTEMA(unsigned short como)
;QUADRO.c,998 :: 		if (0 == RCON.B3)
	BTFSC       RCON+0, 3 
	GOTO        L_F07_CONFIGURA_SISTEMA163
;QUADRO.c,1000 :: 		como = 1;
	MOVLW       1
	MOVWF       FARG_F07_CONFIGURA_SISTEMA_como+0 
;QUADRO.c,1001 :: 		}
L_F07_CONFIGURA_SISTEMA163:
;QUADRO.c,1002 :: 		switch (como)
	GOTO        L_F07_CONFIGURA_SISTEMA164
;QUADRO.c,1004 :: 		case 0:
L_F07_CONFIGURA_SISTEMA166:
;QUADRO.c,1005 :: 		trisd = _1Bit;
	MOVLW       1
	MOVWF       TRISD+0 
;QUADRO.c,1006 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;QUADRO.c,1007 :: 		lcd_cmd(_lcd_clear); // clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;QUADRO.c,1008 :: 		lcd_cmd(_lcd_cursor_off); // cursor?
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;QUADRO.c,1010 :: 		Lcd_Out(defLCDLINHA1, 1, "alex");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_QUADRO+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_QUADRO+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;QUADRO.c,1011 :: 		delay_ms(500);
	MOVLW       13
	MOVWF       R11, 0
	MOVLW       175
	MOVWF       R12, 0
	MOVLW       182
	MOVWF       R13, 0
L_F07_CONFIGURA_SISTEMA167:
	DECFSZ      R13, 1, 1
	BRA         L_F07_CONFIGURA_SISTEMA167
	DECFSZ      R12, 1, 1
	BRA         L_F07_CONFIGURA_SISTEMA167
	DECFSZ      R11, 1, 1
	BRA         L_F07_CONFIGURA_SISTEMA167
	NOP
;QUADRO.c,1012 :: 		Lcd_Out(defLCDLINHA2, 1, "henrique");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_QUADRO+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_QUADRO+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;QUADRO.c,1013 :: 		delay_ms(500);
	MOVLW       13
	MOVWF       R11, 0
	MOVLW       175
	MOVWF       R12, 0
	MOVLW       182
	MOVWF       R13, 0
L_F07_CONFIGURA_SISTEMA168:
	DECFSZ      R13, 1, 1
	BRA         L_F07_CONFIGURA_SISTEMA168
	DECFSZ      R12, 1, 1
	BRA         L_F07_CONFIGURA_SISTEMA168
	DECFSZ      R11, 1, 1
	BRA         L_F07_CONFIGURA_SISTEMA168
	NOP
;QUADRO.c,1014 :: 		lcd_cmd(_lcd_clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;QUADRO.c,1015 :: 		BitErroCRC = 0;
	BCF         _BitErroCRC+0, BitPos(_BitErroCRC+0) 
;QUADRO.c,1016 :: 		BitErroIPD = 0;
	BCF         _BitErroIPD+0, BitPos(_BitErroIPD+0) 
;QUADRO.c,1019 :: 		case 1:
L_F07_CONFIGURA_SISTEMA169:
;QUADRO.c,1021 :: 		GalgumERRO = 0;
	CLRF        _GalgumERRO+0 
;QUADRO.c,1022 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_F07_CONFIGURA_SISTEMA170:
	DECFSZ      R13, 1, 1
	BRA         L_F07_CONFIGURA_SISTEMA170
	DECFSZ      R12, 1, 1
	BRA         L_F07_CONFIGURA_SISTEMA170
	DECFSZ      R11, 1, 1
	BRA         L_F07_CONFIGURA_SISTEMA170
	NOP
	NOP
;QUADRO.c,1023 :: 		gie_bit = 0;
	BCF         GIE_bit+0, BitPos(GIE_bit+0) 
;QUADRO.c,1024 :: 		ADIE_bit = 0;
	BCF         ADIE_bit+0, BitPos(ADIE_bit+0) 
;QUADRO.c,1025 :: 		BCLIE_bit = 0;
	BCF         BCLIE_bit+0, BitPos(BCLIE_bit+0) 
;QUADRO.c,1026 :: 		CCP1IE_bit = 0;
	BCF         CCP1IE_bit+0, BitPos(CCP1IE_bit+0) 
;QUADRO.c,1027 :: 		CCP2IE_bit = 0;
	BCF         CCP2IE_bit+0, BitPos(CCP2IE_bit+0) 
;QUADRO.c,1028 :: 		EEIE_bit = 0;
	BCF         EEIE_bit+0, BitPos(EEIE_bit+0) 
;QUADRO.c,1029 :: 		INT0F_bit = 0;
	BCF         INT0F_bit+0, BitPos(INT0F_bit+0) 
;QUADRO.c,1030 :: 		INT0IE_bit = 0;
	BCF         INT0IE_bit+0, BitPos(INT0IE_bit+0) 
;QUADRO.c,1031 :: 		INT1IE_bit = 0;
	BCF         INT1IE_bit+0, BitPos(INT1IE_bit+0) 
;QUADRO.c,1032 :: 		INT2IE_bit = 0;
	BCF         INT2IE_bit+0, BitPos(INT2IE_bit+0) 
;QUADRO.c,1033 :: 		LVDIE_bit = 0;
	BCF         LVDIE_bit+0, BitPos(LVDIE_bit+0) 
;QUADRO.c,1034 :: 		PSPIE_bit = 0;
	BCF         PSPIE_bit+0, BitPos(PSPIE_bit+0) 
;QUADRO.c,1035 :: 		RBIE_bit = 0;
	BCF         RBIE_bit+0, BitPos(RBIE_bit+0) 
;QUADRO.c,1036 :: 		SSPIE_bit = 0;
	BCF         SSPIE_bit+0, BitPos(SSPIE_bit+0) 
;QUADRO.c,1037 :: 		T0IE_bit = 1;
	BSF         T0IE_bit+0, BitPos(T0IE_bit+0) 
;QUADRO.c,1038 :: 		TMR1IE_bit = 0;
	BCF         TMR1IE_bit+0, BitPos(TMR1IE_bit+0) 
;QUADRO.c,1039 :: 		TMR2IE_bit = 0;
	BCF         TMR2IE_bit+0, BitPos(TMR2IE_bit+0) 
;QUADRO.c,1040 :: 		TMR3IE_bit = 0;
	BCF         TMR3IE_bit+0, BitPos(TMR3IE_bit+0) 
;QUADRO.c,1041 :: 		TXIE_bit = 0;
	BCF         TXIE_bit+0, BitPos(TXIE_bit+0) 
;QUADRO.c,1042 :: 		porta = 0;
	CLRF        PORTA+0 
;QUADRO.c,1043 :: 		portb = 0xFF;
	MOVLW       255
	MOVWF       PORTB+0 
;QUADRO.c,1044 :: 		portc = 0;
	CLRF        PORTC+0 
;QUADRO.c,1045 :: 		portd = 0;
	CLRF        PORTD+0 
;QUADRO.c,1046 :: 		porte = 0;
	CLRF        PORTE+0 
;QUADRO.c,1047 :: 		trisa = 0b00101111;
	MOVLW       47
	MOVWF       TRISA+0 
;QUADRO.c,1048 :: 		trisb = 0xff; //TUDO ENTRADA
	MOVLW       255
	MOVWF       TRISB+0 
;QUADRO.c,1049 :: 		trisc = 0b10000001;
	MOVLW       129
	MOVWF       TRISC+0 
;QUADRO.c,1050 :: 		trisd = _1Bit;
	MOVLW       1
	MOVWF       TRISD+0 
;QUADRO.c,1051 :: 		trise = _4Bit;
	MOVLW       8
	MOVWF       TRISE+0 
;QUADRO.c,1052 :: 		adcon0 = 0b00000001;
	MOVLW       1
	MOVWF       ADCON0+0 
;QUADRO.c,1053 :: 		adcon1 = 0b01000010;
	MOVLW       66
	MOVWF       ADCON1+0 
;QUADRO.c,1055 :: 		ipr1 = 0xff;
	MOVLW       255
	MOVWF       IPR1+0 
;QUADRO.c,1056 :: 		ipr2 = 0xff;
	MOVLW       255
	MOVWF       IPR2+0 
;QUADRO.c,1057 :: 		peie_bit = 1;
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;QUADRO.c,1058 :: 		intedg0_bit = 0;
	BCF         INTEDG0_bit+0, BitPos(INTEDG0_bit+0) 
;QUADRO.c,1059 :: 		intedg1_bit = 0;
	BCF         INTEDG1_bit+0, BitPos(INTEDG1_bit+0) 
;QUADRO.c,1060 :: 		intedg2_bit = 0;
	BCF         INTEDG2_bit+0, BitPos(INTEDG2_bit+0) 
;QUADRO.c,1061 :: 		rbpu_bit = 1;
	BSF         RBPU_bit+0, BitPos(RBPU_bit+0) 
;QUADRO.c,1062 :: 		rbif_bit = 0;
	BCF         RBIF_bit+0, BitPos(RBIF_bit+0) 
;QUADRO.c,1063 :: 		rcie_bit = 1;
	BSF         RCIE_bit+0, BitPos(RCIE_bit+0) 
;QUADRO.c,1064 :: 		ipen_bit = 0;
	BCF         IPEN_bit+0, BitPos(IPEN_bit+0) 
;QUADRO.c,1065 :: 		t0con.tmr0on = 1;
	BSF         T0CON+0, 7 
;QUADRO.c,1066 :: 		t0con.t08bit = 0;
	BCF         T0CON+0, 6 
;QUADRO.c,1067 :: 		t0con.t0cs = 0;
	BCF         T0CON+0, 5 
;QUADRO.c,1068 :: 		t0con.t0se = 0;
	BCF         T0CON+0, 4 
;QUADRO.c,1069 :: 		t0con.psa = 0;
	BCF         T0CON+0, 3 
;QUADRO.c,1070 :: 		t0con.t0ps2 = 1;
	BSF         T0CON+0, 2 
;QUADRO.c,1071 :: 		t0con.t0ps1 = 0;
	BCF         T0CON+0, 1 
;QUADRO.c,1072 :: 		t0con.t0ps0 = 0;
	BCF         T0CON+0, 0 
;QUADRO.c,1073 :: 		TMR0H = 0x85;
	MOVLW       133
	MOVWF       TMR0H+0 
;QUADRO.c,1074 :: 		TMR0L = 0xEE;
	MOVLW       238
	MOVWF       TMR0L+0 
;QUADRO.c,1075 :: 		tmr0ie_bit = 1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;QUADRO.c,1076 :: 		tmr1cs_bit = 0;
	BCF         TMR1CS_bit+0, BitPos(TMR1CS_bit+0) 
;QUADRO.c,1078 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_F07_CONFIGURA_SISTEMA171:
	DECFSZ      R13, 1, 1
	BRA         L_F07_CONFIGURA_SISTEMA171
	DECFSZ      R12, 1, 1
	BRA         L_F07_CONFIGURA_SISTEMA171
	DECFSZ      R11, 1, 1
	BRA         L_F07_CONFIGURA_SISTEMA171
	NOP
	NOP
;QUADRO.c,1079 :: 		GidOndeCabineEsta = 0;
	CLRF        _GidOndeCabineEsta+0 
;QUADRO.c,1080 :: 		GpareAqui = 32;
	MOVLW       32
	MOVWF       _GpareAqui+0 
;QUADRO.c,1081 :: 		GretornaHome = 0;
	CLRF        _GretornaHome+0 
;QUADRO.c,1082 :: 		Gmenu = 0;
	CLRF        _Gmenu+0 
;QUADRO.c,1083 :: 		Gnivel = defVisualiza;
	MOVLW       1
	MOVWF       _Gnivel+0 
;QUADRO.c,1084 :: 		Gseq = 1;
	MOVLW       1
	MOVWF       _Gseq+0 
;QUADRO.c,1085 :: 		GsubMenu = 0;
	CLRF        _GsubMenu+0 
;QUADRO.c,1086 :: 		GteclaPress = '>';
	MOVLW       62
	MOVWF       _GteclaPress+0 
;QUADRO.c,1087 :: 		GstateELEVA = def1STOPPED;
	CLRF        _GstateELEVA+0 
;QUADRO.c,1088 :: 		Tecla.Para = 1;
	BSF         _Tecla+0, 2 
;QUADRO.c,1089 :: 		BitGravar = 0;
	BCF         _BitGravar+0, BitPos(_BitGravar+0) 
;QUADRO.c,1090 :: 		GloginState = def1PWDDESLOGADO;
	MOVLW       1
	MOVWF       _GloginState+0 
;QUADRO.c,1091 :: 		BitAvaliar = 0;
	BCF         _BitAvaliar+0, BitPos(_BitAvaliar+0) 
;QUADRO.c,1092 :: 		BitAudioOn = 0;
	BCF         _BitAudioOn+0, BitPos(_BitAudioOn+0) 
;QUADRO.c,1093 :: 		BitCancelaCloseOpen = 0;
	BCF         _BitCancelaCloseOpen+0, BitPos(_BitCancelaCloseOpen+0) 
;QUADRO.c,1094 :: 		BitStopDown = 0;
	BCF         _BitStopDown+0, BitPos(_BitStopDown+0) 
;QUADRO.c,1095 :: 		BitStopUp = 0;
	BCF         _BitStopUp+0, BitPos(_BitStopUp+0) 
;QUADRO.c,1096 :: 		Tecla.Audio = 0;
	BCF         _Tecla+0, 4 
;QUADRO.c,1097 :: 		Tecla.Desce = 0;
	BCF         _Tecla+0, 1 
;QUADRO.c,1098 :: 		Tecla.IrAte = 0;
	BCF         _Tecla+0, 5 
;QUADRO.c,1099 :: 		Tecla.Nivela = 0;
	BCF         _Tecla+0, 3 
;QUADRO.c,1100 :: 		Tecla.Sobe = 0;
	BCF         _Tecla+0, 0 
;QUADRO.c,1101 :: 		LastTecla.Desce = 0;
	BCF         _LastTecla+0, 1 
;QUADRO.c,1102 :: 		LastTecla.Sobe = 0;
	BCF         _LastTecla+0, 0 
;QUADRO.c,1103 :: 		BitVaiVoltar = 0;
	BCF         _BitVaiVoltar+0, BitPos(_BitVaiVoltar+0) 
;QUADRO.c,1104 :: 		BitKeyAvaliar = 0;
	BCF         _BitKeyAvaliar+0, BitPos(_BitKeyAvaliar+0) 
;QUADRO.c,1105 :: 		BitNaoSeq = 0;
	BCF         _BitNaoSeq+0, BitPos(_BitNaoSeq+0) 
;QUADRO.c,1106 :: 		BitSenhasIguais = 0;
	BCF         _BitSenhasIguais+0, BitPos(_BitSenhasIguais+0) 
;QUADRO.c,1107 :: 		BitGravar = 0;
	BCF         _BitGravar+0, BitPos(_BitGravar+0) 
;QUADRO.c,1108 :: 		BitAtualizarLcd = 0;
	BCF         _BitAtualizarLcd+0, BitPos(_BitAtualizarLcd+0) 
;QUADRO.c,1109 :: 		BitPararAqui = 0;
	BCF         _BitPararAqui+0, BitPos(_BitPararAqui+0) 
;QUADRO.c,1110 :: 		GchamadaState = def5NORMAL;
	MOVLW       5
	MOVWF       _GchamadaState+0 
;QUADRO.c,1111 :: 		GidRXstate = 0;
	CLRF        _GidRXstate+0 
;QUADRO.c,1112 :: 		Bitindice = 0;
	BCF         _Bitindice+0, BitPos(_Bitindice+0) 
;QUADRO.c,1113 :: 		GposSenha = 0;
	CLRF        _GposSenha+0 
;QUADRO.c,1114 :: 		GsenhaPosi = 0;
	CLRF        _GsenhaPosi+0 
;QUADRO.c,1115 :: 		GfaleAqui = 42;
	MOVLW       42
	MOVWF       _GfaleAqui+0 
;QUADRO.c,1116 :: 		GprotNivela = 0;
	CLRF        _GprotNivela+0 
;QUADRO.c,1117 :: 		rc5_FALAR_OUVIR = 0;
	BCF         RC5_bit+0, BitPos(RC5_bit+0) 
;QUADRO.c,1118 :: 		Gunidade7SEG = Num_Let_7Se[0];
	MOVLW       250
	MOVWF       _Gunidade7SEG+0 
;QUADRO.c,1119 :: 		Gdezena7SEG = Num_Let_7Se[0];
	MOVLW       250
	MOVWF       _Gdezena7SEG+0 
;QUADRO.c,1120 :: 		BitDescer=0;
	BCF         _BitDescer+0, BitPos(_BitDescer+0) 
;QUADRO.c,1122 :: 		I2C1_Init(100000);
	MOVLW       50
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;QUADRO.c,1123 :: 		uart1_init(19200);
	MOVLW       64
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;QUADRO.c,1124 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;QUADRO.c,1125 :: 		lcd_cmd(_lcd_clear); // clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;QUADRO.c,1126 :: 		lcd_cmd(_lcd_cursor_off); // cursor?
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;QUADRO.c,1127 :: 		F04_ENCHE_CG_RAM();
	CALL        _F04_ENCHE_CG_RAM+0, 0
;QUADRO.c,1128 :: 		for (F07ee = 0; F07ee != 16; F07ee++)
	CLRF        F07_CONFIGURA_SISTEMA_F07ee_L0+0 
L_F07_CONFIGURA_SISTEMA172:
	MOVF        F07_CONFIGURA_SISTEMA_F07ee_L0+0, 0 
	XORLW       16
	BTFSC       STATUS+0, 2 
	GOTO        L_F07_CONFIGURA_SISTEMA173
;QUADRO.c,1130 :: 		stgLcd1[F07ee]=32;
	MOVLW       _stgLcd1+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd1+0)
	MOVWF       FSR1H 
	MOVF        F07_CONFIGURA_SISTEMA_F07ee_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       32
	MOVWF       POSTINC1+0 
;QUADRO.c,1131 :: 		stgLcd2[F07ee]=32;
	MOVLW       _stgLcd2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	MOVWF       FSR1H 
	MOVF        F07_CONFIGURA_SISTEMA_F07ee_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       32
	MOVWF       POSTINC1+0 
;QUADRO.c,1128 :: 		for (F07ee = 0; F07ee != 16; F07ee++)
	INCF        F07_CONFIGURA_SISTEMA_F07ee_L0+0, 1 
;QUADRO.c,1132 :: 		}
	GOTO        L_F07_CONFIGURA_SISTEMA172
L_F07_CONFIGURA_SISTEMA173:
;QUADRO.c,1133 :: 		gie_bit = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;QUADRO.c,1134 :: 		}
	GOTO        L_F07_CONFIGURA_SISTEMA165
L_F07_CONFIGURA_SISTEMA164:
	MOVF        FARG_F07_CONFIGURA_SISTEMA_como+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_F07_CONFIGURA_SISTEMA166
	MOVF        FARG_F07_CONFIGURA_SISTEMA_como+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_F07_CONFIGURA_SISTEMA169
L_F07_CONFIGURA_SISTEMA165:
;QUADRO.c,1135 :: 		}
L_end_F07_CONFIGURA_SISTEMA:
	RETURN      0
; end of _F07_CONFIGURA_SISTEMA

_F08verificaParada:

;QUADRO.c,1138 :: 		short F08verificaParada (unsigned short F08qualID)//0 a 31, vai somar 10
;QUADRO.c,1141 :: 		F08stg[0]=244;//inicio da transmissão
	MOVLW       244
	MOVWF       F08verificaParada_F08stg_L0+0 
;QUADRO.c,1142 :: 		F08stg[1] = F08qualID + 10;
	MOVLW       10
	ADDWF       FARG_F08verificaParada_F08qualID+0, 0 
	MOVWF       F08verificaParada_F08stg_L0+1 
;QUADRO.c,1143 :: 		F08stg[2] = 0b00000100;//para não ser vazio - zero para a transmissão
	MOVLW       4
	MOVWF       F08verificaParada_F08stg_L0+2 
;QUADRO.c,1144 :: 		F08stg[3] = F08stg[2]+F08stg[1];
	MOVF        F08verificaParada_F08stg_L0+1, 0 
	ADDLW       4
	MOVWF       F08verificaParada_F08stg_L0+3 
;QUADRO.c,1145 :: 		F08stg[4] = 0;//fim da transmissão
	CLRF        F08verificaParada_F08stg_L0+4 
;QUADRO.c,1146 :: 		F05_UART_WRITE(F08stg);
	MOVLW       F08verificaParada_F08stg_L0+0
	MOVWF       FARG_F05_UART_WRITE_Text+0 
	MOVLW       hi_addr(F08verificaParada_F08stg_L0+0)
	MOVWF       FARG_F05_UART_WRITE_Text+1 
	CALL        _F05_UART_WRITE+0, 0
;QUADRO.c,1147 :: 		if (GidRecebido == F08stg[1])
	MOVF        _GidRecebido+0, 0 
	XORWF       F08verificaParada_F08stg_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F08verificaParada175
;QUADRO.c,1149 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_F08verificaParada
;QUADRO.c,1150 :: 		}
L_F08verificaParada175:
;QUADRO.c,1151 :: 		return 0;
	CLRF        R0 
;QUADRO.c,1152 :: 		}
L_end_F08verificaParada:
	RETURN      0
; end of _F08verificaParada

_F09:

;QUADRO.c,1154 :: 		void F09(void)
;QUADRO.c,1157 :: 		}
L_end_F09:
	RETURN      0
; end of _F09

_F10_ESCREVE_DS1307:

;QUADRO.c,1159 :: 		void F10_ESCREVE_DS1307(unsigned short F10time, unsigned short F10end)
;QUADRO.c,1161 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;QUADRO.c,1162 :: 		I2C1_Wr(0xD0);
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;QUADRO.c,1163 :: 		I2C1_Wr(F10end);//ONDE COMEÇA A ESCRITA
	MOVF        FARG_F10_ESCREVE_DS1307_F10end+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;QUADRO.c,1164 :: 		I2C1_Wr(Dec2Bcd(F10time));//QUAL VALOR A SER ESCRITO
	MOVF        FARG_F10_ESCREVE_DS1307_F10time+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;QUADRO.c,1165 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;QUADRO.c,1166 :: 		}
L_end_F10_ESCREVE_DS1307:
	RETURN      0
; end of _F10_ESCREVE_DS1307

_F11_HABILITA_PARADAS:

;QUADRO.c,1168 :: 		void F11_HABILITA_PARADAS(unsigned short F11adress)
;QUADRO.c,1174 :: 		F11readValue = EEPROM_Read(F11adress); //OOO7
	MOVF        FARG_F11_HABILITA_PARADAS_F11adress+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       F11_HABILITA_PARADAS_F11readValue_L0+0 
;QUADRO.c,1175 :: 		if ('1' == GteclaPress)
	MOVLW       49
	XORWF       _GteclaPress+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F11_HABILITA_PARADAS176
;QUADRO.c,1177 :: 		if (F11readValue & _6Bit) //apaga primeiro bit
	BTFSS       F11_HABILITA_PARADAS_F11readValue_L0+0, 5 
	GOTO        L_F11_HABILITA_PARADAS177
;QUADRO.c,1179 :: 		F11readValue &= 0b11011111;
	MOVLW       223
	ANDWF       F11_HABILITA_PARADAS_F11readValue_L0+0, 1 
;QUADRO.c,1180 :: 		}
	GOTO        L_F11_HABILITA_PARADAS178
L_F11_HABILITA_PARADAS177:
;QUADRO.c,1183 :: 		F11readValue |= _6Bit;//liga primeiro bit
	BSF         F11_HABILITA_PARADAS_F11readValue_L0+0, 5 
;QUADRO.c,1184 :: 		}
L_F11_HABILITA_PARADAS178:
;QUADRO.c,1185 :: 		EEPROM_Write(F11adress, F11readValue);
	MOVF        FARG_F11_HABILITA_PARADAS_F11adress+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        F11_HABILITA_PARADAS_F11readValue_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;QUADRO.c,1186 :: 		delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_F11_HABILITA_PARADAS179:
	DECFSZ      R13, 1, 1
	BRA         L_F11_HABILITA_PARADAS179
	DECFSZ      R12, 1, 1
	BRA         L_F11_HABILITA_PARADAS179
	NOP
;QUADRO.c,1187 :: 		GteclaPress ='<';
	MOVLW       60
	MOVWF       _GteclaPress+0 
;QUADRO.c,1188 :: 		}
L_F11_HABILITA_PARADAS176:
;QUADRO.c,1189 :: 		if (F08verificaParada (F11adress))
	MOVF        FARG_F11_HABILITA_PARADAS_F11adress+0, 0 
	MOVWF       FARG_F08verificaParada_F08qualID+0 
	CALL        _F08verificaParada+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F11_HABILITA_PARADAS180
;QUADRO.c,1191 :: 		stgLcd1[0] = 	'D';
	MOVLW       68
	MOVWF       _stgLcd1+0 
;QUADRO.c,1192 :: 		stgLcd1[1] = 	'e';
	MOVLW       101
	MOVWF       _stgLcd1+1 
;QUADRO.c,1193 :: 		stgLcd1[2] = 	't';
	MOVLW       116
	MOVWF       _stgLcd1+2 
;QUADRO.c,1194 :: 		stgLcd1[3] = 	'e';
	MOVLW       101
	MOVWF       _stgLcd1+3 
;QUADRO.c,1195 :: 		stgLcd1[4] = 	'c';
	MOVLW       99
	MOVWF       _stgLcd1+4 
;QUADRO.c,1196 :: 		stgLcd1[5] = 	't';
	MOVLW       116
	MOVWF       _stgLcd1+5 
;QUADRO.c,1197 :: 		stgLcd1[6] = 	'a';
	MOVLW       97
	MOVWF       _stgLcd1+6 
;QUADRO.c,1198 :: 		stgLcd1[7] = 	'd';
	MOVLW       100
	MOVWF       _stgLcd1+7 
;QUADRO.c,1199 :: 		stgLcd1[8] = 	'a';
	MOVLW       97
	MOVWF       _stgLcd1+8 
;QUADRO.c,1200 :: 		if (_0Bit == (_6Bit & F11readValue))
	MOVLW       32
	ANDWF       F11_HABILITA_PARADAS_F11readValue_L0+0, 0 
	MOVWF       R1 
	MOVLW       0
	ANDLW       0
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__F11_HABILITA_PARADAS698
	MOVF        R1, 0 
	XORLW       0
L__F11_HABILITA_PARADAS698:
	BTFSS       STATUS+0, 2 
	GOTO        L_F11_HABILITA_PARADAS181
;QUADRO.c,1202 :: 		if (BitInverter)
	BTFSS       _BitInverter+0, BitPos(_BitInverter+0) 
	GOTO        L_F11_HABILITA_PARADAS182
;QUADRO.c,1204 :: 		stgLcd2[15] = 	def7SIMBEXCLAM;
	MOVLW       7
	MOVWF       _stgLcd2+15 
;QUADRO.c,1205 :: 		}
L_F11_HABILITA_PARADAS182:
;QUADRO.c,1206 :: 		}
L_F11_HABILITA_PARADAS181:
;QUADRO.c,1207 :: 		}
	GOTO        L_F11_HABILITA_PARADAS183
L_F11_HABILITA_PARADAS180:
;QUADRO.c,1210 :: 		stgLcd1[0] = 	'N';
	MOVLW       78
	MOVWF       _stgLcd1+0 
;QUADRO.c,1211 :: 		stgLcd1[1] = 	defSIMBaTIL;
	MOVLW       205
	MOVWF       _stgLcd1+1 
;QUADRO.c,1212 :: 		stgLcd1[2] = 	'o';
	MOVLW       111
	MOVWF       _stgLcd1+2 
;QUADRO.c,1213 :: 		stgLcd1[4] = 	'D';
	MOVLW       68
	MOVWF       _stgLcd1+4 
;QUADRO.c,1214 :: 		stgLcd1[5] = 	'e';
	MOVLW       101
	MOVWF       _stgLcd1+5 
;QUADRO.c,1215 :: 		stgLcd1[6] = 	't';
	MOVLW       116
	MOVWF       _stgLcd1+6 
;QUADRO.c,1216 :: 		stgLcd1[7] = 	'e';
	MOVLW       101
	MOVWF       _stgLcd1+7 
;QUADRO.c,1217 :: 		stgLcd1[8] = 	'c';
	MOVLW       99
	MOVWF       _stgLcd1+8 
;QUADRO.c,1218 :: 		stgLcd1[9] = 	't';
	MOVLW       116
	MOVWF       _stgLcd1+9 
;QUADRO.c,1219 :: 		stgLcd1[10] = 	'a';
	MOVLW       97
	MOVWF       _stgLcd1+10 
;QUADRO.c,1220 :: 		stgLcd1[11] = 	'd';
	MOVLW       100
	MOVWF       _stgLcd1+11 
;QUADRO.c,1221 :: 		stgLcd1[12] = 	'a';
	MOVLW       97
	MOVWF       _stgLcd1+12 
;QUADRO.c,1222 :: 		if (_6Bit == (_6Bit & F11readValue))
	MOVLW       32
	ANDWF       F11_HABILITA_PARADAS_F11readValue_L0+0, 0 
	MOVWF       R1 
	MOVLW       0
	ANDLW       0
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__F11_HABILITA_PARADAS699
	MOVF        R1, 0 
	XORLW       32
L__F11_HABILITA_PARADAS699:
	BTFSS       STATUS+0, 2 
	GOTO        L_F11_HABILITA_PARADAS184
;QUADRO.c,1224 :: 		if (BitInverter)
	BTFSS       _BitInverter+0, BitPos(_BitInverter+0) 
	GOTO        L_F11_HABILITA_PARADAS185
;QUADRO.c,1226 :: 		stgLcd2[15] = 	def7SIMBEXCLAM;
	MOVLW       7
	MOVWF       _stgLcd2+15 
;QUADRO.c,1227 :: 		}
L_F11_HABILITA_PARADAS185:
;QUADRO.c,1228 :: 		}
L_F11_HABILITA_PARADAS184:
;QUADRO.c,1229 :: 		}
L_F11_HABILITA_PARADAS183:
;QUADRO.c,1230 :: 		stgLcd2[0] = 'i';
	MOVLW       105
	MOVWF       _stgLcd2+0 
;QUADRO.c,1231 :: 		stgLcd2[1] = 'D';
	MOVLW       68
	MOVWF       _stgLcd2+1 
;QUADRO.c,1232 :: 		stgLcd2[2] = ':';
	MOVLW       58
	MOVWF       _stgLcd2+2 
;QUADRO.c,1233 :: 		if (F11adress>9)
	MOVF        FARG_F11_HABILITA_PARADAS_F11adress+0, 0 
	SUBLW       9
	BTFSC       STATUS+0, 0 
	GOTO        L_F11_HABILITA_PARADAS186
;QUADRO.c,1235 :: 		stgLcd2[3]=F11adress/10+48;
	MOVLW       10
	MOVWF       R4 
	MOVF        FARG_F11_HABILITA_PARADAS_F11adress+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _stgLcd2+3 
;QUADRO.c,1236 :: 		}
	GOTO        L_F11_HABILITA_PARADAS187
L_F11_HABILITA_PARADAS186:
;QUADRO.c,1239 :: 		stgLcd2[3]='0';
	MOVLW       48
	MOVWF       _stgLcd2+3 
;QUADRO.c,1240 :: 		}
L_F11_HABILITA_PARADAS187:
;QUADRO.c,1241 :: 		stgLcd2[4]=F11adress%10+48;
	MOVLW       10
	MOVWF       R4 
	MOVF        FARG_F11_HABILITA_PARADAS_F11adress+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _stgLcd2+4 
;QUADRO.c,1242 :: 		if (_0Bit == (_6Bit & F11readValue))
	MOVLW       32
	ANDWF       F11_HABILITA_PARADAS_F11readValue_L0+0, 0 
	MOVWF       R1 
	MOVLW       0
	ANDLW       0
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__F11_HABILITA_PARADAS700
	MOVF        R1, 0 
	XORLW       0
L__F11_HABILITA_PARADAS700:
	BTFSS       STATUS+0, 2 
	GOTO        L_F11_HABILITA_PARADAS188
;QUADRO.c,1244 :: 		stgLcd2[6] = 	'D';
	MOVLW       68
	MOVWF       _stgLcd2+6 
;QUADRO.c,1245 :: 		stgLcd2[7] = 	'e';
	MOVLW       101
	MOVWF       _stgLcd2+7 
;QUADRO.c,1246 :: 		stgLcd2[8] = 	's';
	MOVLW       115
	MOVWF       _stgLcd2+8 
;QUADRO.c,1247 :: 		stgLcd2[9] = 	'l';
	MOVLW       108
	MOVWF       _stgLcd2+9 
;QUADRO.c,1248 :: 		stgLcd2[10] = 	'i';
	MOVLW       105
	MOVWF       _stgLcd2+10 
;QUADRO.c,1249 :: 		stgLcd2[11] = 	'g';
	MOVLW       103
	MOVWF       _stgLcd2+11 
;QUADRO.c,1250 :: 		stgLcd2[12] = 	'a';
	MOVLW       97
	MOVWF       _stgLcd2+12 
;QUADRO.c,1251 :: 		stgLcd2[13] = 	'd';
	MOVLW       100
	MOVWF       _stgLcd2+13 
;QUADRO.c,1252 :: 		stgLcd2[14] = 	'a';
	MOVLW       97
	MOVWF       _stgLcd2+14 
;QUADRO.c,1253 :: 		}
	GOTO        L_F11_HABILITA_PARADAS189
L_F11_HABILITA_PARADAS188:
;QUADRO.c,1256 :: 		stgLcd2[6] = 	'L';
	MOVLW       76
	MOVWF       _stgLcd2+6 
;QUADRO.c,1257 :: 		stgLcd2[7] = 	'i';
	MOVLW       105
	MOVWF       _stgLcd2+7 
;QUADRO.c,1258 :: 		stgLcd2[8]  =  	'g';
	MOVLW       103
	MOVWF       _stgLcd2+8 
;QUADRO.c,1259 :: 		stgLcd2[9] = 	'a';
	MOVLW       97
	MOVWF       _stgLcd2+9 
;QUADRO.c,1260 :: 		stgLcd2[10] = 	'd';
	MOVLW       100
	MOVWF       _stgLcd2+10 
;QUADRO.c,1261 :: 		stgLcd2[11] = 	'a';
	MOVLW       97
	MOVWF       _stgLcd2+11 
;QUADRO.c,1262 :: 		}
L_F11_HABILITA_PARADAS189:
;QUADRO.c,1263 :: 		F11ee = F11adress * 2;
	MOVF        FARG_F11_HABILITA_PARADAS_F11adress+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       F11_HABILITA_PARADAS_F11ee_L0+0 
;QUADRO.c,1264 :: 		F11par = EEPROM_Read(F11ee+32);
	MOVLW       32
	ADDWF       R0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       F11_HABILITA_PARADAS_F11par_L0+0 
;QUADRO.c,1265 :: 		F11ee++;
	INCF        F11_HABILITA_PARADAS_F11ee_L0+0, 1 
;QUADRO.c,1266 :: 		F11impar = EEPROM_Read(F11ee+32);
	MOVLW       32
	ADDWF       F11_HABILITA_PARADAS_F11ee_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
;QUADRO.c,1267 :: 		Gunidade7SEG = Num_Let_7Se[F11par];
	MOVLW       _Num_Let_7Se+0
	ADDWF       F11_HABILITA_PARADAS_F11par_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_7Se+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_7Se+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _Gunidade7SEG+0
;QUADRO.c,1268 :: 		Gdezena7SEG = Num_Let_7Se[F11impar];
	MOVLW       _Num_Let_7Se+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_7Se+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_7Se+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _Gdezena7SEG+0
;QUADRO.c,1269 :: 		}
L_end_F11_HABILITA_PARADAS:
	RETURN      0
; end of _F11_HABILITA_PARADAS

_F12_JUMPER_SENSOR:

;QUADRO.c,1271 :: 		void F12_JUMPER_SENSOR(unsigned short F12address)
;QUADRO.c,1279 :: 		F12gravarEEprom = 0;
	BCF         F12_JUMPER_SENSOR_F12gravarEEprom_L0+0, BitPos(F12_JUMPER_SENSOR_F12gravarEEprom_L0+0) 
;QUADRO.c,1280 :: 		F12readValue = EEPROM_Read(F12address); //OOO7
	MOVF        FARG_F12_JUMPER_SENSOR_F12address+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       F12_JUMPER_SENSOR_F12readValue_L0+0 
;QUADRO.c,1281 :: 		switch (GteclaPress)
	GOTO        L_F12_JUMPER_SENSOR190
;QUADRO.c,1283 :: 		case '0'://0
L_F12_JUMPER_SENSOR192:
;QUADRO.c,1285 :: 		F12readValue |= 0b00011111;//apaga todos
	MOVLW       31
	IORWF       F12_JUMPER_SENSOR_F12readValue_L0+0, 1 
;QUADRO.c,1286 :: 		F12gravarEEprom = 1;
	BSF         F12_JUMPER_SENSOR_F12gravarEEprom_L0+0, BitPos(F12_JUMPER_SENSOR_F12gravarEEprom_L0+0) 
;QUADRO.c,1287 :: 		break;
	GOTO        L_F12_JUMPER_SENSOR191
;QUADRO.c,1289 :: 		case '1'://1
L_F12_JUMPER_SENSOR193:
;QUADRO.c,1291 :: 		if (F12readValue & _1Bit) //apaga primeiro bit
	BTFSS       F12_JUMPER_SENSOR_F12readValue_L0+0, 0 
	GOTO        L_F12_JUMPER_SENSOR194
;QUADRO.c,1293 :: 		F12readValue &= 0b11111110;
	MOVLW       254
	ANDWF       F12_JUMPER_SENSOR_F12readValue_L0+0, 1 
;QUADRO.c,1294 :: 		}
	GOTO        L_F12_JUMPER_SENSOR195
L_F12_JUMPER_SENSOR194:
;QUADRO.c,1297 :: 		F12readValue |= _1Bit;//liga primeiro bit
	BSF         F12_JUMPER_SENSOR_F12readValue_L0+0, 0 
;QUADRO.c,1298 :: 		}
L_F12_JUMPER_SENSOR195:
;QUADRO.c,1299 :: 		F12gravarEEprom = 1;
	BSF         F12_JUMPER_SENSOR_F12gravarEEprom_L0+0, BitPos(F12_JUMPER_SENSOR_F12gravarEEprom_L0+0) 
;QUADRO.c,1300 :: 		break;
	GOTO        L_F12_JUMPER_SENSOR191
;QUADRO.c,1302 :: 		case '2'://2
L_F12_JUMPER_SENSOR196:
;QUADRO.c,1304 :: 		if (F12readValue & _2Bit) //apaga segundo bit
	BTFSS       F12_JUMPER_SENSOR_F12readValue_L0+0, 1 
	GOTO        L_F12_JUMPER_SENSOR197
;QUADRO.c,1306 :: 		F12readValue &= 0b11111101;
	MOVLW       253
	ANDWF       F12_JUMPER_SENSOR_F12readValue_L0+0, 1 
;QUADRO.c,1307 :: 		}
	GOTO        L_F12_JUMPER_SENSOR198
L_F12_JUMPER_SENSOR197:
;QUADRO.c,1310 :: 		F12readValue |= _2Bit;//liga segundo bit
	BSF         F12_JUMPER_SENSOR_F12readValue_L0+0, 1 
;QUADRO.c,1311 :: 		}
L_F12_JUMPER_SENSOR198:
;QUADRO.c,1312 :: 		F12gravarEEprom = 1;
	BSF         F12_JUMPER_SENSOR_F12gravarEEprom_L0+0, BitPos(F12_JUMPER_SENSOR_F12gravarEEprom_L0+0) 
;QUADRO.c,1313 :: 		break;
	GOTO        L_F12_JUMPER_SENSOR191
;QUADRO.c,1315 :: 		case '3'://3
L_F12_JUMPER_SENSOR199:
;QUADRO.c,1317 :: 		if (F12readValue & _3Bit) //apaga terceiro bit
	BTFSS       F12_JUMPER_SENSOR_F12readValue_L0+0, 2 
	GOTO        L_F12_JUMPER_SENSOR200
;QUADRO.c,1319 :: 		F12readValue &= 0b11111011;
	MOVLW       251
	ANDWF       F12_JUMPER_SENSOR_F12readValue_L0+0, 1 
;QUADRO.c,1320 :: 		}
	GOTO        L_F12_JUMPER_SENSOR201
L_F12_JUMPER_SENSOR200:
;QUADRO.c,1323 :: 		F12readValue |= _3Bit;//liga terceiro bit
	BSF         F12_JUMPER_SENSOR_F12readValue_L0+0, 2 
;QUADRO.c,1324 :: 		}
L_F12_JUMPER_SENSOR201:
;QUADRO.c,1325 :: 		F12gravarEEprom = 1;
	BSF         F12_JUMPER_SENSOR_F12gravarEEprom_L0+0, BitPos(F12_JUMPER_SENSOR_F12gravarEEprom_L0+0) 
;QUADRO.c,1326 :: 		break;
	GOTO        L_F12_JUMPER_SENSOR191
;QUADRO.c,1328 :: 		case '4'://4
L_F12_JUMPER_SENSOR202:
;QUADRO.c,1330 :: 		if (F12readValue & _4Bit) //apaga quarto bit
	BTFSS       F12_JUMPER_SENSOR_F12readValue_L0+0, 3 
	GOTO        L_F12_JUMPER_SENSOR203
;QUADRO.c,1332 :: 		F12readValue &= 0b11110111;
	MOVLW       247
	ANDWF       F12_JUMPER_SENSOR_F12readValue_L0+0, 1 
;QUADRO.c,1333 :: 		}
	GOTO        L_F12_JUMPER_SENSOR204
L_F12_JUMPER_SENSOR203:
;QUADRO.c,1336 :: 		F12readValue |= _4Bit;//liga quarto bit
	BSF         F12_JUMPER_SENSOR_F12readValue_L0+0, 3 
;QUADRO.c,1337 :: 		}
L_F12_JUMPER_SENSOR204:
;QUADRO.c,1338 :: 		F12gravarEEprom = 1;
	BSF         F12_JUMPER_SENSOR_F12gravarEEprom_L0+0, BitPos(F12_JUMPER_SENSOR_F12gravarEEprom_L0+0) 
;QUADRO.c,1339 :: 		break;
	GOTO        L_F12_JUMPER_SENSOR191
;QUADRO.c,1341 :: 		case '5'://5
L_F12_JUMPER_SENSOR205:
;QUADRO.c,1343 :: 		if (F12readValue & _5Bit) //apaga quinto bit
	BTFSS       F12_JUMPER_SENSOR_F12readValue_L0+0, 4 
	GOTO        L_F12_JUMPER_SENSOR206
;QUADRO.c,1345 :: 		F12readValue &= 0b11101111;
	MOVLW       239
	ANDWF       F12_JUMPER_SENSOR_F12readValue_L0+0, 1 
;QUADRO.c,1346 :: 		}
	GOTO        L_F12_JUMPER_SENSOR207
L_F12_JUMPER_SENSOR206:
;QUADRO.c,1349 :: 		F12readValue |= _5Bit;//liga quinto bit
	BSF         F12_JUMPER_SENSOR_F12readValue_L0+0, 4 
;QUADRO.c,1350 :: 		}
L_F12_JUMPER_SENSOR207:
;QUADRO.c,1351 :: 		F12gravarEEprom = 1;
	BSF         F12_JUMPER_SENSOR_F12gravarEEprom_L0+0, BitPos(F12_JUMPER_SENSOR_F12gravarEEprom_L0+0) 
;QUADRO.c,1352 :: 		break;
	GOTO        L_F12_JUMPER_SENSOR191
;QUADRO.c,1354 :: 		}
L_F12_JUMPER_SENSOR190:
	MOVF        _GteclaPress+0, 0 
	XORLW       48
	BTFSC       STATUS+0, 2 
	GOTO        L_F12_JUMPER_SENSOR192
	MOVF        _GteclaPress+0, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_F12_JUMPER_SENSOR193
	MOVF        _GteclaPress+0, 0 
	XORLW       50
	BTFSC       STATUS+0, 2 
	GOTO        L_F12_JUMPER_SENSOR196
	MOVF        _GteclaPress+0, 0 
	XORLW       51
	BTFSC       STATUS+0, 2 
	GOTO        L_F12_JUMPER_SENSOR199
	MOVF        _GteclaPress+0, 0 
	XORLW       52
	BTFSC       STATUS+0, 2 
	GOTO        L_F12_JUMPER_SENSOR202
	MOVF        _GteclaPress+0, 0 
	XORLW       53
	BTFSC       STATUS+0, 2 
	GOTO        L_F12_JUMPER_SENSOR205
L_F12_JUMPER_SENSOR191:
;QUADRO.c,1355 :: 		if (Gnivel == defEdicao)
	MOVF        _Gnivel+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_F12_JUMPER_SENSOR208
;QUADRO.c,1357 :: 		Gnivel = defVisualiza;
	MOVLW       1
	MOVWF       _Gnivel+0 
;QUADRO.c,1358 :: 		}
L_F12_JUMPER_SENSOR208:
;QUADRO.c,1359 :: 		if (F12gravarEEprom)
	BTFSS       F12_JUMPER_SENSOR_F12gravarEEprom_L0+0, BitPos(F12_JUMPER_SENSOR_F12gravarEEprom_L0+0) 
	GOTO        L_F12_JUMPER_SENSOR209
;QUADRO.c,1361 :: 		F12gravarEEprom = 0;
	BCF         F12_JUMPER_SENSOR_F12gravarEEprom_L0+0, BitPos(F12_JUMPER_SENSOR_F12gravarEEprom_L0+0) 
;QUADRO.c,1362 :: 		EEPROM_Write(F12address, F12readValue);
	MOVF        FARG_F12_JUMPER_SENSOR_F12address+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        F12_JUMPER_SENSOR_F12readValue_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;QUADRO.c,1363 :: 		}
L_F12_JUMPER_SENSOR209:
;QUADRO.c,1364 :: 		F12TestValue = _1Bit;
	MOVLW       1
	MOVWF       F12_JUMPER_SENSOR_F12TestValue_L0+0 
;QUADRO.c,1365 :: 		for (F12ee = 0; F12ee != 5; F12ee++)//coloca na string stgLcd1 a representaCAo dos bits editados
	CLRF        F12_JUMPER_SENSOR_F12ee_L0+0 
L_F12_JUMPER_SENSOR210:
	MOVF        F12_JUMPER_SENSOR_F12ee_L0+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_F12_JUMPER_SENSOR211
;QUADRO.c,1367 :: 		if (F12TestValue & F12readValue)
	MOVF        F12_JUMPER_SENSOR_F12readValue_L0+0, 0 
	ANDWF       F12_JUMPER_SENSOR_F12TestValue_L0+0, 0 
	MOVWF       R0 
	BTFSC       STATUS+0, 2 
	GOTO        L_F12_JUMPER_SENSOR213
;QUADRO.c,1369 :: 		stgLcd1[F12ee] = defSIMBON0;
	MOVLW       _stgLcd1+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd1+0)
	MOVWF       FSR1H 
	MOVF        F12_JUMPER_SENSOR_F12ee_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;QUADRO.c,1370 :: 		}
	GOTO        L_F12_JUMPER_SENSOR214
L_F12_JUMPER_SENSOR213:
;QUADRO.c,1373 :: 		if (BitInverter)
	BTFSS       _BitInverter+0, BitPos(_BitInverter+0) 
	GOTO        L_F12_JUMPER_SENSOR215
;QUADRO.c,1375 :: 		stgLcd1[F12ee] = def6SIMBSWITCHOFF;
	MOVLW       _stgLcd1+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd1+0)
	MOVWF       FSR1H 
	MOVF        F12_JUMPER_SENSOR_F12ee_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       6
	MOVWF       POSTINC1+0 
;QUADRO.c,1376 :: 		}
	GOTO        L_F12_JUMPER_SENSOR216
L_F12_JUMPER_SENSOR215:
;QUADRO.c,1379 :: 		stgLcd1[F12ee] = def7SIMBEXCLAM;
	MOVLW       _stgLcd1+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd1+0)
	MOVWF       FSR1H 
	MOVF        F12_JUMPER_SENSOR_F12ee_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       7
	MOVWF       POSTINC1+0 
;QUADRO.c,1380 :: 		}
L_F12_JUMPER_SENSOR216:
;QUADRO.c,1381 :: 		}
L_F12_JUMPER_SENSOR214:
;QUADRO.c,1382 :: 		stgLcd2[F12ee] = 49+F12ee;
	MOVLW       _stgLcd2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	MOVWF       FSR1H 
	MOVF        F12_JUMPER_SENSOR_F12ee_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        F12_JUMPER_SENSOR_F12ee_L0+0, 0 
	ADDLW       49
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;QUADRO.c,1383 :: 		F12TestValue = F12TestValue << 1;
	RLCF        F12_JUMPER_SENSOR_F12TestValue_L0+0, 1 
	BCF         F12_JUMPER_SENSOR_F12TestValue_L0+0, 0 
;QUADRO.c,1365 :: 		for (F12ee = 0; F12ee != 5; F12ee++)//coloca na string stgLcd1 a representaCAo dos bits editados
	INCF        F12_JUMPER_SENSOR_F12ee_L0+0, 1 
;QUADRO.c,1384 :: 		}
	GOTO        L_F12_JUMPER_SENSOR210
L_F12_JUMPER_SENSOR211:
;QUADRO.c,1385 :: 		stgLcd1[6] = 'J';
	MOVLW       74
	MOVWF       _stgLcd1+6 
;QUADRO.c,1386 :: 		stgLcd1[7] = 'u';
	MOVLW       117
	MOVWF       _stgLcd1+7 
;QUADRO.c,1387 :: 		stgLcd1[8] = 'm';
	MOVLW       109
	MOVWF       _stgLcd1+8 
;QUADRO.c,1388 :: 		stgLcd1[9] = 'p';
	MOVLW       112
	MOVWF       _stgLcd1+9 
;QUADRO.c,1389 :: 		stgLcd1[10] = 'e';
	MOVLW       101
	MOVWF       _stgLcd1+10 
;QUADRO.c,1390 :: 		stgLcd1[11] = 'r';
	MOVLW       114
	MOVWF       _stgLcd1+11 
;QUADRO.c,1392 :: 		stgLcd2[6] = 'i';
	MOVLW       105
	MOVWF       _stgLcd2+6 
;QUADRO.c,1393 :: 		stgLcd2[7] = 'D';
	MOVLW       68
	MOVWF       _stgLcd2+7 
;QUADRO.c,1394 :: 		stgLcd2[8] = ':';
	MOVLW       58
	MOVWF       _stgLcd2+8 
;QUADRO.c,1395 :: 		if (F12address>9)
	MOVF        FARG_F12_JUMPER_SENSOR_F12address+0, 0 
	SUBLW       9
	BTFSC       STATUS+0, 0 
	GOTO        L_F12_JUMPER_SENSOR217
;QUADRO.c,1397 :: 		stgLcd2[9]=F12address/10+48;
	MOVLW       10
	MOVWF       R4 
	MOVF        FARG_F12_JUMPER_SENSOR_F12address+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _stgLcd2+9 
;QUADRO.c,1398 :: 		}
	GOTO        L_F12_JUMPER_SENSOR218
L_F12_JUMPER_SENSOR217:
;QUADRO.c,1401 :: 		stgLcd2[9]='0';
	MOVLW       48
	MOVWF       _stgLcd2+9 
;QUADRO.c,1402 :: 		}
L_F12_JUMPER_SENSOR218:
;QUADRO.c,1403 :: 		stgLcd2[10]=F12address%10+48;
	MOVLW       10
	MOVWF       R4 
	MOVF        FARG_F12_JUMPER_SENSOR_F12address+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _stgLcd2+10 
;QUADRO.c,1404 :: 		F12ee = F12address * 2;
	MOVF        FARG_F12_JUMPER_SENSOR_F12address+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       F12_JUMPER_SENSOR_F12ee_L0+0 
;QUADRO.c,1405 :: 		F12par = EEPROM_Read(F12ee+32);
	MOVLW       32
	ADDWF       R0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       F12_JUMPER_SENSOR_F12par_L0+0 
;QUADRO.c,1406 :: 		F12ee++;
	INCF        F12_JUMPER_SENSOR_F12ee_L0+0, 1 
;QUADRO.c,1407 :: 		F12impar = EEPROM_Read(F12ee+32);
	MOVLW       32
	ADDWF       F12_JUMPER_SENSOR_F12ee_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
;QUADRO.c,1408 :: 		Gunidade7SEG = Num_Let_7Se[F12par];
	MOVLW       _Num_Let_7Se+0
	ADDWF       F12_JUMPER_SENSOR_F12par_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_7Se+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_7Se+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _Gunidade7SEG+0
;QUADRO.c,1409 :: 		Gdezena7SEG = Num_Let_7Se[F12impar];
	MOVLW       _Num_Let_7Se+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_7Se+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_7Se+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _Gdezena7SEG+0
;QUADRO.c,1410 :: 		}
L_end_F12_JUMPER_SENSOR:
	RETURN      0
; end of _F12_JUMPER_SENSOR

_F13_LIMPA_BY_JUMPERS:

;QUADRO.c,1412 :: 		unsigned short F13_LIMPA_BY_JUMPERS (unsigned short F13oo)
;QUADRO.c,1416 :: 		if (F13oo==0)//para averiguar
	MOVF        FARG_F13_LIMPA_BY_JUMPERS_F13oo+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_F13_LIMPA_BY_JUMPERS219
;QUADRO.c,1418 :: 		for (F13ee = 0; F13ee != 32; F13ee++)
	CLRF        F13_LIMPA_BY_JUMPERS_F13ee_L0+0 
L_F13_LIMPA_BY_JUMPERS220:
	MOVF        F13_LIMPA_BY_JUMPERS_F13ee_L0+0, 0 
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_F13_LIMPA_BY_JUMPERS221
;QUADRO.c,1420 :: 		F13aa = EEPROM_Read(F13ee);
	MOVF        F13_LIMPA_BY_JUMPERS_F13ee_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
;QUADRO.c,1421 :: 		F13aa &= 0b00011111;
	MOVLW       31
	ANDWF       R0, 0 
	MOVWF       R1 
;QUADRO.c,1422 :: 		if (F13aa != 0b00011111)
	MOVF        R1, 0 
	XORLW       31
	BTFSC       STATUS+0, 2 
	GOTO        L_F13_LIMPA_BY_JUMPERS223
;QUADRO.c,1423 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_F13_LIMPA_BY_JUMPERS
L_F13_LIMPA_BY_JUMPERS223:
;QUADRO.c,1418 :: 		for (F13ee = 0; F13ee != 32; F13ee++)
	INCF        F13_LIMPA_BY_JUMPERS_F13ee_L0+0, 1 
;QUADRO.c,1424 :: 		}
	GOTO        L_F13_LIMPA_BY_JUMPERS220
L_F13_LIMPA_BY_JUMPERS221:
;QUADRO.c,1425 :: 		return 0;
	CLRF        R0 
	GOTO        L_end_F13_LIMPA_BY_JUMPERS
;QUADRO.c,1426 :: 		}
L_F13_LIMPA_BY_JUMPERS219:
;QUADRO.c,1429 :: 		for (F13ee = 0; F13ee != 32; F13ee++)
	CLRF        F13_LIMPA_BY_JUMPERS_F13ee_L0+0 
L_F13_LIMPA_BY_JUMPERS225:
	MOVF        F13_LIMPA_BY_JUMPERS_F13ee_L0+0, 0 
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_F13_LIMPA_BY_JUMPERS226
;QUADRO.c,1431 :: 		F13aa = EEPROM_Read(F13ee);
	MOVF        F13_LIMPA_BY_JUMPERS_F13ee_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
;QUADRO.c,1432 :: 		F13aa |= 0b00011111;
	MOVLW       31
	IORWF       R0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
;QUADRO.c,1433 :: 		EEPROM_Write(F13ee, F13aa);
	MOVF        F13_LIMPA_BY_JUMPERS_F13ee_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	CALL        _EEPROM_Write+0, 0
;QUADRO.c,1434 :: 		delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_F13_LIMPA_BY_JUMPERS228:
	DECFSZ      R13, 1, 1
	BRA         L_F13_LIMPA_BY_JUMPERS228
	DECFSZ      R12, 1, 1
	BRA         L_F13_LIMPA_BY_JUMPERS228
	NOP
;QUADRO.c,1429 :: 		for (F13ee = 0; F13ee != 32; F13ee++)
	INCF        F13_LIMPA_BY_JUMPERS_F13ee_L0+0, 1 
;QUADRO.c,1435 :: 		}
	GOTO        L_F13_LIMPA_BY_JUMPERS225
L_F13_LIMPA_BY_JUMPERS226:
;QUADRO.c,1437 :: 		}
L_end_F13_LIMPA_BY_JUMPERS:
	RETURN      0
; end of _F13_LIMPA_BY_JUMPERS

_F14_EDITA_ID:

;QUADRO.c,1439 :: 		void F14_EDITA_ID (void)
;QUADRO.c,1441 :: 		unsigned short F14ee = 0;
	CLRF        F14_EDITA_ID_F14ee_L0+0 
;QUADRO.c,1445 :: 		for (F14procuraSearch = 0; F14procuraSearch != 32; F14procuraSearch++)
	CLRF        F14_EDITA_ID_F14procuraSearch_L0+0 
L_F14_EDITA_ID229:
	MOVF        F14_EDITA_ID_F14procuraSearch_L0+0, 0 
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_F14_EDITA_ID230
;QUADRO.c,1447 :: 		GidRecebido = 0;
	CLRF        _GidRecebido+0 
;QUADRO.c,1448 :: 		if (F08verificaParada (F14procuraSearch))
	MOVF        F14_EDITA_ID_F14procuraSearch_L0+0, 0 
	MOVWF       FARG_F08verificaParada_F08qualID+0 
	CALL        _F08verificaParada+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F14_EDITA_ID232
;QUADRO.c,1450 :: 		F14ee++;
	INCF        F14_EDITA_ID_F14ee_L0+0, 1 
;QUADRO.c,1451 :: 		GidOriginal = F14procuraSearch;
	MOVF        F14_EDITA_ID_F14procuraSearch_L0+0, 0 
	MOVWF       _GidOriginal+0 
;QUADRO.c,1452 :: 		}
L_F14_EDITA_ID232:
;QUADRO.c,1445 :: 		for (F14procuraSearch = 0; F14procuraSearch != 32; F14procuraSearch++)
	INCF        F14_EDITA_ID_F14procuraSearch_L0+0, 1 
;QUADRO.c,1453 :: 		}
	GOTO        L_F14_EDITA_ID229
L_F14_EDITA_ID230:
;QUADRO.c,1454 :: 		stgLcd1[0] = 'P';
	MOVLW       80
	MOVWF       _stgLcd1+0 
;QUADRO.c,1455 :: 		stgLcd1[1] = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+1 
;QUADRO.c,1456 :: 		stgLcd1[2] = 'r';
	MOVLW       114
	MOVWF       _stgLcd1+2 
;QUADRO.c,1457 :: 		stgLcd1[3] = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+3 
;QUADRO.c,1458 :: 		stgLcd1[4] = 'd';
	MOVLW       100
	MOVWF       _stgLcd1+4 
;QUADRO.c,1459 :: 		stgLcd1[5] = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+5 
;QUADRO.c,1460 :: 		stgLcd1[6] = 's';
	MOVLW       115
	MOVWF       _stgLcd1+6 
;QUADRO.c,1461 :: 		stgLcd1[7] = ':';
	MOVLW       58
	MOVWF       _stgLcd1+7 
;QUADRO.c,1462 :: 		if (F14ee>9)//PARA ESCREVE NO LCD
	MOVF        F14_EDITA_ID_F14ee_L0+0, 0 
	SUBLW       9
	BTFSC       STATUS+0, 0 
	GOTO        L_F14_EDITA_ID233
;QUADRO.c,1464 :: 		stgLcd1[8]=(F14ee/10)+48;//primeiro digito
	MOVLW       10
	MOVWF       R4 
	MOVF        F14_EDITA_ID_F14ee_L0+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _stgLcd1+8 
;QUADRO.c,1465 :: 		}
	GOTO        L_F14_EDITA_ID234
L_F14_EDITA_ID233:
;QUADRO.c,1468 :: 		stgLcd1[8]='0';//primeiro digito
	MOVLW       48
	MOVWF       _stgLcd1+8 
;QUADRO.c,1469 :: 		}
L_F14_EDITA_ID234:
;QUADRO.c,1470 :: 		stgLcd1[9]=(F14ee%10)+48;
	MOVLW       10
	MOVWF       R4 
	MOVF        F14_EDITA_ID_F14ee_L0+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _stgLcd1+9 
;QUADRO.c,1471 :: 		BitGravar = 0;
	BCF         _BitGravar+0, BitPos(_BitGravar+0) 
;QUADRO.c,1472 :: 		switch (GteclaPress)
	GOTO        L_F14_EDITA_ID235
;QUADRO.c,1474 :: 		case 'D':
L_F14_EDITA_ID237:
;QUADRO.c,1476 :: 		GidNovaEditada++;
	INCF        _GidNovaEditada+0, 1 
;QUADRO.c,1477 :: 		if (GidNovaEditada>31)
	MOVF        _GidNovaEditada+0, 0 
	SUBLW       31
	BTFSC       STATUS+0, 0 
	GOTO        L_F14_EDITA_ID238
;QUADRO.c,1479 :: 		GidNovaEditada = 0;
	CLRF        _GidNovaEditada+0 
;QUADRO.c,1480 :: 		}
L_F14_EDITA_ID238:
;QUADRO.c,1481 :: 		break;
	GOTO        L_F14_EDITA_ID236
;QUADRO.c,1483 :: 		case 'C':
L_F14_EDITA_ID239:
;QUADRO.c,1485 :: 		GidNovaEditada--;
	DECF        _GidNovaEditada+0, 1 
;QUADRO.c,1486 :: 		if (GidNovaEditada>250)
	MOVF        _GidNovaEditada+0, 0 
	SUBLW       250
	BTFSC       STATUS+0, 0 
	GOTO        L_F14_EDITA_ID240
;QUADRO.c,1488 :: 		GidNovaEditada = 31;
	MOVLW       31
	MOVWF       _GidNovaEditada+0 
;QUADRO.c,1489 :: 		}
L_F14_EDITA_ID240:
;QUADRO.c,1490 :: 		break;
	GOTO        L_F14_EDITA_ID236
;QUADRO.c,1492 :: 		case 'B':
L_F14_EDITA_ID241:
;QUADRO.c,1494 :: 		stgLcd2[15] = defSIMBrecording;
	MOVLW       220
	MOVWF       _stgLcd2+15 
;QUADRO.c,1495 :: 		BitGravar = 1;
	BSF         _BitGravar+0, BitPos(_BitGravar+0) 
;QUADRO.c,1496 :: 		break;
	GOTO        L_F14_EDITA_ID236
;QUADRO.c,1498 :: 		}
L_F14_EDITA_ID235:
	MOVF        _GteclaPress+0, 0 
	XORLW       68
	BTFSC       STATUS+0, 2 
	GOTO        L_F14_EDITA_ID237
	MOVF        _GteclaPress+0, 0 
	XORLW       67
	BTFSC       STATUS+0, 2 
	GOTO        L_F14_EDITA_ID239
	MOVF        _GteclaPress+0, 0 
	XORLW       66
	BTFSC       STATUS+0, 2 
	GOTO        L_F14_EDITA_ID241
L_F14_EDITA_ID236:
;QUADRO.c,1499 :: 		stgLcd2[7] = 'e';//PODE MOSTRAR QUAL ID DE QUAL PLACANDAR ESTa CONECTADA
	MOVLW       101
	MOVWF       _stgLcd2+7 
;QUADRO.c,1500 :: 		stgLcd2[8] = 'D';
	MOVLW       68
	MOVWF       _stgLcd2+8 
;QUADRO.c,1501 :: 		stgLcd2[9] = ':';
	MOVLW       58
	MOVWF       _stgLcd2+9 
;QUADRO.c,1502 :: 		if (GidNovaEditada>9)
	MOVF        _GidNovaEditada+0, 0 
	SUBLW       9
	BTFSC       STATUS+0, 0 
	GOTO        L_F14_EDITA_ID242
;QUADRO.c,1504 :: 		stgLcd2[10]=(GidNovaEditada/10)+48;//primeiro digito
	MOVLW       10
	MOVWF       R4 
	MOVF        _GidNovaEditada+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _stgLcd2+10 
;QUADRO.c,1505 :: 		}
	GOTO        L_F14_EDITA_ID243
L_F14_EDITA_ID242:
;QUADRO.c,1508 :: 		stgLcd2[10]='0';//primeiro digito
	MOVLW       48
	MOVWF       _stgLcd2+10 
;QUADRO.c,1509 :: 		}
L_F14_EDITA_ID243:
;QUADRO.c,1510 :: 		stgLcd2[11]=(GidNovaEditada%10)+48;
	MOVLW       10
	MOVWF       R4 
	MOVF        _GidNovaEditada+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _stgLcd2+11 
;QUADRO.c,1511 :: 		if (1 == F14ee)
	MOVLW       1
	XORWF       F14_EDITA_ID_F14ee_L0+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F14_EDITA_ID244
;QUADRO.c,1513 :: 		stgLcd2[0] = 'i';//PODE MOSTRAR QUAL ID DE QUAL PLACANDAR ESTa CONECTADA
	MOVLW       105
	MOVWF       _stgLcd2+0 
;QUADRO.c,1514 :: 		stgLcd2[1] = 'D';
	MOVLW       68
	MOVWF       _stgLcd2+1 
;QUADRO.c,1515 :: 		stgLcd2[2] = ':';
	MOVLW       58
	MOVWF       _stgLcd2+2 
;QUADRO.c,1516 :: 		if (GidOriginal>9)
	MOVF        _GidOriginal+0, 0 
	SUBLW       9
	BTFSC       STATUS+0, 0 
	GOTO        L_F14_EDITA_ID245
;QUADRO.c,1518 :: 		stgLcd2[3]=(GidOriginal/10)+48;//primeiro digito
	MOVLW       10
	MOVWF       R4 
	MOVF        _GidOriginal+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _stgLcd2+3 
;QUADRO.c,1519 :: 		}
	GOTO        L_F14_EDITA_ID246
L_F14_EDITA_ID245:
;QUADRO.c,1522 :: 		stgLcd2[3]='0';//primeiro digito
	MOVLW       48
	MOVWF       _stgLcd2+3 
;QUADRO.c,1523 :: 		}
L_F14_EDITA_ID246:
;QUADRO.c,1524 :: 		stgLcd2[4]=(GidOriginal%10)+48;
	MOVLW       10
	MOVWF       R4 
	MOVF        _GidOriginal+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _stgLcd2+4 
;QUADRO.c,1525 :: 		if (BitGravar)
	BTFSS       _BitGravar+0, BitPos(_BitGravar+0) 
	GOTO        L_F14_EDITA_ID247
;QUADRO.c,1527 :: 		BitGravar = 0;
	BCF         _BitGravar+0, BitPos(_BitGravar+0) 
;QUADRO.c,1528 :: 		F14ee = GidNovaEditada+10;
	MOVLW       10
	ADDWF       _GidNovaEditada+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       F14_EDITA_ID_F14ee_L0+0 
;QUADRO.c,1529 :: 		GidOriginal+=10;
	MOVLW       10
	ADDWF       _GidOriginal+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _GidOriginal+0 
;QUADRO.c,1530 :: 		F14oo = F14ee+GidOriginal;
	MOVF        R1, 0 
	ADDWF       R2, 0 
	MOVWF       R0 
;QUADRO.c,1531 :: 		F14stgEnvio[0]=254;
	MOVLW       254
	MOVWF       F14_EDITA_ID_F14stgEnvio_L0+0 
;QUADRO.c,1532 :: 		F14stgEnvio[1]=GidOriginal;
	MOVF        R1, 0 
	MOVWF       F14_EDITA_ID_F14stgEnvio_L0+1 
;QUADRO.c,1533 :: 		F14stgEnvio[2]=F14ee;
	MOVF        R2, 0 
	MOVWF       F14_EDITA_ID_F14stgEnvio_L0+2 
;QUADRO.c,1534 :: 		F14stgEnvio[3]=F14oo;
	MOVF        R0, 0 
	MOVWF       F14_EDITA_ID_F14stgEnvio_L0+3 
;QUADRO.c,1535 :: 		F14stgEnvio[4]=110;
	MOVLW       110
	MOVWF       F14_EDITA_ID_F14stgEnvio_L0+4 
;QUADRO.c,1536 :: 		F14stgEnvio[5]=0;
	CLRF        F14_EDITA_ID_F14stgEnvio_L0+5 
;QUADRO.c,1537 :: 		F05_UART_WRITE(F14stgEnvio);
	MOVLW       F14_EDITA_ID_F14stgEnvio_L0+0
	MOVWF       FARG_F05_UART_WRITE_Text+0 
	MOVLW       hi_addr(F14_EDITA_ID_F14stgEnvio_L0+0)
	MOVWF       FARG_F05_UART_WRITE_Text+1 
	CALL        _F05_UART_WRITE+0, 0
;QUADRO.c,1538 :: 		}
L_F14_EDITA_ID247:
;QUADRO.c,1539 :: 		}
L_F14_EDITA_ID244:
;QUADRO.c,1540 :: 		}
L_end_F14_EDITA_ID:
	RETURN      0
; end of _F14_EDITA_ID

_F15_CONF_DS1307:

;QUADRO.c,1542 :: 		void F15_CONF_DS1307(void)
;QUADRO.c,1546 :: 		if (defEdicao == Gnivel)//modo ediCAo
	MOVLW       2
	XORWF       _Gnivel+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307248
;QUADRO.c,1548 :: 		stgLcd2[15] = defSIMBrecording;
	MOVLW       220
	MOVWF       _stgLcd2+15 
;QUADRO.c,1549 :: 		if (0 == Gseq)
	MOVLW       0
	XORWF       _Gseq+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307249
;QUADRO.c,1551 :: 		GsubMenu--;
	DECF        _GsubMenu+0, 1 
;QUADRO.c,1552 :: 		Gseq = 1;
	MOVLW       1
	MOVWF       _Gseq+0 
;QUADRO.c,1553 :: 		}
L_F15_CONF_DS1307249:
;QUADRO.c,1554 :: 		if (Gseq > 250) Gseq = 1;//ESTOUROU
	MOVF        _Gseq+0, 0 
	SUBLW       250
	BTFSC       STATUS+0, 0 
	GOTO        L_F15_CONF_DS1307250
	MOVLW       1
	MOVWF       _Gseq+0 
L_F15_CONF_DS1307250:
;QUADRO.c,1555 :: 		if (Gseq > 8)
	MOVF        _Gseq+0, 0 
	SUBLW       8
	BTFSC       STATUS+0, 0 
	GOTO        L_F15_CONF_DS1307251
;QUADRO.c,1557 :: 		Gseq = 1;
	MOVLW       1
	MOVWF       _Gseq+0 
;QUADRO.c,1558 :: 		GsubMenu++;
	INCF        _GsubMenu+0, 1 
;QUADRO.c,1559 :: 		}
L_F15_CONF_DS1307251:
;QUADRO.c,1560 :: 		if ((GteclaPress > 47) & (GteclaPress < 58) & (Gseq < 9)) //COLOCA DADO DO TECLADO DENTRO DA STRING
	MOVF        _GteclaPress+0, 0 
	SUBLW       47
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       58
	SUBWF       _GteclaPress+0, 0 
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVLW       9
	SUBWF       _Gseq+0, 0 
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307252
;QUADRO.c,1562 :: 		stgTime[Gseq] = GteclaPress-48;
	MOVLW       _stgTime+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgTime+0)
	MOVWF       FSR1H 
	MOVF        _Gseq+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       48
	SUBWF       _GteclaPress+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;QUADRO.c,1563 :: 		if (GsubMenu < 3)
	MOVLW       3
	SUBWF       _GsubMenu+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_F15_CONF_DS1307253
;QUADRO.c,1565 :: 		Gseq++;
	INCF        _Gseq+0, 1 
;QUADRO.c,1566 :: 		}
L_F15_CONF_DS1307253:
;QUADRO.c,1567 :: 		BitNaoSeq = 1;
	BSF         _BitNaoSeq+0, BitPos(_BitNaoSeq+0) 
;QUADRO.c,1568 :: 		}
L_F15_CONF_DS1307252:
;QUADRO.c,1569 :: 		switch (Gseq)
	GOTO        L_F15_CONF_DS1307254
;QUADRO.c,1571 :: 		case 1:
L_F15_CONF_DS1307256:
;QUADRO.c,1572 :: 		case 2:
L_F15_CONF_DS1307257:
;QUADRO.c,1574 :: 		if (GsubMenu == horas)
	MOVLW       0
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__F15_CONF_DS1307705
	MOVLW       1
	XORWF       _GsubMenu+0, 0 
L__F15_CONF_DS1307705:
	BTFSS       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307258
;QUADRO.c,1576 :: 		stgLcd2[Gseq] = 'H';
	MOVLW       _stgLcd2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	MOVWF       FSR1H 
	MOVF        _Gseq+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       72
	MOVWF       POSTINC1+0 
;QUADRO.c,1577 :: 		stgLcd2[Gseq+1] = 'o';
	MOVF        _Gseq+0, 0 
	ADDLW       1
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _stgLcd2+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       111
	MOVWF       POSTINC1+0 
;QUADRO.c,1578 :: 		stgLcd2[Gseq+2] = 'r';
	MOVLW       2
	ADDWF       _Gseq+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _stgLcd2+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       114
	MOVWF       POSTINC1+0 
;QUADRO.c,1579 :: 		stgLcd2[Gseq+3] = 'a';
	MOVLW       3
	ADDWF       _Gseq+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _stgLcd2+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       97
	MOVWF       POSTINC1+0 
;QUADRO.c,1580 :: 		stgLcd2[Gseq+4] = 's';
	MOVLW       4
	ADDWF       _Gseq+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _stgLcd2+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       115
	MOVWF       POSTINC1+0 
;QUADRO.c,1581 :: 		}
L_F15_CONF_DS1307258:
;QUADRO.c,1582 :: 		if (GsubMenu == datas)
	MOVLW       0
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__F15_CONF_DS1307706
	MOVLW       2
	XORWF       _GsubMenu+0, 0 
L__F15_CONF_DS1307706:
	BTFSS       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307259
;QUADRO.c,1584 :: 		stgLcd2[Gseq] = 'D';
	MOVLW       _stgLcd2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	MOVWF       FSR1H 
	MOVF        _Gseq+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       68
	MOVWF       POSTINC1+0 
;QUADRO.c,1585 :: 		stgLcd2[Gseq+1] = 'i';
	MOVF        _Gseq+0, 0 
	ADDLW       1
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _stgLcd2+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       105
	MOVWF       POSTINC1+0 
;QUADRO.c,1586 :: 		stgLcd2[Gseq+2] = 'a';
	MOVLW       2
	ADDWF       _Gseq+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _stgLcd2+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       97
	MOVWF       POSTINC1+0 
;QUADRO.c,1587 :: 		}
L_F15_CONF_DS1307259:
;QUADRO.c,1588 :: 		break;
	GOTO        L_F15_CONF_DS1307255
;QUADRO.c,1590 :: 		case 4:
L_F15_CONF_DS1307260:
;QUADRO.c,1591 :: 		case 5:
L_F15_CONF_DS1307261:
;QUADRO.c,1593 :: 		if (GsubMenu == horas)
	MOVLW       0
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__F15_CONF_DS1307707
	MOVLW       1
	XORWF       _GsubMenu+0, 0 
L__F15_CONF_DS1307707:
	BTFSS       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307262
;QUADRO.c,1595 :: 		stgLcd2[Gseq] = 'M';
	MOVLW       _stgLcd2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	MOVWF       FSR1H 
	MOVF        _Gseq+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       77
	MOVWF       POSTINC1+0 
;QUADRO.c,1596 :: 		stgLcd2[Gseq+1] = 'i';
	MOVF        _Gseq+0, 0 
	ADDLW       1
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _stgLcd2+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       105
	MOVWF       POSTINC1+0 
;QUADRO.c,1597 :: 		stgLcd2[Gseq+2] = 'n';
	MOVLW       2
	ADDWF       _Gseq+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _stgLcd2+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       110
	MOVWF       POSTINC1+0 
;QUADRO.c,1598 :: 		stgLcd2[Gseq+3] = '.';
	MOVLW       3
	ADDWF       _Gseq+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _stgLcd2+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       46
	MOVWF       POSTINC1+0 
;QUADRO.c,1599 :: 		}
L_F15_CONF_DS1307262:
;QUADRO.c,1600 :: 		if (GsubMenu == datas)
	MOVLW       0
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__F15_CONF_DS1307708
	MOVLW       2
	XORWF       _GsubMenu+0, 0 
L__F15_CONF_DS1307708:
	BTFSS       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307263
;QUADRO.c,1602 :: 		stgLcd2[Gseq] = 'M';
	MOVLW       _stgLcd2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	MOVWF       FSR1H 
	MOVF        _Gseq+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       77
	MOVWF       POSTINC1+0 
;QUADRO.c,1603 :: 		stgLcd2[Gseq+1] = defSIMBeTIL;
	MOVF        _Gseq+0, 0 
	ADDLW       1
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _stgLcd2+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       148
	MOVWF       POSTINC1+0 
;QUADRO.c,1604 :: 		stgLcd2[Gseq+2] = 's';
	MOVLW       2
	ADDWF       _Gseq+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _stgLcd2+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       115
	MOVWF       POSTINC1+0 
;QUADRO.c,1605 :: 		}
L_F15_CONF_DS1307263:
;QUADRO.c,1606 :: 		break;
	GOTO        L_F15_CONF_DS1307255
;QUADRO.c,1608 :: 		case 7:
L_F15_CONF_DS1307264:
;QUADRO.c,1609 :: 		case 8:
L_F15_CONF_DS1307265:
;QUADRO.c,1611 :: 		if (GsubMenu == horas)
	MOVLW       0
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__F15_CONF_DS1307709
	MOVLW       1
	XORWF       _GsubMenu+0, 0 
L__F15_CONF_DS1307709:
	BTFSS       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307266
;QUADRO.c,1613 :: 		stgLcd2[Gseq] = 'S';
	MOVLW       _stgLcd2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	MOVWF       FSR1H 
	MOVF        _Gseq+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       83
	MOVWF       POSTINC1+0 
;QUADRO.c,1614 :: 		stgLcd2[Gseq+1] = 'e';
	MOVF        _Gseq+0, 0 
	ADDLW       1
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _stgLcd2+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       101
	MOVWF       POSTINC1+0 
;QUADRO.c,1615 :: 		stgLcd2[Gseq+2] = 'g';
	MOVLW       2
	ADDWF       _Gseq+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _stgLcd2+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       103
	MOVWF       POSTINC1+0 
;QUADRO.c,1616 :: 		stgLcd2[Gseq+3] = '.';
	MOVLW       3
	ADDWF       _Gseq+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _stgLcd2+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       46
	MOVWF       POSTINC1+0 
;QUADRO.c,1617 :: 		}
L_F15_CONF_DS1307266:
;QUADRO.c,1618 :: 		if (GsubMenu == datas)
	MOVLW       0
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__F15_CONF_DS1307710
	MOVLW       2
	XORWF       _GsubMenu+0, 0 
L__F15_CONF_DS1307710:
	BTFSS       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307267
;QUADRO.c,1620 :: 		stgLcd2[Gseq] = 'A';
	MOVLW       _stgLcd2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	MOVWF       FSR1H 
	MOVF        _Gseq+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       65
	MOVWF       POSTINC1+0 
;QUADRO.c,1621 :: 		stgLcd2[Gseq+1] = 'n';
	MOVF        _Gseq+0, 0 
	ADDLW       1
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _stgLcd2+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       110
	MOVWF       POSTINC1+0 
;QUADRO.c,1622 :: 		stgLcd2[Gseq+2] = 'o';
	MOVLW       2
	ADDWF       _Gseq+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _stgLcd2+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       111
	MOVWF       POSTINC1+0 
;QUADRO.c,1623 :: 		}
L_F15_CONF_DS1307267:
;QUADRO.c,1624 :: 		break;
	GOTO        L_F15_CONF_DS1307255
;QUADRO.c,1626 :: 		}
L_F15_CONF_DS1307254:
	MOVF        _Gseq+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307256
	MOVF        _Gseq+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307257
	MOVF        _Gseq+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307260
	MOVF        _Gseq+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307261
	MOVF        _Gseq+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307264
	MOVF        _Gseq+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307265
L_F15_CONF_DS1307255:
;QUADRO.c,1627 :: 		if ((0 == Gseq % 3) && (BitNaoSeq))
	MOVLW       3
	MOVWF       R4 
	MOVF        _Gseq+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       0
	XORWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307270
	BTFSS       _BitNaoSeq+0, BitPos(_BitNaoSeq+0) 
	GOTO        L_F15_CONF_DS1307270
L__F15_CONF_DS1307669:
;QUADRO.c,1629 :: 		BitAvaliar = 1;
	BSF         _BitAvaliar+0, BitPos(_BitAvaliar+0) 
;QUADRO.c,1630 :: 		Gseq--;
	DECF        _Gseq+0, 1 
;QUADRO.c,1631 :: 		}
L_F15_CONF_DS1307270:
;QUADRO.c,1632 :: 		stgLcd2[Gseq-1] = '^';
	DECF        _Gseq+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       _stgLcd2+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       94
	MOVWF       POSTINC1+0 
;QUADRO.c,1633 :: 		}
L_F15_CONF_DS1307248:
;QUADRO.c,1634 :: 		if (GsubMenu == horas)
	MOVLW       0
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__F15_CONF_DS1307711
	MOVLW       1
	XORWF       _GsubMenu+0, 0 
L__F15_CONF_DS1307711:
	BTFSS       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307271
;QUADRO.c,1636 :: 		stgLcd1[12] = 'H';
	MOVLW       72
	MOVWF       _stgLcd1+12 
;QUADRO.c,1637 :: 		stgLcd1[13] = 'o';
	MOVLW       111
	MOVWF       _stgLcd1+13 
;QUADRO.c,1638 :: 		stgLcd1[14] = 'r';
	MOVLW       114
	MOVWF       _stgLcd1+14 
;QUADRO.c,1639 :: 		stgLcd1[15] = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+15 
;QUADRO.c,1640 :: 		}
L_F15_CONF_DS1307271:
;QUADRO.c,1641 :: 		if (GsubMenu == datas)
	MOVLW       0
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__F15_CONF_DS1307712
	MOVLW       2
	XORWF       _GsubMenu+0, 0 
L__F15_CONF_DS1307712:
	BTFSS       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307272
;QUADRO.c,1643 :: 		stgLcd1[12] = 'D';
	MOVLW       68
	MOVWF       _stgLcd1+12 
;QUADRO.c,1644 :: 		stgLcd1[13] = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+13 
;QUADRO.c,1645 :: 		stgLcd1[14] = 't';
	MOVLW       116
	MOVWF       _stgLcd1+14 
;QUADRO.c,1646 :: 		stgLcd1[15] = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+15 
;QUADRO.c,1647 :: 		}
L_F15_CONF_DS1307272:
;QUADRO.c,1648 :: 		if (Gnivel == defVisualiza)
	MOVF        _Gnivel+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307273
;QUADRO.c,1650 :: 		Gseq = 1; //modo visualizaCAo
	MOVLW       1
	MOVWF       _Gseq+0 
;QUADRO.c,1651 :: 		}
L_F15_CONF_DS1307273:
;QUADRO.c,1652 :: 		if (BitAvaliar) //DETERMINA SE VALORES E JA ATUALIZA
	BTFSS       _BitAvaliar+0, BitPos(_BitAvaliar+0) 
	GOTO        L_F15_CONF_DS1307274
;QUADRO.c,1654 :: 		BitAvaliar = 0;
	BCF         _BitAvaliar+0, BitPos(_BitAvaliar+0) 
;QUADRO.c,1655 :: 		if (GsubMenu == datas)//CONFIGURACAO DATA
	MOVLW       0
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__F15_CONF_DS1307713
	MOVLW       2
	XORWF       _GsubMenu+0, 0 
L__F15_CONF_DS1307713:
	BTFSS       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307275
;QUADRO.c,1657 :: 		switch (Gseq)
	GOTO        L_F15_CONF_DS1307276
;QUADRO.c,1659 :: 		case 1:
L_F15_CONF_DS1307278:
;QUADRO.c,1660 :: 		case 2:
L_F15_CONF_DS1307279:
;QUADRO.c,1662 :: 		F15ee = (stgTime[1])*10;
	MOVLW       10
	MULWF       _stgTime+1 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       F15_CONF_DS1307_F15ee_L0+0 
;QUADRO.c,1663 :: 		F15ee = F15ee + (stgTime[2]);
	MOVF        _stgTime+2, 0 
	ADDWF       R0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       F15_CONF_DS1307_F15ee_L0+0 
;QUADRO.c,1664 :: 		if ((F15ee != 0) && (F15ee < 32))//DIAS ESTAO ENTRE 1 E 31
	MOVF        R1, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307282
	MOVLW       32
	SUBWF       F15_CONF_DS1307_F15ee_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_F15_CONF_DS1307282
L__F15_CONF_DS1307668:
;QUADRO.c,1666 :: 		F10_ESCREVE_DS1307(F15ee,4);
	MOVF        F15_CONF_DS1307_F15ee_L0+0, 0 
	MOVWF       FARG_F10_ESCREVE_DS1307_F10time+0 
	MOVLW       4
	MOVWF       FARG_F10_ESCREVE_DS1307_F10end+0 
	CALL        _F10_ESCREVE_DS1307+0, 0
;QUADRO.c,1667 :: 		Gseq = 4;
	MOVLW       4
	MOVWF       _Gseq+0 
;QUADRO.c,1668 :: 		}
	GOTO        L_F15_CONF_DS1307283
L_F15_CONF_DS1307282:
;QUADRO.c,1671 :: 		Gseq = 1; //VALOR FORA DOS LIMITES, RETORNA
	MOVLW       1
	MOVWF       _Gseq+0 
;QUADRO.c,1672 :: 		}
L_F15_CONF_DS1307283:
;QUADRO.c,1673 :: 		break;
	GOTO        L_F15_CONF_DS1307277
;QUADRO.c,1675 :: 		case 4:
L_F15_CONF_DS1307284:
;QUADRO.c,1676 :: 		case 5:
L_F15_CONF_DS1307285:
;QUADRO.c,1678 :: 		F15ee = (stgTime[4])*10;
	MOVLW       10
	MULWF       _stgTime+4 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       F15_CONF_DS1307_F15ee_L0+0 
;QUADRO.c,1679 :: 		F15ee = F15ee + (stgTime[5]);
	MOVF        _stgTime+5, 0 
	ADDWF       R0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       F15_CONF_DS1307_F15ee_L0+0 
;QUADRO.c,1680 :: 		if ((F15ee != 0) && (F15ee < 13))//MESES ESTAO ENTRE 1 E 12
	MOVF        R1, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307288
	MOVLW       13
	SUBWF       F15_CONF_DS1307_F15ee_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_F15_CONF_DS1307288
L__F15_CONF_DS1307667:
;QUADRO.c,1682 :: 		F10_ESCREVE_DS1307(F15ee,5);
	MOVF        F15_CONF_DS1307_F15ee_L0+0, 0 
	MOVWF       FARG_F10_ESCREVE_DS1307_F10time+0 
	MOVLW       5
	MOVWF       FARG_F10_ESCREVE_DS1307_F10end+0 
	CALL        _F10_ESCREVE_DS1307+0, 0
;QUADRO.c,1683 :: 		Gseq = 7;
	MOVLW       7
	MOVWF       _Gseq+0 
;QUADRO.c,1684 :: 		}
	GOTO        L_F15_CONF_DS1307289
L_F15_CONF_DS1307288:
;QUADRO.c,1687 :: 		Gseq = 4; //VALOR FORA DOS LIMITES, RETORNA
	MOVLW       4
	MOVWF       _Gseq+0 
;QUADRO.c,1688 :: 		}
L_F15_CONF_DS1307289:
;QUADRO.c,1689 :: 		break;
	GOTO        L_F15_CONF_DS1307277
;QUADRO.c,1691 :: 		case 7:
L_F15_CONF_DS1307290:
;QUADRO.c,1692 :: 		case 8:
L_F15_CONF_DS1307291:
;QUADRO.c,1694 :: 		F15ee = (stgTime[7])*10;
	MOVLW       10
	MULWF       _stgTime+7 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       F15_CONF_DS1307_F15ee_L0+0 
;QUADRO.c,1695 :: 		F15ee = F15ee + (stgTime[8]);
	MOVF        _stgTime+8, 0 
	ADDWF       R0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       F15_CONF_DS1307_F15ee_L0+0 
;QUADRO.c,1696 :: 		if (F15ee < 100)// ANOS ESTAO ENTRE O E 99
	MOVLW       100
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_F15_CONF_DS1307292
;QUADRO.c,1698 :: 		F10_ESCREVE_DS1307(F15ee,6);
	MOVF        F15_CONF_DS1307_F15ee_L0+0, 0 
	MOVWF       FARG_F10_ESCREVE_DS1307_F10time+0 
	MOVLW       6
	MOVWF       FARG_F10_ESCREVE_DS1307_F10end+0 
	CALL        _F10_ESCREVE_DS1307+0, 0
;QUADRO.c,1699 :: 		Gseq = 1;
	MOVLW       1
	MOVWF       _Gseq+0 
;QUADRO.c,1700 :: 		Gnivel = defVisualiza;
	MOVLW       1
	MOVWF       _Gnivel+0 
;QUADRO.c,1701 :: 		}
	GOTO        L_F15_CONF_DS1307293
L_F15_CONF_DS1307292:
;QUADRO.c,1704 :: 		Gseq = 7; //VALOR FORA DOS LIMITES, RETORNA
	MOVLW       7
	MOVWF       _Gseq+0 
;QUADRO.c,1705 :: 		}
L_F15_CONF_DS1307293:
;QUADRO.c,1706 :: 		break;
	GOTO        L_F15_CONF_DS1307277
;QUADRO.c,1708 :: 		}
L_F15_CONF_DS1307276:
	MOVF        _Gseq+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307278
	MOVF        _Gseq+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307279
	MOVF        _Gseq+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307284
	MOVF        _Gseq+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307285
	MOVF        _Gseq+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307290
	MOVF        _Gseq+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307291
L_F15_CONF_DS1307277:
;QUADRO.c,1709 :: 		}
L_F15_CONF_DS1307275:
;QUADRO.c,1710 :: 		if (GsubMenu == horas)//CONFIGURACAO HORAS
	MOVLW       0
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__F15_CONF_DS1307714
	MOVLW       1
	XORWF       _GsubMenu+0, 0 
L__F15_CONF_DS1307714:
	BTFSS       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307294
;QUADRO.c,1712 :: 		switch (Gseq)
	GOTO        L_F15_CONF_DS1307295
;QUADRO.c,1714 :: 		case 1:
L_F15_CONF_DS1307297:
;QUADRO.c,1715 :: 		case 2:
L_F15_CONF_DS1307298:
;QUADRO.c,1717 :: 		F15ee = (stgTime[1])*10;
	MOVLW       10
	MULWF       _stgTime+1 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       F15_CONF_DS1307_F15ee_L0+0 
;QUADRO.c,1718 :: 		F15ee = F15ee + (stgTime[2]);
	MOVF        _stgTime+2, 0 
	ADDWF       R0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       F15_CONF_DS1307_F15ee_L0+0 
;QUADRO.c,1719 :: 		if  (F15ee < 24)//HORAS ESTAO ENTRE 0 E 23
	MOVLW       24
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_F15_CONF_DS1307299
;QUADRO.c,1721 :: 		F10_ESCREVE_DS1307(F15ee,2);
	MOVF        F15_CONF_DS1307_F15ee_L0+0, 0 
	MOVWF       FARG_F10_ESCREVE_DS1307_F10time+0 
	MOVLW       2
	MOVWF       FARG_F10_ESCREVE_DS1307_F10end+0 
	CALL        _F10_ESCREVE_DS1307+0, 0
;QUADRO.c,1722 :: 		Gseq = 4; //SALTA PRA MINUTOS
	MOVLW       4
	MOVWF       _Gseq+0 
;QUADRO.c,1723 :: 		}
	GOTO        L_F15_CONF_DS1307300
L_F15_CONF_DS1307299:
;QUADRO.c,1726 :: 		Gseq = 1; //VALOR FORA DOS LIMITES, RETORNA
	MOVLW       1
	MOVWF       _Gseq+0 
;QUADRO.c,1727 :: 		}
L_F15_CONF_DS1307300:
;QUADRO.c,1728 :: 		break;
	GOTO        L_F15_CONF_DS1307296
;QUADRO.c,1730 :: 		case 4:
L_F15_CONF_DS1307301:
;QUADRO.c,1731 :: 		case 5:
L_F15_CONF_DS1307302:
;QUADRO.c,1733 :: 		F15ee = (stgTime[4])*10;
	MOVLW       10
	MULWF       _stgTime+4 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       F15_CONF_DS1307_F15ee_L0+0 
;QUADRO.c,1734 :: 		F15ee = F15ee + (stgTime[5]);
	MOVF        _stgTime+5, 0 
	ADDWF       R0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       F15_CONF_DS1307_F15ee_L0+0 
;QUADRO.c,1735 :: 		if (F15ee < 60)//MINUTOS ENTRE 0 E 59
	MOVLW       60
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_F15_CONF_DS1307303
;QUADRO.c,1737 :: 		F10_ESCREVE_DS1307(F15ee,1);
	MOVF        F15_CONF_DS1307_F15ee_L0+0, 0 
	MOVWF       FARG_F10_ESCREVE_DS1307_F10time+0 
	MOVLW       1
	MOVWF       FARG_F10_ESCREVE_DS1307_F10end+0 
	CALL        _F10_ESCREVE_DS1307+0, 0
;QUADRO.c,1738 :: 		Gseq = 7;
	MOVLW       7
	MOVWF       _Gseq+0 
;QUADRO.c,1739 :: 		}
	GOTO        L_F15_CONF_DS1307304
L_F15_CONF_DS1307303:
;QUADRO.c,1742 :: 		Gseq = 4; //VALOR FORA DOS LIMITES, RETORNA
	MOVLW       4
	MOVWF       _Gseq+0 
;QUADRO.c,1743 :: 		}
L_F15_CONF_DS1307304:
;QUADRO.c,1744 :: 		break;
	GOTO        L_F15_CONF_DS1307296
;QUADRO.c,1746 :: 		case 7:
L_F15_CONF_DS1307305:
;QUADRO.c,1747 :: 		case 8:
L_F15_CONF_DS1307306:
;QUADRO.c,1749 :: 		F15ee = (stgTime[7])*10;
	MOVLW       10
	MULWF       _stgTime+7 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       F15_CONF_DS1307_F15ee_L0+0 
;QUADRO.c,1750 :: 		F15ee = F15ee + (stgTime[8]);
	MOVF        _stgTime+8, 0 
	ADDWF       R0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       F15_CONF_DS1307_F15ee_L0+0 
;QUADRO.c,1751 :: 		if (F15ee < 60)//SEGUNDOS ESTAO ENTRE 0 E 59
	MOVLW       60
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_F15_CONF_DS1307307
;QUADRO.c,1753 :: 		F10_ESCREVE_DS1307(F15ee,0);
	MOVF        F15_CONF_DS1307_F15ee_L0+0, 0 
	MOVWF       FARG_F10_ESCREVE_DS1307_F10time+0 
	CLRF        FARG_F10_ESCREVE_DS1307_F10end+0 
	CALL        _F10_ESCREVE_DS1307+0, 0
;QUADRO.c,1754 :: 		Gseq = 1;
	MOVLW       1
	MOVWF       _Gseq+0 
;QUADRO.c,1755 :: 		Gnivel = defVisualiza;
	MOVLW       1
	MOVWF       _Gnivel+0 
;QUADRO.c,1756 :: 		}
	GOTO        L_F15_CONF_DS1307308
L_F15_CONF_DS1307307:
;QUADRO.c,1759 :: 		Gseq = 7; //VALOR FORA DOS LIMITES, RETORNA
	MOVLW       7
	MOVWF       _Gseq+0 
;QUADRO.c,1760 :: 		}
L_F15_CONF_DS1307308:
;QUADRO.c,1761 :: 		break;
	GOTO        L_F15_CONF_DS1307296
;QUADRO.c,1763 :: 		}
L_F15_CONF_DS1307295:
	MOVF        _Gseq+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307297
	MOVF        _Gseq+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307298
	MOVF        _Gseq+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307301
	MOVF        _Gseq+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307302
	MOVF        _Gseq+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307305
	MOVF        _Gseq+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307306
L_F15_CONF_DS1307296:
;QUADRO.c,1764 :: 		}
L_F15_CONF_DS1307294:
;QUADRO.c,1765 :: 		}
L_F15_CONF_DS1307274:
;QUADRO.c,1766 :: 		if (GsubMenu == horas)
	MOVLW       0
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__F15_CONF_DS1307715
	MOVLW       1
	XORWF       _GsubMenu+0, 0 
L__F15_CONF_DS1307715:
	BTFSS       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307309
;QUADRO.c,1768 :: 		for (F15aa = 0; F15aa != 8; F15aa++)
	CLRF        F15_CONF_DS1307_F15aa_L0+0 
L_F15_CONF_DS1307310:
	MOVF        F15_CONF_DS1307_F15aa_L0+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307311
;QUADRO.c,1770 :: 		stgLcd1[F15aa]=stgFormatedTime[F15aa];
	MOVLW       _stgLcd1+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd1+0)
	MOVWF       FSR1H 
	MOVF        F15_CONF_DS1307_F15aa_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       _stgFormatedTime+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_stgFormatedTime+0)
	MOVWF       FSR0H 
	MOVF        F15_CONF_DS1307_F15aa_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;QUADRO.c,1768 :: 		for (F15aa = 0; F15aa != 8; F15aa++)
	INCF        F15_CONF_DS1307_F15aa_L0+0, 1 
;QUADRO.c,1771 :: 		}
	GOTO        L_F15_CONF_DS1307310
L_F15_CONF_DS1307311:
;QUADRO.c,1772 :: 		}
L_F15_CONF_DS1307309:
;QUADRO.c,1773 :: 		if (GsubMenu == datas)
	MOVLW       0
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__F15_CONF_DS1307716
	MOVLW       2
	XORWF       _GsubMenu+0, 0 
L__F15_CONF_DS1307716:
	BTFSS       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307313
;QUADRO.c,1775 :: 		for (F15aa = 0; F15aa != 8; F15aa++)
	CLRF        F15_CONF_DS1307_F15aa_L0+0 
L_F15_CONF_DS1307314:
	MOVF        F15_CONF_DS1307_F15aa_L0+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_F15_CONF_DS1307315
;QUADRO.c,1777 :: 		stgLcd1[F15aa]=stgFormatedDate[F15aa];
	MOVLW       _stgLcd1+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd1+0)
	MOVWF       FSR1H 
	MOVF        F15_CONF_DS1307_F15aa_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       _stgFormatedDate+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_stgFormatedDate+0)
	MOVWF       FSR0H 
	MOVF        F15_CONF_DS1307_F15aa_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;QUADRO.c,1775 :: 		for (F15aa = 0; F15aa != 8; F15aa++)
	INCF        F15_CONF_DS1307_F15aa_L0+0, 1 
;QUADRO.c,1778 :: 		}
	GOTO        L_F15_CONF_DS1307314
L_F15_CONF_DS1307315:
;QUADRO.c,1779 :: 		}
L_F15_CONF_DS1307313:
;QUADRO.c,1780 :: 		}
L_end_F15_CONF_DS1307:
	RETURN      0
; end of _F15_CONF_DS1307

_F16_CONFIG_SENHA:

;QUADRO.c,1782 :: 		void F16_CONFIG_SENHA(void)
;QUADRO.c,1785 :: 		if (Gnivel == defVisualiza)//modo visualiza
	MOVF        _Gnivel+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_F16_CONFIG_SENHA317
;QUADRO.c,1787 :: 		for (F16aa = 0; F16aa != 6; F16aa++)
	CLRF        F16_CONFIG_SENHA_F16aa_L0+0 
L_F16_CONFIG_SENHA318:
	MOVF        F16_CONFIG_SENHA_F16aa_L0+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_F16_CONFIG_SENHA319
;QUADRO.c,1789 :: 		stg_senha1[F16aa] = '_';
	MOVLW       _stg_senha1+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stg_senha1+0)
	MOVWF       FSR1H 
	MOVF        F16_CONFIG_SENHA_F16aa_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       95
	MOVWF       POSTINC1+0 
;QUADRO.c,1790 :: 		stg_senha2[F16aa] = '_';
	MOVLW       _stg_senha2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stg_senha2+0)
	MOVWF       FSR1H 
	MOVF        F16_CONFIG_SENHA_F16aa_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       95
	MOVWF       POSTINC1+0 
;QUADRO.c,1791 :: 		stgLcd1[F16aa] = EEPROM_Read(F16aa+250);
	MOVLW       _stgLcd1+0
	MOVWF       FLOC__F16_CONFIG_SENHA+0 
	MOVLW       hi_addr(_stgLcd1+0)
	MOVWF       FLOC__F16_CONFIG_SENHA+1 
	MOVF        F16_CONFIG_SENHA_F16aa_L0+0, 0 
	ADDWF       FLOC__F16_CONFIG_SENHA+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__F16_CONFIG_SENHA+1, 1 
	MOVLW       250
	ADDWF       F16_CONFIG_SENHA_F16aa_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVFF       FLOC__F16_CONFIG_SENHA+0, FSR1
	MOVFF       FLOC__F16_CONFIG_SENHA+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;QUADRO.c,1787 :: 		for (F16aa = 0; F16aa != 6; F16aa++)
	INCF        F16_CONFIG_SENHA_F16aa_L0+0, 1 
;QUADRO.c,1792 :: 		}
	GOTO        L_F16_CONFIG_SENHA318
L_F16_CONFIG_SENHA319:
;QUADRO.c,1793 :: 		stgLcd1[7] = 'S';
	MOVLW       83
	MOVWF       _stgLcd1+7 
;QUADRO.c,1794 :: 		stgLcd1[8] = 'e';
	MOVLW       101
	MOVWF       _stgLcd1+8 
;QUADRO.c,1795 :: 		stgLcd1[9] = 'n';
	MOVLW       110
	MOVWF       _stgLcd1+9 
;QUADRO.c,1796 :: 		stgLcd1[10] = 'h';
	MOVLW       104
	MOVWF       _stgLcd1+10 
;QUADRO.c,1797 :: 		stgLcd1[11] = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+11 
;QUADRO.c,1798 :: 		GsenhaPosi = 0;
	CLRF        _GsenhaPosi+0 
;QUADRO.c,1799 :: 		}
L_F16_CONFIG_SENHA317:
;QUADRO.c,1800 :: 		if (Gnivel == defEdicao)//modo edita
	MOVF        _Gnivel+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_F16_CONFIG_SENHA321
;QUADRO.c,1802 :: 		stgLcd2[15] = defSIMBrecording;
	MOVLW       220
	MOVWF       _stgLcd2+15 
;QUADRO.c,1803 :: 		if (GsenhaPosi < 12)//digita segunda senha
	MOVLW       12
	SUBWF       _GsenhaPosi+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_F16_CONFIG_SENHA322
;QUADRO.c,1805 :: 		if (GsenhaPosi < 6)//digita primeira senha
	MOVLW       6
	SUBWF       _GsenhaPosi+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_F16_CONFIG_SENHA323
;QUADRO.c,1807 :: 		if ((GteclaPress > 47) & (GteclaPress < 58))
	MOVF        _GteclaPress+0, 0 
	SUBLW       47
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       58
	SUBWF       _GteclaPress+0, 0 
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F16_CONFIG_SENHA324
;QUADRO.c,1809 :: 		stg_senha1[GsenhaPosi] = GteclaPress;
	MOVLW       _stg_senha1+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stg_senha1+0)
	MOVWF       FSR1H 
	MOVF        _GsenhaPosi+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        _GteclaPress+0, 0 
	MOVWF       POSTINC1+0 
;QUADRO.c,1810 :: 		GsenhaPosi++;
	INCF        _GsenhaPosi+0, 1 
;QUADRO.c,1811 :: 		}
L_F16_CONFIG_SENHA324:
;QUADRO.c,1812 :: 		GteclaPress = 120;
	MOVLW       120
	MOVWF       _GteclaPress+0 
;QUADRO.c,1813 :: 		stgLcd2[9]  = '1';
	MOVLW       49
	MOVWF       _stgLcd2+9 
;QUADRO.c,1814 :: 		}
	GOTO        L_F16_CONFIG_SENHA325
L_F16_CONFIG_SENHA323:
;QUADRO.c,1817 :: 		if ((GteclaPress > 47) & (GteclaPress < 58))
	MOVF        _GteclaPress+0, 0 
	SUBLW       47
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       58
	SUBWF       _GteclaPress+0, 0 
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F16_CONFIG_SENHA326
;QUADRO.c,1819 :: 		stg_senha2[GsenhaPosi - 6] = GteclaPress;
	MOVLW       6
	SUBWF       _GsenhaPosi+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       _stg_senha2+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_stg_senha2+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        _GteclaPress+0, 0 
	MOVWF       POSTINC1+0 
;QUADRO.c,1820 :: 		GsenhaPosi++;
	INCF        _GsenhaPosi+0, 1 
;QUADRO.c,1821 :: 		}
L_F16_CONFIG_SENHA326:
;QUADRO.c,1822 :: 		GteclaPress = 120;
	MOVLW       120
	MOVWF       _GteclaPress+0 
;QUADRO.c,1823 :: 		stgLcd2[9]  = '2';
	MOVLW       50
	MOVWF       _stgLcd2+9 
;QUADRO.c,1824 :: 		}
L_F16_CONFIG_SENHA325:
;QUADRO.c,1825 :: 		stgLcd1[8]  = 'D';
	MOVLW       68
	MOVWF       _stgLcd1+8 
;QUADRO.c,1826 :: 		stgLcd1[9]  = 'i';
	MOVLW       105
	MOVWF       _stgLcd1+9 
;QUADRO.c,1827 :: 		stgLcd1[10]  = 'g';
	MOVLW       103
	MOVWF       _stgLcd1+10 
;QUADRO.c,1828 :: 		stgLcd1[11]  = 'i';
	MOVLW       105
	MOVWF       _stgLcd1+11 
;QUADRO.c,1829 :: 		stgLcd1[12]  = 't';
	MOVLW       116
	MOVWF       _stgLcd1+12 
;QUADRO.c,1830 :: 		stgLcd1[13]  = 'e';
	MOVLW       101
	MOVWF       _stgLcd1+13 
;QUADRO.c,1831 :: 		stgLcd1[15]  = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+15 
;QUADRO.c,1832 :: 		stgLcd2[11]  = 'S';
	MOVLW       83
	MOVWF       _stgLcd2+11 
;QUADRO.c,1833 :: 		stgLcd2[12]  = 'e';
	MOVLW       101
	MOVWF       _stgLcd2+12 
;QUADRO.c,1834 :: 		stgLcd2[13]  = 'n';
	MOVLW       110
	MOVWF       _stgLcd2+13 
;QUADRO.c,1835 :: 		stgLcd2[14]  = 'h';
	MOVLW       104
	MOVWF       _stgLcd2+14 
;QUADRO.c,1836 :: 		stgLcd2[15]  = 'a';
	MOVLW       97
	MOVWF       _stgLcd2+15 
;QUADRO.c,1837 :: 		for (F16aa = 0; F16aa != 6; F16aa++)
	CLRF        F16_CONFIG_SENHA_F16aa_L0+0 
L_F16_CONFIG_SENHA327:
	MOVF        F16_CONFIG_SENHA_F16aa_L0+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_F16_CONFIG_SENHA328
;QUADRO.c,1839 :: 		stgLcd1[F16aa] = stg_senha1[F16aa];
	MOVLW       _stgLcd1+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd1+0)
	MOVWF       FSR1H 
	MOVF        F16_CONFIG_SENHA_F16aa_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       _stg_senha1+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_stg_senha1+0)
	MOVWF       FSR0H 
	MOVF        F16_CONFIG_SENHA_F16aa_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;QUADRO.c,1840 :: 		stgLcd2[F16aa] = stg_senha2[F16aa];
	MOVLW       _stgLcd2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	MOVWF       FSR1H 
	MOVF        F16_CONFIG_SENHA_F16aa_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       _stg_senha2+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_stg_senha2+0)
	MOVWF       FSR0H 
	MOVF        F16_CONFIG_SENHA_F16aa_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;QUADRO.c,1837 :: 		for (F16aa = 0; F16aa != 6; F16aa++)
	INCF        F16_CONFIG_SENHA_F16aa_L0+0, 1 
;QUADRO.c,1841 :: 		}
	GOTO        L_F16_CONFIG_SENHA327
L_F16_CONFIG_SENHA328:
;QUADRO.c,1842 :: 		}
	GOTO        L_F16_CONFIG_SENHA330
L_F16_CONFIG_SENHA322:
;QUADRO.c,1845 :: 		BitSenhasIguais = 1; //vamos ter fé
	BSF         _BitSenhasIguais+0, BitPos(_BitSenhasIguais+0) 
;QUADRO.c,1846 :: 		for (F16aa = 0; F16aa != 6; F16aa++)
	CLRF        F16_CONFIG_SENHA_F16aa_L0+0 
L_F16_CONFIG_SENHA331:
	MOVF        F16_CONFIG_SENHA_F16aa_L0+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_F16_CONFIG_SENHA332
;QUADRO.c,1848 :: 		if (stg_senha1[F16aa] != stg_senha2[F16aa])
	MOVLW       _stg_senha1+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_stg_senha1+0)
	MOVWF       FSR0H 
	MOVF        F16_CONFIG_SENHA_F16aa_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVLW       _stg_senha2+0
	MOVWF       FSR2 
	MOVLW       hi_addr(_stg_senha2+0)
	MOVWF       FSR2H 
	MOVF        F16_CONFIG_SENHA_F16aa_L0+0, 0 
	ADDWF       FSR2, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR2H, 1 
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_F16_CONFIG_SENHA334
;QUADRO.c,1850 :: 		BitSenhasIguais = 0; //em caso de qualquer diferenCa, negativa valor positivado
	BCF         _BitSenhasIguais+0, BitPos(_BitSenhasIguais+0) 
;QUADRO.c,1851 :: 		break;//não tem mais porque continuar procurando
	GOTO        L_F16_CONFIG_SENHA332
;QUADRO.c,1852 :: 		}
L_F16_CONFIG_SENHA334:
;QUADRO.c,1846 :: 		for (F16aa = 0; F16aa != 6; F16aa++)
	INCF        F16_CONFIG_SENHA_F16aa_L0+0, 1 
;QUADRO.c,1853 :: 		}
	GOTO        L_F16_CONFIG_SENHA331
L_F16_CONFIG_SENHA332:
;QUADRO.c,1854 :: 		if (1 == BitSenhasIguais)
	BTFSS       _BitSenhasIguais+0, BitPos(_BitSenhasIguais+0) 
	GOTO        L_F16_CONFIG_SENHA335
;QUADRO.c,1856 :: 		stgLcd1[0]  = 'S';
	MOVLW       83
	MOVWF       _stgLcd1+0 
;QUADRO.c,1857 :: 		stgLcd1[1]  = 'e';
	MOVLW       101
	MOVWF       _stgLcd1+1 
;QUADRO.c,1858 :: 		stgLcd1[2]  = 'n';
	MOVLW       110
	MOVWF       _stgLcd1+2 
;QUADRO.c,1859 :: 		stgLcd1[3]  = 'h';
	MOVLW       104
	MOVWF       _stgLcd1+3 
;QUADRO.c,1860 :: 		stgLcd1[4]  = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+4 
;QUADRO.c,1861 :: 		stgLcd1[6]  = 'A';
	MOVLW       65
	MOVWF       _stgLcd1+6 
;QUADRO.c,1862 :: 		stgLcd1[7]  = 'l';
	MOVLW       108
	MOVWF       _stgLcd1+7 
;QUADRO.c,1863 :: 		stgLcd1[8]  = 't';
	MOVLW       116
	MOVWF       _stgLcd1+8 
;QUADRO.c,1864 :: 		stgLcd1[9]  = 'e';
	MOVLW       101
	MOVWF       _stgLcd1+9 
;QUADRO.c,1865 :: 		stgLcd1[10] = 'r';
	MOVLW       114
	MOVWF       _stgLcd1+10 
;QUADRO.c,1866 :: 		stgLcd1[11] = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+11 
;QUADRO.c,1867 :: 		stgLcd1[12] = 'd';
	MOVLW       100
	MOVWF       _stgLcd1+12 
;QUADRO.c,1868 :: 		stgLcd1[13] = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+13 
;QUADRO.c,1869 :: 		stgLcd1[14] = '!';
	MOVLW       33
	MOVWF       _stgLcd1+14 
;QUADRO.c,1870 :: 		BitVaiVoltar = 1;
	BSF         _BitVaiVoltar+0, BitPos(_BitVaiVoltar+0) 
;QUADRO.c,1871 :: 		if (GvaiVoltar > 3)//3 segundos
	MOVF        _GvaiVoltar+0, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_F16_CONFIG_SENHA336
;QUADRO.c,1873 :: 		Gnivel = defVisualiza;
	MOVLW       1
	MOVWF       _Gnivel+0 
;QUADRO.c,1874 :: 		BitVaiVoltar = 0;
	BCF         _BitVaiVoltar+0, BitPos(_BitVaiVoltar+0) 
;QUADRO.c,1875 :: 		for (F16aa = 0; F16aa != 6; F16aa++)
	CLRF        F16_CONFIG_SENHA_F16aa_L0+0 
L_F16_CONFIG_SENHA337:
	MOVF        F16_CONFIG_SENHA_F16aa_L0+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_F16_CONFIG_SENHA338
;QUADRO.c,1877 :: 		EEPROM_Write(F16aa+250, stg_senha1[F16aa]);
	MOVLW       250
	ADDWF       F16_CONFIG_SENHA_F16aa_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       _stg_senha1+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_stg_senha1+0)
	MOVWF       FSR0H 
	MOVF        F16_CONFIG_SENHA_F16aa_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;QUADRO.c,1878 :: 		delay_ms(20);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_F16_CONFIG_SENHA340:
	DECFSZ      R13, 1, 1
	BRA         L_F16_CONFIG_SENHA340
	DECFSZ      R12, 1, 1
	BRA         L_F16_CONFIG_SENHA340
	NOP
	NOP
;QUADRO.c,1875 :: 		for (F16aa = 0; F16aa != 6; F16aa++)
	INCF        F16_CONFIG_SENHA_F16aa_L0+0, 1 
;QUADRO.c,1879 :: 		}
	GOTO        L_F16_CONFIG_SENHA337
L_F16_CONFIG_SENHA338:
;QUADRO.c,1880 :: 		}
L_F16_CONFIG_SENHA336:
;QUADRO.c,1881 :: 		}
	GOTO        L_F16_CONFIG_SENHA341
L_F16_CONFIG_SENHA335:
;QUADRO.c,1884 :: 		stgLcd1[0]  = 'N';
	MOVLW       78
	MOVWF       _stgLcd1+0 
;QUADRO.c,1885 :: 		stgLcd1[1]  = defSIMBaTIL;
	MOVLW       205
	MOVWF       _stgLcd1+1 
;QUADRO.c,1886 :: 		stgLcd1[2]  = 'o';
	MOVLW       111
	MOVWF       _stgLcd1+2 
;QUADRO.c,1887 :: 		stgLcd1[4]  = 'I';
	MOVLW       73
	MOVWF       _stgLcd1+4 
;QUADRO.c,1888 :: 		stgLcd1[5]  = 'g';
	MOVLW       103
	MOVWF       _stgLcd1+5 
;QUADRO.c,1889 :: 		stgLcd1[6]  = 'u';
	MOVLW       117
	MOVWF       _stgLcd1+6 
;QUADRO.c,1890 :: 		stgLcd1[7]  = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+7 
;QUADRO.c,1891 :: 		stgLcd1[8]  = 'i';
	MOVLW       105
	MOVWF       _stgLcd1+8 
;QUADRO.c,1892 :: 		stgLcd1[9]  = 's';
	MOVLW       115
	MOVWF       _stgLcd1+9 
;QUADRO.c,1893 :: 		stgLcd1[10] = '!';
	MOVLW       33
	MOVWF       _stgLcd1+10 
;QUADRO.c,1894 :: 		BitVaiVoltar = 1;
	BSF         _BitVaiVoltar+0, BitPos(_BitVaiVoltar+0) 
;QUADRO.c,1895 :: 		if (GvaiVoltar > 3)
	MOVF        _GvaiVoltar+0, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_F16_CONFIG_SENHA342
;QUADRO.c,1897 :: 		BitVaiVoltar = 0;
	BCF         _BitVaiVoltar+0, BitPos(_BitVaiVoltar+0) 
;QUADRO.c,1898 :: 		Gnivel = defVisualiza;
	MOVLW       1
	MOVWF       _Gnivel+0 
;QUADRO.c,1899 :: 		}
L_F16_CONFIG_SENHA342:
;QUADRO.c,1900 :: 		}
L_F16_CONFIG_SENHA341:
;QUADRO.c,1901 :: 		}
L_F16_CONFIG_SENHA330:
;QUADRO.c,1902 :: 		}
L_F16_CONFIG_SENHA321:
;QUADRO.c,1903 :: 		}
L_end_F16_CONFIG_SENHA:
	RETURN      0
; end of _F16_CONFIG_SENHA

_F17_EDITA_APELIDOS:

;QUADRO.c,1905 :: 		void F17_EDITA_APELIDOS(unsigned short UCEnderecoF17)
;QUADRO.c,1910 :: 		F17BitGravarEEprom = 0;
	BCF         F17_EDITA_APELIDOS_F17BitGravarEEprom_L0+0, BitPos(F17_EDITA_APELIDOS_F17BitGravarEEprom_L0+0) 
;QUADRO.c,1911 :: 		F17readValue = EEPROM_Read(UCEnderecoF17+32); //OOO7
	MOVLW       32
	ADDWF       FARG_F17_EDITA_APELIDOS_UCEnderecoF17+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       F17_EDITA_APELIDOS_F17readValue_L0+0 
;QUADRO.c,1912 :: 		switch (GteclaPress)
	GOTO        L_F17_EDITA_APELIDOS343
;QUADRO.c,1914 :: 		case '0':
L_F17_EDITA_APELIDOS345:
;QUADRO.c,1915 :: 		case '1':
L_F17_EDITA_APELIDOS346:
;QUADRO.c,1916 :: 		case '2':
L_F17_EDITA_APELIDOS347:
;QUADRO.c,1917 :: 		case '3':
L_F17_EDITA_APELIDOS348:
;QUADRO.c,1918 :: 		case '4':
L_F17_EDITA_APELIDOS349:
;QUADRO.c,1919 :: 		case '5':
L_F17_EDITA_APELIDOS350:
;QUADRO.c,1920 :: 		case '6':
L_F17_EDITA_APELIDOS351:
;QUADRO.c,1921 :: 		case '7':
L_F17_EDITA_APELIDOS352:
;QUADRO.c,1922 :: 		case '8':
L_F17_EDITA_APELIDOS353:
;QUADRO.c,1923 :: 		case '9':
L_F17_EDITA_APELIDOS354:
;QUADRO.c,1925 :: 		F17readValue = GteclaPress-48;//apaga todos
	MOVLW       48
	SUBWF       _GteclaPress+0, 0 
	MOVWF       F17_EDITA_APELIDOS_F17readValue_L0+0 
;QUADRO.c,1926 :: 		F17BitGravarEEprom = 1;
	BSF         F17_EDITA_APELIDOS_F17BitGravarEEprom_L0+0, BitPos(F17_EDITA_APELIDOS_F17BitGravarEEprom_L0+0) 
;QUADRO.c,1927 :: 		break;
	GOTO        L_F17_EDITA_APELIDOS344
;QUADRO.c,1929 :: 		case '#':
L_F17_EDITA_APELIDOS355:
;QUADRO.c,1931 :: 		F17readValue++;
	INCF        F17_EDITA_APELIDOS_F17readValue_L0+0, 1 
;QUADRO.c,1932 :: 		if (F17readValue>31)
	MOVF        F17_EDITA_APELIDOS_F17readValue_L0+0, 0 
	SUBLW       31
	BTFSC       STATUS+0, 0 
	GOTO        L_F17_EDITA_APELIDOS356
;QUADRO.c,1934 :: 		F17readValue = 0;
	CLRF        F17_EDITA_APELIDOS_F17readValue_L0+0 
;QUADRO.c,1935 :: 		}
L_F17_EDITA_APELIDOS356:
;QUADRO.c,1936 :: 		F17BitGravarEEprom = 1;
	BSF         F17_EDITA_APELIDOS_F17BitGravarEEprom_L0+0, BitPos(F17_EDITA_APELIDOS_F17BitGravarEEprom_L0+0) 
;QUADRO.c,1937 :: 		break;
	GOTO        L_F17_EDITA_APELIDOS344
;QUADRO.c,1939 :: 		case '*':
L_F17_EDITA_APELIDOS357:
;QUADRO.c,1941 :: 		F17readValue--;
	DECF        F17_EDITA_APELIDOS_F17readValue_L0+0, 1 
;QUADRO.c,1942 :: 		if (F17readValue>250)
	MOVF        F17_EDITA_APELIDOS_F17readValue_L0+0, 0 
	SUBLW       250
	BTFSC       STATUS+0, 0 
	GOTO        L_F17_EDITA_APELIDOS358
;QUADRO.c,1944 :: 		F17readValue = 31;
	MOVLW       31
	MOVWF       F17_EDITA_APELIDOS_F17readValue_L0+0 
;QUADRO.c,1945 :: 		}
L_F17_EDITA_APELIDOS358:
;QUADRO.c,1946 :: 		F17BitGravarEEprom = 1;
	BSF         F17_EDITA_APELIDOS_F17BitGravarEEprom_L0+0, BitPos(F17_EDITA_APELIDOS_F17BitGravarEEprom_L0+0) 
;QUADRO.c,1947 :: 		break;
	GOTO        L_F17_EDITA_APELIDOS344
;QUADRO.c,1949 :: 		}
L_F17_EDITA_APELIDOS343:
	MOVF        _GteclaPress+0, 0 
	XORLW       48
	BTFSC       STATUS+0, 2 
	GOTO        L_F17_EDITA_APELIDOS345
	MOVF        _GteclaPress+0, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_F17_EDITA_APELIDOS346
	MOVF        _GteclaPress+0, 0 
	XORLW       50
	BTFSC       STATUS+0, 2 
	GOTO        L_F17_EDITA_APELIDOS347
	MOVF        _GteclaPress+0, 0 
	XORLW       51
	BTFSC       STATUS+0, 2 
	GOTO        L_F17_EDITA_APELIDOS348
	MOVF        _GteclaPress+0, 0 
	XORLW       52
	BTFSC       STATUS+0, 2 
	GOTO        L_F17_EDITA_APELIDOS349
	MOVF        _GteclaPress+0, 0 
	XORLW       53
	BTFSC       STATUS+0, 2 
	GOTO        L_F17_EDITA_APELIDOS350
	MOVF        _GteclaPress+0, 0 
	XORLW       54
	BTFSC       STATUS+0, 2 
	GOTO        L_F17_EDITA_APELIDOS351
	MOVF        _GteclaPress+0, 0 
	XORLW       55
	BTFSC       STATUS+0, 2 
	GOTO        L_F17_EDITA_APELIDOS352
	MOVF        _GteclaPress+0, 0 
	XORLW       56
	BTFSC       STATUS+0, 2 
	GOTO        L_F17_EDITA_APELIDOS353
	MOVF        _GteclaPress+0, 0 
	XORLW       57
	BTFSC       STATUS+0, 2 
	GOTO        L_F17_EDITA_APELIDOS354
	MOVF        _GteclaPress+0, 0 
	XORLW       35
	BTFSC       STATUS+0, 2 
	GOTO        L_F17_EDITA_APELIDOS355
	MOVF        _GteclaPress+0, 0 
	XORLW       42
	BTFSC       STATUS+0, 2 
	GOTO        L_F17_EDITA_APELIDOS357
L_F17_EDITA_APELIDOS344:
;QUADRO.c,1950 :: 		if (Gnivel == defEdicao)
	MOVF        _Gnivel+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_F17_EDITA_APELIDOS359
;QUADRO.c,1952 :: 		Gnivel = defVisualiza;
	MOVLW       1
	MOVWF       _Gnivel+0 
;QUADRO.c,1953 :: 		}
L_F17_EDITA_APELIDOS359:
;QUADRO.c,1954 :: 		if (1 == F17BitGravarEEprom)
	BTFSS       F17_EDITA_APELIDOS_F17BitGravarEEprom_L0+0, BitPos(F17_EDITA_APELIDOS_F17BitGravarEEprom_L0+0) 
	GOTO        L_F17_EDITA_APELIDOS360
;QUADRO.c,1956 :: 		F17BitGravarEEprom = 0;
	BCF         F17_EDITA_APELIDOS_F17BitGravarEEprom_L0+0, BitPos(F17_EDITA_APELIDOS_F17BitGravarEEprom_L0+0) 
;QUADRO.c,1957 :: 		EEPROM_Write(UCEnderecoF17+32, F17readValue);
	MOVLW       32
	ADDWF       FARG_F17_EDITA_APELIDOS_UCEnderecoF17+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        F17_EDITA_APELIDOS_F17readValue_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;QUADRO.c,1958 :: 		}
L_F17_EDITA_APELIDOS360:
;QUADRO.c,1959 :: 		F17idQual = UCEnderecoF17%2;
	MOVLW       1
	ANDWF       FARG_F17_EDITA_APELIDOS_UCEnderecoF17+0, 0 
	MOVWF       R1 
;QUADRO.c,1960 :: 		stgLcd1[0] = 'A';
	MOVLW       65
	MOVWF       _stgLcd1+0 
;QUADRO.c,1961 :: 		stgLcd1[1] = 'p';
	MOVLW       112
	MOVWF       _stgLcd1+1 
;QUADRO.c,1962 :: 		stgLcd1[2] = 'e';
	MOVLW       101
	MOVWF       _stgLcd1+2 
;QUADRO.c,1963 :: 		stgLcd1[3] = 'l';
	MOVLW       108
	MOVWF       _stgLcd1+3 
;QUADRO.c,1964 :: 		stgLcd1[4] = 'i';
	MOVLW       105
	MOVWF       _stgLcd1+4 
;QUADRO.c,1965 :: 		stgLcd1[5] = 'd';
	MOVLW       100
	MOVWF       _stgLcd1+5 
;QUADRO.c,1966 :: 		stgLcd1[6] = 'o';
	MOVLW       111
	MOVWF       _stgLcd1+6 
;QUADRO.c,1967 :: 		stgLcd1[7] = ':';
	MOVLW       58
	MOVWF       _stgLcd1+7 
;QUADRO.c,1968 :: 		if (0 == F17idQual)//UCEnderecoF17 é par
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F17_EDITA_APELIDOS361
;QUADRO.c,1970 :: 		Gunidade7SEG = Num_Let_7Se[F17readValue];
	MOVLW       _Num_Let_7Se+0
	ADDWF       F17_EDITA_APELIDOS_F17readValue_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_7Se+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_7Se+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _Gunidade7SEG+0
;QUADRO.c,1971 :: 		Gdezena7SEG = 0;//apagado
	CLRF        _Gdezena7SEG+0 
;QUADRO.c,1972 :: 		F17readValue = EEPROM_Read(UCEnderecoF17+32); //OOO7
	MOVLW       32
	ADDWF       FARG_F17_EDITA_APELIDOS_UCEnderecoF17+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       F17_EDITA_APELIDOS_F17readValue_L0+0 
;QUADRO.c,1973 :: 		stgLcd1[8] = Num_Let_LCD[F17readValue];
	MOVLW       _Num_Let_LCD+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _stgLcd1+8
;QUADRO.c,1974 :: 		F17readValue = EEPROM_Read(UCEnderecoF17+33); //OOO7
	MOVLW       33
	ADDWF       FARG_F17_EDITA_APELIDOS_UCEnderecoF17+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       F17_EDITA_APELIDOS_F17readValue_L0+0 
;QUADRO.c,1975 :: 		stgLcd1[9] = Num_Let_LCD[F17readValue];
	MOVLW       _Num_Let_LCD+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _stgLcd1+9
;QUADRO.c,1976 :: 		stgLcd2[8] = '^';
	MOVLW       94
	MOVWF       _stgLcd2+8 
;QUADRO.c,1977 :: 		}
	GOTO        L_F17_EDITA_APELIDOS362
L_F17_EDITA_APELIDOS361:
;QUADRO.c,1980 :: 		Gunidade7SEG = 0;//apagado
	CLRF        _Gunidade7SEG+0 
;QUADRO.c,1981 :: 		Gdezena7SEG = Num_Let_7Se[F17readValue];
	MOVLW       _Num_Let_7Se+0
	ADDWF       F17_EDITA_APELIDOS_F17readValue_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_7Se+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_7Se+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _Gdezena7SEG+0
;QUADRO.c,1982 :: 		F17readValue = EEPROM_Read(UCEnderecoF17+31); //OOO7
	MOVLW       31
	ADDWF       FARG_F17_EDITA_APELIDOS_UCEnderecoF17+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       F17_EDITA_APELIDOS_F17readValue_L0+0 
;QUADRO.c,1983 :: 		stgLcd1[8] = Num_Let_LCD[F17readValue];
	MOVLW       _Num_Let_LCD+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _stgLcd1+8
;QUADRO.c,1984 :: 		F17readValue = EEPROM_Read(UCEnderecoF17+32); //OOO7
	MOVLW       32
	ADDWF       FARG_F17_EDITA_APELIDOS_UCEnderecoF17+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       F17_EDITA_APELIDOS_F17readValue_L0+0 
;QUADRO.c,1985 :: 		stgLcd1[9] = Num_Let_LCD[F17readValue];
	MOVLW       _Num_Let_LCD+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _stgLcd1+9
;QUADRO.c,1986 :: 		stgLcd2[9] = '^';
	MOVLW       94
	MOVWF       _stgLcd2+9 
;QUADRO.c,1987 :: 		}
L_F17_EDITA_APELIDOS362:
;QUADRO.c,1988 :: 		UCEnderecoF17 = UCEnderecoF17/2;
	MOVF        FARG_F17_EDITA_APELIDOS_UCEnderecoF17+0, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	MOVF        R1, 0 
	MOVWF       FARG_F17_EDITA_APELIDOS_UCEnderecoF17+0 
;QUADRO.c,1989 :: 		stgLcd1[11] = 'i';
	MOVLW       105
	MOVWF       _stgLcd1+11 
;QUADRO.c,1990 :: 		stgLcd1[12] = 'D';
	MOVLW       68
	MOVWF       _stgLcd1+12 
;QUADRO.c,1991 :: 		stgLcd1[13] = ':';
	MOVLW       58
	MOVWF       _stgLcd1+13 
;QUADRO.c,1992 :: 		if (UCEnderecoF17>9)
	MOVF        R1, 0 
	SUBLW       9
	BTFSC       STATUS+0, 0 
	GOTO        L_F17_EDITA_APELIDOS363
;QUADRO.c,1994 :: 		stgLcd1[14]=UCEnderecoF17/10+48;//primeiro digito
	MOVLW       10
	MOVWF       R4 
	MOVF        FARG_F17_EDITA_APELIDOS_UCEnderecoF17+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _stgLcd1+14 
;QUADRO.c,1995 :: 		}
	GOTO        L_F17_EDITA_APELIDOS364
L_F17_EDITA_APELIDOS363:
;QUADRO.c,1998 :: 		stgLcd1[14]='0';//primeiro digito
	MOVLW       48
	MOVWF       _stgLcd1+14 
;QUADRO.c,1999 :: 		}
L_F17_EDITA_APELIDOS364:
;QUADRO.c,2000 :: 		stgLcd1[15]=UCEnderecoF17%10+48;
	MOVLW       10
	MOVWF       R4 
	MOVF        FARG_F17_EDITA_APELIDOS_UCEnderecoF17+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _stgLcd1+15 
;QUADRO.c,2001 :: 		}
L_end_F17_EDITA_APELIDOS:
	RETURN      0
; end of _F17_EDITA_APELIDOS

_F18_FORMATA_APELIDOS:

;QUADRO.c,2003 :: 		void F18_FORMATA_APELIDOS(void)
;QUADRO.c,2009 :: 		for (F18uu = 0; F18uu != 32; F18uu++)
	CLRF        F18_FORMATA_APELIDOS_F18uu_L0+0 
L_F18_FORMATA_APELIDOS365:
	MOVF        F18_FORMATA_APELIDOS_F18uu_L0+0, 0 
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_F18_FORMATA_APELIDOS366
;QUADRO.c,2011 :: 		F18ee = F18uu * 2;
	MOVF        F18_FORMATA_APELIDOS_F18uu_L0+0, 0 
	MOVWF       F18_FORMATA_APELIDOS_F18ee_L0+0 
	RLCF        F18_FORMATA_APELIDOS_F18ee_L0+0, 1 
	BCF         F18_FORMATA_APELIDOS_F18ee_L0+0, 0 
;QUADRO.c,2012 :: 		F18aa = F18uu / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        F18_FORMATA_APELIDOS_F18uu_L0+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       F18_FORMATA_APELIDOS_F18aa_L0+0 
;QUADRO.c,2013 :: 		F18oo = EEPROM_Read(F18ee+32);
	MOVLW       32
	ADDWF       F18_FORMATA_APELIDOS_F18ee_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
;QUADRO.c,2014 :: 		if (F18oo != F18aa)
	MOVF        R0, 0 
	XORWF       F18_FORMATA_APELIDOS_F18aa_L0+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_F18_FORMATA_APELIDOS368
;QUADRO.c,2016 :: 		EEPROM_Write(F18ee+32, F18aa);
	MOVLW       32
	ADDWF       F18_FORMATA_APELIDOS_F18ee_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        F18_FORMATA_APELIDOS_F18aa_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;QUADRO.c,2017 :: 		delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_F18_FORMATA_APELIDOS369:
	DECFSZ      R13, 1, 1
	BRA         L_F18_FORMATA_APELIDOS369
	DECFSZ      R12, 1, 1
	BRA         L_F18_FORMATA_APELIDOS369
	NOP
;QUADRO.c,2018 :: 		}
L_F18_FORMATA_APELIDOS368:
;QUADRO.c,2019 :: 		F18aa = F18uu % 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        F18_FORMATA_APELIDOS_F18uu_L0+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       F18_FORMATA_APELIDOS_F18aa_L0+0 
;QUADRO.c,2020 :: 		F18oo = EEPROM_Read(F18ee+33);
	MOVLW       33
	ADDWF       F18_FORMATA_APELIDOS_F18ee_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
;QUADRO.c,2021 :: 		if (F18oo != F18aa)
	MOVF        R0, 0 
	XORWF       F18_FORMATA_APELIDOS_F18aa_L0+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_F18_FORMATA_APELIDOS370
;QUADRO.c,2023 :: 		EEPROM_Write(F18ee+33, F18aa);
	MOVLW       33
	ADDWF       F18_FORMATA_APELIDOS_F18ee_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        F18_FORMATA_APELIDOS_F18aa_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;QUADRO.c,2024 :: 		delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_F18_FORMATA_APELIDOS371:
	DECFSZ      R13, 1, 1
	BRA         L_F18_FORMATA_APELIDOS371
	DECFSZ      R12, 1, 1
	BRA         L_F18_FORMATA_APELIDOS371
	NOP
;QUADRO.c,2025 :: 		}
L_F18_FORMATA_APELIDOS370:
;QUADRO.c,2009 :: 		for (F18uu = 0; F18uu != 32; F18uu++)
	INCF        F18_FORMATA_APELIDOS_F18uu_L0+0, 1 
;QUADRO.c,2026 :: 		}
	GOTO        L_F18_FORMATA_APELIDOS365
L_F18_FORMATA_APELIDOS366:
;QUADRO.c,2027 :: 		}
L_end_F18_FORMATA_APELIDOS:
	RETURN      0
; end of _F18_FORMATA_APELIDOS

_F19_CONFIG_GERAIS:

;QUADRO.c,2029 :: 		void F19_CONFIG_GERAIS (unsigned short F19address)
;QUADRO.c,2035 :: 		F19BitGravarEEprom = 0;
	BCF         F19_CONFIG_GERAIS_F19BitGravarEEprom_L0+0, BitPos(F19_CONFIG_GERAIS_F19BitGravarEEprom_L0+0) 
;QUADRO.c,2036 :: 		F19aa = EEPROM_Read(F19address); //OOO7
	MOVF        FARG_F19_CONFIG_GERAIS_F19address+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       F19_CONFIG_GERAIS_F19aa_L0+0 
;QUADRO.c,2037 :: 		switch (GteclaPress)
	GOTO        L_F19_CONFIG_GERAIS372
;QUADRO.c,2039 :: 		case '0'://0
L_F19_CONFIG_GERAIS374:
;QUADRO.c,2041 :: 		F19aa = _0Bit;//apaga todos
	CLRF        F19_CONFIG_GERAIS_F19aa_L0+0 
;QUADRO.c,2042 :: 		F19BitGravarEEprom = 1;
	BSF         F19_CONFIG_GERAIS_F19BitGravarEEprom_L0+0, BitPos(F19_CONFIG_GERAIS_F19BitGravarEEprom_L0+0) 
;QUADRO.c,2043 :: 		break;
	GOTO        L_F19_CONFIG_GERAIS373
;QUADRO.c,2045 :: 		case '1'://1
L_F19_CONFIG_GERAIS375:
;QUADRO.c,2047 :: 		if (F19aa & _1Bit) //apaga primeiro bit
	BTFSS       F19_CONFIG_GERAIS_F19aa_L0+0, 0 
	GOTO        L_F19_CONFIG_GERAIS376
;QUADRO.c,2049 :: 		F19aa &= 0b11111110;
	MOVLW       254
	ANDWF       F19_CONFIG_GERAIS_F19aa_L0+0, 1 
;QUADRO.c,2050 :: 		}
	GOTO        L_F19_CONFIG_GERAIS377
L_F19_CONFIG_GERAIS376:
;QUADRO.c,2053 :: 		F19aa |= _1Bit;//liga primeiro bit
	BSF         F19_CONFIG_GERAIS_F19aa_L0+0, 0 
;QUADRO.c,2054 :: 		}
L_F19_CONFIG_GERAIS377:
;QUADRO.c,2055 :: 		F19BitGravarEEprom = 1;
	BSF         F19_CONFIG_GERAIS_F19BitGravarEEprom_L0+0, BitPos(F19_CONFIG_GERAIS_F19BitGravarEEprom_L0+0) 
;QUADRO.c,2056 :: 		break;
	GOTO        L_F19_CONFIG_GERAIS373
;QUADRO.c,2058 :: 		case '2'://2
L_F19_CONFIG_GERAIS378:
;QUADRO.c,2060 :: 		if (F19aa & _2Bit) //apaga segundo bit
	BTFSS       F19_CONFIG_GERAIS_F19aa_L0+0, 1 
	GOTO        L_F19_CONFIG_GERAIS379
;QUADRO.c,2062 :: 		F19aa &= 0b11111101;
	MOVLW       253
	ANDWF       F19_CONFIG_GERAIS_F19aa_L0+0, 1 
;QUADRO.c,2063 :: 		}
	GOTO        L_F19_CONFIG_GERAIS380
L_F19_CONFIG_GERAIS379:
;QUADRO.c,2066 :: 		F19aa |= _2Bit;//liga segundo bit
	BSF         F19_CONFIG_GERAIS_F19aa_L0+0, 1 
;QUADRO.c,2067 :: 		}
L_F19_CONFIG_GERAIS380:
;QUADRO.c,2068 :: 		F19BitGravarEEprom = 1;
	BSF         F19_CONFIG_GERAIS_F19BitGravarEEprom_L0+0, BitPos(F19_CONFIG_GERAIS_F19BitGravarEEprom_L0+0) 
;QUADRO.c,2069 :: 		break;
	GOTO        L_F19_CONFIG_GERAIS373
;QUADRO.c,2071 :: 		case '3'://3
L_F19_CONFIG_GERAIS381:
;QUADRO.c,2073 :: 		if (F19aa & _3Bit) //apaga terceiro bit
	BTFSS       F19_CONFIG_GERAIS_F19aa_L0+0, 2 
	GOTO        L_F19_CONFIG_GERAIS382
;QUADRO.c,2075 :: 		F19aa &= 0b11111011;
	MOVLW       251
	ANDWF       F19_CONFIG_GERAIS_F19aa_L0+0, 1 
;QUADRO.c,2076 :: 		}
	GOTO        L_F19_CONFIG_GERAIS383
L_F19_CONFIG_GERAIS382:
;QUADRO.c,2079 :: 		F19aa |= _3Bit;//liga terceiro bit
	BSF         F19_CONFIG_GERAIS_F19aa_L0+0, 2 
;QUADRO.c,2080 :: 		}
L_F19_CONFIG_GERAIS383:
;QUADRO.c,2081 :: 		F19BitGravarEEprom = 1;
	BSF         F19_CONFIG_GERAIS_F19BitGravarEEprom_L0+0, BitPos(F19_CONFIG_GERAIS_F19BitGravarEEprom_L0+0) 
;QUADRO.c,2082 :: 		break;
	GOTO        L_F19_CONFIG_GERAIS373
;QUADRO.c,2084 :: 		case '4'://4
L_F19_CONFIG_GERAIS384:
;QUADRO.c,2086 :: 		if (F19aa & _4Bit) //apaga quarto bit
	BTFSS       F19_CONFIG_GERAIS_F19aa_L0+0, 3 
	GOTO        L_F19_CONFIG_GERAIS385
;QUADRO.c,2088 :: 		F19aa &= 0b11110111;
	MOVLW       247
	ANDWF       F19_CONFIG_GERAIS_F19aa_L0+0, 1 
;QUADRO.c,2089 :: 		}
	GOTO        L_F19_CONFIG_GERAIS386
L_F19_CONFIG_GERAIS385:
;QUADRO.c,2092 :: 		F19aa |= _4Bit;//liga quarto bit
	BSF         F19_CONFIG_GERAIS_F19aa_L0+0, 3 
;QUADRO.c,2093 :: 		}
L_F19_CONFIG_GERAIS386:
;QUADRO.c,2094 :: 		F19BitGravarEEprom = 1;
	BSF         F19_CONFIG_GERAIS_F19BitGravarEEprom_L0+0, BitPos(F19_CONFIG_GERAIS_F19BitGravarEEprom_L0+0) 
;QUADRO.c,2095 :: 		break;
	GOTO        L_F19_CONFIG_GERAIS373
;QUADRO.c,2097 :: 		case '5'://5
L_F19_CONFIG_GERAIS387:
;QUADRO.c,2099 :: 		if (F19aa & _5Bit) //apaga quinto bit
	BTFSS       F19_CONFIG_GERAIS_F19aa_L0+0, 4 
	GOTO        L_F19_CONFIG_GERAIS388
;QUADRO.c,2101 :: 		F19aa &= 0b11101111;
	MOVLW       239
	ANDWF       F19_CONFIG_GERAIS_F19aa_L0+0, 1 
;QUADRO.c,2102 :: 		}
	GOTO        L_F19_CONFIG_GERAIS389
L_F19_CONFIG_GERAIS388:
;QUADRO.c,2105 :: 		F19aa |= _5Bit;//liga quinto bit
	BSF         F19_CONFIG_GERAIS_F19aa_L0+0, 4 
;QUADRO.c,2106 :: 		}
L_F19_CONFIG_GERAIS389:
;QUADRO.c,2107 :: 		F19BitGravarEEprom = 1;
	BSF         F19_CONFIG_GERAIS_F19BitGravarEEprom_L0+0, BitPos(F19_CONFIG_GERAIS_F19BitGravarEEprom_L0+0) 
;QUADRO.c,2108 :: 		break;
	GOTO        L_F19_CONFIG_GERAIS373
;QUADRO.c,2110 :: 		case '6'://4
L_F19_CONFIG_GERAIS390:
;QUADRO.c,2112 :: 		if (F19aa & _6Bit) //apaga quarto bit
	BTFSS       F19_CONFIG_GERAIS_F19aa_L0+0, 5 
	GOTO        L_F19_CONFIG_GERAIS391
;QUADRO.c,2114 :: 		F19aa &= 0b11011111;
	MOVLW       223
	ANDWF       F19_CONFIG_GERAIS_F19aa_L0+0, 1 
;QUADRO.c,2115 :: 		}
	GOTO        L_F19_CONFIG_GERAIS392
L_F19_CONFIG_GERAIS391:
;QUADRO.c,2118 :: 		F19aa |= _6Bit;//liga quarto bit
	BSF         F19_CONFIG_GERAIS_F19aa_L0+0, 5 
;QUADRO.c,2119 :: 		}
L_F19_CONFIG_GERAIS392:
;QUADRO.c,2120 :: 		F19BitGravarEEprom = 1;
	BSF         F19_CONFIG_GERAIS_F19BitGravarEEprom_L0+0, BitPos(F19_CONFIG_GERAIS_F19BitGravarEEprom_L0+0) 
;QUADRO.c,2121 :: 		break;
	GOTO        L_F19_CONFIG_GERAIS373
;QUADRO.c,2123 :: 		case '7'://5
L_F19_CONFIG_GERAIS393:
;QUADRO.c,2125 :: 		if (F19aa & _7Bit) //apaga quinto bit
	BTFSS       F19_CONFIG_GERAIS_F19aa_L0+0, 6 
	GOTO        L_F19_CONFIG_GERAIS394
;QUADRO.c,2127 :: 		F19aa &= 0b10111111;
	MOVLW       191
	ANDWF       F19_CONFIG_GERAIS_F19aa_L0+0, 1 
;QUADRO.c,2128 :: 		}
	GOTO        L_F19_CONFIG_GERAIS395
L_F19_CONFIG_GERAIS394:
;QUADRO.c,2131 :: 		F19aa |= _7Bit;//liga quinto bit
	BSF         F19_CONFIG_GERAIS_F19aa_L0+0, 6 
;QUADRO.c,2132 :: 		}
L_F19_CONFIG_GERAIS395:
;QUADRO.c,2133 :: 		F19BitGravarEEprom = 1;
	BSF         F19_CONFIG_GERAIS_F19BitGravarEEprom_L0+0, BitPos(F19_CONFIG_GERAIS_F19BitGravarEEprom_L0+0) 
;QUADRO.c,2134 :: 		break;
	GOTO        L_F19_CONFIG_GERAIS373
;QUADRO.c,2136 :: 		case '8'://5
L_F19_CONFIG_GERAIS396:
;QUADRO.c,2138 :: 		if (F19aa & _8Bit) //apaga quinto bit
	BTFSS       F19_CONFIG_GERAIS_F19aa_L0+0, 7 
	GOTO        L_F19_CONFIG_GERAIS397
;QUADRO.c,2140 :: 		F19aa &= 0b01111111;
	MOVLW       127
	ANDWF       F19_CONFIG_GERAIS_F19aa_L0+0, 1 
;QUADRO.c,2141 :: 		}
	GOTO        L_F19_CONFIG_GERAIS398
L_F19_CONFIG_GERAIS397:
;QUADRO.c,2144 :: 		F19aa |= _8Bit;//liga quinto bit
	BSF         F19_CONFIG_GERAIS_F19aa_L0+0, 7 
;QUADRO.c,2145 :: 		}
L_F19_CONFIG_GERAIS398:
;QUADRO.c,2146 :: 		F19BitGravarEEprom = 1;
	BSF         F19_CONFIG_GERAIS_F19BitGravarEEprom_L0+0, BitPos(F19_CONFIG_GERAIS_F19BitGravarEEprom_L0+0) 
;QUADRO.c,2147 :: 		break;
	GOTO        L_F19_CONFIG_GERAIS373
;QUADRO.c,2149 :: 		}
L_F19_CONFIG_GERAIS372:
	MOVF        _GteclaPress+0, 0 
	XORLW       48
	BTFSC       STATUS+0, 2 
	GOTO        L_F19_CONFIG_GERAIS374
	MOVF        _GteclaPress+0, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_F19_CONFIG_GERAIS375
	MOVF        _GteclaPress+0, 0 
	XORLW       50
	BTFSC       STATUS+0, 2 
	GOTO        L_F19_CONFIG_GERAIS378
	MOVF        _GteclaPress+0, 0 
	XORLW       51
	BTFSC       STATUS+0, 2 
	GOTO        L_F19_CONFIG_GERAIS381
	MOVF        _GteclaPress+0, 0 
	XORLW       52
	BTFSC       STATUS+0, 2 
	GOTO        L_F19_CONFIG_GERAIS384
	MOVF        _GteclaPress+0, 0 
	XORLW       53
	BTFSC       STATUS+0, 2 
	GOTO        L_F19_CONFIG_GERAIS387
	MOVF        _GteclaPress+0, 0 
	XORLW       54
	BTFSC       STATUS+0, 2 
	GOTO        L_F19_CONFIG_GERAIS390
	MOVF        _GteclaPress+0, 0 
	XORLW       55
	BTFSC       STATUS+0, 2 
	GOTO        L_F19_CONFIG_GERAIS393
	MOVF        _GteclaPress+0, 0 
	XORLW       56
	BTFSC       STATUS+0, 2 
	GOTO        L_F19_CONFIG_GERAIS396
L_F19_CONFIG_GERAIS373:
;QUADRO.c,2150 :: 		if (Gnivel == defEdicao)
	MOVF        _Gnivel+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_F19_CONFIG_GERAIS399
;QUADRO.c,2152 :: 		Gnivel = defVisualiza;
	MOVLW       1
	MOVWF       _Gnivel+0 
;QUADRO.c,2153 :: 		}
L_F19_CONFIG_GERAIS399:
;QUADRO.c,2154 :: 		if (F19BitGravarEEprom)
	BTFSS       F19_CONFIG_GERAIS_F19BitGravarEEprom_L0+0, BitPos(F19_CONFIG_GERAIS_F19BitGravarEEprom_L0+0) 
	GOTO        L_F19_CONFIG_GERAIS400
;QUADRO.c,2156 :: 		F19BitGravarEEprom = 0;
	BCF         F19_CONFIG_GERAIS_F19BitGravarEEprom_L0+0, BitPos(F19_CONFIG_GERAIS_F19BitGravarEEprom_L0+0) 
;QUADRO.c,2157 :: 		EEPROM_Write(F19address, F19aa);
	MOVF        FARG_F19_CONFIG_GERAIS_F19address+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        F19_CONFIG_GERAIS_F19aa_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;QUADRO.c,2158 :: 		}
L_F19_CONFIG_GERAIS400:
;QUADRO.c,2159 :: 		F19oo = _1Bit;
	MOVLW       1
	MOVWF       F19_CONFIG_GERAIS_F19oo_L0+0 
;QUADRO.c,2160 :: 		for (F19ee = 0; F19ee != 8; F19ee++)//coloca na string stgLcd1 a representaCAo dos bits editados
	CLRF        F19_CONFIG_GERAIS_F19ee_L0+0 
L_F19_CONFIG_GERAIS401:
	MOVF        F19_CONFIG_GERAIS_F19ee_L0+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_F19_CONFIG_GERAIS402
;QUADRO.c,2162 :: 		if (F19oo & F19aa)
	MOVF        F19_CONFIG_GERAIS_F19aa_L0+0, 0 
	ANDWF       F19_CONFIG_GERAIS_F19oo_L0+0, 0 
	MOVWF       R0 
	BTFSC       STATUS+0, 2 
	GOTO        L_F19_CONFIG_GERAIS404
;QUADRO.c,2164 :: 		stgLcd1[F19ee] = defSIMBON0;
	MOVLW       _stgLcd1+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd1+0)
	MOVWF       FSR1H 
	MOVF        F19_CONFIG_GERAIS_F19ee_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;QUADRO.c,2165 :: 		}
	GOTO        L_F19_CONFIG_GERAIS405
L_F19_CONFIG_GERAIS404:
;QUADRO.c,2168 :: 		stgLcd1[F19ee] = def6SIMBSWITCHOFF;
	MOVLW       _stgLcd1+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd1+0)
	MOVWF       FSR1H 
	MOVF        F19_CONFIG_GERAIS_F19ee_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       6
	MOVWF       POSTINC1+0 
;QUADRO.c,2169 :: 		}
L_F19_CONFIG_GERAIS405:
;QUADRO.c,2170 :: 		stgLcd2[F19ee] = 49+F19ee;
	MOVLW       _stgLcd2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	MOVWF       FSR1H 
	MOVF        F19_CONFIG_GERAIS_F19ee_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        F19_CONFIG_GERAIS_F19ee_L0+0, 0 
	ADDLW       49
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;QUADRO.c,2171 :: 		F19oo = F19oo << 1;
	RLCF        F19_CONFIG_GERAIS_F19oo_L0+0, 1 
	BCF         F19_CONFIG_GERAIS_F19oo_L0+0, 0 
;QUADRO.c,2160 :: 		for (F19ee = 0; F19ee != 8; F19ee++)//coloca na string stgLcd1 a representaCAo dos bits editados
	INCF        F19_CONFIG_GERAIS_F19ee_L0+0, 1 
;QUADRO.c,2172 :: 		}
	GOTO        L_F19_CONFIG_GERAIS401
L_F19_CONFIG_GERAIS402:
;QUADRO.c,2173 :: 		F19address -= 95;
	MOVLW       95
	SUBWF       FARG_F19_CONFIG_GERAIS_F19address+0, 1 
;QUADRO.c,2174 :: 		switch (F19address)
	GOTO        L_F19_CONFIG_GERAIS406
;QUADRO.c,2176 :: 		case 1:
L_F19_CONFIG_GERAIS408:
;QUADRO.c,2178 :: 		stgLcd1[9]  	= 'G';
	MOVLW       71
	MOVWF       _stgLcd1+9 
;QUADRO.c,2179 :: 		stgLcd1[10]  	= 'e';
	MOVLW       101
	MOVWF       _stgLcd1+10 
;QUADRO.c,2180 :: 		stgLcd1[11] 	= 'r';
	MOVLW       114
	MOVWF       _stgLcd1+11 
;QUADRO.c,2181 :: 		stgLcd1[12] 	= 'a';
	MOVLW       97
	MOVWF       _stgLcd1+12 
;QUADRO.c,2182 :: 		stgLcd1[13] 	= 'i';
	MOVLW       105
	MOVWF       _stgLcd1+13 
;QUADRO.c,2183 :: 		stgLcd1[14] 	= 's';
	MOVLW       115
	MOVWF       _stgLcd1+14 
;QUADRO.c,2184 :: 		break;
	GOTO        L_F19_CONFIG_GERAIS407
;QUADRO.c,2186 :: 		case 2:
L_F19_CONFIG_GERAIS409:
;QUADRO.c,2188 :: 		stgLcd1[9]  	= 'A';
	MOVLW       65
	MOVWF       _stgLcd1+9 
;QUADRO.c,2189 :: 		stgLcd1[10]  	= 'v';
	MOVLW       118
	MOVWF       _stgLcd1+10 
;QUADRO.c,2190 :: 		stgLcd1[11] 	= 'i';
	MOVLW       105
	MOVWF       _stgLcd1+11 
;QUADRO.c,2191 :: 		stgLcd1[12] 	= 's';
	MOVLW       115
	MOVWF       _stgLcd1+12 
;QUADRO.c,2192 :: 		stgLcd1[13] 	= 'o';
	MOVLW       111
	MOVWF       _stgLcd1+13 
;QUADRO.c,2193 :: 		stgLcd1[14] 	= 's';
	MOVLW       115
	MOVWF       _stgLcd1+14 
;QUADRO.c,2194 :: 		break;
	GOTO        L_F19_CONFIG_GERAIS407
;QUADRO.c,2196 :: 		}
L_F19_CONFIG_GERAIS406:
	MOVF        FARG_F19_CONFIG_GERAIS_F19address+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_F19_CONFIG_GERAIS408
	MOVF        FARG_F19_CONFIG_GERAIS_F19address+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_F19_CONFIG_GERAIS409
L_F19_CONFIG_GERAIS407:
;QUADRO.c,2197 :: 		Gunidade7SEG = Num_Let_7Se[F19address/10];
	MOVLW       10
	MOVWF       R4 
	MOVF        FARG_F19_CONFIG_GERAIS_F19address+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       _Num_Let_7Se+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_7Se+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_7Se+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       _Gunidade7SEG+0 
;QUADRO.c,2198 :: 		Gunidade7SEG |= _3Bit;
	MOVLW       4
	IORWF       R0, 0 
	MOVWF       _Gunidade7SEG+0 
;QUADRO.c,2199 :: 		Gdezena7SEG = Num_Let_7Se[F19address%10];
	MOVLW       10
	MOVWF       R4 
	MOVF        FARG_F19_CONFIG_GERAIS_F19address+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       _Num_Let_7Se+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_7Se+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_7Se+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _Gdezena7SEG+0
;QUADRO.c,2200 :: 		}
L_end_F19_CONFIG_GERAIS:
	RETURN      0
; end of _F19_CONFIG_GERAIS

_F76_SUB_LIMITS:

;QUADRO.c,2205 :: 		void F76_SUB_LIMITS(unsigned short F76min, unsigned short F76max)
;QUADRO.c,2207 :: 		if (0 == F76min)
	MOVLW       0
	XORWF       FARG_F76_SUB_LIMITS_F76min+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F76_SUB_LIMITS410
;QUADRO.c,2209 :: 		if (GsubMenu > 250) GsubMenu = F76max;
	MOVF        _GsubMenu+0, 0 
	SUBLW       250
	BTFSC       STATUS+0, 0 
	GOTO        L_F76_SUB_LIMITS411
	MOVF        FARG_F76_SUB_LIMITS_F76max+0, 0 
	MOVWF       _GsubMenu+0 
L_F76_SUB_LIMITS411:
;QUADRO.c,2210 :: 		if (GsubMenu > F76max) GsubMenu = 0;
	MOVF        _GsubMenu+0, 0 
	SUBWF       FARG_F76_SUB_LIMITS_F76max+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_F76_SUB_LIMITS412
	CLRF        _GsubMenu+0 
L_F76_SUB_LIMITS412:
;QUADRO.c,2211 :: 		}
	GOTO        L_F76_SUB_LIMITS413
L_F76_SUB_LIMITS410:
;QUADRO.c,2214 :: 		if (GsubMenu < F76min) GsubMenu = F76max;
	MOVF        FARG_F76_SUB_LIMITS_F76min+0, 0 
	SUBWF       _GsubMenu+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_F76_SUB_LIMITS414
	MOVF        FARG_F76_SUB_LIMITS_F76max+0, 0 
	MOVWF       _GsubMenu+0 
L_F76_SUB_LIMITS414:
;QUADRO.c,2215 :: 		if (GsubMenu > F76max) GsubMenu = F76min;
	MOVF        _GsubMenu+0, 0 
	SUBWF       FARG_F76_SUB_LIMITS_F76max+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_F76_SUB_LIMITS415
	MOVF        FARG_F76_SUB_LIMITS_F76min+0, 0 
	MOVWF       _GsubMenu+0 
L_F76_SUB_LIMITS415:
;QUADRO.c,2216 :: 		}
L_F76_SUB_LIMITS413:
;QUADRO.c,2217 :: 		}
L_end_F76_SUB_LIMITS:
	RETURN      0
; end of _F76_SUB_LIMITS

_F78_MENU:

;QUADRO.c,2219 :: 		void F78_MENU(void)
;QUADRO.c,2223 :: 		if (Gmenu > itens)
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__F78_MENU723
	MOVF        _Gmenu+0, 0 
	SUBLW       9
L__F78_MENU723:
	BTFSC       STATUS+0, 0 
	GOTO        L_F78_MENU416
;QUADRO.c,2225 :: 		Gmenu = 1;
	MOVLW       1
	MOVWF       _Gmenu+0 
;QUADRO.c,2226 :: 		}
L_F78_MENU416:
;QUADRO.c,2227 :: 		if (0 == Gmenu)
	MOVLW       0
	XORWF       _Gmenu+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F78_MENU417
;QUADRO.c,2229 :: 		Gmenu = itens;
	MOVLW       9
	MOVWF       _Gmenu+0 
;QUADRO.c,2230 :: 		}
L_F78_MENU417:
;QUADRO.c,2231 :: 		if (Gmenu>9)
	MOVF        _Gmenu+0, 0 
	SUBLW       9
	BTFSC       STATUS+0, 0 
	GOTO        L_F78_MENU418
;QUADRO.c,2233 :: 		Gunidade7SEG = Num_Let_7Se[1];
	MOVLW       48
	MOVWF       _Gunidade7SEG+0 
;QUADRO.c,2234 :: 		Gdezena7SEG = Num_Let_7Se[Gmenu-10];
	MOVLW       10
	SUBWF       _Gmenu+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       _Num_Let_7Se+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_7Se+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(_Num_Let_7Se+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _Gdezena7SEG+0
;QUADRO.c,2235 :: 		}
	GOTO        L_F78_MENU419
L_F78_MENU418:
;QUADRO.c,2238 :: 		Gunidade7SEG = Num_Let_7Se[0];
	MOVLW       250
	MOVWF       _Gunidade7SEG+0 
;QUADRO.c,2239 :: 		Gdezena7SEG = Num_Let_7Se[Gmenu];
	MOVLW       _Num_Let_7Se+0
	ADDWF       _Gmenu+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_7Se+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_7Se+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _Gdezena7SEG+0
;QUADRO.c,2240 :: 		}
L_F78_MENU419:
;QUADRO.c,2242 :: 		if (defMenu == Gnivel)
	MOVLW       0
	XORWF       _Gnivel+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F78_MENU420
;QUADRO.c,2244 :: 		stgLcd2[8]  = 'M';
	MOVLW       77
	MOVWF       _stgLcd2+8 
;QUADRO.c,2245 :: 		stgLcd2[9]  = 'e';
	MOVLW       101
	MOVWF       _stgLcd2+9 
;QUADRO.c,2246 :: 		stgLcd2[10]  = 'n';
	MOVLW       110
	MOVWF       _stgLcd2+10 
;QUADRO.c,2247 :: 		stgLcd2[11]  = 'u';
	MOVLW       117
	MOVWF       _stgLcd2+11 
;QUADRO.c,2249 :: 		F78aa = Gmenu%10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _Gmenu+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
;QUADRO.c,2250 :: 		stgLcd2[13] = F78aa+48;
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _stgLcd2+13 
;QUADRO.c,2251 :: 		stgLcd2[14] = '/';
	MOVLW       47
	MOVWF       _stgLcd2+14 
;QUADRO.c,2253 :: 		stgLcd2[15] = F78aa+48;
	MOVLW       57
	MOVWF       _stgLcd2+15 
;QUADRO.c,2254 :: 		if (BitInverter)
	BTFSS       _BitInverter+0, BitPos(_BitInverter+0) 
	GOTO        L_F78_MENU421
;QUADRO.c,2256 :: 		Gdezena7SEG |= _3Bit;//para aparecer o ponto no digito da dezena quando está se acessando o menu
	BSF         _Gdezena7SEG+0, 2 
;QUADRO.c,2257 :: 		}
	GOTO        L_F78_MENU422
L_F78_MENU421:
;QUADRO.c,2260 :: 		Gunidade7SEG |= _3Bit;//para aparecer o ponto no digito da unidade quando está se acessando o menu
	BSF         _Gunidade7SEG+0, 2 
;QUADRO.c,2261 :: 		}
L_F78_MENU422:
;QUADRO.c,2262 :: 		}
L_F78_MENU420:
;QUADRO.c,2275 :: 		switch (Gmenu)
	GOTO        L_F78_MENU423
;QUADRO.c,2277 :: 		case 1:
L_F78_MENU425:
;QUADRO.c,2279 :: 		if (defMenu == Gnivel)
	MOVLW       0
	XORWF       _Gnivel+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F78_MENU426
;QUADRO.c,2281 :: 		stgLcd1[0]  = 'P';
	MOVLW       80
	MOVWF       _stgLcd1+0 
;QUADRO.c,2282 :: 		stgLcd1[1] = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+1 
;QUADRO.c,2283 :: 		stgLcd1[2] = 'r';
	MOVLW       114
	MOVWF       _stgLcd1+2 
;QUADRO.c,2284 :: 		stgLcd1[3] = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+3 
;QUADRO.c,2285 :: 		stgLcd1[4] = 'd';
	MOVLW       100
	MOVWF       _stgLcd1+4 
;QUADRO.c,2286 :: 		stgLcd1[5] = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+5 
;QUADRO.c,2287 :: 		stgLcd1[6] = 's';
	MOVLW       115
	MOVWF       _stgLcd1+6 
;QUADRO.c,2288 :: 		stgLcd1[8]  = 'O';
	MOVLW       79
	MOVWF       _stgLcd1+8 
;QUADRO.c,2289 :: 		stgLcd1[9]  = 'N';
	MOVLW       78
	MOVWF       _stgLcd1+9 
;QUADRO.c,2291 :: 		stgLcd1[11]  = 'O';
	MOVLW       79
	MOVWF       _stgLcd1+11 
;QUADRO.c,2292 :: 		stgLcd1[12]  = 'F';
	MOVLW       70
	MOVWF       _stgLcd1+12 
;QUADRO.c,2293 :: 		stgLcd1[13]  = 'F';
	MOVLW       70
	MOVWF       _stgLcd1+13 
;QUADRO.c,2294 :: 		GsubMenu = 0;
	CLRF        _GsubMenu+0 
;QUADRO.c,2295 :: 		}
	GOTO        L_F78_MENU427
L_F78_MENU426:
;QUADRO.c,2298 :: 		F76_SUB_LIMITS(0, 31);
	CLRF        FARG_F76_SUB_LIMITS_F76min+0 
	MOVLW       31
	MOVWF       FARG_F76_SUB_LIMITS_F76max+0 
	CALL        _F76_SUB_LIMITS+0, 0
;QUADRO.c,2299 :: 		F11_HABILITA_PARADAS(GsubMenu);
	MOVF        _GsubMenu+0, 0 
	MOVWF       FARG_F11_HABILITA_PARADAS_F11adress+0 
	CALL        _F11_HABILITA_PARADAS+0, 0
;QUADRO.c,2300 :: 		}
L_F78_MENU427:
;QUADRO.c,2301 :: 		break;
	GOTO        L_F78_MENU424
;QUADRO.c,2303 :: 		case 2:
L_F78_MENU428:
;QUADRO.c,2305 :: 		if (defMenu == Gnivel)
	MOVLW       0
	XORWF       _Gnivel+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F78_MENU429
;QUADRO.c,2307 :: 		stgLcd1[0]  = 'J';
	MOVLW       74
	MOVWF       _stgLcd1+0 
;QUADRO.c,2308 :: 		stgLcd1[1]  = 'u';
	MOVLW       117
	MOVWF       _stgLcd1+1 
;QUADRO.c,2309 :: 		stgLcd1[2]  = 'm';
	MOVLW       109
	MOVWF       _stgLcd1+2 
;QUADRO.c,2310 :: 		stgLcd1[3]  = 'p';
	MOVLW       112
	MOVWF       _stgLcd1+3 
;QUADRO.c,2311 :: 		stgLcd1[4]  = 'e';
	MOVLW       101
	MOVWF       _stgLcd1+4 
;QUADRO.c,2312 :: 		stgLcd1[5]  = 'r';
	MOVLW       114
	MOVWF       _stgLcd1+5 
;QUADRO.c,2314 :: 		stgLcd1[7]  = 'S';
	MOVLW       83
	MOVWF       _stgLcd1+7 
;QUADRO.c,2315 :: 		stgLcd1[8] = 'e';
	MOVLW       101
	MOVWF       _stgLcd1+8 
;QUADRO.c,2316 :: 		stgLcd1[9] = 'n';
	MOVLW       110
	MOVWF       _stgLcd1+9 
;QUADRO.c,2317 :: 		stgLcd1[10] = 's';
	MOVLW       115
	MOVWF       _stgLcd1+10 
;QUADRO.c,2318 :: 		stgLcd1[11] = 'o';
	MOVLW       111
	MOVWF       _stgLcd1+11 
;QUADRO.c,2319 :: 		stgLcd1[12] = 'r';
	MOVLW       114
	MOVWF       _stgLcd1+12 
;QUADRO.c,2320 :: 		stgLcd1[13] = 'e';
	MOVLW       101
	MOVWF       _stgLcd1+13 
;QUADRO.c,2321 :: 		stgLcd1[14] = 's';
	MOVLW       115
	MOVWF       _stgLcd1+14 
;QUADRO.c,2322 :: 		GsubMenu = 0;
	CLRF        _GsubMenu+0 
;QUADRO.c,2323 :: 		}
	GOTO        L_F78_MENU430
L_F78_MENU429:
;QUADRO.c,2326 :: 		F76_SUB_LIMITS(0, 31);
	CLRF        FARG_F76_SUB_LIMITS_F76min+0 
	MOVLW       31
	MOVWF       FARG_F76_SUB_LIMITS_F76max+0 
	CALL        _F76_SUB_LIMITS+0, 0
;QUADRO.c,2327 :: 		F12_JUMPER_SENSOR(GsubMenu);
	MOVF        _GsubMenu+0, 0 
	MOVWF       FARG_F12_JUMPER_SENSOR_F12address+0 
	CALL        _F12_JUMPER_SENSOR+0, 0
;QUADRO.c,2328 :: 		}
L_F78_MENU430:
;QUADRO.c,2329 :: 		break;
	GOTO        L_F78_MENU424
;QUADRO.c,2331 :: 		case 3:
L_F78_MENU431:
;QUADRO.c,2334 :: 		if (defMenu == Gnivel)
	MOVLW       0
	XORWF       _Gnivel+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F78_MENU432
;QUADRO.c,2336 :: 		stgLcd1[0]  = 'L';
	MOVLW       76
	MOVWF       _stgLcd1+0 
;QUADRO.c,2337 :: 		stgLcd1[1]  = 'i';
	MOVLW       105
	MOVWF       _stgLcd1+1 
;QUADRO.c,2338 :: 		stgLcd1[2]  = 'm';
	MOVLW       109
	MOVWF       _stgLcd1+2 
;QUADRO.c,2339 :: 		stgLcd1[3]  = 'p';
	MOVLW       112
	MOVWF       _stgLcd1+3 
;QUADRO.c,2340 :: 		stgLcd1[4]  = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+4 
;QUADRO.c,2341 :: 		stgLcd1[6]  = 'J';
	MOVLW       74
	MOVWF       _stgLcd1+6 
;QUADRO.c,2342 :: 		stgLcd1[7]  = 'u';
	MOVLW       117
	MOVWF       _stgLcd1+7 
;QUADRO.c,2343 :: 		stgLcd1[8]  = 'm';
	MOVLW       109
	MOVWF       _stgLcd1+8 
;QUADRO.c,2344 :: 		stgLcd1[9]  = 'p';
	MOVLW       112
	MOVWF       _stgLcd1+9 
;QUADRO.c,2345 :: 		stgLcd1[10]  = 'e';
	MOVLW       101
	MOVWF       _stgLcd1+10 
;QUADRO.c,2346 :: 		stgLcd1[11]  = 'r';
	MOVLW       114
	MOVWF       _stgLcd1+11 
;QUADRO.c,2347 :: 		stgLcd1[12]  = 's';
	MOVLW       115
	MOVWF       _stgLcd1+12 
;QUADRO.c,2348 :: 		}
	GOTO        L_F78_MENU433
L_F78_MENU432:
;QUADRO.c,2351 :: 		if (F13_LIMPA_BY_JUMPERS(0))
	CLRF        FARG_F13_LIMPA_BY_JUMPERS_F13oo+0 
	CALL        _F13_LIMPA_BY_JUMPERS+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F78_MENU434
;QUADRO.c,2353 :: 		stgLcd2[0]  = 'T';
	MOVLW       84
	MOVWF       _stgLcd2+0 
;QUADRO.c,2354 :: 		stgLcd2[1]  = 'e';
	MOVLW       101
	MOVWF       _stgLcd2+1 
;QUADRO.c,2355 :: 		stgLcd2[2]  = 'c';
	MOVLW       99
	MOVWF       _stgLcd2+2 
;QUADRO.c,2356 :: 		stgLcd2[3]  = 'l';
	MOVLW       108
	MOVWF       _stgLcd2+3 
;QUADRO.c,2357 :: 		stgLcd2[4]  = 'e';
	MOVLW       101
	MOVWF       _stgLcd2+4 
;QUADRO.c,2358 :: 		stgLcd2[6]  = '#';
	MOVLW       35
	MOVWF       _stgLcd2+6 
;QUADRO.c,2359 :: 		if ('#' == GteclaPress)
	MOVLW       35
	XORWF       _GteclaPress+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F78_MENU435
;QUADRO.c,2361 :: 		F78aa = F13_LIMPA_BY_JUMPERS(1);
	MOVLW       1
	MOVWF       FARG_F13_LIMPA_BY_JUMPERS_F13oo+0 
	CALL        _F13_LIMPA_BY_JUMPERS+0, 0
;QUADRO.c,2362 :: 		GteclaPress = '>';
	MOVLW       62
	MOVWF       _GteclaPress+0 
;QUADRO.c,2363 :: 		}
L_F78_MENU435:
;QUADRO.c,2364 :: 		}
	GOTO        L_F78_MENU436
L_F78_MENU434:
;QUADRO.c,2367 :: 		stgLcd1[0]  = 'T';
	MOVLW       84
	MOVWF       _stgLcd1+0 
;QUADRO.c,2368 :: 		stgLcd1[1]  = 'o';
	MOVLW       111
	MOVWF       _stgLcd1+1 
;QUADRO.c,2369 :: 		stgLcd1[2]  = 'd';
	MOVLW       100
	MOVWF       _stgLcd1+2 
;QUADRO.c,2370 :: 		stgLcd1[3]  = 'o';
	MOVLW       111
	MOVWF       _stgLcd1+3 
;QUADRO.c,2371 :: 		stgLcd1[4]  = 's';
	MOVLW       115
	MOVWF       _stgLcd1+4 
;QUADRO.c,2373 :: 		stgLcd1[6]  =  'o';
	MOVLW       111
	MOVWF       _stgLcd1+6 
;QUADRO.c,2374 :: 		stgLcd1[7]  =  's';
	MOVLW       115
	MOVWF       _stgLcd1+7 
;QUADRO.c,2376 :: 		stgLcd1[9]  =  'J';
	MOVLW       74
	MOVWF       _stgLcd1+9 
;QUADRO.c,2377 :: 		stgLcd1[10]  = 'u';
	MOVLW       117
	MOVWF       _stgLcd1+10 
;QUADRO.c,2378 :: 		stgLcd1[11]  = 'm';
	MOVLW       109
	MOVWF       _stgLcd1+11 
;QUADRO.c,2379 :: 		stgLcd1[12]  = 'p';
	MOVLW       112
	MOVWF       _stgLcd1+12 
;QUADRO.c,2380 :: 		stgLcd1[13]  = 'e';
	MOVLW       101
	MOVWF       _stgLcd1+13 
;QUADRO.c,2381 :: 		stgLcd1[14]  = 'r';
	MOVLW       114
	MOVWF       _stgLcd1+14 
;QUADRO.c,2382 :: 		stgLcd1[15]  = 's';
	MOVLW       115
	MOVWF       _stgLcd1+15 
;QUADRO.c,2384 :: 		stgLcd2[0]  = 'E';
	MOVLW       69
	MOVWF       _stgLcd2+0 
;QUADRO.c,2385 :: 		stgLcd2[1]  = 's';
	MOVLW       115
	MOVWF       _stgLcd2+1 
;QUADRO.c,2386 :: 		stgLcd2[2]  = 't';
	MOVLW       116
	MOVWF       _stgLcd2+2 
;QUADRO.c,2387 :: 		stgLcd2[3]  = defSIMBaTIL;
	MOVLW       205
	MOVWF       _stgLcd2+3 
;QUADRO.c,2388 :: 		stgLcd2[4]  = 'o';
	MOVLW       111
	MOVWF       _stgLcd2+4 
;QUADRO.c,2390 :: 		stgLcd2[6]  = 'L';
	MOVLW       76
	MOVWF       _stgLcd2+6 
;QUADRO.c,2391 :: 		stgLcd2[7]  = 'i';
	MOVLW       105
	MOVWF       _stgLcd2+7 
;QUADRO.c,2392 :: 		stgLcd2[8]  = 'm';
	MOVLW       109
	MOVWF       _stgLcd2+8 
;QUADRO.c,2393 :: 		stgLcd2[9]  = 'p';
	MOVLW       112
	MOVWF       _stgLcd2+9 
;QUADRO.c,2394 :: 		stgLcd2[10]  = 'o';
	MOVLW       111
	MOVWF       _stgLcd2+10 
;QUADRO.c,2395 :: 		stgLcd2[11]  = 's';
	MOVLW       115
	MOVWF       _stgLcd2+11 
;QUADRO.c,2396 :: 		stgLcd2[12]  = '!';
	MOVLW       33
	MOVWF       _stgLcd2+12 
;QUADRO.c,2400 :: 		BitVaiVoltar = 1;
	BSF         _BitVaiVoltar+0, BitPos(_BitVaiVoltar+0) 
;QUADRO.c,2401 :: 		if (GvaiVoltar > 3)
	MOVF        _GvaiVoltar+0, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_F78_MENU437
;QUADRO.c,2403 :: 		BitVaiVoltar = 0;
	BCF         _BitVaiVoltar+0, BitPos(_BitVaiVoltar+0) 
;QUADRO.c,2404 :: 		Gnivel = defMenu;
	CLRF        _Gnivel+0 
;QUADRO.c,2405 :: 		}
L_F78_MENU437:
;QUADRO.c,2406 :: 		}
L_F78_MENU436:
;QUADRO.c,2407 :: 		}
L_F78_MENU433:
;QUADRO.c,2408 :: 		break;
	GOTO        L_F78_MENU424
;QUADRO.c,2410 :: 		case 4:
L_F78_MENU438:
;QUADRO.c,2412 :: 		if (defMenu == Gnivel)
	MOVLW       0
	XORWF       _Gnivel+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F78_MENU439
;QUADRO.c,2414 :: 		stgLcd1[0]  = 'E';
	MOVLW       69
	MOVWF       _stgLcd1+0 
;QUADRO.c,2415 :: 		stgLcd1[1]  = 'd';
	MOVLW       100
	MOVWF       _stgLcd1+1 
;QUADRO.c,2416 :: 		stgLcd1[2]  = 'i';
	MOVLW       105
	MOVWF       _stgLcd1+2 
;QUADRO.c,2417 :: 		stgLcd1[3]  = 't';
	MOVLW       116
	MOVWF       _stgLcd1+3 
;QUADRO.c,2418 :: 		stgLcd1[4]  = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+4 
;QUADRO.c,2420 :: 		stgLcd1[6]  = 'i';
	MOVLW       105
	MOVWF       _stgLcd1+6 
;QUADRO.c,2421 :: 		stgLcd1[7]  = 'D';
	MOVLW       68
	MOVWF       _stgLcd1+7 
;QUADRO.c,2422 :: 		stgLcd1[8]  = 's';
	MOVLW       115
	MOVWF       _stgLcd1+8 
;QUADRO.c,2423 :: 		GidNovaEditada = 0;
	CLRF        _GidNovaEditada+0 
;QUADRO.c,2424 :: 		}
	GOTO        L_F78_MENU440
L_F78_MENU439:
;QUADRO.c,2427 :: 		F76_SUB_LIMITS(0, 31);
	CLRF        FARG_F76_SUB_LIMITS_F76min+0 
	MOVLW       31
	MOVWF       FARG_F76_SUB_LIMITS_F76max+0 
	CALL        _F76_SUB_LIMITS+0, 0
;QUADRO.c,2428 :: 		F14_EDITA_ID();
	CALL        _F14_EDITA_ID+0, 0
;QUADRO.c,2429 :: 		}
L_F78_MENU440:
;QUADRO.c,2430 :: 		break;
	GOTO        L_F78_MENU424
;QUADRO.c,2432 :: 		case 5:
L_F78_MENU441:
;QUADRO.c,2434 :: 		if (defMenu == Gnivel)
	MOVLW       0
	XORWF       _Gnivel+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F78_MENU442
;QUADRO.c,2436 :: 		stgLcd1[0]  = 'C';
	MOVLW       67
	MOVWF       _stgLcd1+0 
;QUADRO.c,2437 :: 		stgLcd1[1]  = 'o';
	MOVLW       111
	MOVWF       _stgLcd1+1 
;QUADRO.c,2438 :: 		stgLcd1[2]  = 'n';
	MOVLW       110
	MOVWF       _stgLcd1+2 
;QUADRO.c,2439 :: 		stgLcd1[3]  = 'f';
	MOVLW       102
	MOVWF       _stgLcd1+3 
;QUADRO.c,2440 :: 		stgLcd1[4]  = 'i';
	MOVLW       105
	MOVWF       _stgLcd1+4 
;QUADRO.c,2441 :: 		stgLcd1[5]  = 'g';
	MOVLW       103
	MOVWF       _stgLcd1+5 
;QUADRO.c,2442 :: 		stgLcd1[6]  = '.';
	MOVLW       46
	MOVWF       _stgLcd1+6 
;QUADRO.c,2444 :: 		stgLcd1[8]  = 'R';
	MOVLW       82
	MOVWF       _stgLcd1+8 
;QUADRO.c,2445 :: 		stgLcd1[9]  = 'e';
	MOVLW       101
	MOVWF       _stgLcd1+9 
;QUADRO.c,2446 :: 		stgLcd1[10] = 'l';
	MOVLW       108
	MOVWF       _stgLcd1+10 
;QUADRO.c,2447 :: 		stgLcd1[11] = 'o';
	MOVLW       111
	MOVWF       _stgLcd1+11 
;QUADRO.c,2448 :: 		stgLcd1[12] = 'g';
	MOVLW       103
	MOVWF       _stgLcd1+12 
;QUADRO.c,2449 :: 		stgLcd1[13] = 'i';
	MOVLW       105
	MOVWF       _stgLcd1+13 
;QUADRO.c,2450 :: 		stgLcd1[14] = 'o';
	MOVLW       111
	MOVWF       _stgLcd1+14 
;QUADRO.c,2451 :: 		}
	GOTO        L_F78_MENU443
L_F78_MENU442:
;QUADRO.c,2454 :: 		F76_SUB_LIMITS(1, 2);
	MOVLW       1
	MOVWF       FARG_F76_SUB_LIMITS_F76min+0 
	MOVLW       2
	MOVWF       FARG_F76_SUB_LIMITS_F76max+0 
	CALL        _F76_SUB_LIMITS+0, 0
;QUADRO.c,2455 :: 		F15_CONF_DS1307();
	CALL        _F15_CONF_DS1307+0, 0
;QUADRO.c,2456 :: 		}
L_F78_MENU443:
;QUADRO.c,2457 :: 		break;
	GOTO        L_F78_MENU424
;QUADRO.c,2459 :: 		case 6:
L_F78_MENU444:
;QUADRO.c,2461 :: 		if (defMenu == Gnivel)
	MOVLW       0
	XORWF       _Gnivel+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F78_MENU445
;QUADRO.c,2463 :: 		stgLcd1[0]  = 	'E';
	MOVLW       69
	MOVWF       _stgLcd1+0 
;QUADRO.c,2464 :: 		stgLcd1[1]  = 	'd';
	MOVLW       100
	MOVWF       _stgLcd1+1 
;QUADRO.c,2465 :: 		stgLcd1[2]  = 	'i';
	MOVLW       105
	MOVWF       _stgLcd1+2 
;QUADRO.c,2466 :: 		stgLcd1[3]  = 	't';
	MOVLW       116
	MOVWF       _stgLcd1+3 
;QUADRO.c,2467 :: 		stgLcd1[4]  = 	'a';
	MOVLW       97
	MOVWF       _stgLcd1+4 
;QUADRO.c,2469 :: 		stgLcd1[6] = 	'S';
	MOVLW       83
	MOVWF       _stgLcd1+6 
;QUADRO.c,2470 :: 		stgLcd1[7] = 	'e';
	MOVLW       101
	MOVWF       _stgLcd1+7 
;QUADRO.c,2471 :: 		stgLcd1[8] = 	'n';
	MOVLW       110
	MOVWF       _stgLcd1+8 
;QUADRO.c,2472 :: 		stgLcd1[9] = 	'h';
	MOVLW       104
	MOVWF       _stgLcd1+9 
;QUADRO.c,2473 :: 		stgLcd1[10] = 	'a';
	MOVLW       97
	MOVWF       _stgLcd1+10 
;QUADRO.c,2474 :: 		}
	GOTO        L_F78_MENU446
L_F78_MENU445:
;QUADRO.c,2477 :: 		F76_SUB_LIMITS(1, 1);
	MOVLW       1
	MOVWF       FARG_F76_SUB_LIMITS_F76min+0 
	MOVLW       1
	MOVWF       FARG_F76_SUB_LIMITS_F76max+0 
	CALL        _F76_SUB_LIMITS+0, 0
;QUADRO.c,2478 :: 		F16_CONFIG_SENHA();
	CALL        _F16_CONFIG_SENHA+0, 0
;QUADRO.c,2479 :: 		}
L_F78_MENU446:
;QUADRO.c,2480 :: 		break;
	GOTO        L_F78_MENU424
;QUADRO.c,2482 :: 		case 7:
L_F78_MENU447:
;QUADRO.c,2484 :: 		if (defMenu == Gnivel)
	MOVLW       0
	XORWF       _Gnivel+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F78_MENU448
;QUADRO.c,2486 :: 		stgLcd1[0]  = 'E';
	MOVLW       69
	MOVWF       _stgLcd1+0 
;QUADRO.c,2487 :: 		stgLcd1[1]  = 'd';
	MOVLW       100
	MOVWF       _stgLcd1+1 
;QUADRO.c,2488 :: 		stgLcd1[2]  = 'i';
	MOVLW       105
	MOVWF       _stgLcd1+2 
;QUADRO.c,2489 :: 		stgLcd1[3]  = 't';
	MOVLW       116
	MOVWF       _stgLcd1+3 
;QUADRO.c,2490 :: 		stgLcd1[4]  = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+4 
;QUADRO.c,2491 :: 		stgLcd1[6]  = 'A';
	MOVLW       65
	MOVWF       _stgLcd1+6 
;QUADRO.c,2492 :: 		stgLcd1[7]  = 'p';
	MOVLW       112
	MOVWF       _stgLcd1+7 
;QUADRO.c,2493 :: 		stgLcd1[8]  = 'e';
	MOVLW       101
	MOVWF       _stgLcd1+8 
;QUADRO.c,2494 :: 		stgLcd1[9]  = 'l';
	MOVLW       108
	MOVWF       _stgLcd1+9 
;QUADRO.c,2495 :: 		stgLcd1[10]  = 'i';
	MOVLW       105
	MOVWF       _stgLcd1+10 
;QUADRO.c,2496 :: 		stgLcd1[11]  = 'd';
	MOVLW       100
	MOVWF       _stgLcd1+11 
;QUADRO.c,2497 :: 		stgLcd1[12]  = 'o';
	MOVLW       111
	MOVWF       _stgLcd1+12 
;QUADRO.c,2498 :: 		stgLcd1[13]  = 's';
	MOVLW       115
	MOVWF       _stgLcd1+13 
;QUADRO.c,2499 :: 		GsubMenu = 0;
	CLRF        _GsubMenu+0 
;QUADRO.c,2500 :: 		}
	GOTO        L_F78_MENU449
L_F78_MENU448:
;QUADRO.c,2503 :: 		F76_SUB_LIMITS(0, 63);
	CLRF        FARG_F76_SUB_LIMITS_F76min+0 
	MOVLW       63
	MOVWF       FARG_F76_SUB_LIMITS_F76max+0 
	CALL        _F76_SUB_LIMITS+0, 0
;QUADRO.c,2504 :: 		F17_EDITA_APELIDOS(GsubMenu);
	MOVF        _GsubMenu+0, 0 
	MOVWF       FARG_F17_EDITA_APELIDOS_UCEnderecoF17+0 
	CALL        _F17_EDITA_APELIDOS+0, 0
;QUADRO.c,2505 :: 		}
L_F78_MENU449:
;QUADRO.c,2506 :: 		break;
	GOTO        L_F78_MENU424
;QUADRO.c,2508 :: 		case 8:
L_F78_MENU450:
;QUADRO.c,2510 :: 		stgLcd1[8]  = 'A';
	MOVLW       65
	MOVWF       _stgLcd1+8 
;QUADRO.c,2511 :: 		stgLcd1[9]  = 'p';
	MOVLW       112
	MOVWF       _stgLcd1+9 
;QUADRO.c,2512 :: 		stgLcd1[10] = 'e';
	MOVLW       101
	MOVWF       _stgLcd1+10 
;QUADRO.c,2513 :: 		stgLcd1[11] = 'l';
	MOVLW       108
	MOVWF       _stgLcd1+11 
;QUADRO.c,2514 :: 		stgLcd1[12] = 'i';
	MOVLW       105
	MOVWF       _stgLcd1+12 
;QUADRO.c,2515 :: 		stgLcd1[13] = 'd';
	MOVLW       100
	MOVWF       _stgLcd1+13 
;QUADRO.c,2516 :: 		stgLcd1[14] = 'o';
	MOVLW       111
	MOVWF       _stgLcd1+14 
;QUADRO.c,2517 :: 		stgLcd1[15] = 's';
	MOVLW       115
	MOVWF       _stgLcd1+15 
;QUADRO.c,2519 :: 		if (defMenu == Gnivel)
	MOVLW       0
	XORWF       _Gnivel+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F78_MENU451
;QUADRO.c,2521 :: 		stgLcd1[0]  = 'F';
	MOVLW       70
	MOVWF       _stgLcd1+0 
;QUADRO.c,2522 :: 		stgLcd1[1]  = 'o';
	MOVLW       111
	MOVWF       _stgLcd1+1 
;QUADRO.c,2523 :: 		stgLcd1[2]  = 'r';
	MOVLW       114
	MOVWF       _stgLcd1+2 
;QUADRO.c,2524 :: 		stgLcd1[3]  = 'm';
	MOVLW       109
	MOVWF       _stgLcd1+3 
;QUADRO.c,2525 :: 		stgLcd1[4]  = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+4 
;QUADRO.c,2526 :: 		stgLcd1[5]  = 't';
	MOVLW       116
	MOVWF       _stgLcd1+5 
;QUADRO.c,2527 :: 		stgLcd1[6]  = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+6 
;QUADRO.c,2528 :: 		}
	GOTO        L_F78_MENU452
L_F78_MENU451:
;QUADRO.c,2531 :: 		stgLcd2[0]  = 'T';
	MOVLW       84
	MOVWF       _stgLcd2+0 
;QUADRO.c,2532 :: 		stgLcd2[1]  = 'e';
	MOVLW       101
	MOVWF       _stgLcd2+1 
;QUADRO.c,2533 :: 		stgLcd2[2]  = 'c';
	MOVLW       99
	MOVWF       _stgLcd2+2 
;QUADRO.c,2534 :: 		stgLcd2[3]  = 'l';
	MOVLW       108
	MOVWF       _stgLcd2+3 
;QUADRO.c,2535 :: 		stgLcd2[4]  = 'e';
	MOVLW       101
	MOVWF       _stgLcd2+4 
;QUADRO.c,2536 :: 		stgLcd2[6]  = '#';
	MOVLW       35
	MOVWF       _stgLcd2+6 
;QUADRO.c,2537 :: 		stgLcd2[7]  = ' ';
	MOVLW       32
	MOVWF       _stgLcd2+7 
;QUADRO.c,2538 :: 		if ('#' == GteclaPress)
	MOVLW       35
	XORWF       _GteclaPress+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F78_MENU453
;QUADRO.c,2540 :: 		BitVaiVoltar = 1;
	BSF         _BitVaiVoltar+0, BitPos(_BitVaiVoltar+0) 
;QUADRO.c,2541 :: 		F18_FORMATA_APELIDOS();
	CALL        _F18_FORMATA_APELIDOS+0, 0
;QUADRO.c,2542 :: 		GteclaPress = '>';
	MOVLW       62
	MOVWF       _GteclaPress+0 
;QUADRO.c,2543 :: 		}
L_F78_MENU453:
;QUADRO.c,2544 :: 		if (GvaiVoltar > 3)
	MOVF        _GvaiVoltar+0, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_F78_MENU454
;QUADRO.c,2546 :: 		BitVaiVoltar = 0;
	BCF         _BitVaiVoltar+0, BitPos(_BitVaiVoltar+0) 
;QUADRO.c,2547 :: 		Gnivel = defMenu;
	CLRF        _Gnivel+0 
;QUADRO.c,2548 :: 		}
L_F78_MENU454:
;QUADRO.c,2549 :: 		if (BitVaiVoltar)
	BTFSS       _BitVaiVoltar+0, BitPos(_BitVaiVoltar+0) 
	GOTO        L_F78_MENU455
;QUADRO.c,2551 :: 		stgLcd1[0]  = 	'A';
	MOVLW       65
	MOVWF       _stgLcd1+0 
;QUADRO.c,2552 :: 		stgLcd1[1]  = 	'p';
	MOVLW       112
	MOVWF       _stgLcd1+1 
;QUADRO.c,2553 :: 		stgLcd1[2] = 	'e';
	MOVLW       101
	MOVWF       _stgLcd1+2 
;QUADRO.c,2554 :: 		stgLcd1[3] = 	'l';
	MOVLW       108
	MOVWF       _stgLcd1+3 
;QUADRO.c,2555 :: 		stgLcd1[4] = 	'i';
	MOVLW       105
	MOVWF       _stgLcd1+4 
;QUADRO.c,2556 :: 		stgLcd1[5] = 	'd';
	MOVLW       100
	MOVWF       _stgLcd1+5 
;QUADRO.c,2557 :: 		stgLcd1[6] = 	'o';
	MOVLW       111
	MOVWF       _stgLcd1+6 
;QUADRO.c,2558 :: 		stgLcd1[7] = 	's';
	MOVLW       115
	MOVWF       _stgLcd1+7 
;QUADRO.c,2568 :: 		stgLcd2[0]  = 	'F';
	MOVLW       70
	MOVWF       _stgLcd2+0 
;QUADRO.c,2569 :: 		stgLcd2[1]  = 	'o';
	MOVLW       111
	MOVWF       _stgLcd2+1 
;QUADRO.c,2570 :: 		stgLcd2[2]  = 	'r';
	MOVLW       114
	MOVWF       _stgLcd2+2 
;QUADRO.c,2571 :: 		stgLcd2[3]  = 	'm';
	MOVLW       109
	MOVWF       _stgLcd2+3 
;QUADRO.c,2572 :: 		stgLcd2[4]  = 	'a';
	MOVLW       97
	MOVWF       _stgLcd2+4 
;QUADRO.c,2573 :: 		stgLcd2[5]  = 	't';
	MOVLW       116
	MOVWF       _stgLcd2+5 
;QUADRO.c,2574 :: 		stgLcd2[6]  = 	'a';
	MOVLW       97
	MOVWF       _stgLcd2+6 
;QUADRO.c,2575 :: 		stgLcd2[7]  = 	'd';
	MOVLW       100
	MOVWF       _stgLcd2+7 
;QUADRO.c,2576 :: 		stgLcd2[8]  = 	'o';
	MOVLW       111
	MOVWF       _stgLcd2+8 
;QUADRO.c,2577 :: 		stgLcd2[9]  = 	's';
	MOVLW       115
	MOVWF       _stgLcd2+9 
;QUADRO.c,2578 :: 		stgLcd2[10]  = 	'!';
	MOVLW       33
	MOVWF       _stgLcd2+10 
;QUADRO.c,2584 :: 		}
L_F78_MENU455:
;QUADRO.c,2585 :: 		}
L_F78_MENU452:
;QUADRO.c,2586 :: 		break;
	GOTO        L_F78_MENU424
;QUADRO.c,2588 :: 		case 9:
L_F78_MENU456:
;QUADRO.c,2591 :: 		if (defMenu == Gnivel)
	MOVLW       0
	XORWF       _Gnivel+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F78_MENU457
;QUADRO.c,2593 :: 		stgLcd1[0]  = 'C';
	MOVLW       67
	MOVWF       _stgLcd1+0 
;QUADRO.c,2594 :: 		stgLcd1[1]  = 'o';
	MOVLW       111
	MOVWF       _stgLcd1+1 
;QUADRO.c,2595 :: 		stgLcd1[2]  = 'n';
	MOVLW       110
	MOVWF       _stgLcd1+2 
;QUADRO.c,2596 :: 		stgLcd1[3]  = 'f';
	MOVLW       102
	MOVWF       _stgLcd1+3 
;QUADRO.c,2597 :: 		stgLcd1[4]  = 'i';
	MOVLW       105
	MOVWF       _stgLcd1+4 
;QUADRO.c,2598 :: 		stgLcd1[5]  = 'g';
	MOVLW       103
	MOVWF       _stgLcd1+5 
;QUADRO.c,2599 :: 		stgLcd1[6]  = '.';
	MOVLW       46
	MOVWF       _stgLcd1+6 
;QUADRO.c,2600 :: 		stgLcd1[8]  = 'G';
	MOVLW       71
	MOVWF       _stgLcd1+8 
;QUADRO.c,2601 :: 		stgLcd1[9]  = 'e';
	MOVLW       101
	MOVWF       _stgLcd1+9 
;QUADRO.c,2602 :: 		stgLcd1[10] = 'r';
	MOVLW       114
	MOVWF       _stgLcd1+10 
;QUADRO.c,2603 :: 		stgLcd1[11] = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+11 
;QUADRO.c,2604 :: 		stgLcd1[12] = 'i';
	MOVLW       105
	MOVWF       _stgLcd1+12 
;QUADRO.c,2605 :: 		stgLcd1[13] = 's';
	MOVLW       115
	MOVWF       _stgLcd1+13 
;QUADRO.c,2606 :: 		}
	GOTO        L_F78_MENU458
L_F78_MENU457:
;QUADRO.c,2609 :: 		F76_SUB_LIMITS(defPAG1, defPAG2);
	MOVLW       96
	MOVWF       FARG_F76_SUB_LIMITS_F76min+0 
	MOVLW       97
	MOVWF       FARG_F76_SUB_LIMITS_F76max+0 
	CALL        _F76_SUB_LIMITS+0, 0
;QUADRO.c,2610 :: 		F19_CONFIG_GERAIS(GsubMenu);
	MOVF        _GsubMenu+0, 0 
	MOVWF       FARG_F19_CONFIG_GERAIS_F19address+0 
	CALL        _F19_CONFIG_GERAIS+0, 0
;QUADRO.c,2611 :: 		}
L_F78_MENU458:
;QUADRO.c,2612 :: 		break;
	GOTO        L_F78_MENU424
;QUADRO.c,2614 :: 		}
L_F78_MENU423:
	MOVF        _Gmenu+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_F78_MENU425
	MOVF        _Gmenu+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_F78_MENU428
	MOVF        _Gmenu+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_F78_MENU431
	MOVF        _Gmenu+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_F78_MENU438
	MOVF        _Gmenu+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_F78_MENU441
	MOVF        _Gmenu+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_F78_MENU444
	MOVF        _Gmenu+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_F78_MENU447
	MOVF        _Gmenu+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_F78_MENU450
	MOVF        _Gmenu+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_F78_MENU456
L_F78_MENU424:
;QUADRO.c,2615 :: 		}
L_end_F78_MENU:
	RETURN      0
; end of _F78_MENU

_F80_LOGIN:

;QUADRO.c,2617 :: 		void F80_LOGIN(void)
;QUADRO.c,2619 :: 		unsigned short SenhaEscondida[] = "493824";//123456 * 4
	MOVLW       52
	MOVWF       F80_LOGIN_SenhaEscondida_L0+0 
	MOVLW       57
	MOVWF       F80_LOGIN_SenhaEscondida_L0+1 
	MOVLW       51
	MOVWF       F80_LOGIN_SenhaEscondida_L0+2 
	MOVLW       56
	MOVWF       F80_LOGIN_SenhaEscondida_L0+3 
	MOVLW       50
	MOVWF       F80_LOGIN_SenhaEscondida_L0+4 
	MOVLW       52
	MOVWF       F80_LOGIN_SenhaEscondida_L0+5 
	CLRF        F80_LOGIN_SenhaEscondida_L0+6 
;QUADRO.c,2623 :: 		switch (GloginState)
	GOTO        L_F80_LOGIN459
;QUADRO.c,2625 :: 		case def1PWDDESLOGADO: //deslogado
L_F80_LOGIN461:
;QUADRO.c,2627 :: 		if (('A' == GteclaPress) & (defVisualiza == Gnivel))
	MOVLW       65
	XORWF       _GteclaPress+0, 0 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVLW       1
	XORWF       _Gnivel+0, 0 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F80_LOGIN462
;QUADRO.c,2629 :: 		Gnivel = defMenu; //APRESENTACAO MENUS
	CLRF        _Gnivel+0 
;QUADRO.c,2630 :: 		}
L_F80_LOGIN462:
;QUADRO.c,2631 :: 		if ('B' == GteclaPress)
	MOVLW       66
	XORWF       _GteclaPress+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F80_LOGIN463
;QUADRO.c,2633 :: 		if (def1STOPPED == GstateELEVA)
	MOVLW       0
	XORWF       _GstateELEVA+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F80_LOGIN464
;QUADRO.c,2635 :: 		if (F00_BIT_ON_OFF(defPAG1, _4Bit))//SENHA PARA ACESSAR MENU?
	MOVLW       96
	MOVWF       FARG_F00_BIT_ON_OFF_endereco+0 
	MOVLW       8
	MOVWF       FARG_F00_BIT_ON_OFF_campo+0 
	CALL        _F00_BIT_ON_OFF+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F80_LOGIN465
;QUADRO.c,2637 :: 		GloginState = defPWDIN3; //SALTA PARA PODER CONFIGURAR SENHA
	MOVLW       3
	MOVWF       _GloginState+0 
;QUADRO.c,2638 :: 		GposSenha = 0;
	CLRF        _GposSenha+0 
;QUADRO.c,2639 :: 		for (F80aa = 0; F80aa != 6; F80aa++)
	CLRF        F80_LOGIN_F80aa_L0+0 
L_F80_LOGIN466:
	MOVF        F80_LOGIN_F80aa_L0+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_F80_LOGIN467
;QUADRO.c,2641 :: 		stgSenhaDigitada[F80aa] = 32;
	MOVLW       _stgSenhaDigitada+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgSenhaDigitada+0)
	MOVWF       FSR1H 
	MOVF        F80_LOGIN_F80aa_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       32
	MOVWF       POSTINC1+0 
;QUADRO.c,2642 :: 		stgSenhaOculta[F80aa] = 32;
	MOVLW       _stgSenhaOculta+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgSenhaOculta+0)
	MOVWF       FSR1H 
	MOVF        F80_LOGIN_F80aa_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       32
	MOVWF       POSTINC1+0 
;QUADRO.c,2639 :: 		for (F80aa = 0; F80aa != 6; F80aa++)
	INCF        F80_LOGIN_F80aa_L0+0, 1 
;QUADRO.c,2643 :: 		}
	GOTO        L_F80_LOGIN466
L_F80_LOGIN467:
;QUADRO.c,2644 :: 		Gmenu = 1;
	MOVLW       1
	MOVWF       _Gmenu+0 
;QUADRO.c,2645 :: 		}
	GOTO        L_F80_LOGIN469
L_F80_LOGIN465:
;QUADRO.c,2648 :: 		GloginState = defPWDOK5;
	MOVLW       5
	MOVWF       _GloginState+0 
;QUADRO.c,2649 :: 		}
L_F80_LOGIN469:
;QUADRO.c,2650 :: 		}
L_F80_LOGIN464:
;QUADRO.c,2651 :: 		}
L_F80_LOGIN463:
;QUADRO.c,2652 :: 		if ('*' == GteclaPress)
	MOVLW       42
	XORWF       _GteclaPress+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F80_LOGIN470
;QUADRO.c,2654 :: 		GloginState = defPWDRECOVE;//WHATS GOING ON HERE?
	MOVLW       7
	MOVWF       _GloginState+0 
;QUADRO.c,2655 :: 		}
L_F80_LOGIN470:
;QUADRO.c,2656 :: 		break;
	GOTO        L_F80_LOGIN460
;QUADRO.c,2658 :: 		case defPWDIN3 ://LOGANDO, INSERINDO SENHA
L_F80_LOGIN471:
;QUADRO.c,2660 :: 		if ('A' == GteclaPress)
	MOVLW       65
	XORWF       _GteclaPress+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F80_LOGIN472
;QUADRO.c,2662 :: 		F07_CONFIGURA_SISTEMA(1);
	MOVLW       1
	MOVWF       FARG_F07_CONFIGURA_SISTEMA_como+0 
	CALL        _F07_CONFIGURA_SISTEMA+0, 0
;QUADRO.c,2663 :: 		}
L_F80_LOGIN472:
;QUADRO.c,2664 :: 		if ((GteclaPress > 47) & (GteclaPress < 58) & (GposSenha < 6))
	MOVF        _GteclaPress+0, 0 
	SUBLW       47
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       58
	SUBWF       _GteclaPress+0, 0 
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVLW       6
	SUBWF       _GposSenha+0, 0 
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F80_LOGIN473
;QUADRO.c,2666 :: 		stgSenhaDigitada[GposSenha] = GteclaPress;
	MOVLW       _stgSenhaDigitada+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgSenhaDigitada+0)
	MOVWF       FSR1H 
	MOVF        _GposSenha+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        _GteclaPress+0, 0 
	MOVWF       POSTINC1+0 
;QUADRO.c,2667 :: 		stgSenhaOculta[GposSenha] = 42; //42 é = *
	MOVLW       _stgSenhaOculta+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgSenhaOculta+0)
	MOVWF       FSR1H 
	MOVF        _GposSenha+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       42
	MOVWF       POSTINC1+0 
;QUADRO.c,2668 :: 		GposSenha++;
	INCF        _GposSenha+0, 1 
;QUADRO.c,2669 :: 		}
L_F80_LOGIN473:
;QUADRO.c,2670 :: 		if (GposSenha > 5)//avalia
	MOVF        _GposSenha+0, 0 
	SUBLW       5
	BTFSC       STATUS+0, 0 
	GOTO        L_F80_LOGIN474
;QUADRO.c,2672 :: 		BitSenhaOk1 = 1; //VAMOS TER FÉ
	BSF         F80_LOGIN_BitSenhaOk1_L0+0, BitPos(F80_LOGIN_BitSenhaOk1_L0+0) 
;QUADRO.c,2673 :: 		for (F80aa = 0; F80aa != 6; F80aa++)
	CLRF        F80_LOGIN_F80aa_L0+0 
L_F80_LOGIN475:
	MOVF        F80_LOGIN_F80aa_L0+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_F80_LOGIN476
;QUADRO.c,2675 :: 		if (stgSenhaDigitada[F80aa] != EEPROM_Read(F80aa+250))
	MOVLW       _stgSenhaDigitada+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_stgSenhaDigitada+0)
	MOVWF       FSR0H 
	MOVF        F80_LOGIN_F80aa_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__F80_LOGIN+0 
	MOVLW       250
	ADDWF       F80_LOGIN_F80aa_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        FLOC__F80_LOGIN+0, 0 
	XORWF       R0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_F80_LOGIN478
;QUADRO.c,2677 :: 		BitSenhaOk1 = 0; //QUALQUER DIFERENCA ZERA VALOR
	BCF         F80_LOGIN_BitSenhaOk1_L0+0, BitPos(F80_LOGIN_BitSenhaOk1_L0+0) 
;QUADRO.c,2678 :: 		break;//não tem mais porque continuar procurando
	GOTO        L_F80_LOGIN476
;QUADRO.c,2679 :: 		}
L_F80_LOGIN478:
;QUADRO.c,2673 :: 		for (F80aa = 0; F80aa != 6; F80aa++)
	INCF        F80_LOGIN_F80aa_L0+0, 1 
;QUADRO.c,2680 :: 		}
	GOTO        L_F80_LOGIN475
L_F80_LOGIN476:
;QUADRO.c,2681 :: 		BitSenhaOk2 = 1; //VAMOS TER FÉ
	BSF         F80_LOGIN_BitSenhaOk2_L0+0, BitPos(F80_LOGIN_BitSenhaOk2_L0+0) 
;QUADRO.c,2682 :: 		for (F80aa = 0; F80aa != 6; F80aa++)
	CLRF        F80_LOGIN_F80aa_L0+0 
L_F80_LOGIN479:
	MOVF        F80_LOGIN_F80aa_L0+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_F80_LOGIN480
;QUADRO.c,2684 :: 		if (stgSenhaDigitada[F80aa] != SenhaEscondida[F80aa])
	MOVLW       _stgSenhaDigitada+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_stgSenhaDigitada+0)
	MOVWF       FSR0H 
	MOVF        F80_LOGIN_F80aa_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVLW       F80_LOGIN_SenhaEscondida_L0+0
	MOVWF       FSR2 
	MOVLW       hi_addr(F80_LOGIN_SenhaEscondida_L0+0)
	MOVWF       FSR2H 
	MOVF        F80_LOGIN_F80aa_L0+0, 0 
	ADDWF       FSR2, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR2H, 1 
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_F80_LOGIN482
;QUADRO.c,2686 :: 		BitSenhaOk2 = 0; //QUALQUER DIFERENCA ZERA VALOR
	BCF         F80_LOGIN_BitSenhaOk2_L0+0, BitPos(F80_LOGIN_BitSenhaOk2_L0+0) 
;QUADRO.c,2687 :: 		break;//não tem mais porque continuar procurando
	GOTO        L_F80_LOGIN480
;QUADRO.c,2688 :: 		}
L_F80_LOGIN482:
;QUADRO.c,2682 :: 		for (F80aa = 0; F80aa != 6; F80aa++)
	INCF        F80_LOGIN_F80aa_L0+0, 1 
;QUADRO.c,2689 :: 		}
	GOTO        L_F80_LOGIN479
L_F80_LOGIN480:
;QUADRO.c,2690 :: 		if (BitSenhaOk2 | BitSenhaOk1)
	BTFSC       F80_LOGIN_BitSenhaOk2_L0+0, BitPos(F80_LOGIN_BitSenhaOk2_L0+0) 
	GOTO        L__F80_LOGIN725
	BTFSC       F80_LOGIN_BitSenhaOk1_L0+0, BitPos(F80_LOGIN_BitSenhaOk1_L0+0) 
	GOTO        L__F80_LOGIN725
	BCF         4056, 0 
	GOTO        L__F80_LOGIN726
L__F80_LOGIN725:
	BSF         4056, 0 
L__F80_LOGIN726:
	BTFSS       4056, 0 
	GOTO        L_F80_LOGIN483
;QUADRO.c,2692 :: 		GloginState = defPWDOK5; //SENHA CORRETA
	MOVLW       5
	MOVWF       _GloginState+0 
;QUADRO.c,2693 :: 		Gmenu = 1;
	MOVLW       1
	MOVWF       _Gmenu+0 
;QUADRO.c,2694 :: 		}
	GOTO        L_F80_LOGIN484
L_F80_LOGIN483:
;QUADRO.c,2697 :: 		GloginState = defPWDERRADA2; //SENHA ERRADA
	MOVLW       2
	MOVWF       _GloginState+0 
;QUADRO.c,2698 :: 		}
L_F80_LOGIN484:
;QUADRO.c,2699 :: 		Gnivel = defMenu;
	CLRF        _Gnivel+0 
;QUADRO.c,2700 :: 		}
L_F80_LOGIN474:
;QUADRO.c,2701 :: 		stgLcd1[0]  = 'D';
	MOVLW       68
	MOVWF       _stgLcd1+0 
;QUADRO.c,2702 :: 		stgLcd1[1]  = 'i';
	MOVLW       105
	MOVWF       _stgLcd1+1 
;QUADRO.c,2703 :: 		stgLcd1[2]  = 'g';
	MOVLW       103
	MOVWF       _stgLcd1+2 
;QUADRO.c,2704 :: 		stgLcd1[3]  = 'i';
	MOVLW       105
	MOVWF       _stgLcd1+3 
;QUADRO.c,2705 :: 		stgLcd1[4]  = 't';
	MOVLW       116
	MOVWF       _stgLcd1+4 
;QUADRO.c,2706 :: 		stgLcd1[5]  = 'e';
	MOVLW       101
	MOVWF       _stgLcd1+5 
;QUADRO.c,2707 :: 		stgLcd1[7]  = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+7 
;QUADRO.c,2708 :: 		stgLcd1[9]  = 's';
	MOVLW       115
	MOVWF       _stgLcd1+9 
;QUADRO.c,2709 :: 		stgLcd1[10] = 'e';
	MOVLW       101
	MOVWF       _stgLcd1+10 
;QUADRO.c,2710 :: 		stgLcd1[11] = 'n';
	MOVLW       110
	MOVWF       _stgLcd1+11 
;QUADRO.c,2711 :: 		stgLcd1[12] = 'h';
	MOVLW       104
	MOVWF       _stgLcd1+12 
;QUADRO.c,2712 :: 		stgLcd1[13] = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+13 
;QUADRO.c,2713 :: 		for (F80aa = 0; F80aa != 6; F80aa++)
	CLRF        F80_LOGIN_F80aa_L0+0 
L_F80_LOGIN485:
	MOVF        F80_LOGIN_F80aa_L0+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_F80_LOGIN486
;QUADRO.c,2715 :: 		stgLcd2[F80aa] = stgSenhaOculta[F80aa];
	MOVLW       _stgLcd2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	MOVWF       FSR1H 
	MOVF        F80_LOGIN_F80aa_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       _stgSenhaOculta+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_stgSenhaOculta+0)
	MOVWF       FSR0H 
	MOVF        F80_LOGIN_F80aa_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;QUADRO.c,2713 :: 		for (F80aa = 0; F80aa != 6; F80aa++)
	INCF        F80_LOGIN_F80aa_L0+0, 1 
;QUADRO.c,2716 :: 		}
	GOTO        L_F80_LOGIN485
L_F80_LOGIN486:
;QUADRO.c,2717 :: 		BitAtualizarLcd = 1;
	BSF         _BitAtualizarLcd+0, BitPos(_BitAtualizarLcd+0) 
;QUADRO.c,2718 :: 		break;
	GOTO        L_F80_LOGIN460
;QUADRO.c,2720 :: 		case defPWDERRADA2: //SENHA ERRADA
L_F80_LOGIN488:
;QUADRO.c,2722 :: 		stgLcd1[0]  = 'S';
	MOVLW       83
	MOVWF       _stgLcd1+0 
;QUADRO.c,2723 :: 		stgLcd1[1]  = 'e';
	MOVLW       101
	MOVWF       _stgLcd1+1 
;QUADRO.c,2724 :: 		stgLcd1[2]  = 'n';
	MOVLW       110
	MOVWF       _stgLcd1+2 
;QUADRO.c,2725 :: 		stgLcd1[3]  = 'h';
	MOVLW       104
	MOVWF       _stgLcd1+3 
;QUADRO.c,2726 :: 		stgLcd1[4]  = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+4 
;QUADRO.c,2727 :: 		stgLcd1[6]  = 'E';
	MOVLW       69
	MOVWF       _stgLcd1+6 
;QUADRO.c,2728 :: 		stgLcd1[7]  = 'r';
	MOVLW       114
	MOVWF       _stgLcd1+7 
;QUADRO.c,2729 :: 		stgLcd1[8]  = 'r';
	MOVLW       114
	MOVWF       _stgLcd1+8 
;QUADRO.c,2730 :: 		stgLcd1[9]  = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+9 
;QUADRO.c,2731 :: 		stgLcd1[10] = 'd';
	MOVLW       100
	MOVWF       _stgLcd1+10 
;QUADRO.c,2732 :: 		stgLcd1[11] = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+11 
;QUADRO.c,2733 :: 		BitVaiVoltar = 1;
	BSF         _BitVaiVoltar+0, BitPos(_BitVaiVoltar+0) 
;QUADRO.c,2734 :: 		if (GvaiVoltar > 3)//3 SEGUNDOS
	MOVF        _GvaiVoltar+0, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_F80_LOGIN489
;QUADRO.c,2736 :: 		F07_CONFIGURA_SISTEMA(1); //REINICIA TODAS A VARIAVEIS
	MOVLW       1
	MOVWF       FARG_F07_CONFIGURA_SISTEMA_como+0 
	CALL        _F07_CONFIGURA_SISTEMA+0, 0
;QUADRO.c,2737 :: 		}
L_F80_LOGIN489:
;QUADRO.c,2738 :: 		BitAtualizarLcd = 1;
	BSF         _BitAtualizarLcd+0, BitPos(_BitAtualizarLcd+0) 
;QUADRO.c,2739 :: 		break; //SENHA DIGITADA ESTa INCORRETA
	GOTO        L_F80_LOGIN460
;QUADRO.c,2741 :: 		case defPWDOK5: //LOGADO, SENHA CORRETA
L_F80_LOGIN490:
;QUADRO.c,2743 :: 		if ((0 == rb0_CABINE)&(F00_BIT_ON_OFF(defPAG1, _2Bit)))//CABINE ABERTA PARA MENU?
	BTFSC       RB0_bit+0, BitPos(RB0_bit+0) 
	GOTO        L__F80_LOGIN727
	BSF         R2, 0 
	GOTO        L__F80_LOGIN728
L__F80_LOGIN727:
	BCF         R2, 0 
L__F80_LOGIN728:
	MOVLW       96
	MOVWF       FARG_F00_BIT_ON_OFF_endereco+0 
	MOVLW       2
	MOVWF       FARG_F00_BIT_ON_OFF_campo+0 
	CALL        _F00_BIT_ON_OFF+0, 0
	CLRF        R1 
	BTFSC       R2, 0 
	INCF        R1, 1 
	MOVF        R1, 0 
	ANDWF       R0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       0
	ANDWF       R1, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_F80_LOGIN491
;QUADRO.c,2745 :: 		stgLcd1[0]  = 'A';
	MOVLW       65
	MOVWF       _stgLcd1+0 
;QUADRO.c,2746 :: 		stgLcd1[1]  = 'b';
	MOVLW       98
	MOVWF       _stgLcd1+1 
;QUADRO.c,2747 :: 		stgLcd1[2]  = 'r';
	MOVLW       114
	MOVWF       _stgLcd1+2 
;QUADRO.c,2748 :: 		stgLcd1[3]  = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+3 
;QUADRO.c,2749 :: 		stgLcd1[5]  = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+5 
;QUADRO.c,2750 :: 		stgLcd1[7]  = 'C';
	MOVLW       67
	MOVWF       _stgLcd1+7 
;QUADRO.c,2751 :: 		stgLcd1[8]  = 'a';
	MOVLW       97
	MOVWF       _stgLcd1+8 
;QUADRO.c,2752 :: 		stgLcd1[9]  = 'b';
	MOVLW       98
	MOVWF       _stgLcd1+9 
;QUADRO.c,2753 :: 		stgLcd1[10] = 'i';
	MOVLW       105
	MOVWF       _stgLcd1+10 
;QUADRO.c,2754 :: 		stgLcd1[11] = 'n';
	MOVLW       110
	MOVWF       _stgLcd1+11 
;QUADRO.c,2755 :: 		stgLcd1[12] = 'e';
	MOVLW       101
	MOVWF       _stgLcd1+12 
;QUADRO.c,2756 :: 		BitVaiVoltar = 1;
	BSF         _BitVaiVoltar+0, BitPos(_BitVaiVoltar+0) 
;QUADRO.c,2757 :: 		if (GvaiVoltar > 3)//3 SEGUNDOS
	MOVF        _GvaiVoltar+0, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_F80_LOGIN492
;QUADRO.c,2759 :: 		F07_CONFIGURA_SISTEMA(1); //REINICIA TODAS A VARIAVEIS
	MOVLW       1
	MOVWF       FARG_F07_CONFIGURA_SISTEMA_como+0 
	CALL        _F07_CONFIGURA_SISTEMA+0, 0
;QUADRO.c,2760 :: 		}
L_F80_LOGIN492:
;QUADRO.c,2761 :: 		}
	GOTO        L_F80_LOGIN493
L_F80_LOGIN491:
;QUADRO.c,2764 :: 		if ('A' == GteclaPress)//ESC
	MOVLW       65
	XORWF       _GteclaPress+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F80_LOGIN494
;QUADRO.c,2766 :: 		switch (Gnivel)
	GOTO        L_F80_LOGIN495
;QUADRO.c,2768 :: 		case defMenu: GloginState = def1PWDDESLOGADO;
L_F80_LOGIN497:
	MOVLW       1
	MOVWF       _GloginState+0 
;QUADRO.c,2769 :: 		break; //REINICIA TODAS A VARIAVEIS
	GOTO        L_F80_LOGIN496
;QUADRO.c,2770 :: 		case defVisualiza: Gnivel = defMenu;
L_F80_LOGIN498:
	CLRF        _Gnivel+0 
;QUADRO.c,2771 :: 		break;
	GOTO        L_F80_LOGIN496
;QUADRO.c,2772 :: 		case defEdicao: Gnivel = defVisualiza;
L_F80_LOGIN499:
	MOVLW       1
	MOVWF       _Gnivel+0 
;QUADRO.c,2773 :: 		break;
	GOTO        L_F80_LOGIN496
;QUADRO.c,2774 :: 		default: Gnivel = defVisualiza;
L_F80_LOGIN500:
	MOVLW       1
	MOVWF       _Gnivel+0 
;QUADRO.c,2775 :: 		break;
	GOTO        L_F80_LOGIN496
;QUADRO.c,2776 :: 		}
L_F80_LOGIN495:
	MOVF        _Gnivel+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_F80_LOGIN497
	MOVF        _Gnivel+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_F80_LOGIN498
	MOVF        _Gnivel+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_F80_LOGIN499
	GOTO        L_F80_LOGIN500
L_F80_LOGIN496:
;QUADRO.c,2777 :: 		}
L_F80_LOGIN494:
;QUADRO.c,2778 :: 		if ('B' == GteclaPress)//OK
	MOVLW       66
	XORWF       _GteclaPress+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F80_LOGIN501
;QUADRO.c,2780 :: 		switch (Gnivel)
	GOTO        L_F80_LOGIN502
;QUADRO.c,2782 :: 		case defMenu: if (Gmenu > 0)Gnivel = defVisualiza;
L_F80_LOGIN504:
	MOVF        _Gmenu+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_F80_LOGIN505
	MOVLW       1
	MOVWF       _Gnivel+0 
L_F80_LOGIN505:
;QUADRO.c,2783 :: 		break;
	GOTO        L_F80_LOGIN503
;QUADRO.c,2784 :: 		case defVisualiza: Gnivel = defEdicao;
L_F80_LOGIN506:
	MOVLW       2
	MOVWF       _Gnivel+0 
;QUADRO.c,2785 :: 		break;
	GOTO        L_F80_LOGIN503
;QUADRO.c,2786 :: 		case defEdicao: Gnivel = defVisualiza;
L_F80_LOGIN507:
	MOVLW       1
	MOVWF       _Gnivel+0 
;QUADRO.c,2787 :: 		break;
	GOTO        L_F80_LOGIN503
;QUADRO.c,2788 :: 		default: Gnivel = defVisualiza;
L_F80_LOGIN508:
	MOVLW       1
	MOVWF       _Gnivel+0 
;QUADRO.c,2789 :: 		break;
	GOTO        L_F80_LOGIN503
;QUADRO.c,2790 :: 		}
L_F80_LOGIN502:
	MOVF        _Gnivel+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_F80_LOGIN504
	MOVF        _Gnivel+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_F80_LOGIN506
	MOVF        _Gnivel+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_F80_LOGIN507
	GOTO        L_F80_LOGIN508
L_F80_LOGIN503:
;QUADRO.c,2791 :: 		}
L_F80_LOGIN501:
;QUADRO.c,2792 :: 		if ('C' == GteclaPress)//<--
	MOVLW       67
	XORWF       _GteclaPress+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F80_LOGIN509
;QUADRO.c,2794 :: 		BitNaoSeq = 0; //SERVE PARA NÃO DEIXAR AVALIAR
	BCF         _BitNaoSeq+0, BitPos(_BitNaoSeq+0) 
;QUADRO.c,2795 :: 		switch (Gnivel)
	GOTO        L_F80_LOGIN510
;QUADRO.c,2797 :: 		case defMenu: Gmenu--;
L_F80_LOGIN512:
	DECF        _Gmenu+0, 1 
;QUADRO.c,2798 :: 		break;
	GOTO        L_F80_LOGIN511
;QUADRO.c,2799 :: 		case defVisualiza: GsubMenu--;
L_F80_LOGIN513:
	DECF        _GsubMenu+0, 1 
;QUADRO.c,2800 :: 		break;
	GOTO        L_F80_LOGIN511
;QUADRO.c,2801 :: 		case defEdicao: Gseq--;
L_F80_LOGIN514:
	DECF        _Gseq+0, 1 
;QUADRO.c,2802 :: 		break;
	GOTO        L_F80_LOGIN511
;QUADRO.c,2803 :: 		default: Gmenu = 1;
L_F80_LOGIN515:
	MOVLW       1
	MOVWF       _Gmenu+0 
;QUADRO.c,2804 :: 		break;
	GOTO        L_F80_LOGIN511
;QUADRO.c,2805 :: 		}
L_F80_LOGIN510:
	MOVF        _Gnivel+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_F80_LOGIN512
	MOVF        _Gnivel+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_F80_LOGIN513
	MOVF        _Gnivel+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_F80_LOGIN514
	GOTO        L_F80_LOGIN515
L_F80_LOGIN511:
;QUADRO.c,2806 :: 		}
L_F80_LOGIN509:
;QUADRO.c,2807 :: 		if ('D' == GteclaPress)//-->
	MOVLW       68
	XORWF       _GteclaPress+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F80_LOGIN516
;QUADRO.c,2809 :: 		BitNaoSeq = 0; //SERVE PARA NÃO DEIXAR AVALIAR
	BCF         _BitNaoSeq+0, BitPos(_BitNaoSeq+0) 
;QUADRO.c,2810 :: 		switch (Gnivel)
	GOTO        L_F80_LOGIN517
;QUADRO.c,2812 :: 		case defMenu: Gmenu++;
L_F80_LOGIN519:
	INCF        _Gmenu+0, 1 
;QUADRO.c,2813 :: 		break;
	GOTO        L_F80_LOGIN518
;QUADRO.c,2814 :: 		case defVisualiza: GsubMenu++;
L_F80_LOGIN520:
	INCF        _GsubMenu+0, 1 
;QUADRO.c,2815 :: 		break;
	GOTO        L_F80_LOGIN518
;QUADRO.c,2816 :: 		case defEdicao: Gseq++;
L_F80_LOGIN521:
	INCF        _Gseq+0, 1 
;QUADRO.c,2817 :: 		break;
	GOTO        L_F80_LOGIN518
;QUADRO.c,2818 :: 		default: Gmenu = 1;
L_F80_LOGIN522:
	MOVLW       1
	MOVWF       _Gmenu+0 
;QUADRO.c,2819 :: 		break;
	GOTO        L_F80_LOGIN518
;QUADRO.c,2820 :: 		}
L_F80_LOGIN517:
	MOVF        _Gnivel+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_F80_LOGIN519
	MOVF        _Gnivel+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_F80_LOGIN520
	MOVF        _Gnivel+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_F80_LOGIN521
	GOTO        L_F80_LOGIN522
L_F80_LOGIN518:
;QUADRO.c,2821 :: 		}
L_F80_LOGIN516:
;QUADRO.c,2822 :: 		F78_MENU(); //PODE ACESSAR MENU PORQUE SENHA DIGITADA ESTa CORRETA
	CALL        _F78_MENU+0, 0
;QUADRO.c,2823 :: 		}
L_F80_LOGIN493:
;QUADRO.c,2824 :: 		BitAtualizarLcd = 1;
	BSF         _BitAtualizarLcd+0, BitPos(_BitAtualizarLcd+0) 
;QUADRO.c,2825 :: 		break;
	GOTO        L_F80_LOGIN460
;QUADRO.c,2827 :: 		default:
L_F80_LOGIN523:
;QUADRO.c,2829 :: 		GloginState = def1PWDDESLOGADO;
	MOVLW       1
	MOVWF       _GloginState+0 
;QUADRO.c,2830 :: 		break;
	GOTO        L_F80_LOGIN460
;QUADRO.c,2832 :: 		}
L_F80_LOGIN459:
	MOVF        _GloginState+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_F80_LOGIN461
	MOVF        _GloginState+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_F80_LOGIN471
	MOVF        _GloginState+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_F80_LOGIN488
	MOVF        _GloginState+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_F80_LOGIN490
	GOTO        L_F80_LOGIN523
L_F80_LOGIN460:
;QUADRO.c,2833 :: 		}
L_end_F80_LOGIN:
	RETURN      0
; end of _F80_LOGIN

_F82_COMANDATPIC:

;QUADRO.c,2835 :: 		void F82_COMANDATPIC(void)
;QUADRO.c,2837 :: 		unsigned short F82ReleCmd = 0;
	CLRF        F82_COMANDATPIC_F82ReleCmd_L0+0 
;QUADRO.c,2838 :: 		if (Tecla.IrAte)
	BTFSS       _Tecla+0, 5 
	GOTO        L_F82_COMANDATPIC524
;QUADRO.c,2840 :: 		Tecla.IrAte = 0;
	BCF         _Tecla+0, 5 
;QUADRO.c,2841 :: 		if (32 == GpareAqui)
	MOVLW       32
	XORWF       _GpareAqui+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F82_COMANDATPIC525
;QUADRO.c,2843 :: 		GpareAqui = GidOndeCabineEsta;//ponto de partida
	MOVF        _GidOndeCabineEsta+0, 0 
	MOVWF       _GpareAqui+0 
;QUADRO.c,2844 :: 		}
L_F82_COMANDATPIC525:
;QUADRO.c,2845 :: 		if (Tecla.Sobe & LastTecla.Sobe)
	BTFSS       _Tecla+0, 0 
	GOTO        L__F82_COMANDATPIC730
	BTFSS       _LastTecla+0, 0 
	GOTO        L__F82_COMANDATPIC730
	BSF         4056, 0 
	GOTO        L__F82_COMANDATPIC731
L__F82_COMANDATPIC730:
	BCF         4056, 0 
L__F82_COMANDATPIC731:
	BTFSS       4056, 0 
	GOTO        L_F82_COMANDATPIC526
;QUADRO.c,2847 :: 		LastTecla.Sobe = 0;
	BCF         _LastTecla+0, 0 
;QUADRO.c,2848 :: 		if (F00_BIT_ON_OFF(GpareAqui+1, _6Bit))//pesquisa se andar acima está habilitado
	MOVF        _GpareAqui+0, 0 
	ADDLW       1
	MOVWF       FARG_F00_BIT_ON_OFF_endereco+0 
	MOVLW       32
	MOVWF       FARG_F00_BIT_ON_OFF_campo+0 
	CALL        _F00_BIT_ON_OFF+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F82_COMANDATPIC527
;QUADRO.c,2850 :: 		GpareAqui++;
	INCF        _GpareAqui+0, 1 
;QUADRO.c,2851 :: 		}
L_F82_COMANDATPIC527:
;QUADRO.c,2852 :: 		}
L_F82_COMANDATPIC526:
;QUADRO.c,2853 :: 		if (Tecla.Desce & LastTecla.Desce)
	BTFSS       _Tecla+0, 1 
	GOTO        L__F82_COMANDATPIC732
	BTFSS       _LastTecla+0, 1 
	GOTO        L__F82_COMANDATPIC732
	BSF         4056, 0 
	GOTO        L__F82_COMANDATPIC733
L__F82_COMANDATPIC732:
	BCF         4056, 0 
L__F82_COMANDATPIC733:
	BTFSS       4056, 0 
	GOTO        L_F82_COMANDATPIC528
;QUADRO.c,2855 :: 		LastTecla.Desce = 0;
	BCF         _LastTecla+0, 1 
;QUADRO.c,2856 :: 		if (GpareAqui)	//não pode descer abaixo de zero
	MOVF        _GpareAqui+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F82_COMANDATPIC529
;QUADRO.c,2858 :: 		GpareAqui--;
	DECF        _GpareAqui+0, 1 
;QUADRO.c,2859 :: 		}
L_F82_COMANDATPIC529:
;QUADRO.c,2860 :: 		}
L_F82_COMANDATPIC528:
;QUADRO.c,2861 :: 		Tecla.Sobe = 0;//anula para não mecher no elevador...
	BCF         _Tecla+0, 0 
;QUADRO.c,2862 :: 		Tecla.Desce = 0;//anula para não mecher no elevador...
	BCF         _Tecla+0, 1 
;QUADRO.c,2863 :: 		}
	GOTO        L_F82_COMANDATPIC530
L_F82_COMANDATPIC524:
;QUADRO.c,2866 :: 		if (GpareAqui<32)
	MOVLW       32
	SUBWF       _GpareAqui+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_F82_COMANDATPIC531
;QUADRO.c,2868 :: 		BitPararAqui = 1;
	BSF         _BitPararAqui+0, BitPos(_BitPararAqui+0) 
;QUADRO.c,2869 :: 		}
L_F82_COMANDATPIC531:
;QUADRO.c,2870 :: 		}
L_F82_COMANDATPIC530:
;QUADRO.c,2871 :: 		if (Tecla.Sobe)//botao subir esta pressionado?
	BTFSS       _Tecla+0, 0 
	GOTO        L_F82_COMANDATPIC532
;QUADRO.c,2873 :: 		Tecla.Sobe = 0;
	BCF         _Tecla+0, 0 
;QUADRO.c,2874 :: 		if (0 == BitCancelaCloseOpen)//pode subir?
	BTFSC       _BitCancelaCloseOpen+0, BitPos(_BitCancelaCloseOpen+0) 
	GOTO        L_F82_COMANDATPIC533
;QUADRO.c,2875 :: 		if (0 == BitStopUp)//esta proibido de subir?
	BTFSC       _BitStopUp+0, BitPos(_BitStopUp+0) 
	GOTO        L_F82_COMANDATPIC534
;QUADRO.c,2876 :: 		if (0 == rd0_FIM_SUPERIOR)//rd0_FIM_SUPERIOR at rd0_bit ;
	BTFSC       RD0_bit+0, BitPos(RD0_bit+0) 
	GOTO        L_F82_COMANDATPIC535
;QUADRO.c,2877 :: 		if (def1STOPPED == GstateELEVA)//tem que estar parado para poder subir
	MOVLW       0
	XORWF       _GstateELEVA+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F82_COMANDATPIC536
;QUADRO.c,2878 :: 		GstateELEVA = def1COMINGUP;
	MOVLW       1
	MOVWF       _GstateELEVA+0 
L_F82_COMANDATPIC536:
L_F82_COMANDATPIC535:
L_F82_COMANDATPIC534:
L_F82_COMANDATPIC533:
;QUADRO.c,2879 :: 		}
L_F82_COMANDATPIC532:
;QUADRO.c,2880 :: 		if (Tecla.Nivela)//botao nivelar esta pressionado?
	BTFSS       _Tecla+0, 3 
	GOTO        L_F82_COMANDATPIC537
;QUADRO.c,2882 :: 		Tecla.Nivela = 0;
	BCF         _Tecla+0, 3 
;QUADRO.c,2883 :: 		if (def1STOPPED == GstateELEVA)//somente coloca a nivelar se estiver parado
	MOVLW       0
	XORWF       _GstateELEVA+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F82_COMANDATPIC538
;QUADRO.c,2885 :: 		if (0 == BitCancelaCloseOpen)
	BTFSC       _BitCancelaCloseOpen+0, BitPos(_BitCancelaCloseOpen+0) 
	GOTO        L_F82_COMANDATPIC539
;QUADRO.c,2887 :: 		GstateELEVA = defLEVELING4;
	MOVLW       4
	MOVWF       _GstateELEVA+0 
;QUADRO.c,2888 :: 		}
L_F82_COMANDATPIC539:
;QUADRO.c,2889 :: 		}
L_F82_COMANDATPIC538:
;QUADRO.c,2890 :: 		}
L_F82_COMANDATPIC537:
;QUADRO.c,2891 :: 		if (Tecla.Desce)//botao descer esta pressionado?
	BTFSS       _Tecla+0, 1 
	GOTO        L_F82_COMANDATPIC540
;QUADRO.c,2893 :: 		Tecla.Desce = 0;
	BCF         _Tecla+0, 1 
;QUADRO.c,2894 :: 		if (0 == BitCancelaCloseOpen)//pode descer?
	BTFSC       _BitCancelaCloseOpen+0, BitPos(_BitCancelaCloseOpen+0) 
	GOTO        L_F82_COMANDATPIC541
;QUADRO.c,2895 :: 		if (0 == BitStopDown)//esta proibido de descer?
	BTFSC       _BitStopDown+0, BitPos(_BitStopDown+0) 
	GOTO        L_F82_COMANDATPIC542
;QUADRO.c,2896 :: 		if (0 == rb1_FIM_INFERIOR)//rb1_FIM_INFERIOR at rb1_bit ;
	BTFSC       RB1_bit+0, BitPos(RB1_bit+0) 
	GOTO        L_F82_COMANDATPIC543
;QUADRO.c,2897 :: 		if (def1STOPPED == GstateELEVA)//tem que estar parado para poder descer
	MOVLW       0
	XORWF       _GstateELEVA+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F82_COMANDATPIC544
;QUADRO.c,2899 :: 		GstateELEVA = def2COMINGDOWN;
	MOVLW       2
	MOVWF       _GstateELEVA+0 
;QUADRO.c,2900 :: 		BitDescer=1;
	BSF         _BitDescer+0, BitPos(_BitDescer+0) 
;QUADRO.c,2901 :: 		}
L_F82_COMANDATPIC544:
L_F82_COMANDATPIC543:
L_F82_COMANDATPIC542:
L_F82_COMANDATPIC541:
;QUADRO.c,2902 :: 		}
L_F82_COMANDATPIC540:
;QUADRO.c,2903 :: 		if (Tecla.Para)//botao parar esta pressionado?
	BTFSS       _Tecla+0, 2 
	GOTO        L_F82_COMANDATPIC545
;QUADRO.c,2905 :: 		BitPararAqui = 0;
	BCF         _BitPararAqui+0, BitPos(_BitPararAqui+0) 
;QUADRO.c,2906 :: 		GpareAqui = 32;
	MOVLW       32
	MOVWF       _GpareAqui+0 
;QUADRO.c,2910 :: 		GstateELEVA = def1STOPPED; //isso pode acontecer sob qualquer circunstância
	CLRF        _GstateELEVA+0 
;QUADRO.c,2911 :: 		}
L_F82_COMANDATPIC545:
;QUADRO.c,2912 :: 		if (BitAudioOn)
	BTFSS       _BitAudioOn+0, BitPos(_BitAudioOn+0) 
	GOTO        L_F82_COMANDATPIC546
;QUADRO.c,2914 :: 		BitAudioOn = 0;
	BCF         _BitAudioOn+0, BitPos(_BitAudioOn+0) 
;QUADRO.c,2915 :: 		F82ReleCmd |= defLIGAAUDIO2;
	BSF         F82_COMANDATPIC_F82ReleCmd_L0+0, 1 
;QUADRO.c,2916 :: 		if (0 == Tecla.Audio)
	BTFSC       _Tecla+0, 4 
	GOTO        L_F82_COMANDATPIC547
;QUADRO.c,2918 :: 		F82ReleCmd = def1FALAAUDIO; //insere primeiro bit
	MOVLW       1
	MOVWF       F82_COMANDATPIC_F82ReleCmd_L0+0 
;QUADRO.c,2919 :: 		}
L_F82_COMANDATPIC547:
;QUADRO.c,2920 :: 		}
L_F82_COMANDATPIC546:
;QUADRO.c,2922 :: 		if (rb1_FIM_INFERIOR)//rb1_FIM_INFERIOR
	BTFSS       RB1_bit+0, BitPos(RB1_bit+0) 
	GOTO        L_F82_COMANDATPIC548
;QUADRO.c,2924 :: 		if (def2COMINGDOWN == GstateELEVA)//SE FIM DE CURSO INFERIOR ESTIVER PRESSIONADO, NÃO DEIXA DESCER
	MOVLW       2
	XORWF       _GstateELEVA+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F82_COMANDATPIC549
;QUADRO.c,2926 :: 		GstateELEVA = def1STOPPED;
	CLRF        _GstateELEVA+0 
;QUADRO.c,2927 :: 		}
L_F82_COMANDATPIC549:
;QUADRO.c,2928 :: 		}
L_F82_COMANDATPIC548:
;QUADRO.c,2929 :: 		if (rd0_FIM_SUPERIOR)//rd0_FIM_SUPERIOR at rd0_bit ;
	BTFSS       RD0_bit+0, BitPos(RD0_bit+0) 
	GOTO        L_F82_COMANDATPIC550
;QUADRO.c,2931 :: 		if (def1COMINGUP == GstateELEVA)//SE FIM DE CURSO SUPERIOR ESTIVER PRESSIONADO, NÃO DEIXA SUBIR
	MOVLW       1
	XORWF       _GstateELEVA+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F82_COMANDATPIC551
;QUADRO.c,2933 :: 		GstateELEVA = def1STOPPED;
	CLRF        _GstateELEVA+0 
;QUADRO.c,2934 :: 		}
L_F82_COMANDATPIC551:
;QUADRO.c,2935 :: 		}
L_F82_COMANDATPIC550:
;QUADRO.c,2936 :: 		switch (GstateELEVA)//vai escrever o que isso implica
	GOTO        L_F82_COMANDATPIC552
;QUADRO.c,2938 :: 		case def1STOPPED:
L_F82_COMANDATPIC554:
;QUADRO.c,2940 :: 		F82ReleCmd &= defOFFALL15; //desliga todos relés de comando
	MOVLW       15
	ANDWF       F82_COMANDATPIC_F82ReleCmd_L0+0, 1 
;QUADRO.c,2941 :: 		ContadorDescer=0;
	CLRF        _ContadorDescer+0 
;QUADRO.c,2942 :: 		BitDescer=0;
	BCF         _BitDescer+0, BitPos(_BitDescer+0) 
;QUADRO.c,2943 :: 		break;
	GOTO        L_F82_COMANDATPIC553
;QUADRO.c,2945 :: 		case def1COMINGUP:
L_F82_COMANDATPIC555:
;QUADRO.c,2947 :: 		F82ReleCmd |= defTACTORRISES;
	BSF         F82_COMANDATPIC_F82ReleCmd_L0+0, 4 
;QUADRO.c,2948 :: 		F82ReleCmd |= defTACTORPOWER;
	BSF         F82_COMANDATPIC_F82ReleCmd_L0+0, 7 
;QUADRO.c,2949 :: 		F82ReleCmd &= 0b10011111; //nAo deixa descer e nAo deixa freiar
	MOVLW       159
	ANDWF       F82_COMANDATPIC_F82ReleCmd_L0+0, 1 
;QUADRO.c,2950 :: 		break;
	GOTO        L_F82_COMANDATPIC553
;QUADRO.c,2952 :: 		case def2COMINGDOWN:
L_F82_COMANDATPIC556:
;QUADRO.c,2972 :: 		F82ReleCmd |= defTACTORDOWN;
	BSF         F82_COMANDATPIC_F82ReleCmd_L0+0, 5 
;QUADRO.c,2973 :: 		F82ReleCmd |= defTACTORPOWER;
	BSF         F82_COMANDATPIC_F82ReleCmd_L0+0, 7 
;QUADRO.c,2974 :: 		F82ReleCmd &= 0b10101111; //nAo deixa subir e nAo deixa freiar
	MOVLW       175
	ANDWF       F82_COMANDATPIC_F82ReleCmd_L0+0, 1 
;QUADRO.c,2979 :: 		F82ReleCmd |= defTACTORDOWN;
	BSF         F82_COMANDATPIC_F82ReleCmd_L0+0, 5 
;QUADRO.c,2980 :: 		F82ReleCmd |= defTACTORPOWER;
	BSF         F82_COMANDATPIC_F82ReleCmd_L0+0, 7 
;QUADRO.c,2981 :: 		F82ReleCmd &= 0b10101111; //nAo deixa subir e nAo deixa freiar
	MOVLW       175
	ANDWF       F82_COMANDATPIC_F82ReleCmd_L0+0, 1 
;QUADRO.c,2983 :: 		break;
	GOTO        L_F82_COMANDATPIC553
;QUADRO.c,2985 :: 		case defLEVELING4:
L_F82_COMANDATPIC557:
;QUADRO.c,2987 :: 		if (0 == BitCancelaCloseOpen)
	BTFSC       _BitCancelaCloseOpen+0, BitPos(_BitCancelaCloseOpen+0) 
	GOTO        L_F82_COMANDATPIC558
;QUADRO.c,2989 :: 		F82ReleCmd |= defTACTORBRAKE;
	BSF         F82_COMANDATPIC_F82ReleCmd_L0+0, 6 
;QUADRO.c,2990 :: 		F82ReleCmd |= defTACTORPOWER;
	BSF         F82_COMANDATPIC_F82ReleCmd_L0+0, 7 
;QUADRO.c,2991 :: 		F82ReleCmd &= 0b11001111; //nAo sobe e nAo desce
	MOVLW       207
	ANDWF       F82_COMANDATPIC_F82ReleCmd_L0+0, 1 
;QUADRO.c,2992 :: 		}
	GOTO        L_F82_COMANDATPIC559
L_F82_COMANDATPIC558:
;QUADRO.c,2995 :: 		F82ReleCmd &= defOFFALL15; //desliga todos relés de comando
	MOVLW       15
	ANDWF       F82_COMANDATPIC_F82ReleCmd_L0+0, 1 
;QUADRO.c,2996 :: 		}
L_F82_COMANDATPIC559:
;QUADRO.c,2997 :: 		break;
	GOTO        L_F82_COMANDATPIC553
;QUADRO.c,2999 :: 		}
L_F82_COMANDATPIC552:
	MOVF        _GstateELEVA+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_F82_COMANDATPIC554
	MOVF        _GstateELEVA+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_F82_COMANDATPIC555
	MOVF        _GstateELEVA+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_F82_COMANDATPIC556
	MOVF        _GstateELEVA+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_F82_COMANDATPIC557
L_F82_COMANDATPIC553:
;QUADRO.c,3034 :: 		F01_IMPRIME_TPIC(Gdezena7SEG);
	MOVF        _Gdezena7SEG+0, 0 
	MOVWF       FARG_F01_IMPRIME_TPIC_F01ee+0 
	CALL        _F01_IMPRIME_TPIC+0, 0
;QUADRO.c,3035 :: 		F01_IMPRIME_TPIC(Gunidade7SEG);
	MOVF        _Gunidade7SEG+0, 0 
	MOVWF       FARG_F01_IMPRIME_TPIC_F01ee+0 
	CALL        _F01_IMPRIME_TPIC+0, 0
;QUADRO.c,3036 :: 		F01_IMPRIME_TPIC(F82ReleCmd);
	MOVF        F82_COMANDATPIC_F82ReleCmd_L0+0, 0 
	MOVWF       FARG_F01_IMPRIME_TPIC_F01ee+0 
	CALL        _F01_IMPRIME_TPIC+0, 0
;QUADRO.c,3037 :: 		rc2_REVELA_TPIC = 0; //rc2_REVELA_TPIC at rc2_bit ;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;QUADRO.c,3038 :: 		rc2_REVELA_TPIC = 1; //rc2_REVELA_TPIC at rc2_bit ;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;QUADRO.c,3039 :: 		}
L_end_F82_COMANDATPIC:
	RETURN      0
; end of _F82_COMANDATPIC

_F84_CHAMADAS:

;QUADRO.c,3041 :: 		void F84_CHAMADAS(void)
;QUADRO.c,3043 :: 		switch (GchamadaState)//FATIA SERVICOS EM SEGUNDO PLANO CONFORME PRIORIDADES
	GOTO        L_F84_CHAMADAS560
;QUADRO.c,3045 :: 		case def7ATUALIZAR://
L_F84_CHAMADAS562:
;QUADRO.c,3047 :: 		if (def1PWDDESLOGADO == GloginState)
	MOVLW       1
	XORWF       _GloginState+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F84_CHAMADAS563
;QUADRO.c,3049 :: 		F06_VERIFICA_SITUACAO();
	CALL        _F06_VERIFICA_SITUACAO+0, 0
;QUADRO.c,3050 :: 		}
L_F84_CHAMADAS563:
;QUADRO.c,3051 :: 		GchamadaState = def8TIMEupdade;
	MOVLW       8
	MOVWF       _GchamadaState+0 
;QUADRO.c,3052 :: 		break;
	GOTO        L_F84_CHAMADAS561
;QUADRO.c,3054 :: 		case def8TIMEupdade:
L_F84_CHAMADAS564:
;QUADRO.c,3056 :: 		F03_UPDATE_DS1307(); //ATUALIZA HORA DO SISTEMA
	CALL        _F03_UPDATE_DS1307+0, 0
;QUADRO.c,3057 :: 		GchamadaState = def5NORMAL;
	MOVLW       5
	MOVWF       _GchamadaState+0 
;QUADRO.c,3058 :: 		break;
	GOTO        L_F84_CHAMADAS561
;QUADRO.c,3060 :: 		case def5NORMAL:
L_F84_CHAMADAS565:
;QUADRO.c,3062 :: 		if (GF03segundos != GsecCountLast)//houve mudanca no segundos
	MOVF        _GF03segundos+0, 0 
	XORWF       _GsecCountLast+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_F84_CHAMADAS566
;QUADRO.c,3064 :: 		GsecCountLast = GF03segundos;
	MOVF        _GF03segundos+0, 0 
	MOVWF       _GsecCountLast+0 
;QUADRO.c,3065 :: 		if (BitVaiVoltar) //isso serve para temporização que deve acontecer depois de alguns segundos
	BTFSS       _BitVaiVoltar+0, BitPos(_BitVaiVoltar+0) 
	GOTO        L_F84_CHAMADAS567
;QUADRO.c,3067 :: 		GvaiVoltar++;
	INCF        _GvaiVoltar+0, 1 
;QUADRO.c,3068 :: 		}
	GOTO        L_F84_CHAMADAS568
L_F84_CHAMADAS567:
;QUADRO.c,3071 :: 		GvaiVoltar = 0;
	CLRF        _GvaiVoltar+0 
;QUADRO.c,3072 :: 		}
L_F84_CHAMADAS568:
;QUADRO.c,3073 :: 		}
L_F84_CHAMADAS566:
;QUADRO.c,3074 :: 		break;
	GOTO        L_F84_CHAMADAS561
;QUADRO.c,3076 :: 		default:
L_F84_CHAMADAS569:
;QUADRO.c,3078 :: 		GchamadaState = def5NORMAL;
	MOVLW       5
	MOVWF       _GchamadaState+0 
;QUADRO.c,3079 :: 		break;
	GOTO        L_F84_CHAMADAS561
;QUADRO.c,3081 :: 		}
L_F84_CHAMADAS560:
	MOVF        _GchamadaState+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_F84_CHAMADAS562
	MOVF        _GchamadaState+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_F84_CHAMADAS564
	MOVF        _GchamadaState+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_F84_CHAMADAS565
	GOTO        L_F84_CHAMADAS569
L_F84_CHAMADAS561:
;QUADRO.c,3082 :: 		}
L_end_F84_CHAMADAS:
	RETURN      0
; end of _F84_CHAMADAS

_F86_HA_JUMPERS:

;QUADRO.c,3084 :: 		unsigned short F86_HA_JUMPERS(void)//VAI PESQUISAR POR JUMPERS ATIVOS, RETORNA 0 SE NÃO HOUVER QUALQUER JUMP ATIVO
;QUADRO.c,3088 :: 		for (F86aa = 0;F86aa != 32;F86aa++)
	CLRF        F86_HA_JUMPERS_F86aa_L0+0 
L_F86_HA_JUMPERS570:
	MOVF        F86_HA_JUMPERS_F86aa_L0+0, 0 
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_F86_HA_JUMPERS571
;QUADRO.c,3090 :: 		F86ee = EEPROM_Read(F86aa);
	MOVF        F86_HA_JUMPERS_F86aa_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
;QUADRO.c,3091 :: 		F86ee &= 0b00011111;
	MOVLW       31
	ANDWF       R0, 0 
	MOVWF       R1 
;QUADRO.c,3092 :: 		if (F86ee != 0b00011111)
	MOVF        R1, 0 
	XORLW       31
	BTFSC       STATUS+0, 2 
	GOTO        L_F86_HA_JUMPERS573
;QUADRO.c,3094 :: 		return F86aa+10;//encontrou um jump ativado, pode voltar
	MOVLW       10
	ADDWF       F86_HA_JUMPERS_F86aa_L0+0, 0 
	MOVWF       R0 
	GOTO        L_end_F86_HA_JUMPERS
;QUADRO.c,3095 :: 		}
L_F86_HA_JUMPERS573:
;QUADRO.c,3088 :: 		for (F86aa = 0;F86aa != 32;F86aa++)
	INCF        F86_HA_JUMPERS_F86aa_L0+0, 1 
;QUADRO.c,3096 :: 		}
	GOTO        L_F86_HA_JUMPERS570
L_F86_HA_JUMPERS571:
;QUADRO.c,3097 :: 		return 0;
	CLRF        R0 
;QUADRO.c,3098 :: 		}
L_end_F86_HA_JUMPERS:
	RETURN      0
; end of _F86_HA_JUMPERS

_F92_ID_NOVO:

;QUADRO.c,3101 :: 		unsigned short F92_ID_NOVO(void)//PROCURA POR PLACA NOVA NÃO HABILITADA
;QUADRO.c,3107 :: 		delay_ms(20);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_F92_ID_NOVO574:
	DECFSZ      R13, 1, 1
	BRA         L_F92_ID_NOVO574
	DECFSZ      R12, 1, 1
	BRA         L_F92_ID_NOVO574
	NOP
	NOP
;QUADRO.c,3108 :: 		for (F92aa = 0;F92aa != 32;F92aa++)
	CLRF        F92_ID_NOVO_F92aa_L0+0 
L_F92_ID_NOVO575:
	MOVF        F92_ID_NOVO_F92aa_L0+0, 0 
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_F92_ID_NOVO576
;QUADRO.c,3110 :: 		F92oo = EEPROM_Read(F92aa);
	MOVF        F92_ID_NOVO_F92aa_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
;QUADRO.c,3111 :: 		F92oo &= _6Bit;
	MOVLW       32
	ANDWF       R0, 0 
	MOVWF       R1 
;QUADRO.c,3112 :: 		if (F92oo  == 0)
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_F92_ID_NOVO578
;QUADRO.c,3114 :: 		F92uu = F92aa+10;
	MOVLW       10
	ADDWF       F92_ID_NOVO_F92aa_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       F92_ID_NOVO_F92uu_L0+0 
;QUADRO.c,3115 :: 		F92stg[0] = 244;//INICIO DA TRANSMISSÃO
	MOVLW       244
	MOVWF       F92_ID_NOVO_F92stg_L0+0 
;QUADRO.c,3116 :: 		F92stg[1] = F92uu;
	MOVF        R0, 0 
	MOVWF       F92_ID_NOVO_F92stg_L0+1 
;QUADRO.c,3117 :: 		F92stg[2] = 0b00000100;//PARA NÃO SER VAZIO - ZERO PARA A TRANSMISSÃO
	MOVLW       4
	MOVWF       F92_ID_NOVO_F92stg_L0+2 
;QUADRO.c,3118 :: 		F92stg[3] = F92stg[2]+F92stg[1];
	MOVF        F92_ID_NOVO_F92stg_L0+1, 0 
	ADDLW       4
	MOVWF       F92_ID_NOVO_F92stg_L0+3 
;QUADRO.c,3119 :: 		F92stg[4] = 0;//FIM DA TRANSMISSÃO
	CLRF        F92_ID_NOVO_F92stg_L0+4 
;QUADRO.c,3120 :: 		F05_UART_WRITE(F92stg);
	MOVLW       F92_ID_NOVO_F92stg_L0+0
	MOVWF       FARG_F05_UART_WRITE_Text+0 
	MOVLW       hi_addr(F92_ID_NOVO_F92stg_L0+0)
	MOVWF       FARG_F05_UART_WRITE_Text+1 
	CALL        _F05_UART_WRITE+0, 0
;QUADRO.c,3121 :: 		if (F92uu == GidRecebido)//NOVO ID FOI ENCONTRADO
	MOVF        F92_ID_NOVO_F92uu_L0+0, 0 
	XORWF       _GidRecebido+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F92_ID_NOVO579
;QUADRO.c,3123 :: 		return F92uu;//FUNÇÃO É ENCERRADA PORQUE ENCONTROU NOVA ID
	MOVF        F92_ID_NOVO_F92uu_L0+0, 0 
	MOVWF       R0 
	GOTO        L_end_F92_ID_NOVO
;QUADRO.c,3124 :: 		}
L_F92_ID_NOVO579:
;QUADRO.c,3125 :: 		}
L_F92_ID_NOVO578:
;QUADRO.c,3108 :: 		for (F92aa = 0;F92aa != 32;F92aa++)
	INCF        F92_ID_NOVO_F92aa_L0+0, 1 
;QUADRO.c,3126 :: 		}
	GOTO        L_F92_ID_NOVO575
L_F92_ID_NOVO576:
;QUADRO.c,3127 :: 		return 0;//NÃO FOI ENCONTRADA NOVA ID
	CLRF        R0 
;QUADRO.c,3128 :: 		}
L_end_F92_ID_NOVO:
	RETURN      0
; end of _F92_ID_NOVO

_F94_PROCURA_PROBLEMAS:

;QUADRO.c,3130 :: 		void F94_PROCURA_PROBLEMAS(void)
;QUADRO.c,3139 :: 		F94oo = Bcd2Dec(GF03segundos);
	MOVF        _GF03segundos+0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
;QUADRO.c,3140 :: 		F94aa = F94oo/4;//DE QUATRO EM QUATRO SEGUNDOS PESQUISA POR PROBLEMAS
	MOVF        R0, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	MOVF        R1, 0 
	MOVWF       F94_PROCURA_PROBLEMAS_F94aa_L0+0 
;QUADRO.c,3141 :: 		if (F94aa != GqualMSGlast)//sempre que muda abilita para nova avaliação
	MOVF        R1, 0 
	XORWF       _GqualMSGlast+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_F94_PROCURA_PROBLEMAS580
;QUADRO.c,3143 :: 		GqualMSGlast = F94aa;//iguala para não entrar aqui novamente
	MOVF        F94_PROCURA_PROBLEMAS_F94aa_L0+0, 0 
	MOVWF       _GqualMSGlast+0 
;QUADRO.c,3144 :: 		GqualMSG++;
	INCF        _GqualMSG+0, 1 
;QUADRO.c,3145 :: 		GF94temp = 0;//resultado zerado
	CLRF        _GF94temp+0 
;QUADRO.c,3146 :: 		F94BitAvaliar = 1;//comando avaliar ativo
	BSF         F94_PROCURA_PROBLEMAS_F94BitAvaliar_L0+0, BitPos(F94_PROCURA_PROBLEMAS_F94BitAvaliar_L0+0) 
;QUADRO.c,3147 :: 		}
L_F94_PROCURA_PROBLEMAS580:
;QUADRO.c,3148 :: 		switch (GqualMSG)
	GOTO        L_F94_PROCURA_PROBLEMAS581
;QUADRO.c,3150 :: 		case defPR0:
L_F94_PROCURA_PROBLEMAS583:
;QUADRO.c,3152 :: 		break;//do nothing
	GOTO        L_F94_PROCURA_PROBLEMAS582
;QUADRO.c,3154 :: 		case defPR1:
L_F94_PROCURA_PROBLEMAS584:
;QUADRO.c,3156 :: 		if (F94BitAvaliar)
	BTFSS       F94_PROCURA_PROBLEMAS_F94BitAvaliar_L0+0, BitPos(F94_PROCURA_PROBLEMAS_F94BitAvaliar_L0+0) 
	GOTO        L_F94_PROCURA_PROBLEMAS585
;QUADRO.c,3158 :: 		if (F00_BIT_ON_OFF(defPAG2, _1Bit))
	MOVLW       97
	MOVWF       FARG_F00_BIT_ON_OFF_endereco+0 
	MOVLW       1
	MOVWF       FARG_F00_BIT_ON_OFF_campo+0 
	CALL        _F00_BIT_ON_OFF+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F94_PROCURA_PROBLEMAS586
;QUADRO.c,3160 :: 		GF94temp = F92_ID_NOVO();//procura por placa nova não habilitada
	CALL        _F92_ID_NOVO+0, 0
	MOVF        R0, 0 
	MOVWF       _GF94temp+0 
;QUADRO.c,3161 :: 		}
L_F94_PROCURA_PROBLEMAS586:
;QUADRO.c,3162 :: 		}
L_F94_PROCURA_PROBLEMAS585:
;QUADRO.c,3163 :: 		if (GF94temp)
	MOVF        _GF94temp+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F94_PROCURA_PROBLEMAS587
;QUADRO.c,3165 :: 		GalgumERRO |= _1Bit;
	BSF         _GalgumERRO+0, 0 
;QUADRO.c,3166 :: 		F94pp = GF94temp - 10;
	MOVLW       10
	SUBWF       _GF94temp+0, 0 
	MOVWF       R2 
;QUADRO.c,3167 :: 		F94ss = F94pp * 2;
	MOVF        R2, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       F94_PROCURA_PROBLEMAS_F94ss_L0+0 
;QUADRO.c,3168 :: 		F94par = EEPROM_Read(F94ss+32);
	MOVLW       32
	ADDWF       R0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       F94_PROCURA_PROBLEMAS_F94par_L0+0 
;QUADRO.c,3169 :: 		F94impar = EEPROM_Read(F94ss+33);
	MOVLW       33
	ADDWF       F94_PROCURA_PROBLEMAS_F94ss_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
;QUADRO.c,3170 :: 		stgLcd1[4] = Num_Let_LCD[F94par];
	MOVLW       _Num_Let_LCD+0
	ADDWF       F94_PROCURA_PROBLEMAS_F94par_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _stgLcd1+4
;QUADRO.c,3171 :: 		stgLcd1[5] = Num_Let_LCD[F94impar];
	MOVLW       _Num_Let_LCD+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _stgLcd1+5
;QUADRO.c,3172 :: 		if (BitInverter)
	BTFSS       _BitInverter+0, BitPos(_BitInverter+0) 
	GOTO        L_F94_PROCURA_PROBLEMAS588
;QUADRO.c,3174 :: 		stgLcd1[6] = 	'C';
	MOVLW       67
	MOVWF       _stgLcd1+6 
;QUADRO.c,3175 :: 		stgLcd1[7] = 	'o';
	MOVLW       111
	MOVWF       _stgLcd1+7 
;QUADRO.c,3176 :: 		stgLcd1[8] = 	'n';
	MOVLW       110
	MOVWF       _stgLcd1+8 
;QUADRO.c,3177 :: 		stgLcd1[9] = 	'e';
	MOVLW       101
	MOVWF       _stgLcd1+9 
;QUADRO.c,3178 :: 		stgLcd1[10] = 	'c';
	MOVLW       99
	MOVWF       _stgLcd1+10 
;QUADRO.c,3179 :: 		stgLcd1[11] = 	't';
	MOVLW       116
	MOVWF       _stgLcd1+11 
;QUADRO.c,3180 :: 		stgLcd1[12] = 	'a';
	MOVLW       97
	MOVWF       _stgLcd1+12 
;QUADRO.c,3181 :: 		stgLcd1[13] = 	'd';
	MOVLW       100
	MOVWF       _stgLcd1+13 
;QUADRO.c,3182 :: 		stgLcd1[14] = 	'o';
	MOVLW       111
	MOVWF       _stgLcd1+14 
;QUADRO.c,3183 :: 		stgLcd1[15] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+15 
;QUADRO.c,3184 :: 		}
	GOTO        L_F94_PROCURA_PROBLEMAS589
L_F94_PROCURA_PROBLEMAS588:
;QUADRO.c,3187 :: 		stgLcd1[6] = 	'N';
	MOVLW       78
	MOVWF       _stgLcd1+6 
;QUADRO.c,3188 :: 		stgLcd1[7] = 	'o';
	MOVLW       111
	MOVWF       _stgLcd1+7 
;QUADRO.c,3189 :: 		stgLcd1[8] = 	'v';
	MOVLW       118
	MOVWF       _stgLcd1+8 
;QUADRO.c,3190 :: 		stgLcd1[9] = 	'o';
	MOVLW       111
	MOVWF       _stgLcd1+9 
;QUADRO.c,3191 :: 		stgLcd1[10] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+10 
;QUADRO.c,3192 :: 		stgLcd1[11] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+11 
;QUADRO.c,3193 :: 		stgLcd1[12] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+12 
;QUADRO.c,3194 :: 		stgLcd1[13] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+13 
;QUADRO.c,3195 :: 		stgLcd1[14] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+14 
;QUADRO.c,3196 :: 		stgLcd1[15] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+15 
;QUADRO.c,3197 :: 		}
L_F94_PROCURA_PROBLEMAS589:
;QUADRO.c,3198 :: 		F94BitAvaliar = 0;//ZERO PORQUE FOI 'USADO'
	BCF         F94_PROCURA_PROBLEMAS_F94BitAvaliar_L0+0, BitPos(F94_PROCURA_PROBLEMAS_F94BitAvaliar_L0+0) 
;QUADRO.c,3199 :: 		}
	GOTO        L_F94_PROCURA_PROBLEMAS590
L_F94_PROCURA_PROBLEMAS587:
;QUADRO.c,3202 :: 		GqualMSG=defPR2;
	MOVLW       2
	MOVWF       _GqualMSG+0 
;QUADRO.c,3203 :: 		GalgumERRO &= 0b11111110;
	MOVLW       254
	ANDWF       _GalgumERRO+0, 1 
;QUADRO.c,3204 :: 		}
L_F94_PROCURA_PROBLEMAS590:
;QUADRO.c,3205 :: 		break;
	GOTO        L_F94_PROCURA_PROBLEMAS582
;QUADRO.c,3207 :: 		case defPR2:
L_F94_PROCURA_PROBLEMAS591:
;QUADRO.c,3209 :: 		if (F94BitAvaliar)
	BTFSS       F94_PROCURA_PROBLEMAS_F94BitAvaliar_L0+0, BitPos(F94_PROCURA_PROBLEMAS_F94BitAvaliar_L0+0) 
	GOTO        L_F94_PROCURA_PROBLEMAS592
;QUADRO.c,3211 :: 		if (F00_BIT_ON_OFF(defPAG2, _2Bit))
	MOVLW       97
	MOVWF       FARG_F00_BIT_ON_OFF_endereco+0 
	MOVLW       2
	MOVWF       FARG_F00_BIT_ON_OFF_campo+0 
	CALL        _F00_BIT_ON_OFF+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F94_PROCURA_PROBLEMAS593
;QUADRO.c,3213 :: 		GF94temp = F86_HA_JUMPERS();
	CALL        _F86_HA_JUMPERS+0, 0
	MOVF        R0, 0 
	MOVWF       _GF94temp+0 
;QUADRO.c,3214 :: 		}
L_F94_PROCURA_PROBLEMAS593:
;QUADRO.c,3215 :: 		}
L_F94_PROCURA_PROBLEMAS592:
;QUADRO.c,3216 :: 		if (GF94temp)
	MOVF        _GF94temp+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F94_PROCURA_PROBLEMAS594
;QUADRO.c,3218 :: 		GalgumERRO |= _2Bit;
	BSF         _GalgumERRO+0, 1 
;QUADRO.c,3219 :: 		F94pp = GF94temp - 10;
	MOVLW       10
	SUBWF       _GF94temp+0, 0 
	MOVWF       R2 
;QUADRO.c,3220 :: 		F94ss = F94pp * 2;
	MOVF        R2, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       F94_PROCURA_PROBLEMAS_F94ss_L0+0 
;QUADRO.c,3221 :: 		F94par = EEPROM_Read(F94ss+32);
	MOVLW       32
	ADDWF       R0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       F94_PROCURA_PROBLEMAS_F94par_L0+0 
;QUADRO.c,3222 :: 		F94impar = EEPROM_Read(F94ss+33);
	MOVLW       33
	ADDWF       F94_PROCURA_PROBLEMAS_F94ss_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
;QUADRO.c,3223 :: 		stgLcd1[4] = Num_Let_LCD[F94par];
	MOVLW       _Num_Let_LCD+0
	ADDWF       F94_PROCURA_PROBLEMAS_F94par_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _stgLcd1+4
;QUADRO.c,3224 :: 		stgLcd1[5] = Num_Let_LCD[F94impar];
	MOVLW       _Num_Let_LCD+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _stgLcd1+5
;QUADRO.c,3225 :: 		stgLcd1[6] = 	'J';
	MOVLW       74
	MOVWF       _stgLcd1+6 
;QUADRO.c,3226 :: 		stgLcd1[7] = 	'u';
	MOVLW       117
	MOVWF       _stgLcd1+7 
;QUADRO.c,3227 :: 		stgLcd1[8] = 	'm';
	MOVLW       109
	MOVWF       _stgLcd1+8 
;QUADRO.c,3228 :: 		stgLcd1[9] = 	'p';
	MOVLW       112
	MOVWF       _stgLcd1+9 
;QUADRO.c,3229 :: 		stgLcd1[10] = 	'e';
	MOVLW       101
	MOVWF       _stgLcd1+10 
;QUADRO.c,3230 :: 		stgLcd1[11] = 	'r';
	MOVLW       114
	MOVWF       _stgLcd1+11 
;QUADRO.c,3231 :: 		stgLcd1[12] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+12 
;QUADRO.c,3232 :: 		stgLcd1[13] = 	'O';
	MOVLW       79
	MOVWF       _stgLcd1+13 
;QUADRO.c,3233 :: 		stgLcd1[14] = 	'N';
	MOVLW       78
	MOVWF       _stgLcd1+14 
;QUADRO.c,3234 :: 		stgLcd1[15] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+15 
;QUADRO.c,3235 :: 		F94BitAvaliar = 0;//ZERO PORQUE FOI 'USADO'
	BCF         F94_PROCURA_PROBLEMAS_F94BitAvaliar_L0+0, BitPos(F94_PROCURA_PROBLEMAS_F94BitAvaliar_L0+0) 
;QUADRO.c,3236 :: 		}
	GOTO        L_F94_PROCURA_PROBLEMAS595
L_F94_PROCURA_PROBLEMAS594:
;QUADRO.c,3239 :: 		GqualMSG = defPR3;
	MOVLW       3
	MOVWF       _GqualMSG+0 
;QUADRO.c,3240 :: 		GalgumERRO &= 0b11111101;
	MOVLW       253
	ANDWF       _GalgumERRO+0, 1 
;QUADRO.c,3241 :: 		}
L_F94_PROCURA_PROBLEMAS595:
;QUADRO.c,3242 :: 		break;
	GOTO        L_F94_PROCURA_PROBLEMAS582
;QUADRO.c,3244 :: 		case defPR3:
L_F94_PROCURA_PROBLEMAS596:
;QUADRO.c,3246 :: 		if (GF94quatID>1)
	MOVF        _GF94quatID+0, 0 
	SUBLW       1
	BTFSC       STATUS+0, 0 
	GOTO        L_F94_PROCURA_PROBLEMAS597
;QUADRO.c,3248 :: 		if (F00_BIT_ON_OFF(defPAG2, _3Bit))
	MOVLW       97
	MOVWF       FARG_F00_BIT_ON_OFF_endereco+0 
	MOVLW       4
	MOVWF       FARG_F00_BIT_ON_OFF_campo+0 
	CALL        _F00_BIT_ON_OFF+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F94_PROCURA_PROBLEMAS598
;QUADRO.c,3251 :: 		GalgumERRO |= _3Bit;
	BSF         _GalgumERRO+0, 2 
;QUADRO.c,3252 :: 		GF94erroIDcolado = GF94erroIDcolado * 2;
	MOVF        _GF94erroIDcolado+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       _GF94erroIDcolado+0 
;QUADRO.c,3253 :: 		F94par = EEPROM_Read(GF94erroIDcolado+32);
	MOVLW       32
	ADDWF       R0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       F94_PROCURA_PROBLEMAS_F94par_L0+0 
;QUADRO.c,3254 :: 		F94impar = EEPROM_Read(GF94erroIDcolado+33);
	MOVLW       33
	ADDWF       _GF94erroIDcolado+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
;QUADRO.c,3255 :: 		stgLcd1[4] = Num_Let_LCD[F94par];
	MOVLW       _Num_Let_LCD+0
	ADDWF       F94_PROCURA_PROBLEMAS_F94par_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _stgLcd1+4
;QUADRO.c,3256 :: 		stgLcd1[5] = Num_Let_LCD[F94impar];
	MOVLW       _Num_Let_LCD+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _stgLcd1+5
;QUADRO.c,3257 :: 		if (BitInverter)
	BTFSS       _BitInverter+0, BitPos(_BitInverter+0) 
	GOTO        L_F94_PROCURA_PROBLEMAS599
;QUADRO.c,3259 :: 		stgLcd1[6] = 	'I';
	MOVLW       73
	MOVWF       _stgLcd1+6 
;QUADRO.c,3260 :: 		stgLcd1[7] = 	'd';
	MOVLW       100
	MOVWF       _stgLcd1+7 
;QUADRO.c,3261 :: 		stgLcd1[8] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+8 
;QUADRO.c,3262 :: 		stgLcd1[9] = 	'S';
	MOVLW       83
	MOVWF       _stgLcd1+9 
;QUADRO.c,3263 :: 		stgLcd1[10] = 	'e';
	MOVLW       101
	MOVWF       _stgLcd1+10 
;QUADRO.c,3264 :: 		stgLcd1[11] = 	'n';
	MOVLW       110
	MOVWF       _stgLcd1+11 
;QUADRO.c,3265 :: 		stgLcd1[12] = 	's';
	MOVLW       115
	MOVWF       _stgLcd1+12 
;QUADRO.c,3266 :: 		stgLcd1[13] = 	'o';
	MOVLW       111
	MOVWF       _stgLcd1+13 
;QUADRO.c,3267 :: 		stgLcd1[14] = 	'r';
	MOVLW       114
	MOVWF       _stgLcd1+14 
;QUADRO.c,3268 :: 		stgLcd1[15] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+15 
;QUADRO.c,3269 :: 		}
	GOTO        L_F94_PROCURA_PROBLEMAS600
L_F94_PROCURA_PROBLEMAS599:
;QUADRO.c,3272 :: 		stgLcd1[6] = 	'C';
	MOVLW       67
	MOVWF       _stgLcd1+6 
;QUADRO.c,3273 :: 		stgLcd1[7] = 	'o';
	MOVLW       111
	MOVWF       _stgLcd1+7 
;QUADRO.c,3274 :: 		stgLcd1[8] = 	'l';
	MOVLW       108
	MOVWF       _stgLcd1+8 
;QUADRO.c,3275 :: 		stgLcd1[9] = 	'a';
	MOVLW       97
	MOVWF       _stgLcd1+9 
;QUADRO.c,3276 :: 		stgLcd1[10] = 	'd';
	MOVLW       100
	MOVWF       _stgLcd1+10 
;QUADRO.c,3277 :: 		stgLcd1[11] = 	'o';
	MOVLW       111
	MOVWF       _stgLcd1+11 
;QUADRO.c,3278 :: 		stgLcd1[12] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+12 
;QUADRO.c,3279 :: 		stgLcd1[13] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+13 
;QUADRO.c,3280 :: 		stgLcd1[14] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+14 
;QUADRO.c,3281 :: 		stgLcd1[15] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+15 
;QUADRO.c,3282 :: 		}
L_F94_PROCURA_PROBLEMAS600:
;QUADRO.c,3283 :: 		}
	GOTO        L_F94_PROCURA_PROBLEMAS601
L_F94_PROCURA_PROBLEMAS598:
;QUADRO.c,3286 :: 		GqualMSG = defPR4;
	MOVLW       4
	MOVWF       _GqualMSG+0 
;QUADRO.c,3287 :: 		GalgumERRO &= 0b11111011;
	MOVLW       251
	ANDWF       _GalgumERRO+0, 1 
;QUADRO.c,3288 :: 		}
L_F94_PROCURA_PROBLEMAS601:
;QUADRO.c,3289 :: 		}
	GOTO        L_F94_PROCURA_PROBLEMAS602
L_F94_PROCURA_PROBLEMAS597:
;QUADRO.c,3292 :: 		GqualMSG = defPR4;
	MOVLW       4
	MOVWF       _GqualMSG+0 
;QUADRO.c,3293 :: 		GalgumERRO &= 0b11111011;
	MOVLW       251
	ANDWF       _GalgumERRO+0, 1 
;QUADRO.c,3294 :: 		}
L_F94_PROCURA_PROBLEMAS602:
;QUADRO.c,3295 :: 		break;
	GOTO        L_F94_PROCURA_PROBLEMAS582
;QUADRO.c,3297 :: 		case defPR4:
L_F94_PROCURA_PROBLEMAS603:
;QUADRO.c,3299 :: 		if (GF94naoRESPONDE)//vai ser apagado no próximo case
	MOVF        _GF94naoRESPONDE+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F94_PROCURA_PROBLEMAS604
;QUADRO.c,3301 :: 		if (F00_BIT_ON_OFF(defPAG2, _4Bit))
	MOVLW       97
	MOVWF       FARG_F00_BIT_ON_OFF_endereco+0 
	MOVLW       8
	MOVWF       FARG_F00_BIT_ON_OFF_campo+0 
	CALL        _F00_BIT_ON_OFF+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F94_PROCURA_PROBLEMAS605
;QUADRO.c,3303 :: 		F94pp = GF94naoRESPONDE-10;
	MOVLW       10
	SUBWF       _GF94naoRESPONDE+0, 0 
	MOVWF       R2 
;QUADRO.c,3304 :: 		GalgumERRO |= _4Bit;//inclui o sinal de erro de que
	BSF         _GalgumERRO+0, 3 
;QUADRO.c,3305 :: 		F94ss = F94pp * 2;
	MOVF        R2, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       F94_PROCURA_PROBLEMAS_F94ss_L0+0 
;QUADRO.c,3306 :: 		F94par = EEPROM_Read(F94ss+32);
	MOVLW       32
	ADDWF       R0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       F94_PROCURA_PROBLEMAS_F94par_L0+0 
;QUADRO.c,3307 :: 		F94impar = EEPROM_Read(F94ss+33);
	MOVLW       33
	ADDWF       F94_PROCURA_PROBLEMAS_F94ss_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
;QUADRO.c,3308 :: 		stgLcd1[4] = Num_Let_LCD[F94par];
	MOVLW       _Num_Let_LCD+0
	ADDWF       F94_PROCURA_PROBLEMAS_F94par_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _stgLcd1+4
;QUADRO.c,3309 :: 		stgLcd1[5] = Num_Let_LCD[F94impar];
	MOVLW       _Num_Let_LCD+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _stgLcd1+5
;QUADRO.c,3310 :: 		if (BitInverter)
	BTFSS       _BitInverter+0, BitPos(_BitInverter+0) 
	GOTO        L_F94_PROCURA_PROBLEMAS606
;QUADRO.c,3313 :: 		stgLcd1[6] = 	'N';
	MOVLW       78
	MOVWF       _stgLcd1+6 
;QUADRO.c,3314 :: 		stgLcd1[7] = defSIMBaTIL;
	MOVLW       205
	MOVWF       _stgLcd1+7 
;QUADRO.c,3315 :: 		stgLcd1[8] = 	'o';
	MOVLW       111
	MOVWF       _stgLcd1+8 
;QUADRO.c,3316 :: 		stgLcd1[9] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+9 
;QUADRO.c,3317 :: 		stgLcd1[10] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+10 
;QUADRO.c,3318 :: 		stgLcd1[11] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+11 
;QUADRO.c,3319 :: 		stgLcd1[12] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+12 
;QUADRO.c,3320 :: 		stgLcd1[13] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+13 
;QUADRO.c,3321 :: 		stgLcd1[14] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+14 
;QUADRO.c,3322 :: 		stgLcd1[15] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+15 
;QUADRO.c,3323 :: 		}
	GOTO        L_F94_PROCURA_PROBLEMAS607
L_F94_PROCURA_PROBLEMAS606:
;QUADRO.c,3326 :: 		stgLcd1[6] = 	'R';
	MOVLW       82
	MOVWF       _stgLcd1+6 
;QUADRO.c,3327 :: 		stgLcd1[7] = 	'e';
	MOVLW       101
	MOVWF       _stgLcd1+7 
;QUADRO.c,3328 :: 		stgLcd1[8] = 	's';
	MOVLW       115
	MOVWF       _stgLcd1+8 
;QUADRO.c,3329 :: 		stgLcd1[9] = 	'p';
	MOVLW       112
	MOVWF       _stgLcd1+9 
;QUADRO.c,3330 :: 		stgLcd1[10] = 	'o';
	MOVLW       111
	MOVWF       _stgLcd1+10 
;QUADRO.c,3331 :: 		stgLcd1[11] = 	'n';
	MOVLW       110
	MOVWF       _stgLcd1+11 
;QUADRO.c,3332 :: 		stgLcd1[12] = 	'd';
	MOVLW       100
	MOVWF       _stgLcd1+12 
;QUADRO.c,3333 :: 		stgLcd1[13] = 	'e';
	MOVLW       101
	MOVWF       _stgLcd1+13 
;QUADRO.c,3334 :: 		stgLcd1[14] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+14 
;QUADRO.c,3335 :: 		stgLcd1[15] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+15 
;QUADRO.c,3336 :: 		}
L_F94_PROCURA_PROBLEMAS607:
;QUADRO.c,3337 :: 		}
	GOTO        L_F94_PROCURA_PROBLEMAS608
L_F94_PROCURA_PROBLEMAS605:
;QUADRO.c,3340 :: 		GF94temp = 0;//resultado zerado
	CLRF        _GF94temp+0 
;QUADRO.c,3341 :: 		GqualMSG = defPR5;
	MOVLW       5
	MOVWF       _GqualMSG+0 
;QUADRO.c,3342 :: 		}
L_F94_PROCURA_PROBLEMAS608:
;QUADRO.c,3343 :: 		}
	GOTO        L_F94_PROCURA_PROBLEMAS609
L_F94_PROCURA_PROBLEMAS604:
;QUADRO.c,3346 :: 		GqualMSG = defPR5;
	MOVLW       5
	MOVWF       _GqualMSG+0 
;QUADRO.c,3347 :: 		GalgumERRO &= 0b11110111;
	MOVLW       247
	ANDWF       _GalgumERRO+0, 1 
;QUADRO.c,3348 :: 		}
L_F94_PROCURA_PROBLEMAS609:
;QUADRO.c,3349 :: 		break;
	GOTO        L_F94_PROCURA_PROBLEMAS582
;QUADRO.c,3351 :: 		case defPR5:
L_F94_PROCURA_PROBLEMAS610:
;QUADRO.c,3353 :: 		if (F00_BIT_ON_OFF(defPAG1, _4Bit))
	MOVLW       96
	MOVWF       FARG_F00_BIT_ON_OFF_endereco+0 
	MOVLW       8
	MOVWF       FARG_F00_BIT_ON_OFF_campo+0 
	CALL        _F00_BIT_ON_OFF+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F94_PROCURA_PROBLEMAS611
;QUADRO.c,3355 :: 		GqualMSG = defPR6;
	MOVLW       6
	MOVWF       _GqualMSG+0 
;QUADRO.c,3356 :: 		GalgumERRO &= 0b11101111;//apaga o erro
	MOVLW       239
	ANDWF       _GalgumERRO+0, 1 
;QUADRO.c,3357 :: 		}
	GOTO        L_F94_PROCURA_PROBLEMAS612
L_F94_PROCURA_PROBLEMAS611:
;QUADRO.c,3360 :: 		if (F00_BIT_ON_OFF(defPAG2, _5Bit))
	MOVLW       97
	MOVWF       FARG_F00_BIT_ON_OFF_endereco+0 
	MOVLW       16
	MOVWF       FARG_F00_BIT_ON_OFF_campo+0 
	CALL        _F00_BIT_ON_OFF+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F94_PROCURA_PROBLEMAS613
;QUADRO.c,3362 :: 		GalgumERRO |= _5Bit;
	BSF         _GalgumERRO+0, 4 
;QUADRO.c,3363 :: 		if (BitInverter)
	BTFSS       _BitInverter+0, BitPos(_BitInverter+0) 
	GOTO        L_F94_PROCURA_PROBLEMAS614
;QUADRO.c,3365 :: 		stgLcd1[4] = 	'P';
	MOVLW       80
	MOVWF       _stgLcd1+4 
;QUADRO.c,3366 :: 		stgLcd1[5] = 	'a';
	MOVLW       97
	MOVWF       _stgLcd1+5 
;QUADRO.c,3367 :: 		stgLcd1[6] = 	's';
	MOVLW       115
	MOVWF       _stgLcd1+6 
;QUADRO.c,3368 :: 		stgLcd1[7] = 	's';
	MOVLW       115
	MOVWF       _stgLcd1+7 
;QUADRO.c,3369 :: 		stgLcd1[8] = 	'W';
	MOVLW       87
	MOVWF       _stgLcd1+8 
;QUADRO.c,3370 :: 		stgLcd1[9] = 	'o';
	MOVLW       111
	MOVWF       _stgLcd1+9 
;QUADRO.c,3371 :: 		stgLcd1[10] = 	'r';
	MOVLW       114
	MOVWF       _stgLcd1+10 
;QUADRO.c,3372 :: 		stgLcd1[11] = 	'd';
	MOVLW       100
	MOVWF       _stgLcd1+11 
;QUADRO.c,3373 :: 		stgLcd1[12] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+12 
;QUADRO.c,3374 :: 		stgLcd1[13] = 	'O';
	MOVLW       79
	MOVWF       _stgLcd1+13 
;QUADRO.c,3375 :: 		stgLcd1[14] = 	'f';
	MOVLW       102
	MOVWF       _stgLcd1+14 
;QUADRO.c,3376 :: 		stgLcd1[15] = 	'f';
	MOVLW       102
	MOVWF       _stgLcd1+15 
;QUADRO.c,3377 :: 		}
L_F94_PROCURA_PROBLEMAS614:
;QUADRO.c,3378 :: 		}
	GOTO        L_F94_PROCURA_PROBLEMAS615
L_F94_PROCURA_PROBLEMAS613:
;QUADRO.c,3381 :: 		GqualMSG = defPR6;
	MOVLW       6
	MOVWF       _GqualMSG+0 
;QUADRO.c,3382 :: 		GalgumERRO &= 0b11101111;
	MOVLW       239
	ANDWF       _GalgumERRO+0, 1 
;QUADRO.c,3383 :: 		}
L_F94_PROCURA_PROBLEMAS615:
;QUADRO.c,3384 :: 		}
L_F94_PROCURA_PROBLEMAS612:
;QUADRO.c,3385 :: 		break;
	GOTO        L_F94_PROCURA_PROBLEMAS582
;QUADRO.c,3387 :: 		case defPR6:
L_F94_PROCURA_PROBLEMAS616:
;QUADRO.c,3389 :: 		if (F00_BIT_ON_OFF(defPAG2, _6Bit))
	MOVLW       97
	MOVWF       FARG_F00_BIT_ON_OFF_endereco+0 
	MOVLW       32
	MOVWF       FARG_F00_BIT_ON_OFF_campo+0 
	CALL        _F00_BIT_ON_OFF+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F94_PROCURA_PROBLEMAS617
;QUADRO.c,3391 :: 		if (GF94erroCancela)
	MOVF        _GF94erroCancela+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F94_PROCURA_PROBLEMAS618
;QUADRO.c,3393 :: 		GalgumERRO |= _6Bit;
	BSF         _GalgumERRO+0, 5 
;QUADRO.c,3394 :: 		F94pp = GF94erroCancela - 10;
	MOVLW       10
	SUBWF       _GF94erroCancela+0, 0 
	MOVWF       R2 
;QUADRO.c,3395 :: 		F94ss = F94pp * 2;
	MOVF        R2, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       F94_PROCURA_PROBLEMAS_F94ss_L0+0 
;QUADRO.c,3396 :: 		F94par = EEPROM_Read(F94ss+32);
	MOVLW       32
	ADDWF       R0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       F94_PROCURA_PROBLEMAS_F94par_L0+0 
;QUADRO.c,3397 :: 		F94impar = EEPROM_Read(F94ss+33);
	MOVLW       33
	ADDWF       F94_PROCURA_PROBLEMAS_F94ss_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
;QUADRO.c,3398 :: 		stgLcd1[4] = Num_Let_LCD[F94par];
	MOVLW       _Num_Let_LCD+0
	ADDWF       F94_PROCURA_PROBLEMAS_F94par_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _stgLcd1+4
;QUADRO.c,3399 :: 		stgLcd1[5] = Num_Let_LCD[F94impar];
	MOVLW       _Num_Let_LCD+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _stgLcd1+5
;QUADRO.c,3400 :: 		if (BitInverter)
	BTFSS       _BitInverter+0, BitPos(_BitInverter+0) 
	GOTO        L_F94_PROCURA_PROBLEMAS619
;QUADRO.c,3402 :: 		stgLcd1[6] = 	'S';
	MOVLW       83
	MOVWF       _stgLcd1+6 
;QUADRO.c,3403 :: 		stgLcd1[7] = 	'e';
	MOVLW       101
	MOVWF       _stgLcd1+7 
;QUADRO.c,3404 :: 		stgLcd1[8] = 	'n';
	MOVLW       110
	MOVWF       _stgLcd1+8 
;QUADRO.c,3405 :: 		stgLcd1[9] = 	's';
	MOVLW       115
	MOVWF       _stgLcd1+9 
;QUADRO.c,3406 :: 		stgLcd1[10] = 	'o';
	MOVLW       111
	MOVWF       _stgLcd1+10 
;QUADRO.c,3407 :: 		stgLcd1[11] = 	'r';
	MOVLW       114
	MOVWF       _stgLcd1+11 
;QUADRO.c,3408 :: 		stgLcd1[12] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+12 
;QUADRO.c,3409 :: 		stgLcd1[13] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+13 
;QUADRO.c,3410 :: 		stgLcd1[14] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+14 
;QUADRO.c,3411 :: 		stgLcd1[15] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+15 
;QUADRO.c,3412 :: 		}
	GOTO        L_F94_PROCURA_PROBLEMAS620
L_F94_PROCURA_PROBLEMAS619:
;QUADRO.c,3415 :: 		stgLcd1[6] = 	'C';
	MOVLW       67
	MOVWF       _stgLcd1+6 
;QUADRO.c,3416 :: 		stgLcd1[7] = 	'a';
	MOVLW       97
	MOVWF       _stgLcd1+7 
;QUADRO.c,3417 :: 		stgLcd1[8] = 	'n';
	MOVLW       110
	MOVWF       _stgLcd1+8 
;QUADRO.c,3418 :: 		stgLcd1[9] = 	'c';
	MOVLW       99
	MOVWF       _stgLcd1+9 
;QUADRO.c,3419 :: 		stgLcd1[10] = 	'e';
	MOVLW       101
	MOVWF       _stgLcd1+10 
;QUADRO.c,3420 :: 		stgLcd1[11] = 	'l';
	MOVLW       108
	MOVWF       _stgLcd1+11 
;QUADRO.c,3421 :: 		stgLcd1[12] = 	'a';
	MOVLW       97
	MOVWF       _stgLcd1+12 
;QUADRO.c,3422 :: 		stgLcd1[13] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+13 
;QUADRO.c,3423 :: 		stgLcd1[14] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+14 
;QUADRO.c,3424 :: 		stgLcd1[15] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+15 
;QUADRO.c,3425 :: 		}
L_F94_PROCURA_PROBLEMAS620:
;QUADRO.c,3426 :: 		}
	GOTO        L_F94_PROCURA_PROBLEMAS621
L_F94_PROCURA_PROBLEMAS618:
;QUADRO.c,3429 :: 		GqualMSG = defPR7;
	MOVLW       7
	MOVWF       _GqualMSG+0 
;QUADRO.c,3430 :: 		GalgumERRO &= 0b11011111;
	MOVLW       223
	ANDWF       _GalgumERRO+0, 1 
;QUADRO.c,3431 :: 		}
L_F94_PROCURA_PROBLEMAS621:
;QUADRO.c,3432 :: 		}
	GOTO        L_F94_PROCURA_PROBLEMAS622
L_F94_PROCURA_PROBLEMAS617:
;QUADRO.c,3435 :: 		GqualMSG = defPR7;
	MOVLW       7
	MOVWF       _GqualMSG+0 
;QUADRO.c,3436 :: 		GalgumERRO &= 0b11011111;
	MOVLW       223
	ANDWF       _GalgumERRO+0, 1 
;QUADRO.c,3437 :: 		}
L_F94_PROCURA_PROBLEMAS622:
;QUADRO.c,3438 :: 		break;
	GOTO        L_F94_PROCURA_PROBLEMAS582
;QUADRO.c,3440 :: 		case defPR7:
L_F94_PROCURA_PROBLEMAS623:
;QUADRO.c,3442 :: 		if (F00_BIT_ON_OFF(defPAG2, _7Bit))
	MOVLW       97
	MOVWF       FARG_F00_BIT_ON_OFF_endereco+0 
	MOVLW       64
	MOVWF       FARG_F00_BIT_ON_OFF_campo+0 
	CALL        _F00_BIT_ON_OFF+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F94_PROCURA_PROBLEMAS624
;QUADRO.c,3444 :: 		if (BitErroCRC)
	BTFSS       _BitErroCRC+0, BitPos(_BitErroCRC+0) 
	GOTO        L_F94_PROCURA_PROBLEMAS625
;QUADRO.c,3446 :: 		if (BitInverter)
	BTFSS       _BitInverter+0, BitPos(_BitInverter+0) 
	GOTO        L_F94_PROCURA_PROBLEMAS626
;QUADRO.c,3448 :: 		GalgumERRO |= _7Bit;
	BSF         _GalgumERRO+0, 6 
;QUADRO.c,3449 :: 		stgLcd1[4] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+4 
;QUADRO.c,3450 :: 		stgLcd1[5] = 	'!';
	MOVLW       33
	MOVWF       _stgLcd1+5 
;QUADRO.c,3451 :: 		stgLcd1[6] = 	'E';
	MOVLW       69
	MOVWF       _stgLcd1+6 
;QUADRO.c,3452 :: 		stgLcd1[7] = 	'R';
	MOVLW       82
	MOVWF       _stgLcd1+7 
;QUADRO.c,3453 :: 		stgLcd1[8] = 	'R';
	MOVLW       82
	MOVWF       _stgLcd1+8 
;QUADRO.c,3454 :: 		stgLcd1[9] = 	'O';
	MOVLW       79
	MOVWF       _stgLcd1+9 
;QUADRO.c,3455 :: 		stgLcd1[10] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+10 
;QUADRO.c,3456 :: 		stgLcd1[11] = 	'C';
	MOVLW       67
	MOVWF       _stgLcd1+11 
;QUADRO.c,3457 :: 		stgLcd1[12] = 	'R';
	MOVLW       82
	MOVWF       _stgLcd1+12 
;QUADRO.c,3458 :: 		stgLcd1[13] = 	'C';
	MOVLW       67
	MOVWF       _stgLcd1+13 
;QUADRO.c,3459 :: 		stgLcd1[14] = 	'!';
	MOVLW       33
	MOVWF       _stgLcd1+14 
;QUADRO.c,3460 :: 		stgLcd1[15] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+15 
;QUADRO.c,3461 :: 		}
L_F94_PROCURA_PROBLEMAS626:
;QUADRO.c,3462 :: 		}
	GOTO        L_F94_PROCURA_PROBLEMAS627
L_F94_PROCURA_PROBLEMAS625:
;QUADRO.c,3465 :: 		GqualMSG=defPR8;
	MOVLW       8
	MOVWF       _GqualMSG+0 
;QUADRO.c,3466 :: 		GalgumERRO &= 0b10111111;
	MOVLW       191
	ANDWF       _GalgumERRO+0, 1 
;QUADRO.c,3467 :: 		}
L_F94_PROCURA_PROBLEMAS627:
;QUADRO.c,3468 :: 		}
	GOTO        L_F94_PROCURA_PROBLEMAS628
L_F94_PROCURA_PROBLEMAS624:
;QUADRO.c,3471 :: 		GqualMSG=defPR8;
	MOVLW       8
	MOVWF       _GqualMSG+0 
;QUADRO.c,3472 :: 		GalgumERRO &= 0b10111111;
	MOVLW       191
	ANDWF       _GalgumERRO+0, 1 
;QUADRO.c,3473 :: 		}
L_F94_PROCURA_PROBLEMAS628:
;QUADRO.c,3474 :: 		break;
	GOTO        L_F94_PROCURA_PROBLEMAS582
;QUADRO.c,3476 :: 		case defPR8:
L_F94_PROCURA_PROBLEMAS629:
;QUADRO.c,3478 :: 		if (F00_BIT_ON_OFF(defPAG2, _8Bit))
	MOVLW       97
	MOVWF       FARG_F00_BIT_ON_OFF_endereco+0 
	MOVLW       128
	MOVWF       FARG_F00_BIT_ON_OFF_campo+0 
	CALL        _F00_BIT_ON_OFF+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F94_PROCURA_PROBLEMAS630
;QUADRO.c,3480 :: 		if (BitErroIPD)
	BTFSS       _BitErroIPD+0, BitPos(_BitErroIPD+0) 
	GOTO        L_F94_PROCURA_PROBLEMAS631
;QUADRO.c,3482 :: 		GalgumERRO |= _8Bit;
	BSF         _GalgumERRO+0, 7 
;QUADRO.c,3483 :: 		F94ss = GerroIPD * 2;
	MOVF        _GerroIPD+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       F94_PROCURA_PROBLEMAS_F94ss_L0+0 
;QUADRO.c,3484 :: 		F94par = EEPROM_Read(F94ss+32);
	MOVLW       32
	ADDWF       R0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       F94_PROCURA_PROBLEMAS_F94par_L0+0 
;QUADRO.c,3485 :: 		F94impar = EEPROM_Read(F94ss+33);
	MOVLW       33
	ADDWF       F94_PROCURA_PROBLEMAS_F94ss_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
;QUADRO.c,3486 :: 		stgLcd1[4] = Num_Let_LCD[F94par];
	MOVLW       _Num_Let_LCD+0
	ADDWF       F94_PROCURA_PROBLEMAS_F94par_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _stgLcd1+4
;QUADRO.c,3487 :: 		stgLcd1[5] = Num_Let_LCD[F94impar];
	MOVLW       _Num_Let_LCD+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_Num_Let_LCD+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, _stgLcd1+5
;QUADRO.c,3488 :: 		if (BitInverter)
	BTFSS       _BitInverter+0, BitPos(_BitInverter+0) 
	GOTO        L_F94_PROCURA_PROBLEMAS632
;QUADRO.c,3490 :: 		stgLcd1[6] = 	'S';
	MOVLW       83
	MOVWF       _stgLcd1+6 
;QUADRO.c,3491 :: 		stgLcd1[7] = 	'e';
	MOVLW       101
	MOVWF       _stgLcd1+7 
;QUADRO.c,3492 :: 		stgLcd1[8] = 	'n';
	MOVLW       110
	MOVWF       _stgLcd1+8 
;QUADRO.c,3493 :: 		stgLcd1[9] = 	's';
	MOVLW       115
	MOVWF       _stgLcd1+9 
;QUADRO.c,3494 :: 		stgLcd1[10] = 	'o';
	MOVLW       111
	MOVWF       _stgLcd1+10 
;QUADRO.c,3495 :: 		stgLcd1[11] = 	'r';
	MOVLW       114
	MOVWF       _stgLcd1+11 
;QUADRO.c,3496 :: 		stgLcd1[12] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+12 
;QUADRO.c,3497 :: 		stgLcd1[13] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+13 
;QUADRO.c,3498 :: 		stgLcd1[14] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+14 
;QUADRO.c,3499 :: 		stgLcd1[15] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+15 
;QUADRO.c,3500 :: 		}
	GOTO        L_F94_PROCURA_PROBLEMAS633
L_F94_PROCURA_PROBLEMAS632:
;QUADRO.c,3503 :: 		stgLcd1[6] = 	'A';
	MOVLW       65
	MOVWF       _stgLcd1+6 
;QUADRO.c,3504 :: 		stgLcd1[7] = 	'n';
	MOVLW       110
	MOVWF       _stgLcd1+7 
;QUADRO.c,3505 :: 		stgLcd1[8] = 	'd';
	MOVLW       100
	MOVWF       _stgLcd1+8 
;QUADRO.c,3506 :: 		stgLcd1[9] = 	'a';
	MOVLW       97
	MOVWF       _stgLcd1+9 
;QUADRO.c,3507 :: 		stgLcd1[10] = 	'r';
	MOVLW       114
	MOVWF       _stgLcd1+10 
;QUADRO.c,3508 :: 		stgLcd1[11] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+11 
;QUADRO.c,3509 :: 		stgLcd1[12] = 	'O';
	MOVLW       79
	MOVWF       _stgLcd1+12 
;QUADRO.c,3510 :: 		stgLcd1[13] = 	'F';
	MOVLW       70
	MOVWF       _stgLcd1+13 
;QUADRO.c,3511 :: 		stgLcd1[14] = 	'F';
	MOVLW       70
	MOVWF       _stgLcd1+14 
;QUADRO.c,3512 :: 		stgLcd1[15] = 	'!';
	MOVLW       33
	MOVWF       _stgLcd1+15 
;QUADRO.c,3513 :: 		}
L_F94_PROCURA_PROBLEMAS633:
;QUADRO.c,3514 :: 		}
	GOTO        L_F94_PROCURA_PROBLEMAS634
L_F94_PROCURA_PROBLEMAS631:
;QUADRO.c,3517 :: 		GqualMSG = defPR0;
	CLRF        _GqualMSG+0 
;QUADRO.c,3518 :: 		GalgumERRO &= 0b01111111;
	MOVLW       127
	ANDWF       _GalgumERRO+0, 1 
;QUADRO.c,3519 :: 		}
L_F94_PROCURA_PROBLEMAS634:
;QUADRO.c,3520 :: 		}
	GOTO        L_F94_PROCURA_PROBLEMAS635
L_F94_PROCURA_PROBLEMAS630:
;QUADRO.c,3523 :: 		GqualMSG = defPR0;
	CLRF        _GqualMSG+0 
;QUADRO.c,3524 :: 		GalgumERRO &= 0b01111111;
	MOVLW       127
	ANDWF       _GalgumERRO+0, 1 
;QUADRO.c,3525 :: 		}
L_F94_PROCURA_PROBLEMAS635:
;QUADRO.c,3526 :: 		F94BitAvaliar = 0;
	BCF         F94_PROCURA_PROBLEMAS_F94BitAvaliar_L0+0, BitPos(F94_PROCURA_PROBLEMAS_F94BitAvaliar_L0+0) 
;QUADRO.c,3527 :: 		break;
	GOTO        L_F94_PROCURA_PROBLEMAS582
;QUADRO.c,3529 :: 		default:
L_F94_PROCURA_PROBLEMAS636:
;QUADRO.c,3531 :: 		GqualMSG = defPR0;
	CLRF        _GqualMSG+0 
;QUADRO.c,3532 :: 		break;
	GOTO        L_F94_PROCURA_PROBLEMAS582
;QUADRO.c,3534 :: 		}
L_F94_PROCURA_PROBLEMAS581:
	MOVF        _GqualMSG+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_F94_PROCURA_PROBLEMAS583
	MOVF        _GqualMSG+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_F94_PROCURA_PROBLEMAS584
	MOVF        _GqualMSG+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_F94_PROCURA_PROBLEMAS591
	MOVF        _GqualMSG+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_F94_PROCURA_PROBLEMAS596
	MOVF        _GqualMSG+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_F94_PROCURA_PROBLEMAS603
	MOVF        _GqualMSG+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_F94_PROCURA_PROBLEMAS610
	MOVF        _GqualMSG+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_F94_PROCURA_PROBLEMAS616
	MOVF        _GqualMSG+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_F94_PROCURA_PROBLEMAS623
	MOVF        _GqualMSG+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_F94_PROCURA_PROBLEMAS629
	GOTO        L_F94_PROCURA_PROBLEMAS636
L_F94_PROCURA_PROBLEMAS582:
;QUADRO.c,3535 :: 		if (GalgumERRO)
	MOVF        _GalgumERRO+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_F94_PROCURA_PROBLEMAS637
;QUADRO.c,3537 :: 		if (!BitInverter)
	BTFSC       _BitInverter+0, BitPos(_BitInverter+0) 
	GOTO        L_F94_PROCURA_PROBLEMAS638
;QUADRO.c,3539 :: 		stgLcd1[3] = def7SIMBEXCLAM;
	MOVLW       7
	MOVWF       _stgLcd1+3 
;QUADRO.c,3540 :: 		}
L_F94_PROCURA_PROBLEMAS638:
;QUADRO.c,3541 :: 		}
	GOTO        L_F94_PROCURA_PROBLEMAS639
L_F94_PROCURA_PROBLEMAS637:
;QUADRO.c,3544 :: 		stgLcd1[3] = 	' ';
	MOVLW       32
	MOVWF       _stgLcd1+3 
;QUADRO.c,3545 :: 		}
L_F94_PROCURA_PROBLEMAS639:
;QUADRO.c,3546 :: 		}
L_end_F94_PROCURA_PROBLEMAS:
	RETURN      0
; end of _F94_PROCURA_PROBLEMAS

_F96_IMPRIME_LCD:

;QUADRO.c,3548 :: 		void F96_IMPRIME_LCD (void)
;QUADRO.c,3551 :: 		unsigned short F96uu = 0;
;QUADRO.c,3552 :: 		if (def1PWDDESLOGADO == GloginState)
	MOVLW       1
	XORWF       _GloginState+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_F96_IMPRIME_LCD640
;QUADRO.c,3554 :: 		F94_PROCURA_PROBLEMAS();
	CALL        _F94_PROCURA_PROBLEMAS+0, 0
;QUADRO.c,3555 :: 		}
L_F96_IMPRIME_LCD640:
;QUADRO.c,3556 :: 		lcd_chr(defLCDLINHA1, 1, stgLcd1[0]);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _stgLcd1+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;QUADRO.c,3557 :: 		for (F96ee = 1; F96ee != 16; F96ee++)
	MOVLW       1
	MOVWF       F96_IMPRIME_LCD_F96ee_L0+0 
L_F96_IMPRIME_LCD641:
	MOVF        F96_IMPRIME_LCD_F96ee_L0+0, 0 
	XORLW       16
	BTFSC       STATUS+0, 2 
	GOTO        L_F96_IMPRIME_LCD642
;QUADRO.c,3559 :: 		lcd_chr_cp(stgLcd1[F96ee]);
	MOVLW       _stgLcd1+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_stgLcd1+0)
	MOVWF       FSR0H 
	MOVF        F96_IMPRIME_LCD_F96ee_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;QUADRO.c,3560 :: 		stgLcd1[F96ee]=32;
	MOVLW       _stgLcd1+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd1+0)
	MOVWF       FSR1H 
	MOVF        F96_IMPRIME_LCD_F96ee_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       32
	MOVWF       POSTINC1+0 
;QUADRO.c,3557 :: 		for (F96ee = 1; F96ee != 16; F96ee++)
	INCF        F96_IMPRIME_LCD_F96ee_L0+0, 1 
;QUADRO.c,3561 :: 		}
	GOTO        L_F96_IMPRIME_LCD641
L_F96_IMPRIME_LCD642:
;QUADRO.c,3562 :: 		stgLcd1[0]=32;
	MOVLW       32
	MOVWF       _stgLcd1+0 
;QUADRO.c,3563 :: 		lcd_chr(defLCDLINHA2, 1, stgLcd2[0]);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _stgLcd2+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;QUADRO.c,3564 :: 		for (F96ee = 1; F96ee != 16; F96ee++)
	MOVLW       1
	MOVWF       F96_IMPRIME_LCD_F96ee_L0+0 
L_F96_IMPRIME_LCD644:
	MOVF        F96_IMPRIME_LCD_F96ee_L0+0, 0 
	XORLW       16
	BTFSC       STATUS+0, 2 
	GOTO        L_F96_IMPRIME_LCD645
;QUADRO.c,3566 :: 		lcd_chr_cp(stgLcd2[F96ee]);
	MOVLW       _stgLcd2+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_stgLcd2+0)
	MOVWF       FSR0H 
	MOVF        F96_IMPRIME_LCD_F96ee_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;QUADRO.c,3567 :: 		stgLcd2[F96ee]=32;
	MOVLW       _stgLcd2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_stgLcd2+0)
	MOVWF       FSR1H 
	MOVF        F96_IMPRIME_LCD_F96ee_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       32
	MOVWF       POSTINC1+0 
;QUADRO.c,3564 :: 		for (F96ee = 1; F96ee != 16; F96ee++)
	INCF        F96_IMPRIME_LCD_F96ee_L0+0, 1 
;QUADRO.c,3568 :: 		}
	GOTO        L_F96_IMPRIME_LCD644
L_F96_IMPRIME_LCD645:
;QUADRO.c,3569 :: 		stgLcd2[0]=32;
	MOVLW       32
	MOVWF       _stgLcd2+0 
;QUADRO.c,3570 :: 		}
L_end_F96_IMPRIME_LCD:
	RETURN      0
; end of _F96_IMPRIME_LCD

_interrupt:

;QUADRO.c,3573 :: 		void interrupt()
;QUADRO.c,3576 :: 		gie_bit = 0;//desliga todas interrupções
	BCF         GIE_bit+0, BitPos(GIE_bit+0) 
;QUADRO.c,3577 :: 		if (rcif_bit)
	BTFSS       RCIF_bit+0, BitPos(RCIF_bit+0) 
	GOTO        L_interrupt647
;QUADRO.c,3579 :: 		rcif_bit = 0;
	BCF         RCIF_bit+0, BitPos(RCIF_bit+0) 
;QUADRO.c,3580 :: 		ISRrx = uart1_read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       interrupt_ISRrx_L0+0 
;QUADRO.c,3581 :: 		switch (GidRXstate)
	GOTO        L_interrupt648
;QUADRO.c,3583 :: 		case 0:
L_interrupt650:
;QUADRO.c,3585 :: 		if (240 == ISRrx)
	MOVLW       240
	XORWF       interrupt_ISRrx_L0+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt651
;QUADRO.c,3587 :: 		GidRXstate = 1;
	MOVLW       1
	MOVWF       _GidRXstate+0 
;QUADRO.c,3588 :: 		}
	GOTO        L_interrupt652
L_interrupt651:
;QUADRO.c,3591 :: 		GidRecebido = 0;
	CLRF        _GidRecebido+0 
;QUADRO.c,3592 :: 		GidCRC = 0;
	CLRF        _GidCRC+0 
;QUADRO.c,3593 :: 		GidSensorRX = 0;
	CLRF        _GidSensorRX+0 
;QUADRO.c,3594 :: 		}
L_interrupt652:
;QUADRO.c,3595 :: 		break;
	GOTO        L_interrupt649
;QUADRO.c,3597 :: 		case 1:
L_interrupt653:
;QUADRO.c,3599 :: 		GidRecebido = ISRrx;
	MOVF        interrupt_ISRrx_L0+0, 0 
	MOVWF       _GidRecebido+0 
;QUADRO.c,3600 :: 		GidRXstate = 2;
	MOVLW       2
	MOVWF       _GidRXstate+0 
;QUADRO.c,3601 :: 		break;
	GOTO        L_interrupt649
;QUADRO.c,3603 :: 		case 2:
L_interrupt654:
;QUADRO.c,3605 :: 		GidSensorRX = ISRrx;
	MOVF        interrupt_ISRrx_L0+0, 0 
	MOVWF       _GidSensorRX+0 
;QUADRO.c,3606 :: 		GidRXstate = 3;
	MOVLW       3
	MOVWF       _GidRXstate+0 
;QUADRO.c,3607 :: 		break;
	GOTO        L_interrupt649
;QUADRO.c,3609 :: 		case 3:
L_interrupt655:
;QUADRO.c,3611 :: 		if (ISRrx == (GidSensorRX+GidRecebido))
	MOVF        _GidRecebido+0, 0 
	ADDWF       _GidSensorRX+0, 0 
	MOVWF       R1 
	CLRF        R2 
	MOVLW       0
	ADDWFC      R2, 1 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt741
	MOVF        R1, 0 
	XORWF       interrupt_ISRrx_L0+0, 0 
L__interrupt741:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt656
;QUADRO.c,3613 :: 		GidCRC = ISRrx;
	MOVF        interrupt_ISRrx_L0+0, 0 
	MOVWF       _GidCRC+0 
;QUADRO.c,3614 :: 		}
	GOTO        L_interrupt657
L_interrupt656:
;QUADRO.c,3617 :: 		GidRecebido = 0;
	CLRF        _GidRecebido+0 
;QUADRO.c,3618 :: 		GidCRC = 0;
	CLRF        _GidCRC+0 
;QUADRO.c,3619 :: 		GidSensorRX = 0;
	CLRF        _GidSensorRX+0 
;QUADRO.c,3620 :: 		BitErroCRC = 1;
	BSF         _BitErroCRC+0, BitPos(_BitErroCRC+0) 
;QUADRO.c,3621 :: 		}
L_interrupt657:
;QUADRO.c,3622 :: 		GidRXstate = 0;
	CLRF        _GidRXstate+0 
;QUADRO.c,3623 :: 		break;
	GOTO        L_interrupt649
;QUADRO.c,3625 :: 		default:
L_interrupt658:
;QUADRO.c,3627 :: 		GidRXstate = 0;
	CLRF        _GidRXstate+0 
;QUADRO.c,3628 :: 		break;
	GOTO        L_interrupt649
;QUADRO.c,3630 :: 		}
L_interrupt648:
	MOVF        _GidRXstate+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt650
	MOVF        _GidRXstate+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt653
	MOVF        _GidRXstate+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt654
	MOVF        _GidRXstate+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt655
	GOTO        L_interrupt658
L_interrupt649:
;QUADRO.c,3631 :: 		}
L_interrupt647:
;QUADRO.c,3632 :: 		if (tmr0if_bit)
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_interrupt659
;QUADRO.c,3634 :: 		tmr0if_bit = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;QUADRO.c,3635 :: 		TMR0H = 0x85;
	MOVLW       133
	MOVWF       TMR0H+0 
;QUADRO.c,3636 :: 		TMR0L = 0xEE;
	MOVLW       238
	MOVWF       TMR0L+0 
;QUADRO.c,3637 :: 		GchamadaState = def7ATUALIZAR;
	MOVLW       7
	MOVWF       _GchamadaState+0 
;QUADRO.c,3638 :: 		GisrInverter++;
	INCF        _GisrInverter+0, 1 
;QUADRO.c,3639 :: 		if (GisrInverter>2)
	MOVF        _GisrInverter+0, 0 
	SUBLW       2
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt660
;QUADRO.c,3641 :: 		GisrInverter=0;
	CLRF        _GisrInverter+0 
;QUADRO.c,3642 :: 		BitInverter=!BitInverter;
	BTG         _BitInverter+0, BitPos(_BitInverter+0) 
;QUADRO.c,3643 :: 		}
L_interrupt660:
;QUADRO.c,3644 :: 		}
L_interrupt659:
;QUADRO.c,3645 :: 		gie_bit = 1;//liga todas interrupções
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;QUADRO.c,3646 :: 		}
L_end_interrupt:
L__interrupt740:
	RETFIE      1
; end of _interrupt

_main:

;QUADRO.c,3648 :: 		void main()
;QUADRO.c,3650 :: 		F07_CONFIGURA_SISTEMA(0);
	CLRF        FARG_F07_CONFIGURA_SISTEMA_como+0 
	CALL        _F07_CONFIGURA_SISTEMA+0, 0
;QUADRO.c,3651 :: 		while (1)
L_main661:
;QUADRO.c,3653 :: 		F02_LE_TECLADO();
	CALL        _F02_LE_TECLADO+0, 0
;QUADRO.c,3654 :: 		F84_CHAMADAS();//PRA FATIAR SERVICOS
	CALL        _F84_CHAMADAS+0, 0
;QUADRO.c,3655 :: 		F80_LOGIN();//SITUACAO LOGIN
	CALL        _F80_LOGIN+0, 0
;QUADRO.c,3656 :: 		F82_COMANDATPIC();//COMANDO RELÉS E DISPLAYS
	CALL        _F82_COMANDATPIC+0, 0
;QUADRO.c,3657 :: 		GteclaPress = '>';
	MOVLW       62
	MOVWF       _GteclaPress+0 
;QUADRO.c,3658 :: 		if (BitAtualizarLcd)
	BTFSS       _BitAtualizarLcd+0, BitPos(_BitAtualizarLcd+0) 
	GOTO        L_main663
;QUADRO.c,3660 :: 		F96_IMPRIME_LCD();
	CALL        _F96_IMPRIME_LCD+0, 0
;QUADRO.c,3661 :: 		BitAtualizarLcd = 0;
	BCF         _BitAtualizarLcd+0, BitPos(_BitAtualizarLcd+0) 
;QUADRO.c,3662 :: 		}
L_main663:
;QUADRO.c,3663 :: 		asm CLRWDT; //limpa WATCHDOG
	CLRWDT
;QUADRO.c,3664 :: 		}
	GOTO        L_main661
;QUADRO.c,3665 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
