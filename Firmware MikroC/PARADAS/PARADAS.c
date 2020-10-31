//gravar id pela subida do elevador!!!

sbit SENSOR_CANCELA_UM at RA0_bit;
sbit SENSOR_CANCELA_DOIS at RA1_bit;
sbit SENSOR_NIVEL_UM at RA2_bit;
sbit SENSOR_NIVEL_DOIS at RA3_bit;
sbit FALAR_OUVIR at RB0_bit;
sbit PINO_IN_RX at RB1_bit;
sbit PINO_OUT_TX at RB2_bit;
sbit RELE_AUDIO at RB3_bit;
sbit RELE_SELENOIDE at RB4_bit;
sbit BOTAO_MULTI at RB5_bit;
sbit AZUL_B6 at RB6_bit;
sbit VERMELHO_B7 at RB7_bit;
//--------------------------------------------//
unsigned char myId;
unsigned char my_novo_id;
unsigned char msg_state;
unsigned char conta_audio;
unsigned char conta_selenoide;
unsigned char crcEnvio;
unsigned char comando;
unsigned char semComunica;
unsigned char piscaAzul;
unsigned char portaState[8];
unsigned char leitura;
bit bi_responder;
bit responder_novo_id;
bit gravar_novo_id;
bit BitAvaliarPortA;
//--------------------------------------------//
void interrupt()
{
	unsigned char UC_rcpt;
    if (RCIF_bit == 1)
    {     
        RCIF_bit = 0;
		//AZUL_B6=0;
		UC_rcpt=UART1_Read();
		VERMELHO_B7=0;
		switch (msg_state)
		{
//--------------------------------------------//			
			case 0:
			{
				if (UC_rcpt == 244)//inicio da transmissão
				{                        
					msg_state=1;
				}
				if (UC_rcpt == 254)//inicio da transmissão para gravação de novo id
				{                        
					msg_state=11;
				}				
				break;				
			}
			case 1:
			{
				if (UC_rcpt == myId)//está falando comigo?
				{
					msg_state=2;
					semComunica=0;
				}
				else
				{
					msg_state=0;//não, reseta
				}
				break;
			}
			case 2:
			{
					comando=UC_rcpt;
					msg_state=3;
				break;
			}
			case 3:
			{
				if (UC_rcpt == (comando+myId))
				{
					VERMELHO_B7=1;
					bi_responder=1;
				}
				msg_state=0;
				break;
			}		
//--------------------------------------------//			
			case 11:
			{
				if (UC_rcpt == myId)//está falando comigo?
				{
					msg_state=12;//salta pra próximo estágio
				}
				else
				{
					msg_state=0;//não, reseta
				}				
				break;
			}
			case 12:
			{
				if (UC_rcpt>9 & UC_rcpt<42)//novo id está dentro da escala?
				{
					my_novo_id=UC_rcpt;
					msg_state=13;					
				}
				else
				{
					msg_state=0;//não, reseta
				}
				break;
			}
			case 13:
			{
				if (UC_rcpt==(my_novo_id+myId))//crc correto?
				{
					msg_state=14;//sim, salta para próximo estágio
				}
				else
				{
					msg_state=0;//não, reseta
				}				
				break;
			}	
			case 14:
			{				
				AZUL_B6=1;
				if (UC_rcpt==100)//responder
				{
					responder_novo_id=1;
				}
				if (UC_rcpt==110)//gravar my_novo_id
				{
					gravar_novo_id=1;
					responder_novo_id=0;
				}			
				msg_state=0;				
				break;
			}
//--------------------------------------------//			
			default:
			{
				msg_state=0;
				break;
			}			
		}								
	}
//--------------------------------------------//	
	if (TMR1IF_bit)
	{ 
		TMR1IF_bit = 0;
		TMR1H	 = 0x0B;
		TMR1L	 = 0xDC;
		if (RELE_AUDIO==1)
		{
			conta_audio++;
			if (conta_audio>250)//tempo em que o audio deve ficar aberto
			{
				RELE_AUDIO=0;
			}
		}
		if (RELE_SELENOIDE==1)
		{
			conta_selenoide++;
			if (conta_selenoide>20)//tempo de ativação do trinco
			{
				conta_selenoide=0;
				RELE_SELENOIDE=0;
			}		
		}
		semComunica++;
		BitAvaliarPortA=1;
	}      
}
//--------------------------------------------//
void responde (void)
{
	unsigned char tmpB;
    unsigned char tmpA=0xFF;
	unsigned char temp;
	for (temp=0;temp<8;temp++)
	{
		tmpA &= portaState[temp];		
	}
	tmpA &= 0b00001111;
	tmpB = PORTB;
	tmpB = tmpB & 0b00111000;
	tmpB = tmpB<<1;
	tmpA = tmpA | tmpB;
	tmpA = tmpA & 0b01111111;
	crcEnvio = tmpA + myId;
	crcEnvio = crcEnvio & 0b01111111;
	FALAR_OUVIR = 1;
	UART1_Write(240);
	UART1_Write(myId);//devolve identificação do andar
	UART1_Write(tmpA);//manda leitura dos ports
	UART1_Write(crcEnvio);
	delay_us(255);
	delay_us(255);
	FALAR_OUVIR = 0;
}
//--------------------------------------------//
void main ()
{

    TRISA = 0b11111111;
    TRISB = 0b00100010;
    RELE_AUDIO = 0;
    FALAR_OUVIR = 0;
    RELE_SELENOIDE = 0;
    CMCON = 7;
	T1CON = 0x21;
	TMR1IF_bit = 0;
	TMR1H	 = 0x0B;
	TMR1L	 = 0xDC;
	TMR1IE_bit = 1;
	INTCON = 0xC0;
    AZUL_B6=0;
    VERMELHO_B7=0;
    UART1_Init(19200);
    RCIE_bit = 1;
    TXIE_bit = 0;
    PEIE_bit = 1;
    GIE_bit = 1;
	PSA_bit = 1;
	PS0_bit = 1;
	PS1_bit = 1;
	PS2_bit = 1;
	msg_state=0;
	bi_responder=0;
	responder_novo_id=0;
	gravar_novo_id=0;
	comando=0;
	leitura=0;
	if (EEPROM_Read(1) != 254)
	{  
		EEPROM_Write(0, 11);
		delay_ms(20);
		EEPROM_Write(1, 254);
		delay_ms(20);
	}	
//--------------------------------------------//
    while (1)
    {
		myId=EEPROM_Read(0);
        FALAR_OUVIR = 0;
		if (PORTB.F5==0)//botao pressionado??
		{
			if (RELE_AUDIO==0)
			{
				if (PORTA.F0==0 | PORTA.F1==0)//cancela fechada, faz sentido abrir selenoide
				{
					if (PORTA.F2==0 | PORTA.F3==0)//na posição, pode abrir selenoide
					{
						RELE_SELENOIDE=1;
						conta_selenoide=0;
					}
				}                                
			}
			if (RELE_SELENOIDE == 0)
			{
				if (PORTA.F0 | PORTA.F1)//cancela aberta, não faz sentido abrir selenoide
				{
					RELE_AUDIO=1;
					conta_audio=0;
				}
				if (PORTA.F2 & PORTA.F3)//não na posição, não pode abrir selenoide
				{
					RELE_AUDIO=1;
					conta_audio=0;
				}                                
			}
		}
		if (bi_responder==1)
		{
			delay_us(100);
			bi_responder=0;
			responde ();
		}
		if (responder_novo_id==1)
		{
			responder_novo_id=0;
			delay_us(100);
			responde ();
		}
		if (gravar_novo_id)//há confirmação para gravar?
		{
			gravar_novo_id=0;
			GIE_bit = 0;
			if (myId != my_novo_id)
			{
				EEPROM_Write(0, my_novo_id);
				delay_ms(20);
			}						
			GIE_bit = 1;
		}
		if (comando & 0b00000001)
		{
			RELE_AUDIO = 1;
			conta_audio=0;
		}
		if (comando & 0b00000010)
		{
			RELE_SELENOIDE = 1;
			conta_selenoide=0;
		}
		if (semComunica>5)
		{
			semComunica=5;
			piscaAzul++;
		}
		if (semComunica<2)
		{
			piscaAzul=0;
			AZUL_B6=0;
		}
		if (piscaAzul>5)
		{
			piscaAzul=0;
			AZUL_B6=!AZUL_B6;			
		}
		if (BitAvaliarPortA==1)
		{	
			BitAvaliarPortA = 0;
			portaState[leitura]=PORTA;//a cada 50mS faz uma leitura do PORTA
			portaState[leitura] &= 0b00001111;
			leitura++;
			if (leitura>7)
			{
				leitura=0;
			}
		}
		asm CLRWDT;
	}
}

