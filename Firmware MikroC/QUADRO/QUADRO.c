//http://www.hardware.com.br/comunidade/ponteiros-entendendo/796454/
// #define pointer     *     // usado em declaracoes
// #define value(a)   (*a)   // usado para acessar o valor do ponteiro
// #define address(a) (&(a)) // usado para acessar o endereco de uma variavel
// #define assign(a,b) a = address(b)  // talvez seja util...
// O QUE INVENTAR? O QUE ADCIONAR?
//PISCA NAS TECLAS
//LED AZUL QUANDO NIVELADO NAS PIDS
//PISCA QUANDO SENSOR DE CANCELA IS BROKEN
//BOTÃO CHAMA ELEVADOR PARA ANDAR MEDIANTE LIBERAÇÃO DO GUINCHEIRO
//AUTO CONCERTAR
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
#define defMenu 0
#define defVisualiza 1
#define defEdicao 2
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
#define	defPR0 0
#define	defPR1 1
#define	defPR2 2
#define	defPR3 3
#define	defPR4 4
#define	defPR5 5
#define	defPR6 6
#define	defPR7 7
#define	defPR8 8
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
#define defPAG1			96
#define defPAG2			97
#define defPAG3			98
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
#define def7ATUALIZAR      	7
#define def2COMINGDOWN 		2
#define def1COMINGUP 		1
#define def1STOPPED 		0
#define def1FALAAUDIO  		0b00000001
#define defLCDLINHA1        1
#define defLCDLINHA2 		2
#define defLEVELING4 		4
#define defLIGAAUDIO2  		0b00000010
#define def5NORMAL 			5
#define defOFFALL15 		0b00001111
#define def8TIMEupdade 		8
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
#define def1PWDDESLOGADO 	1
#define defPWDERRADA2 		2
#define defPWDIN3 			3
#define defPWDINGUI4		4
#define defPWDOK5 			5
#define defPWDOKGUI6 		6
#define defPWDRECOVE 		7
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
#define defSIMBON0 			0
#define defSIMBACIMA1 		1
#define defSIMBABAIXO2 		2
#define defSIMBPLACE3 		3
#define def4SIMBSWITCHDOWN 	4
#define def5SIMBSWITCHUP	5
#define def6SIMBSWITCHOFF 	6
#define def7SIMBEXCLAM 		7
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
#define defSIMBAUDIO        0b11110100//244 SIMBOLOS PRONTOS LCD
#define defSIMBCANCELA      0b11011101
#define defSIMBDESCENDO     0b10110100
#define defSIMBLEVELING     0b10111011
#define defSIMBNAODESCE     0b10111001
#define defSIMBNAOSOBE      0b10111010
#define defSIMBSUBINDO      0b10110011
#define defSIMBINPLACE      0b10111000
#define defSIMBaTIL         0b11001101
#define defSIMBeTIL         0b10010100
#define defSIMBeh           0b10010110
#define defSIMBrecording    0b11011100
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
#define defTACTORPOWER    	0b10000000
#define defTACTORBRAKE   	0b01000000
#define defTACTORDOWN   	0b00100000
#define defTACTORRISES    	0b00010000
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
bit Bitindice;
bit BitAvaliar;
bit BitAudioOn;
bit BitCancelaCloseOpen;
bit BitStopDown;
bit BitStopUp;
//bit BitTeclaAudio;
//bit BitTeclaDesce;
//bit BitTeclaDesceLast;
//bit BitTeclaIrAte;
//bit BitTeclaNivela;
//bit BitTeclaPara;
//bit BitTeclaSobe;
//bit BitTeclaSobeLast;
bit BitVaiVoltar;
bit BitKeyAvaliar;
bit BitNaoSeq;
bit BitSenhasIguais;
bit BitGravar;
bit BitAtualizarLcd;
bit BitPararAqui;
bit BitPararAquiOnce;
bit BitErroCRC;
bit BitErroIPD;
bit BitInverter;
bit BitNaoSobreEscrever;
bit BitDescer;

typedef struct
	{
		Sobe :1; 
		Desce :1;
		Para :1;
		Nivela :1;
		Audio :1;
		IrAte :1;
		bit7 :1;
		bit8 :1;
	} BitFields;

BitFields Tecla, LastTecla;
	
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
sbit rb0_CABINE at rb0_bit;//onde se conecta o interruptor da porta da cabine
sbit rb1_FIM_INFERIOR at rb1_bit; //
sbit rb2_IRate at rb2_bit;
sbit rb3_AUDIO at rb3_bit;//onde se conecta o botAo de audio
sbit rb4_NIVEL at rb4_bit;
sbit rb5_DESCE at rb5_bit;
sbit rb6_PARA at rb6_bit;
sbit rb7_SOBE at rb7_bit;
sbit rc1_PHOTO_TPIC at rc1_bit; //pino 13 tpic
sbit rc2_REVELA_TPIC at rc2_bit; //pino 12 tpic
sbit rc5_FALAR_OUVIR at rc5_bit; //onde controla pino do max485 para falar ouvir
sbit rd0_FIM_SUPERIOR at rd0_bit;
sbit rd1_DADOS_TPIC at rd1_bit; //pino 3 tpic
sbit lcd_d4 at latd4_bit;
sbit lcd_d4_direction at trisd4_bit;
sbit lcd_d5 at latd5_bit;
sbit lcd_d5_direction at trisd5_bit;
sbit lcd_d6 at latd6_bit;
sbit lcd_d6_direction at trisd6_bit;
sbit lcd_d7 at latd7_bit;
sbit lcd_d7_direction at trisd7_bit;
sbit lcd_en at latd3_bit;
sbit lcd_en_direction at trisd3_bit;
sbit lcd_rs at latd2_bit;
sbit lcd_rs_direction at trisd2_bit;
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
uint8_t GbiggerPID;
uint8_t GchamadaState;
uint8_t GvaiVoltar;
uint8_t Gdezena7SEG;
uint8_t GretornaHome;
uint8_t GidCRC;
uint8_t GidOndeCabineEsta;
uint8_t GidOndeCabineEstaVA;
uint8_t GidIPDerro;
uint8_t GidNovaEditada;
uint8_t GidOriginal;
uint8_t GidRXstate;
uint8_t GidRecebido;
uint8_t GidSensorRX;
uint8_t GloginState;
uint8_t Gmenu;
uint8_t Gnivel;
uint8_t GpareAqui;
uint8_t GqualMSG;
uint8_t GqualMSGlast;
uint8_t GposSenha;
uint8_t GsecCountLast;
uint8_t GF03segundos;
uint8_t GminCountLast;
uint8_t GF03minutos;
uint8_t GsenhaPosi;
uint8_t Gseq;
uint8_t GstateELEVA;
uint8_t GstateELEVAlast;
uint8_t GsubMenu;
uint8_t GteclaPress;
uint8_t Gunidade7SEG;
uint8_t GfaleAqui;
uint8_t GprotNivela;
uint8_t GF94naoRESPONDE;
uint8_t GF94temp;
uint8_t GF94erroCancela;
uint8_t GisrInverter;
uint8_t GalgumERRO;
uint8_t GerroIPD;
uint8_t GF94quatID;
uint8_t GF94erroIDcolado;
uint8_t GF94erroIDcoladoLast;
uint8_t ContadorDescer;
uint8_t ContadorPOWER;
uint8_t ContadorPOWERlast;
uint8_t F82ReleCmdLast;
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
uint8_t stgTime[10];
uint8_t stgFormatedDate[8];
uint8_t stgFormatedTime[8];
uint8_t stgLcd1[16];
uint8_t stgLcd2[16];
uint8_t stgMemorias[2][32];
uint8_t stgSenhaDigitada[6];
uint8_t stgSenhaOculta[6];
uint8_t stg_senha1[6];
uint8_t stg_senha2[6];
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
const uint8_t FIMsuperior[] = "FIM SUPERIOR";
const tecla_nenhuma = 70;

const horas = 1;
const datas = 2;
const _0Bit  = 0b00000000;
const _1Bit  = 0b00000001;
const _2Bit  = 0b00000010;
const _3Bit  = 0b00000100;
const _4Bit  = 0b00001000;
const _5Bit  = 0b00010000;
const _6Bit  = 0b00100000;
const _7Bit  = 0b01000000;
const _8Bit  = 0b10000000;
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
const uint8_t charactes[8][8] = 
{
    {31, 31, 31, 31, 31, 31, 31, 0},//defSIMBON0
    {31, 14,  4, 31,  0,  0,  0, 0},//defSIMBACIMA1
    { 0,  0,  0, 31,  4, 14, 31, 0},//defSIMBABAIXO2
	{31, 14,  4, 31,  4, 14, 31, 0},//defSIMBLEVELING
    {31, 23, 23, 17, 21, 17, 31, 0},//def4SIMBSWITCHDOWN
    {31, 29, 29, 17, 21, 17, 31, 0},//def5SIMBSWITCHUP
    {31, 17, 17, 17, 17, 17, 31, 0},//def6SIMBSWITCHOFF
    {31, 27, 27, 27, 31, 27, 31, 0} //def7SIMBEXCLAM
};
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
//---------------------------------------0     1     2     3     4     5     6     7     8     9     10    11    12    13    14    15    16    17    18    19    20    21    22    23    24    25    26    27    28    29    30    31
const uint8_t Num_Let_7Se[32] = {0xFA, 0x30, 0xD9, 0x79, 0x33, 0x6B, 0xEB, 0x3A, 0xFB, 0x7B, 0xBB, 0xE3, 0xCA, 0xC1, 0xF1, 0xCB, 0x8B, 0xB3, 0x20, 0xF0, 0xC2, 0xBA, 0xA1, 0xE1, 0x9B, 0x81, 0xE0, 0xF2, 0x73, 0x01, 0x04, 0x00};
const uint8_t Num_Let_LCD[32] = {'0' , '1',  '2',  '3',  '4',  '5',  '6',  '7',  '8',  '9',  'A',  'b',  'C',  'c',  'd',  'E',  'F',  'H',  'i',  'J',  'L',  'N',  'n',  'o',  'P',  'r',  'u',  'U',  'Y',  '-',  '.' , ' ' };
//  INDICE EEPROM  ---------------------0x00  0x01  0x02  0x03  0x04  0x05  0x06  0x07  0x08  0x09  0x0A  0x0B  0x0C  0x0D  0x0E  0x0F  0x10  0x11  0x12  0x13  0x14  0x15  0x16  0x17  0x18  0x19  0x1A  0x1B  0x1C  0x1D  0x1E  0x1F
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
short F00_BIT_ON_OFF(char endereco, char campo)//PESQUISA POR BIT HABILITADO NA EEPROM
{
    if (campo &= EEPROM_Read(endereco))//de onde até onde?
    {
        return 1;
    }
    return 0;
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
void F01_IMPRIME_TPIC(uint8_t F01ee)
{
    uint8_t F01aa;	
    for (F01aa = 0; F01aa != 8; F01aa++) 
	{
        if (0 == (F01ee & _8Bit))
            rd1_DADOS_TPIC = 0;
        else
            rd1_DADOS_TPIC = 1; 
        F01ee = F01ee << 1;
        rc1_PHOTO_TPIC = 1;
        rc1_PHOTO_TPIC = 0;
    }
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
void F02_LE_TECLADO(void)
{
	uint8_t F02aa = 2;
    uint8_t F02ee;		
	uint8_t F02uu;
    uint8_t F02KeyAdc[4];
	uint8_t F02stgTeclaValida[2]={123,125};
	uint8_t TeclaPressionadaF02[16] = {'1', '4', '7', '*', '2', '5', '8', '0', '3', '6', '9', '#', 'A', 'B', 'C', 'D'};
	while (F02stgTeclaValida[0] != F02stgTeclaValida[1])
	{
		F02aa++;
		if (F02aa > 1)
		{
			F02aa = 0;
		}
		delay_ms(2);
		adcon0 = 0b00011001;
		delay_ms(2);
		GO_bit = 1;
		while (GO_bit);
		F02KeyAdc[0] = ADRESH;
		adcon0 = 0b00010001;
		delay_ms(2);
		GO_bit = 1;
		while (GO_bit);
		F02KeyAdc[1] = ADRESH;
		adcon0 = 0b00001001;
		delay_ms(2);
		GO_bit = 1;
		while (GO_bit);
		F02KeyAdc[2] = ADRESH;
		adcon0 = 0b00000001;
		delay_ms(2);
		GO_bit = 1;
		while (GO_bit);
		F02KeyAdc[3] = ADRESH;
		F02uu = 0;
		F02stgTeclaValida[F02aa]=tecla_nenhuma;//se nenhum valor for encontrado, ha situaCAo para igualar e sair do while
		for (F02ee = 0; F02ee != 4; F02ee++) 
		{
			if (F02KeyAdc[F02ee] > 40 & F02KeyAdc[F02ee] < 60) 
			{
				F02stgTeclaValida[F02aa] = TeclaPressionadaF02[F02uu];
			}
			F02uu++;
			if (F02KeyAdc[F02ee] > 90 & F02KeyAdc[F02ee] < 110) 
			{
				F02stgTeclaValida[F02aa] = TeclaPressionadaF02[F02uu];
			}
			F02uu++;
			if (F02KeyAdc[F02ee] > 140 & F02KeyAdc[F02ee] < 160) 
			{
				F02stgTeclaValida[F02aa] = TeclaPressionadaF02[F02uu];
			}
			F02uu++;
			if (F02KeyAdc[F02ee] > 190 & F02KeyAdc[F02ee] < 210) 
			{
				F02stgTeclaValida[F02aa] = TeclaPressionadaF02[F02uu];
			}
			F02uu++;	
		}		
	}
	if ((BitKeyAvaliar) & (F02stgTeclaValida[0] < tecla_nenhuma))
	{
		BitKeyAvaliar = 0;
		GteclaPress = F02stgTeclaValida[0];
	}
	if (tecla_nenhuma == F02stgTeclaValida[0])
	{
		BitKeyAvaliar = 1;
		GteclaPress = tecla_nenhuma;
	}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////
	switch (GloginState)
	{
		case def1PWDDESLOGADO:
		{
			if (rb7_SOBE)
			{
				Tecla.Sobe = 0;
				LastTecla.Sobe = 1;
			}
			else		
			{
				Tecla.Sobe = 1;//tecla está pressionada
			}			
			if (rb5_DESCE)
			{
				Tecla.Desce = 0;
				LastTecla.Desce = 1;//bit é armado para poder posteriormente ser abilitado quando for apertado
			}
			else
			{
				Tecla.Desce = 1;//tecla está pressionada
			}		
			if (rb4_NIVEL)
			{
				GprotNivela=0;
				Tecla.Nivela = 0;
			}
			else
			{
				GprotNivela++;
				if (GprotNivela<50)
				{
					Tecla.Nivela = 1;
				}
				else
				{
					GprotNivela=50;
					Tecla.Nivela = 0;
				}
			}	
			break;
		}
		default:
		{
			GstateELEVA = def1STOPPED;
			Tecla.Sobe = 0;
			Tecla.Desce = 0;
			Tecla.Nivela = 0;
			break;
		}
	}
			
    if (rb6_PARA)
    {
		Tecla.Para = 0;
    }
	else	
	{
        Tecla.Para = 1;//tecla está pressionada
	}
	
    if (rb3_AUDIO)
    {
		Tecla.Audio = 0;
    }
	else
	{
        Tecla.Audio = 1;//tecla está pressionada
	}
		
    if (rb2_IRate)
    {
		Tecla.IrAte = 0;
    }
	else
	{
        Tecla.IrAte = 1;//tecla está pressionada
	}
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
void F03_UPDATE_DS1307(void)
{
	uint8_t F03ano;
	uint8_t F03dia;
	uint8_t F03mes;
	uint8_t F03hora;
    I2C1_Start();
    I2C1_Wr(0xD0);
    I2C1_Wr(0);
    I2C1_Repeated_Start();
    I2C1_Wr(0xD1);
    GF03segundos = I2C1_Rd(1);
    GF03minutos = I2C1_Rd(1);
    F03hora = I2C1_Rd(1);
    F03dia = I2C1_Rd(1);//semana
    F03dia = I2C1_Rd(1);
    F03mes = I2C1_Rd(1);
    F03ano = I2C1_Rd(0);
    I2C1_Stop();
	stgFormatedTime[0] = ((F03hora & 0x30) >> 4) + 48;
	stgFormatedTime[1] = (F03hora & 0x0f) + 48;
	stgFormatedTime[2] = ':';
	stgFormatedTime[3] = ((GF03minutos & 0x70) >> 4) + 48;
	stgFormatedTime[4] = (GF03minutos & 0x0f) + 48;
	stgFormatedTime[5] = ':';
	stgFormatedTime[6] = ((GF03segundos & 0x70) >> 4) + 48;
	stgFormatedTime[7] = (GF03segundos & 0x0f) + 48;
	stgFormatedDate[0] = ((F03dia & 0x30) >> 4) + 48;
	stgFormatedDate[1] = (F03dia & 0x0f) + 48;
	stgFormatedDate[2] = '/';
	stgFormatedDate[3] = ((F03mes & 0xf0) >> 4) + 48;
	stgFormatedDate[4] = (F03mes & 0x0f) + 48;
	stgFormatedDate[5] = '/';
	stgFormatedDate[6] = ((F03ano & 0xf0) >> 4) + 48;
	stgFormatedDate[7] = (F03ano & 0x0f) + 48;
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
void F04_ENCHE_CG_RAM(void)//enche a cg ram do lcd//
{
    uint8_t F04aa;
    uint8_t F04ee;
    for (F04ee = 0; F04ee != 8; F04ee++) 
	{
        lcd_cmd(0x40 + (F04ee * 8));
        for (F04aa = 0; F04aa != 8; F04aa++) 
		{
            lcd_chr_cp(charactes[F04ee][F04aa]);
        }
    }
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
void F05_UART_WRITE(char* Text)
{
	rc5_FALAR_OUVIR = 1; //rc5_FALAR_OUVIR at rc5_bit ;
	while(*Text)UART1_Write(*Text++);
	delay_us(255);
	delay_us(255);
	RCREG=0;
	rcif_bit = 0;
	rc5_FALAR_OUVIR = 0; //rc5_FALAR_OUVIR at rc5_bit ;
	rcie_bit = 1;//liga int recepção
	delay_ms(3); //TEMPO PARA RX RECEBER DADOS
	rcie_bit = 0;//desliga int recepção 
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
void F06_VERIFICA_SITUACAO(void)
{
	uint8_t F06MaiorPlaca=0;
	uint8_t F06lasso;
    uint8_t F06audioIndex = 0;
    uint8_t F06cancelaIndex = 0;
    uint8_t F06ee;
    uint8_t F06oo;	
    uint8_t F06impar;
    uint8_t F06par;
	uint8_t F06stg[5];//onde prepara msg para enviar para a torre
    uint8_t F06stgAudio[4] = {255, 255, 255, 255};
    uint8_t F06stgCancela[4] = {255, 255, 255, 255};
	tmr0ie_bit = 0;
	tmr0if_bit = 0;	
    if (rb0_CABINE)//rb0_CABINE at rb0_bit ;
    {
        BitCancelaCloseOpen = 1; //PORTA CABINE ABERTA
        GstateELEVA = def1STOPPED;
    }
	else
	{
		BitCancelaCloseOpen = 0; //sinaliza como fechada		
	}	
    BitStopUp = 0;
    BitStopDown = 0;
	GF94naoRESPONDE=0;
	GF94erroCancela=0;
	GF94quatID=0;
	BitNaoSobreEscrever=1;
	GF94erroIDcolado=0;
	GF94erroIDcoladoLast=0;
	/***************************************************/			
    for (F06lasso = 0;F00_BIT_ON_OFF(F06lasso, _6Bit); F06lasso++)//dentro do for está a condição encerrar 
	{
		F06stg[0]=244;//inicio da transmissão
		F06stg[1] = F06lasso + 10;			
		if (GfaleAqui == F06stg[1])
		{
			F06stg[2]=0b00000001;//abrir audio
		}
		else
		{
			F06stg[2] = 0b00000100;//para não ser vazio - zero para a transmissão
		}			
		F06stg[3]=F06stg[2]+F06stg[1];
		F06stg[4]=0;//fim da transmissão
	/***************************************************/
		Bitindice=0;
		do
		{
			F05_UART_WRITE(F06stg);//enviar e receber situação dos sensores
			stgMemorias[Bitindice][F06lasso]=GidCRC;
			Bitindice=~Bitindice;
		}			
		while (stgMemorias[0][F06lasso]!=stgMemorias[1][F06lasso]);
	/***************************************************/
		if (GidRecebido == F06stg[1])//andar respondeu?
		{
			F06MaiorPlaca = F06lasso; //vai guardar a maior placa a responder
			/***************************************************/								
			if (F00_BIT_ON_OFF(F06lasso, _1Bit))//tecla um no menu jump [id]ignora sensor cancela?
			{
				if (0b00000011 == (GidSensorRX&3))//ha cancela aberta
				{
					BitCancelaCloseOpen = 1;
					GstateELEVA = def1STOPPED;
					F06stgCancela[F06cancelaIndex] = F06lasso;//anota qual andar isso aconteceu
					F06cancelaIndex++;
					if (F06cancelaIndex > 3)//nAo deixa passar desse valor
					{
						F06cancelaIndex = 3;
					}
				}
				if (0b00000001 == (GidSensorRX&3))//NORMALMENTE, NÃO DEVE ISSO ACONTECER
				{
					GF94erroCancela=GidRecebido;
				}					
				if (0b00000010 == (GidSensorRX&3))//NORMALMENTE, NÃO DEVE ISSO ACONTECER
				{
					GF94erroCancela=GidRecebido;
				}	
			}
			/***************************************************/				
			if (F00_BIT_ON_OFF(F06lasso, _2Bit))//tecla dois no menu jump [id]ignora audio
			{
				if (GidSensorRX & _5Bit)//ha chamada de audio
				{
					BitAudioOn = 1;
					F06stgAudio[F06audioIndex] = F06lasso;//vai inserindo na F06stgAudio onde houve chamada de audio
					F06audioIndex++;
					if (F06audioIndex > 3)//nAo deixa passar desse valor
					{
						F06audioIndex = 3;
					}
				}				
			}		
			/***************************************************/				
			if (F00_BIT_ON_OFF(F06lasso, _3Bit))//tecla tres ignora sensor abaixo
			{
				if (_3Bit == (GidSensorRX&12))//defSIMBABAIXO2
				{
					GF94erroIDcolado=F06lasso;
					stgLcd1[0] = defSIMBABAIXO2;
					GidOndeCabineEsta = F06lasso; //atualiza posiCAo do elevador
					if (def2COMINGDOWN == GstateELEVA)//se estiver descendo
					{
						if (0 == F06lasso)//fim de curso eletronico
						{
							GstateELEVA = def1STOPPED; //PARA PORQUE ESTa NO FUNDO DO POCO
						}							
						if (BitPararAqui)
						{
							if (GpareAqui>=GidOndeCabineEsta)
							{
								GstateELEVA = def1STOPPED;
								GpareAqui=32;
								BitPararAqui=0;
							}
						}						
					}
					if (0 == F06lasso)//fim de curso eletronico
					{
						BitStopDown = 1;
					}						
				}				
			}
			/***************************************************/						
			if (F00_BIT_ON_OFF(F06lasso, _4Bit))//tecla quatro ignora sensor acima
			{
				if (_4Bit == (GidSensorRX&12))//defSIMBACIMA1
				{
					GF94erroIDcolado=F06lasso;
					stgLcd1[0] = defSIMBACIMA1;
					GidOndeCabineEsta = F06lasso; //atualiza posiCAo do elevador
					if (GstateELEVA==def1COMINGUP)//se estiver subindo
					{
						if (GbiggerPID == F06lasso)//fim de curso eletronico
						{
							GstateELEVA = def1STOPPED; //PARA PORQUE ESTa ACIMA DE TUDO
						}
						if (BitPararAqui)
						{
							if (GpareAqui<=GidOndeCabineEsta)
							{
								GstateELEVA = def1STOPPED;
								GpareAqui=32;
								BitPararAqui=0;
							}
						}				
					}
					if (GbiggerPID == F06lasso)//fim de curso eletronico
					{
						BitStopUp = 1;
					}						
				}				
			}
			/***************************************************/				
			if (F00_BIT_ON_OFF(F06lasso, _5Bit))//tecla cinco ignora nivelado
			{
				if (0 == (GidSensorRX&12))//nivelado
				{
					GF94erroIDcolado=F06lasso;
					stgLcd1[0] = defSIMBPLACE3;//SIMBOLO DE NIVELADO NA STRING DO LCD
					GidOndeCabineEsta = F06lasso; //atualiza posiCAo do elevador
					if (BitPararAqui)
					{
						if (GstateELEVA==def1COMINGUP)//se estiver subindo
						{
							if (GpareAqui<=GidOndeCabineEsta)//está mais alto do que o ponto marcado?
							{
								GstateELEVA = def1STOPPED;
								GpareAqui=32;
								BitPararAqui=0;
							}												
						}
						if (GstateELEVA==def2COMINGDOWN)//se estiver descendo
						{
							if (GpareAqui>=GidOndeCabineEsta)//está mais baixo do que o ponto marcado?
							{
								GstateELEVA = def1STOPPED;
								GpareAqui = 32;
								BitPararAqui = 0;
							}													
						}							
					}
					if (GstateELEVA==def1COMINGUP)//se estiver subindo
					{								
						if (GbiggerPID == F06lasso)//fim de curso eletronico
						{
							GstateELEVA = def1STOPPED; //PARA PORQUE ESTa ACIMA DE TUDO
						}				
					}
					if (GstateELEVA==def2COMINGDOWN)//se estiver descendo
					{								
						if (0 == F06lasso)//fim de curso eletronico
						{
							GstateELEVA = def1STOPPED; //PARA PORQUE ESTa NO FUNDO DO POCO
						}						
					}	
				}				
			}
			if (GF94erroIDcolado != GF94erroIDcoladoLast)
			{
				GF94erroIDcoladoLast = GF94erroIDcolado;
				GF94quatID++;
			}
		}
		/***************************************************/			
		else
		{
			if (BitNaoSobreEscrever)
			{
				GF94naoRESPONDE = F06stg[1];
				BitNaoSobreEscrever = 0;
			}
			if (F00_BIT_ON_OFF(defPAG1, _1Bit))//PARA TUDO quando não responde alguma placa de andar?
			{
				GstateELEVA = def1STOPPED;
				break;
			}
		}
    }
	/***************************************************/				
    F06ee = GidOndeCabineEsta * 2;
    F06par = EEPROM_Read(F06ee+32);
    F06impar = EEPROM_Read(F06ee+33);    
    Gunidade7SEG = Num_Let_7Se[F06par];
    Gdezena7SEG = Num_Let_7Se[F06impar];
    stgLcd1[1] = Num_Let_LCD[F06par];//será isso necessário?
    stgLcd1[2] = Num_Let_LCD[F06impar];//será isso necessário?
	/***************************************************/			
	if ((Tecla.Audio) & (0 == BitAudioOn))//tecla audio e sem chamada ativa
	{
		GfaleAqui = GidOndeCabineEsta+10;
		Tecla.Audio = 0;
	}
	else
	{
		GfaleAqui = 42;
	}
	/***************************************************/			
    if (BitCancelaCloseOpen)//ha cancela aberta
    {
        stgLcd2[0] = defSIMBCANCELA;
		if (rb0_CABINE)//rb0_CABINE at rb0_bit
		{
			stgLcd2[1] = '.';
			if (BitInverter)
			{
				stgLcd2[2] = 'C';
				stgLcd2[3] = 'a';
				stgLcd2[4] = 'b';	
				stgLcd2[5] = 'i';
				stgLcd2[6] = 'n';	
				stgLcd2[7] = 'e';				
			}
			else
			{
				stgLcd2[2] = 'A';
				stgLcd2[3] = 'b';
				stgLcd2[4] = 'e';	
				stgLcd2[5] = 'r';
				stgLcd2[6] = 't';	
				stgLcd2[7] = 'a';				
			}
			F06oo = 8;
		}
		else		
		{
			F06oo = 1;
		}
		for (F06lasso = 0;(F06stgCancela[F06lasso] != 255) && (F06oo<13);F06lasso++)//vai colocar no LCD os lugares onde há cancela aberta
		{
			F06ee = F06stgCancela[F06lasso] * 2;
			F06par = EEPROM_Read(F06ee+32);
			F06impar = EEPROM_Read(F06ee+33);				
			stgLcd2[F06oo] = '.';
			stgLcd2[F06oo + 1] = Num_Let_LCD[F06par];
			stgLcd2[F06oo + 2] = Num_Let_LCD[F06impar];
			F06oo = F06oo + 3;
		}	
    }
	/***************************************************/			
    switch (GstateELEVA)//vai escrever no lcd o que isso implica
    {
		case def1STOPPED:
		{
			if (!BitCancelaCloseOpen) 
			{
				stgLcd2[0] = 'O';
				stgLcd2[1] = 'K';
				if (BitStopUp) 
				{
					stgLcd2[2] = defSIMBNAOSOBE;
				}
				if (BitStopDown) 
				{
					stgLcd2[2] = defSIMBNAODESCE;
				}
			}
			BitPararAquiOnce = 1;
			break;
		}
		case def1COMINGUP:
		{
			stgLcd2[0] = defSIMBSUBINDO;
			stgLcd2[1] = 'S';
			stgLcd2[2] = 'o';
			stgLcd2[3] = 'b';
			stgLcd2[4] = 'e';
			if (GidOndeCabineEstaVA != GidOndeCabineEsta)
			{
				if (GidOndeCabineEstaVA != GidOndeCabineEsta-1)//chegou numa parada diferente
				{
					BitErroIPD = 1;
					GerroIPD = GidOndeCabineEstaVA+1;
				}				
			}	
			break;
		}
		case def2COMINGDOWN:
		{
			stgLcd2[0] = defSIMBDESCENDO;
			stgLcd2[1] = 'D';
			stgLcd2[2] = 'e';
			stgLcd2[3] = 's';
			stgLcd2[4] = 'c';
			stgLcd2[5] = 'e';
			if (GidOndeCabineEstaVA != GidOndeCabineEsta)
			{	
				if (GidOndeCabineEstaVA != GidOndeCabineEsta+1)
				{
					BitErroIPD = 1;
					GerroIPD = GidOndeCabineEstaVA-1;					
				}
			}			
			GidOndeCabineEstaVA = GidOndeCabineEsta;		
			break;
		}
		case defLEVELING4:
		{
			stgLcd2[0] = defSIMBLEVELING;
			stgLcd2[1] = 'N';
			stgLcd2[2] = 'i';
			stgLcd2[3] = 'v';
			stgLcd2[4] = 'e';
			stgLcd2[5] = 'l';
			stgLcd2[6] = 'a';
			GstateELEVA = def1STOPPED;//NAO PODE TRAVAR
			if (GidOndeCabineEstaVA != GidOndeCabineEsta)//chegou numa parada diferente
			{
				if (GidOndeCabineEstaVA != GidOndeCabineEsta+1)
				{		
					BitErroIPD = 1;
					GerroIPD = GidOndeCabineEstaVA-1;										
				}
			}			
			break;
		}
    }	
	GidOndeCabineEstaVA = GidOndeCabineEsta;	
	/***************************************************/	
	if (GpareAqui < 32)
	{	
		if (BitInverter)
		{
			if (GpareAqui>GidOndeCabineEsta)
			{
				stgLcd2[6] =  defSIMBSUBINDO;//MAIS TARDE FAZER TECLAS PISCAREM
			}				
			if (GpareAqui<GidOndeCabineEsta)
			{
				stgLcd2[6] = defSIMBDESCENDO;
			}			
		}
		stgLcd2[7] = 'I';
		stgLcd2[8] = 'r';		
		stgLcd2[9] = ' ';
		stgLcd2[10] = 'A';
		stgLcd2[11] = 't';
		stgLcd2[12] = defSIMBeh;
		stgLcd2[13] = ':';		
		F06ee = GpareAqui * 2;
		F06par = EEPROM_Read(F06ee+32);
		F06impar = EEPROM_Read(F06ee+33);		
		stgLcd2[14] = Num_Let_LCD[F06par];
		stgLcd2[15] = Num_Let_LCD[F06impar];	
	}	
    if (BitAudioOn)//ha audio aberto
    {
        stgLcd1[4] = defSIMBAUDIO;
        F06oo = 5;
        for (F06lasso = 0;(F06stgAudio[F06lasso] != 255) && (F06oo<13); F06lasso++)//vai colocar no LCD os lugares onde há cancela aberta
		{
			F06ee = F06stgAudio[F06lasso] * 2;
			F06par = EEPROM_Read(F06ee+32);
			F06impar = EEPROM_Read(F06ee+33);         
			stgLcd1[F06oo] = '.';
			stgLcd1[F06oo + 1] = Num_Let_LCD[F06par];
			stgLcd1[F06oo + 2] = Num_Let_LCD[F06impar];
			F06oo += 3;
        }
    }
	if (F00_BIT_ON_OFF(defPAG1, _3Bit))//MOSTRA OCULTA RELÓGIO CALENDÁRIO
	{
		if (0 == BitAudioOn)
		{
			for (F06oo = 0; F06oo != 8; F06oo++)
			{
				stgLcd1[F06oo+8]=stgFormatedTime[F06oo];	//mostra hora se não houver chamda de audio			
			}
		}		
		if (GstateELEVA == def1STOPPED)//precisa estar parado
		{
			if ((0 == BitCancelaCloseOpen) && (GpareAqui==32))//cancela fechadas  
			{
				for (F06oo = 0; F06oo != 8; F06oo++)
				{
					stgLcd2[F06oo+8]=stgFormatedDate[F06oo];	//mostra a data se tudo estiver ok			
				}				
			}
		}		
	}
	/***************************************************/			
	if (rb1_FIM_INFERIOR)//rd0_FIM_SUPERIOR at rd0_bit
	{
		stgLcd2[0] = defSIMBNAODESCE;			
		if (BitInverter)
		{
			stgLcd2[1] = 	'F';
			stgLcd2[2] = 	'i';
			stgLcd2[3] = 	'm';
			stgLcd2[4] = 	' ';
			stgLcd2[5] = 	'C';
			stgLcd2[6] = 	'u';
			stgLcd2[7] = 	'r';
			stgLcd2[8] = 	's';
			stgLcd2[9] = 	'o';
			stgLcd2[10] = 	' ';
			stgLcd2[11] = 	'F';
			stgLcd2[12] = 	'u';
			stgLcd2[13] = 	'n';
			stgLcd2[14] = 	'd';
			stgLcd2[15] = 	'o';			
		}
		else
		{
			stgLcd2[1] = 	'L';	
			stgLcd2[2] = 	'i';    
			stgLcd2[3] = 	'm';    
			stgLcd2[4] = 	'i';    
			stgLcd2[5] = 	't';    
			stgLcd2[6] = 	'e';    
			stgLcd2[7] = 	' ';     
			stgLcd2[8] = 	'I';     
			stgLcd2[9] = 	'n';     
			stgLcd2[10] = 	'f';     
			stgLcd2[11] = 	'e';     
			stgLcd2[12] = 	'r';     
			stgLcd2[13] = 	'i';     
			stgLcd2[14] = 	'o';     
			stgLcd2[15] = 	'r';		
		}		
	}
	/***************************************************/			
	if (rd0_FIM_SUPERIOR)//rd0_FIM_SUPERIOR at rd0_bit
	{
		stgLcd2[0] = defSIMBNAOSOBE;			
		if (BitInverter)
		{
			stgLcd2[1] = 	'F';
			stgLcd2[2] = 	'i';
			stgLcd2[3] = 	'm';
			stgLcd2[4] = 	' ';
			stgLcd2[5] = 	'C';
			stgLcd2[6] = 	'u';
			stgLcd2[7] = 	'r';
			stgLcd2[8] = 	's';
			stgLcd2[9] = 	'o';
			stgLcd2[10] = 	' ';
			stgLcd2[11] = 	'T';
			stgLcd2[12] = 	'o';
			stgLcd2[13] = 	'p';
			stgLcd2[14] = 	'o';
			stgLcd2[15] = 	' ';			
		}
		else
		{
			stgLcd2[1] = 	'L';	
			stgLcd2[2] = 	'i';    
			stgLcd2[3] = 	'm';    
			stgLcd2[4] = 	'i';    
			stgLcd2[5] = 	't';    
			stgLcd2[6] = 	'e';    
			stgLcd2[7] = 	' ';     
			stgLcd2[8] = 	'S';     
			stgLcd2[9] = 	'u';     
			stgLcd2[10] = 	'p';     
			stgLcd2[11] = 	'e';     
			stgLcd2[12] = 	'r';     
			stgLcd2[13] = 	'i';     
			stgLcd2[14] = 	'o';     
			stgLcd2[15] = 	'r';		
		}		
	}	
	GbiggerPID = F06MaiorPlaca;
	tmr0ie_bit = 1;
	BitAtualizarLcd = 1;
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
void F07_CONFIGURA_SISTEMA(uint8_t como)
{
	uint8_t F07ee;
	if (0 == RCON.B3)
	{
		como = 1;
	}		
	switch (como)
	{
		case 0:
			trisd = _1Bit;
			lcd_init();
			lcd_cmd(_lcd_clear); // clear display
			lcd_cmd(_lcd_cursor_off); // cursor?
			//F04_ENCHE_CG_RAM();			
			Lcd_Out(defLCDLINHA1, 1, "alex");
			delay_ms(500);
			Lcd_Out(defLCDLINHA2, 1, "henrique");
			delay_ms(500);
			lcd_cmd(_lcd_clear);
			BitErroCRC = 0;
			BitErroIPD = 0;
			//NO-BREAK HERE
//SFR			
		case 1:

			GalgumERRO = 0;
			delay_ms(100);
			gie_bit = 0;
			ADIE_bit = 0;
			BCLIE_bit = 0;
			CCP1IE_bit = 0;
			CCP2IE_bit = 0;
			EEIE_bit = 0;
			INT0F_bit = 0;
			INT0IE_bit = 0;
			INT1IE_bit = 0;
			INT2IE_bit = 0;
			LVDIE_bit = 0;			
			PSPIE_bit = 0;
			RBIE_bit = 0;
			SSPIE_bit = 0;
			T0IE_bit = 1;
			TMR1IE_bit = 0;
			TMR2IE_bit = 0;
			TMR3IE_bit = 0;
			TXIE_bit = 0;			
			porta = 0;
			portb = 0xFF;
			portc = 0;
			portd = 0;
			porte = 0;
			trisa = 0b00101111;
			trisb = 0xff; //TUDO ENTRADA
			trisc = 0b10000001;
			trisd = _1Bit;
			trise = _4Bit;
			adcon0 = 0b00000001;
			adcon1 = 0b01000010;
			//adcon2 = 0b00101001 ;//quando 18f4520 estiver selecionado
			ipr1 = 0xff;
			ipr2 = 0xff;
			peie_bit = 1;
			intedg0_bit = 0; 
			intedg1_bit = 0; 
			intedg2_bit = 0; 
			rbpu_bit = 1;
			rbif_bit = 0; 
			rcie_bit = 1;
			ipen_bit = 0; 
			t0con.tmr0on = 1;
			t0con.t08bit = 0; 
			t0con.t0cs = 0; 
			t0con.t0se = 0; 
			t0con.psa = 0; 
			t0con.t0ps2 = 1;
			t0con.t0ps1 = 0; 
			t0con.t0ps0 = 0; 
			TMR0H = 0x85;
			TMR0L = 0xEE;
			tmr0ie_bit = 1;
			tmr1cs_bit = 0; 
//MEUS			
			delay_ms(100);
			GidOndeCabineEsta = 0;
			GpareAqui = 32;
			GretornaHome = 0;
			Gmenu = 0;
			Gnivel = defVisualiza;
			Gseq = 1;
			GsubMenu = 0;
			GteclaPress = '>';
			GstateELEVA = def1STOPPED;
			Tecla.Para = 1;
			BitGravar = 0;
			GloginState = def1PWDDESLOGADO;			
			BitAvaliar = 0;
			BitAudioOn = 0;
			BitCancelaCloseOpen = 0;
			BitStopDown = 0;
			BitStopUp = 0;
			Tecla.Audio = 0;
			Tecla.Desce = 0;
			Tecla.IrAte = 0;
			Tecla.Nivela = 0;
			Tecla.Sobe = 0;
			LastTecla.Desce = 0;
			LastTecla.Sobe = 0;
			BitVaiVoltar = 0;
			BitKeyAvaliar = 0;
			BitNaoSeq = 0;
			BitSenhasIguais = 0;
			BitGravar = 0;
			BitAtualizarLcd = 0;
			BitPararAqui = 0;		
			GchamadaState = def5NORMAL;
			GidRXstate = 0;
			Bitindice = 0;
			GposSenha = 0;
			GsenhaPosi = 0;
			GfaleAqui = 42;
			GprotNivela = 0;
			rc5_FALAR_OUVIR = 0;
			Gunidade7SEG = Num_Let_7Se[0];
			Gdezena7SEG = Num_Let_7Se[0];	
			BitDescer=0;		
//INTIS			
			I2C1_Init(100000);
			uart1_init(19200);			
			lcd_init();
			lcd_cmd(_lcd_clear); // clear display
			lcd_cmd(_lcd_cursor_off); // cursor?
			F04_ENCHE_CG_RAM();	
			for (F07ee = 0; F07ee != 16; F07ee++) 
			{
				stgLcd1[F07ee]=32;
				stgLcd2[F07ee]=32;
			}			
			gie_bit = 1;
	}
}

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
short F08verificaParada (uint8_t F08qualID)//0 a 31, vai somar 10
{
	uint8_t F08stg[5];	
	F08stg[0]=244;//inicio da transmissão
	F08stg[1] = F08qualID + 10;
	F08stg[2] = 0b00000100;//para não ser vazio - zero para a transmissão		
	F08stg[3] = F08stg[2]+F08stg[1];
	F08stg[4] = 0;//fim da transmissão
	F05_UART_WRITE(F08stg);	
	if (GidRecebido == F08stg[1])
    {
        return 1;
    }
		return 0;	
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
void F09(void)
{
	
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
void F10_ESCREVE_DS1307(uint8_t F10time, uint8_t F10end)
{
    I2C1_Start();
    I2C1_Wr(0xD0);
    I2C1_Wr(F10end);//ONDE COMEÇA A ESCRITA
    I2C1_Wr(Dec2Bcd(F10time));//QUAL VALOR A SER ESCRITO
    I2C1_Stop();
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
void F11_HABILITA_PARADAS(uint8_t F11adress)
{
    uint8_t F11readValue;
    uint8_t F11ee;
	uint8_t F11par;
    uint8_t F11impar;
	F11readValue = EEPROM_Read(F11adress); //OOO7
    if ('1' == GteclaPress) 
		{
			if (F11readValue & _6Bit) //apaga primeiro bit
			{
				F11readValue &= 0b11011111;
			}
			else 
			{
				F11readValue |= _6Bit;//liga primeiro bit
			}
			EEPROM_Write(F11adress, F11readValue);
			delay_ms(10);
			GteclaPress ='<';
		}
	if (F08verificaParada (F11adress))
	{
		stgLcd1[0] = 	'D';
		stgLcd1[1] = 	'e';
		stgLcd1[2] = 	't';
		stgLcd1[3] = 	'e';
		stgLcd1[4] = 	'c';
		stgLcd1[5] = 	't';
		stgLcd1[6] = 	'a';
		stgLcd1[7] = 	'd';
		stgLcd1[8] = 	'a';
		if (_0Bit == (_6Bit & F11readValue)) 
		{
			if (BitInverter)
			{
				stgLcd2[15] = 	def7SIMBEXCLAM;				
			}
		}
	}
	else
	{
		stgLcd1[0] = 	'N';
		stgLcd1[1] = 	defSIMBaTIL;
		stgLcd1[2] = 	'o';
		stgLcd1[4] = 	'D';
		stgLcd1[5] = 	'e';
		stgLcd1[6] = 	't';
		stgLcd1[7] = 	'e';
		stgLcd1[8] = 	'c';
		stgLcd1[9] = 	't';
		stgLcd1[10] = 	'a';
		stgLcd1[11] = 	'd';
		stgLcd1[12] = 	'a';
		if (_6Bit == (_6Bit & F11readValue)) 
		{
			if (BitInverter)
			{
				stgLcd2[15] = 	def7SIMBEXCLAM;				
			}
		}
	}
	stgLcd2[0] = 'i';
	stgLcd2[1] = 'D';
	stgLcd2[2] = ':';
	if (F11adress>9)
	{
		stgLcd2[3]=F11adress/10+48;
	}
	else
	{
		stgLcd2[3]='0';
	}			
	stgLcd2[4]=F11adress%10+48;		
	if (_0Bit == (_6Bit & F11readValue)) 
	{
		stgLcd2[6] = 	'D';
		stgLcd2[7] = 	'e';
		stgLcd2[8] = 	's';		
		stgLcd2[9] = 	'l';
		stgLcd2[10] = 	'i';
		stgLcd2[11] = 	'g';
		stgLcd2[12] = 	'a';
		stgLcd2[13] = 	'd';
		stgLcd2[14] = 	'a';		
	}
	else
	{
		stgLcd2[6] = 	'L';
		stgLcd2[7] = 	'i';
		stgLcd2[8]  =  	'g';
		stgLcd2[9] = 	'a';
		stgLcd2[10] = 	'd';
		stgLcd2[11] = 	'a';	
	}	
	F11ee = F11adress * 2;
    F11par = EEPROM_Read(F11ee+32);
    F11ee++;
    F11impar = EEPROM_Read(F11ee+32);
    Gunidade7SEG = Num_Let_7Se[F11par];
    Gdezena7SEG = Num_Let_7Se[F11impar];
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
void F12_JUMPER_SENSOR(uint8_t F12address)
{
    uint8_t F12readValue;
    uint8_t F12ee;
	uint8_t F12TestValue;
	uint8_t F12par;
    uint8_t F12impar;
    bit F12gravarEEprom;
    F12gravarEEprom = 0;
	F12readValue = EEPROM_Read(F12address); //OOO7
    switch (GteclaPress) 
	{
		case '0'://0
		{
			F12readValue |= 0b00011111;//apaga todos
			F12gravarEEprom = 1;
			break;
		}		
		case '1'://1
		{
			if (F12readValue & _1Bit) //apaga primeiro bit
			{
				F12readValue &= 0b11111110;
			}
			else 
			{
				F12readValue |= _1Bit;//liga primeiro bit
			}
			F12gravarEEprom = 1;
			break;
		}
		case '2'://2
		{
			if (F12readValue & _2Bit) //apaga segundo bit
			{                            
				F12readValue &= 0b11111101;
			}                            
			else                         
			{                            
				F12readValue |= _2Bit;//liga segundo bit
			}
			F12gravarEEprom = 1;
			break;
		}
		case '3'://3
		{
			if (F12readValue & _3Bit) //apaga terceiro bit
			{                            
				F12readValue &= 0b11111011;
			}                            
			else                         
			{                            
				F12readValue |= _3Bit;//liga terceiro bit
			}
			F12gravarEEprom = 1;
			break;
		}
		case '4'://4
		{
			if (F12readValue & _4Bit) //apaga quarto bit
			{                            
				F12readValue &= 0b11110111;
			}                            
			else                         
			{                            
				F12readValue |= _4Bit;//liga quarto bit
			}
			F12gravarEEprom = 1;
			break;
		}
		case '5'://5
		{
			if (F12readValue & _5Bit) //apaga quinto bit
			{                            
				F12readValue &= 0b11101111;
			}                            
			else                         
			{                            
				F12readValue |= _5Bit;//liga quinto bit
			}
			F12gravarEEprom = 1;
			break;
		}
    }
    if (Gnivel == defEdicao) 
	{
        Gnivel = defVisualiza;
    }
    if (F12gravarEEprom) 
	{
        F12gravarEEprom = 0;
		EEPROM_Write(F12address, F12readValue);
    } 
    F12TestValue = _1Bit;
    for (F12ee = 0; F12ee != 5; F12ee++)//coloca na string stgLcd1 a representaCAo dos bits editados
	{		
        if (F12TestValue & F12readValue) 
		{
            stgLcd1[F12ee] = defSIMBON0;
        }
        else 
		{
			if (BitInverter)
			{
				stgLcd1[F12ee] = def6SIMBSWITCHOFF;				
			}
			else
			{
				stgLcd1[F12ee] = def7SIMBEXCLAM;	
			}
        }
		stgLcd2[F12ee] = 49+F12ee;
        F12TestValue = F12TestValue << 1;
    }
	stgLcd1[6] = 'J';
	stgLcd1[7] = 'u';
	stgLcd1[8] = 'm';
	stgLcd1[9] = 'p';
	stgLcd1[10] = 'e';
	stgLcd1[11] = 'r';
	
	stgLcd2[6] = 'i';
	stgLcd2[7] = 'D';
	stgLcd2[8] = ':';
	if (F12address>9)
	{
		stgLcd2[9]=F12address/10+48;
	}
	else
	{
		stgLcd2[9]='0';
	}			
	stgLcd2[10]=F12address%10+48;		
	F12ee = F12address * 2;
    F12par = EEPROM_Read(F12ee+32);
    F12ee++;
    F12impar = EEPROM_Read(F12ee+32);
    Gunidade7SEG = Num_Let_7Se[F12par];
    Gdezena7SEG = Num_Let_7Se[F12impar];
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
uint8_t F13_LIMPA_BY_JUMPERS (uint8_t F13oo)
{
	uint8_t F13aa;
    uint8_t F13ee;	
	if (F13oo==0)//para averiguar
	{
		for (F13ee = 0; F13ee != 32; F13ee++)
		{
			F13aa = EEPROM_Read(F13ee);
			F13aa &= 0b00011111;
			if (F13aa != 0b00011111)
			return 1;
		}
		return 0;
	}
	else//para gravar
	{
		for (F13ee = 0; F13ee != 32; F13ee++) 
		{
			F13aa = EEPROM_Read(F13ee);
			F13aa |= 0b00011111;
			EEPROM_Write(F13ee, F13aa);			
			delay_ms(10);		
		}
	}	
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
void F14_EDITA_ID (void)
{
	uint8_t F14ee = 0;
	uint8_t F14oo = 0;	
	uint8_t F14stgEnvio[6];
	uint8_t F14procuraSearch;
	for (F14procuraSearch = 0; F14procuraSearch != 32; F14procuraSearch++) 
	{	
		GidRecebido = 0;
		if (F08verificaParada (F14procuraSearch))
		{
			F14ee++;
			GidOriginal = F14procuraSearch;
		}
	}
	stgLcd1[0] = 'P';
	stgLcd1[1] = 'a';
	stgLcd1[2] = 'r';
	stgLcd1[3] = 'a';
	stgLcd1[4] = 'd';
	stgLcd1[5] = 'a';
	stgLcd1[6] = 's';
	stgLcd1[7] = ':';
	if (F14ee>9)//PARA ESCREVE NO LCD
	{
		stgLcd1[8]=(F14ee/10)+48;//primeiro digito
	}
	else
	{
		stgLcd1[8]='0';//primeiro digito
	}
	stgLcd1[9]=(F14ee%10)+48;		
	BitGravar = 0;	
	switch (GteclaPress)		
	{
		case 'D':
		{                          
			GidNovaEditada++;
			if (GidNovaEditada>31)
			{
				GidNovaEditada = 0;
			}
			break;
		}	
		case 'C':
		{                          
			GidNovaEditada--;
			if (GidNovaEditada>250)
			{
				GidNovaEditada = 31;
			}
			break;
		}
		case 'B':
		{       
			stgLcd2[15] = defSIMBrecording;
			BitGravar = 1;
			break;
		}		
	}
	stgLcd2[7] = 'e';//PODE MOSTRAR QUAL ID DE QUAL PLACANDAR ESTa CONECTADA
	stgLcd2[8] = 'D';
	stgLcd2[9] = ':';		
	if (GidNovaEditada>9)
	{
		stgLcd2[10]=(GidNovaEditada/10)+48;//primeiro digito
	}
	else
	{
		stgLcd2[10]='0';//primeiro digito
	}
	stgLcd2[11]=(GidNovaEditada%10)+48;		
	if (1 == F14ee)
	{
		stgLcd2[0] = 'i';//PODE MOSTRAR QUAL ID DE QUAL PLACANDAR ESTa CONECTADA
		stgLcd2[1] = 'D';
		stgLcd2[2] = ':';		
		if (GidOriginal>9)
		{
			stgLcd2[3]=(GidOriginal/10)+48;//primeiro digito
		}
		else
		{
			stgLcd2[3]='0';//primeiro digito
		}
		stgLcd2[4]=(GidOriginal%10)+48;		
		if (BitGravar)
		{			
			BitGravar = 0;
			F14ee = GidNovaEditada+10;
			GidOriginal+=10;
			F14oo = F14ee+GidOriginal;			
			F14stgEnvio[0]=254;		
			F14stgEnvio[1]=GidOriginal;		
			F14stgEnvio[2]=F14ee;		
			F14stgEnvio[3]=F14oo;		
			F14stgEnvio[4]=110;
			F14stgEnvio[5]=0;
			F05_UART_WRITE(F14stgEnvio);				
		}
	}	
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
void F15_CONF_DS1307(void)
{
	uint8_t F15aa;
	uint8_t F15ee;
    if (defEdicao == Gnivel)//modo ediCAo
    {
		stgLcd2[15] = defSIMBrecording;
        if (0 == Gseq) 
		{
            GsubMenu--;
            Gseq = 1;
        }
        if (Gseq > 250) Gseq = 1;//ESTOUROU
        if (Gseq > 8) 
		{
            Gseq = 1;
            GsubMenu++;
        }
        if ((GteclaPress > 47) & (GteclaPress < 58) & (Gseq < 9)) //COLOCA DADO DO TECLADO DENTRO DA STRING
        {
            stgTime[Gseq] = GteclaPress-48;
            if (GsubMenu < 3) 
			{
                Gseq++;
            }
            BitNaoSeq = 1;
        }
        switch (Gseq) 
		{
			case 1:
			case 2:
			{
				if (GsubMenu == horas) 
				{
					stgLcd2[Gseq] = 'H';
					stgLcd2[Gseq+1] = 'o';
					stgLcd2[Gseq+2] = 'r';
					stgLcd2[Gseq+3] = 'a';
					stgLcd2[Gseq+4] = 's';
				}
				if (GsubMenu == datas) 
				{
					stgLcd2[Gseq] = 'D';
					stgLcd2[Gseq+1] = 'i';
					stgLcd2[Gseq+2] = 'a';					
				}
				break;
			}
			case 4:
			case 5:
			{
				if (GsubMenu == horas) 
				{
					stgLcd2[Gseq] = 'M';
					stgLcd2[Gseq+1] = 'i';
					stgLcd2[Gseq+2] = 'n';
					stgLcd2[Gseq+3] = '.';				
				}
				if (GsubMenu == datas) 
				{
					stgLcd2[Gseq] = 'M';
					stgLcd2[Gseq+1] = defSIMBeTIL;
					stgLcd2[Gseq+2] = 's';				
				}
				break;
			}
			case 7:
			case 8:
			{
				if (GsubMenu == horas) 
				{
					stgLcd2[Gseq] = 'S';
					stgLcd2[Gseq+1] = 'e';
					stgLcd2[Gseq+2] = 'g';
					stgLcd2[Gseq+3] = '.';
				}
				if (GsubMenu == datas) 
				{
					stgLcd2[Gseq] = 'A';
					stgLcd2[Gseq+1] = 'n';
					stgLcd2[Gseq+2] = 'o';
				}
				break;
			}
        }
        if ((0 == Gseq % 3) && (BitNaoSeq))
		{
            BitAvaliar = 1;
            Gseq--;
        }
		stgLcd2[Gseq-1] = '^';		
    }
	if (GsubMenu == horas) 
	{
		stgLcd1[12] = 'H';
		stgLcd1[13] = 'o';
		stgLcd1[14] = 'r';
		stgLcd1[15] = 'a';
	}
	if (GsubMenu == datas) 
	{
		stgLcd1[12] = 'D';
		stgLcd1[13] = 'a';
		stgLcd1[14] = 't';
		stgLcd1[15] = 'a';
	}
    if (Gnivel == defVisualiza)
	{
        Gseq = 1; //modo visualizaCAo
    }
    if (BitAvaliar) //DETERMINA SE VALORES E JA ATUALIZA
    {
        BitAvaliar = 0;
        if (GsubMenu == datas)//CONFIGURACAO DATA
        {
            switch (Gseq) 
			{
				case 1:
				case 2:
				{
					F15ee = (stgTime[1])*10;
					F15ee = F15ee + (stgTime[2]);
					if ((F15ee != 0) && (F15ee < 32))//DIAS ESTAO ENTRE 1 E 31
					{
						F10_ESCREVE_DS1307(F15ee,4);
						Gseq = 4;
					}
					else 
					{
						Gseq = 1; //VALOR FORA DOS LIMITES, RETORNA
					}
					break;
				}
				case 4:
				case 5:
				{
					F15ee = (stgTime[4])*10;
					F15ee = F15ee + (stgTime[5]);
					if ((F15ee != 0) && (F15ee < 13))//MESES ESTAO ENTRE 1 E 12
					{
						F10_ESCREVE_DS1307(F15ee,5);
						Gseq = 7;
					}
					else
					{
						Gseq = 4; //VALOR FORA DOS LIMITES, RETORNA
					}
					break;
				}
				case 7:
				case 8:
				{
					F15ee = (stgTime[7])*10;
					F15ee = F15ee + (stgTime[8]);
					if (F15ee < 100)// ANOS ESTAO ENTRE O E 99
					{
						F10_ESCREVE_DS1307(F15ee,6);
						Gseq = 1;
						Gnivel = defVisualiza;
					}
					else
					{
						Gseq = 7; //VALOR FORA DOS LIMITES, RETORNA
					}
					break;
				}
            }
        }
        if (GsubMenu == horas)//CONFIGURACAO HORAS
        {
            switch (Gseq) 
			{
				case 1:
				case 2:
				{
					F15ee = (stgTime[1])*10;
					F15ee = F15ee + (stgTime[2]);
					if  (F15ee < 24)//HORAS ESTAO ENTRE 0 E 23
					{
						F10_ESCREVE_DS1307(F15ee,2);
						Gseq = 4; //SALTA PRA MINUTOS
					}
					else 
					{
						Gseq = 1; //VALOR FORA DOS LIMITES, RETORNA
					}
					break;
				}
				case 4:
				case 5:
				{
					F15ee = (stgTime[4])*10;
					F15ee = F15ee + (stgTime[5]);
					if (F15ee < 60)//MINUTOS ENTRE 0 E 59
					{
						F10_ESCREVE_DS1307(F15ee,1);
						Gseq = 7;
					}
					else
					{
						Gseq = 4; //VALOR FORA DOS LIMITES, RETORNA
					}
					break;
				}
				case 7:
				case 8:
				{
					F15ee = (stgTime[7])*10;
					F15ee = F15ee + (stgTime[8]);
					if (F15ee < 60)//SEGUNDOS ESTAO ENTRE 0 E 59
					{
						F10_ESCREVE_DS1307(F15ee,0);
						Gseq = 1;
						Gnivel = defVisualiza;
					}
					else 
					{
						Gseq = 7; //VALOR FORA DOS LIMITES, RETORNA
					}
					break;
				}
            }
        }
    }
    if (GsubMenu == horas) 
	{
		for (F15aa = 0; F15aa != 8; F15aa++)
		{
			stgLcd1[F15aa]=stgFormatedTime[F15aa];					
		}			
    }
    if (GsubMenu == datas) 
	{
		for (F15aa = 0; F15aa != 8; F15aa++)
		{
			stgLcd1[F15aa]=stgFormatedDate[F15aa];					
		}
    }	
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
void F16_CONFIG_SENHA(void)
{
    uint8_t F16aa;
    if (Gnivel == defVisualiza)//modo visualiza
    {
        for (F16aa = 0; F16aa != 6; F16aa++) 
		{
            stg_senha1[F16aa] = '_';
            stg_senha2[F16aa] = '_';
            stgLcd1[F16aa] = EEPROM_Read(F16aa+250);
        }
        stgLcd1[7] = 'S';
        stgLcd1[8] = 'e';
        stgLcd1[9] = 'n';
        stgLcd1[10] = 'h';
        stgLcd1[11] = 'a';
        GsenhaPosi = 0;
    }
    if (Gnivel == defEdicao)//modo edita
    {
		stgLcd2[15] = defSIMBrecording;
        if (GsenhaPosi < 12)//digita segunda senha
        {
			if (GsenhaPosi < 6)//digita primeira senha
			{
				if ((GteclaPress > 47) & (GteclaPress < 58)) 
				{
					stg_senha1[GsenhaPosi] = GteclaPress;	
					GsenhaPosi++;
				}
				GteclaPress = 120;	
				stgLcd2[9]  = '1';			
			}
			else//vai estar entre 6 e 11
			{
				if ((GteclaPress > 47) & (GteclaPress < 58)) 
				{
					stg_senha2[GsenhaPosi - 6] = GteclaPress;                
					GsenhaPosi++;
				}
				GteclaPress = 120;
				stgLcd2[9]  = '2';				
			}
			stgLcd1[8]  = 'D';
			stgLcd1[9]  = 'i';
			stgLcd1[10]  = 'g';
			stgLcd1[11]  = 'i';
			stgLcd1[12]  = 't';
			stgLcd1[13]  = 'e';
			stgLcd1[15]  = 'a';
			stgLcd2[11]  = 'S';
			stgLcd2[12]  = 'e';
			stgLcd2[13]  = 'n';
			stgLcd2[14]  = 'h';
			stgLcd2[15]  = 'a';		
			for (F16aa = 0; F16aa != 6; F16aa++)
			{
				stgLcd1[F16aa] = stg_senha1[F16aa];
				stgLcd2[F16aa] = stg_senha2[F16aa];				
			}
        }
		else//confere se sAo iguais        
        {
            BitSenhasIguais = 1; //vamos ter fé
            for (F16aa = 0; F16aa != 6; F16aa++) 
			{
                if (stg_senha1[F16aa] != stg_senha2[F16aa]) 
				{
                    BitSenhasIguais = 0; //em caso de qualquer diferenCa, negativa valor positivado
					break;//não tem mais porque continuar procurando
                }
            }
            if (1 == BitSenhasIguais) 
			{
				stgLcd1[0]  = 'S';				
				stgLcd1[1]  = 'e';				
				stgLcd1[2]  = 'n';				
				stgLcd1[3]  = 'h';				
				stgLcd1[4]  = 'a';							
				stgLcd1[6]  = 'A';				
				stgLcd1[7]  = 'l';				
				stgLcd1[8]  = 't';				
				stgLcd1[9]  = 'e';				
				stgLcd1[10] = 'r';				
				stgLcd1[11] = 'a';				
				stgLcd1[12] = 'd';				
				stgLcd1[13] = 'a';				
				stgLcd1[14] = '!';				   			
				BitVaiVoltar = 1;
                if (GvaiVoltar > 3)//3 segundos
                {
                    Gnivel = defVisualiza;
                    BitVaiVoltar = 0;
                    for (F16aa = 0; F16aa != 6; F16aa++) 
					{
                        EEPROM_Write(F16aa+250, stg_senha1[F16aa]);
                        delay_ms(20);
                    }
                }
            }
            else 
			{		
				stgLcd1[0]  = 'N';				
				stgLcd1[1]  = defSIMBaTIL;				
				stgLcd1[2]  = 'o';							
				stgLcd1[4]  = 'I';				
				stgLcd1[5]  = 'g';				
				stgLcd1[6]  = 'u';				
				stgLcd1[7]  = 'a';				
				stgLcd1[8]  = 'i';				
				stgLcd1[9]  = 's';				
				stgLcd1[10] = '!';				   
				BitVaiVoltar = 1;				
                if (GvaiVoltar > 3)
                {
					BitVaiVoltar = 0;
                    Gnivel = defVisualiza;                   
                }
            }
        }
    }
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
void F17_EDITA_APELIDOS(uint8_t UCEnderecoF17)
{
    uint8_t F17readValue;
	uint8_t F17idQual;
    bit F17BitGravarEEprom;
    F17BitGravarEEprom = 0;
	F17readValue = EEPROM_Read(UCEnderecoF17+32); //OOO7
    switch (GteclaPress) 
	{
		case '0':
		case '1':
		case '2':
		case '3':
		case '4':
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
		{
			F17readValue = GteclaPress-48;//apaga todos
			F17BitGravarEEprom = 1;
			break;
		}
		case '#':
		{                          
			F17readValue++;
			if (F17readValue>31)
			{
				F17readValue = 0;
			}
			F17BitGravarEEprom = 1;
			break;
		}	
		case '*':
		{                          
			F17readValue--;
			if (F17readValue>250)
			{
				F17readValue = 31;
			}
			F17BitGravarEEprom = 1;
			break;
		}		
    }	
    if (Gnivel == defEdicao) 
	{
        Gnivel = defVisualiza;
    }
    if (1 == F17BitGravarEEprom) 
	{
        F17BitGravarEEprom = 0;
		EEPROM_Write(UCEnderecoF17+32, F17readValue);
    }
	F17idQual = UCEnderecoF17%2;
	stgLcd1[0] = 'A';
	stgLcd1[1] = 'p';
	stgLcd1[2] = 'e';
	stgLcd1[3] = 'l';
	stgLcd1[4] = 'i';
	stgLcd1[5] = 'd';
	stgLcd1[6] = 'o';	
	stgLcd1[7] = ':';
	if (0 == F17idQual)//UCEnderecoF17 é par
	{
		Gunidade7SEG = Num_Let_7Se[F17readValue];
		Gdezena7SEG = 0;//apagado
		F17readValue = EEPROM_Read(UCEnderecoF17+32); //OOO7 
		stgLcd1[8] = Num_Let_LCD[F17readValue];
		F17readValue = EEPROM_Read(UCEnderecoF17+33); //OOO7 
		stgLcd1[9] = Num_Let_LCD[F17readValue];
		stgLcd2[8] = '^';
	}
	else//UCEnderecoF17 é impar
	{
		Gunidade7SEG = 0;//apagado
		Gdezena7SEG = Num_Let_7Se[F17readValue];
		F17readValue = EEPROM_Read(UCEnderecoF17+31); //OOO7 
		stgLcd1[8] = Num_Let_LCD[F17readValue];
		F17readValue = EEPROM_Read(UCEnderecoF17+32); //OOO7 
		stgLcd1[9] = Num_Let_LCD[F17readValue];
		stgLcd2[9] = '^';		
	}		
	UCEnderecoF17 = UCEnderecoF17/2;
	stgLcd1[11] = 'i';
	stgLcd1[12] = 'D';
	stgLcd1[13] = ':';
	if (UCEnderecoF17>9)
	{
		stgLcd1[14]=UCEnderecoF17/10+48;//primeiro digito
	}
	else
	{
		stgLcd1[14]='0';//primeiro digito
	}		
	stgLcd1[15]=UCEnderecoF17%10+48;		
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
void F18_FORMATA_APELIDOS(void)
{
    uint8_t F18aa;
    uint8_t F18ee;
	uint8_t F18oo;
    uint8_t F18uu;
    for (F18uu = 0; F18uu != 32; F18uu++) 
	{
        F18ee = F18uu * 2;
        F18aa = F18uu / 10;		
		F18oo = EEPROM_Read(F18ee+32);
		if (F18oo != F18aa)
		{
			EEPROM_Write(F18ee+32, F18aa);
			delay_ms(10);
		}		
        F18aa = F18uu % 10;		
		F18oo = EEPROM_Read(F18ee+33);
		if (F18oo != F18aa)
		{
			EEPROM_Write(F18ee+33, F18aa);
			delay_ms(10);
		}		
    }
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
void F19_CONFIG_GERAIS (uint8_t F19address)
{
    uint8_t F19aa;
    uint8_t F19ee;
	uint8_t F19oo;
    bit F19BitGravarEEprom;
    F19BitGravarEEprom = 0;
	F19aa = EEPROM_Read(F19address); //OOO7
    switch (GteclaPress) 
	{
		case '0'://0
		{
			F19aa = _0Bit;//apaga todos
			F19BitGravarEEprom = 1;
			break;
		}		
		case '1'://1
		{
			if (F19aa & _1Bit) //apaga primeiro bit
			{
				F19aa &= 0b11111110;
			}
			else 
			{
				F19aa |= _1Bit;//liga primeiro bit
			}
			F19BitGravarEEprom = 1;
			break;
		}
		case '2'://2
		{
			if (F19aa & _2Bit) //apaga segundo bit
			{                            
				F19aa &= 0b11111101;
			}                            
			else                         
			{                            
				F19aa |= _2Bit;//liga segundo bit
			}
			F19BitGravarEEprom = 1;
			break;
		}
		case '3'://3
		{
			if (F19aa & _3Bit) //apaga terceiro bit
			{                            
				F19aa &= 0b11111011;
			}                            
			else                         
			{                            
				F19aa |= _3Bit;//liga terceiro bit
			}
			F19BitGravarEEprom = 1;
			break;
		}
		case '4'://4
		{
			if (F19aa & _4Bit) //apaga quarto bit
			{                            
				F19aa &= 0b11110111;
			}                            
			else                         
			{                            
				F19aa |= _4Bit;//liga quarto bit
			}
			F19BitGravarEEprom = 1;
			break;
		}
		case '5'://5
		{
			if (F19aa & _5Bit) //apaga quinto bit
			{                            
				F19aa &= 0b11101111;
			}                            
			else                         
			{                            
				F19aa |= _5Bit;//liga quinto bit
			}
			F19BitGravarEEprom = 1;
			break;
		}
		case '6'://4
		{
			if (F19aa & _6Bit) //apaga quarto bit
			{                            
				F19aa &= 0b11011111;
			}                            
			else                         
			{                            
				F19aa |= _6Bit;//liga quarto bit
			}
			F19BitGravarEEprom = 1;
			break;
		}
		case '7'://5
		{
			if (F19aa & _7Bit) //apaga quinto bit
			{                            
				F19aa &= 0b10111111;
			}                            
			else                         
			{                            
				F19aa |= _7Bit;//liga quinto bit
			}
			F19BitGravarEEprom = 1;
			break;
		}	
		case '8'://5
		{
			if (F19aa & _8Bit) //apaga quinto bit
			{                            
				F19aa &= 0b01111111;
			}                            
			else                         
			{                            
				F19aa |= _8Bit;//liga quinto bit
			}
			F19BitGravarEEprom = 1;
			break;
		}
    }
    if (Gnivel == defEdicao) 
	{
        Gnivel = defVisualiza;
    }
    if (F19BitGravarEEprom) 
	{
        F19BitGravarEEprom = 0;
		EEPROM_Write(F19address, F19aa);
    } 
    F19oo = _1Bit;
    for (F19ee = 0; F19ee != 8; F19ee++)//coloca na string stgLcd1 a representaCAo dos bits editados
	{		
        if (F19oo & F19aa) 
		{
            stgLcd1[F19ee] = defSIMBON0;
        }
        else 
		{
            stgLcd1[F19ee] = def6SIMBSWITCHOFF;
        }
		stgLcd2[F19ee] = 49+F19ee;
        F19oo = F19oo << 1;
    }
	F19address -= 95;
	switch (F19address)
	{
		case 1:
		{
			stgLcd1[9]  	= 'G';
			stgLcd1[10]  	= 'e';
			stgLcd1[11] 	= 'r';
			stgLcd1[12] 	= 'a';
			stgLcd1[13] 	= 'i';
			stgLcd1[14] 	= 's';				
			break;
		}
		case 2:
		{
			stgLcd1[9]  	= 'A';
			stgLcd1[10]  	= 'v';
			stgLcd1[11] 	= 'i';
			stgLcd1[12] 	= 's';
			stgLcd1[13] 	= 'o';
			stgLcd1[14] 	= 's';				
			break;
		}
	}	
	Gunidade7SEG = Num_Let_7Se[F19address/10];
	Gunidade7SEG |= _3Bit;
	Gdezena7SEG = Num_Let_7Se[F19address%10];	
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
void F76_SUB_LIMITS(uint8_t F76min, uint8_t F76max)
{
    if (0 == F76min) 
	{
        if (GsubMenu > 250) GsubMenu = F76max;
        if (GsubMenu > F76max) GsubMenu = 0;
    }
    else 
	{
        if (GsubMenu < F76min) GsubMenu = F76max;
        if (GsubMenu > F76max) GsubMenu = F76min;
    }
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
void F78_MENU(void)
{
	uint8_t F78aa;
    const itens = 9;
    if (Gmenu > itens) 
	{
        Gmenu = 1;
    }
    if (0 == Gmenu) 
	{
        Gmenu = itens;
    }
	if (Gmenu>9)
	{
		Gunidade7SEG = Num_Let_7Se[1];
		Gdezena7SEG = Num_Let_7Se[Gmenu-10];	
	}
	else
	{
		Gunidade7SEG = Num_Let_7Se[0];
		Gdezena7SEG = Num_Let_7Se[Gmenu];	
	}	
	
	if (defMenu == Gnivel) 
	{
		stgLcd2[8]  = 'M';
		stgLcd2[9]  = 'e';
		stgLcd2[10]  = 'n';
		stgLcd2[11]  = 'u';
	
		F78aa = Gmenu%10;
		stgLcd2[13] = F78aa+48;	
		stgLcd2[14] = '/';
		F78aa = itens%10;
		stgLcd2[15] = F78aa+48;	
		if (BitInverter)
		{
			Gdezena7SEG |= _3Bit;//para aparecer o ponto no digito da dezena quando está se acessando o menu					
		}
		else
		{
			Gunidade7SEG |= _3Bit;//para aparecer o ponto no digito da unidade quando está se acessando o menu					
		}
	}	
	// if (Gnivel == defMenu) 
	// {
		// F78aa = Gmenu/10;
		// stgLcd1[11] = F78aa+48;
		// F78aa = Gmenu%10;
		// stgLcd1[12] = F78aa+48;	
		// stgLcd1[13] = '/';
		// F78aa = itens/10;
		// stgLcd1[14] = F78aa+48;
		// F78aa = itens%10;
		// stgLcd1[15] = F78aa+48;		
	// }		
	switch (Gmenu)
	{
		case 1:
		{		
			if (defMenu == Gnivel) 
			{
				stgLcd1[0]  = 'P';
				stgLcd1[1] = 'a';
				stgLcd1[2] = 'r';
				stgLcd1[3] = 'a';
				stgLcd1[4] = 'd';
				stgLcd1[5] = 'a';				
				stgLcd1[6] = 's';				
				stgLcd1[8]  = 'O';
				stgLcd1[9]  = 'N';

				stgLcd1[11]  = 'O';
				stgLcd1[12]  = 'F';
				stgLcd1[13]  = 'F';				
				GsubMenu = 0;				
			}
			else 
			{				
				F76_SUB_LIMITS(0, 31);
				F11_HABILITA_PARADAS(GsubMenu);
			}
			break;			
		}
		case 2:
		{
			if (defMenu == Gnivel) 
			{
				stgLcd1[0]  = 'J';
				stgLcd1[1]  = 'u';
				stgLcd1[2]  = 'm';
				stgLcd1[3]  = 'p';
				stgLcd1[4]  = 'e';
				stgLcd1[5]  = 'r';
				
				stgLcd1[7]  = 'S';
				stgLcd1[8] = 'e';
				stgLcd1[9] = 'n';
				stgLcd1[10] = 's';
				stgLcd1[11] = 'o';
				stgLcd1[12] = 'r';
				stgLcd1[13] = 'e';
				stgLcd1[14] = 's';
				GsubMenu = 0;				
			}
			else 
			{				
				F76_SUB_LIMITS(0, 31);
				F12_JUMPER_SENSOR(GsubMenu);
			}
			break;
		}
		case 3:
		{
				
			if (defMenu == Gnivel) 
			{
				stgLcd1[0]  = 'L';
				stgLcd1[1]  = 'i';
				stgLcd1[2]  = 'm';
				stgLcd1[3]  = 'p';
				stgLcd1[4]  = 'a';				
				stgLcd1[6]  = 'J';	
				stgLcd1[7]  = 'u';
				stgLcd1[8]  = 'm';
				stgLcd1[9]  = 'p';
				stgLcd1[10]  = 'e';
				stgLcd1[11]  = 'r';
				stgLcd1[12]  = 's';	
			}
			else
			{
				if (F13_LIMPA_BY_JUMPERS(0))	
				{
					stgLcd2[0]  = 'T';
					stgLcd2[1]  = 'e';
					stgLcd2[2]  = 'c';
					stgLcd2[3]  = 'l';
					stgLcd2[4]  = 'e';
					stgLcd2[6]  = '#';				
					if ('#' == GteclaPress)
					{
						F78aa = F13_LIMPA_BY_JUMPERS(1);
						GteclaPress = '>';
					}					
				}				
				else 
				{
					stgLcd1[0]  = 'T';
					stgLcd1[1]  = 'o';
					stgLcd1[2]  = 'd';
					stgLcd1[3]  = 'o';
					stgLcd1[4]  = 's';
					//stgLcd1[5]  = ' ';
					stgLcd1[6]  =  'o';
					stgLcd1[7]  =  's';
					//stgLcd1[8]  =  ' ';
					stgLcd1[9]  =  'J';
					stgLcd1[10]  = 'u';
					stgLcd1[11]  = 'm';
					stgLcd1[12]  = 'p';
					stgLcd1[13]  = 'e';
					stgLcd1[14]  = 'r';
					stgLcd1[15]  = 's';
					
					stgLcd2[0]  = 'E';
					stgLcd2[1]  = 's';	
					stgLcd2[2]  = 't';						
					stgLcd2[3]  = defSIMBaTIL;						
					stgLcd2[4]  = 'o';						
					//stgLcd2[5]  = ' ';
					stgLcd2[6]  = 'L';
					stgLcd2[7]  = 'i';
					stgLcd2[8]  = 'm';
					stgLcd2[9]  = 'p';
					stgLcd2[10]  = 'o';
					stgLcd2[11]  = 's';
					stgLcd2[12]  = '!';
					// stgLcd2[13]  = ' ';
					// stgLcd2[14]  = ' ';
					// stgLcd2[15]  = ' ';
					BitVaiVoltar = 1;
					if (GvaiVoltar > 3)
					{
						BitVaiVoltar = 0;
						Gnivel = defMenu;                   
					}					
				}
			}
			break;
		}
		case 4:
		{
			if (defMenu == Gnivel) 
			{
				stgLcd1[0]  = 'E';
				stgLcd1[1]  = 'd';
				stgLcd1[2]  = 'i';
				stgLcd1[3]  = 't';
				stgLcd1[4]  = 'a';
				
				stgLcd1[6]  = 'i';
				stgLcd1[7]  = 'D';
				stgLcd1[8]  = 's';
				GidNovaEditada = 0;				
			}
			else 
			{
				F76_SUB_LIMITS(0, 31);
				F14_EDITA_ID();
			}
			break;
		}	
		case 5:
		{
			if (defMenu == Gnivel) 
			{
				stgLcd1[0]  = 'C';
				stgLcd1[1]  = 'o';
				stgLcd1[2]  = 'n';
				stgLcd1[3]  = 'f';
				stgLcd1[4]  = 'i';
				stgLcd1[5]  = 'g';
				stgLcd1[6]  = '.';
				
				stgLcd1[8]  = 'R';
				stgLcd1[9]  = 'e';
				stgLcd1[10] = 'l';
				stgLcd1[11] = 'o';
				stgLcd1[12] = 'g';
				stgLcd1[13] = 'i';
				stgLcd1[14] = 'o';				
			}
			else 
			{
				F76_SUB_LIMITS(1, 2);
				F15_CONF_DS1307();
			}
			break;
		}	
		case 6:
		{
			if (defMenu == Gnivel) 
			{
				stgLcd1[0]  = 	'E';
				stgLcd1[1]  = 	'd';
				stgLcd1[2]  = 	'i';
				stgLcd1[3]  = 	't';
				stgLcd1[4]  = 	'a';
				
				stgLcd1[6] = 	'S';
				stgLcd1[7] = 	'e';
				stgLcd1[8] = 	'n';
				stgLcd1[9] = 	'h';
				stgLcd1[10] = 	'a';				
			}
			else 
			{
				F76_SUB_LIMITS(1, 1);
				F16_CONFIG_SENHA();
			}
			break;
		}
		case 7:
		{
			if (defMenu == Gnivel) 
			{			
				stgLcd1[0]  = 'E';
				stgLcd1[1]  = 'd';
				stgLcd1[2]  = 'i';
				stgLcd1[3]  = 't';
				stgLcd1[4]  = 'a';				
				stgLcd1[6]  = 'A';
				stgLcd1[7]  = 'p';
				stgLcd1[8]  = 'e';
				stgLcd1[9]  = 'l';
				stgLcd1[10]  = 'i';
				stgLcd1[11]  = 'd';
				stgLcd1[12]  = 'o';
				stgLcd1[13]  = 's';
				GsubMenu = 0;
			}
			else 
			{
				F76_SUB_LIMITS(0, 63);
				F17_EDITA_APELIDOS(GsubMenu);
			}
			break;
		}
		case 8:
		{
				stgLcd1[8]  = 'A';
				stgLcd1[9]  = 'p';
				stgLcd1[10] = 'e';
				stgLcd1[11] = 'l';
				stgLcd1[12] = 'i';
				stgLcd1[13] = 'd';
				stgLcd1[14] = 'o';
				stgLcd1[15] = 's';
				
			if (defMenu == Gnivel) 
			{
				stgLcd1[0]  = 'F';
				stgLcd1[1]  = 'o';
				stgLcd1[2]  = 'r';
				stgLcd1[3]  = 'm';
				stgLcd1[4]  = 'a';
				stgLcd1[5]  = 't';
				stgLcd1[6]  = 'a';				
			}
			else
			{
				stgLcd2[0]  = 'T';
				stgLcd2[1]  = 'e';
				stgLcd2[2]  = 'c';
				stgLcd2[3]  = 'l';
				stgLcd2[4]  = 'e';
				stgLcd2[6]  = '#';
				stgLcd2[7]  = ' ';				
				if ('#' == GteclaPress)
				{
					BitVaiVoltar = 1;
					F18_FORMATA_APELIDOS();
					GteclaPress = '>';
				}
                if (GvaiVoltar > 3)
                {
					BitVaiVoltar = 0;
                    Gnivel = defMenu;                   
                }
				if (BitVaiVoltar)
				{
					stgLcd1[0]  = 	'A';
					stgLcd1[1]  = 	'p';
					stgLcd1[2] = 	'e';
					stgLcd1[3] = 	'l';
					stgLcd1[4] = 	'i';
					stgLcd1[5] = 	'd';
					stgLcd1[6] = 	'o';
					stgLcd1[7] = 	's';
					// stgLcd1[8]  = 	' ';
					// stgLcd1[9]  = 	' ';
					// stgLcd1[10] = 	' ';
					// stgLcd1[11] = 	' ';
					// stgLcd1[12] = 	' ';
					// stgLcd1[13] = 	' ';
					// stgLcd1[14] = 	' ';
					// stgLcd1[15] = 	' ';					

					stgLcd2[0]  = 	'F';
					stgLcd2[1]  = 	'o';
					stgLcd2[2]  = 	'r';
					stgLcd2[3]  = 	'm';
					stgLcd2[4]  = 	'a';
					stgLcd2[5]  = 	't';
					stgLcd2[6]  = 	'a';				
					stgLcd2[7]  = 	'd';
					stgLcd2[8]  = 	'o';
					stgLcd2[9]  = 	's';	
					stgLcd2[10]  = 	'!';
					// stgLcd2[11]  = 	' ';
					// stgLcd2[12]  = 	' ';
					// stgLcd2[13]  = 	' ';
					// stgLcd2[14]  = 	' ';
					// stgLcd2[15]  = 	' ';
				}				
			}
			break;
		}
		case 9:
		{
				
			if (defMenu == Gnivel) 
			{
				stgLcd1[0]  = 'C';
				stgLcd1[1]  = 'o';
				stgLcd1[2]  = 'n';
				stgLcd1[3]  = 'f';
				stgLcd1[4]  = 'i';
				stgLcd1[5]  = 'g';
				stgLcd1[6]  = '.';				
				stgLcd1[8]  = 'G';
				stgLcd1[9]  = 'e';
				stgLcd1[10] = 'r';
				stgLcd1[11] = 'a';
				stgLcd1[12] = 'i';
				stgLcd1[13] = 's';	
			}
			else 
			{
				F76_SUB_LIMITS(defPAG1, defPAG2);
				F19_CONFIG_GERAIS(GsubMenu);
			}
			break;
		}		
	}		
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
void F80_LOGIN(void)
{
	uint8_t SenhaEscondida[] = "493824";//123456 * 4
    uint8_t F80aa;
	bit BitSenhaOk1;
	bit BitSenhaOk2;
    switch (GloginState) 
	{
		case def1PWDDESLOGADO: //deslogado
		{
			if (('A' == GteclaPress) & (defVisualiza == Gnivel)) 
			{
				Gnivel = defMenu; //APRESENTACAO MENUS				
			}
			if ('B' == GteclaPress) 
			{
				if (def1STOPPED == GstateELEVA)
				{
					if (F00_BIT_ON_OFF(defPAG1, _4Bit))//SENHA PARA ACESSAR MENU?
					{
						GloginState = defPWDIN3; //SALTA PARA PODER CONFIGURAR SENHA
						GposSenha = 0;
						for (F80aa = 0; F80aa != 6; F80aa++) 
						{
							stgSenhaDigitada[F80aa] = 32;
							stgSenhaOculta[F80aa] = 32;
						}
						Gmenu = 1;									
					}
					else//NÃO PRECISA SENHA
					{
						GloginState = defPWDOK5;
					}
				}
			}
			if ('*' == GteclaPress) 
			{
				GloginState = defPWDRECOVE;//WHATS GOING ON HERE?
			}
			break;
		}
		case defPWDIN3 ://LOGANDO, INSERINDO SENHA
		{
			if ('A' == GteclaPress) 
			{
				F07_CONFIGURA_SISTEMA(1);
			}
			if ((GteclaPress > 47) & (GteclaPress < 58) & (GposSenha < 6)) 
			{
				stgSenhaDigitada[GposSenha] = GteclaPress;
				stgSenhaOculta[GposSenha] = 42; //42 é = *
				GposSenha++;				
			}
			if (GposSenha > 5)//avalia
			{
				BitSenhaOk1 = 1; //VAMOS TER FÉ
				for (F80aa = 0; F80aa != 6; F80aa++) 
				{
					if (stgSenhaDigitada[F80aa] != EEPROM_Read(F80aa+250)) 
					{
						BitSenhaOk1 = 0; //QUALQUER DIFERENCA ZERA VALOR
						break;//não tem mais porque continuar procurando
					}
				}
				BitSenhaOk2 = 1; //VAMOS TER FÉ
				for (F80aa = 0; F80aa != 6; F80aa++) 
				{
					if (stgSenhaDigitada[F80aa] != SenhaEscondida[F80aa]) 
					{
						BitSenhaOk2 = 0; //QUALQUER DIFERENCA ZERA VALOR
						break;//não tem mais porque continuar procurando
					}
				}				
				if (BitSenhaOk2 | BitSenhaOk1)
				{
					GloginState = defPWDOK5; //SENHA CORRETA
					Gmenu = 1;
				}				
				else 
				{
					GloginState = defPWDERRADA2; //SENHA ERRADA
				}
				Gnivel = defMenu;
			}			
			stgLcd1[0]  = 'D';
			stgLcd1[1]  = 'i';
			stgLcd1[2]  = 'g';
			stgLcd1[3]  = 'i';
			stgLcd1[4]  = 't';
			stgLcd1[5]  = 'e';
			stgLcd1[7]  = 'a';
			stgLcd1[9]  = 's';
			stgLcd1[10] = 'e';
			stgLcd1[11] = 'n';
			stgLcd1[12] = 'h';
			stgLcd1[13] = 'a';			
			for (F80aa = 0; F80aa != 6; F80aa++) 
			{
				stgLcd2[F80aa] = stgSenhaOculta[F80aa];
			}
			BitAtualizarLcd = 1;
			break; 
		}
		case defPWDERRADA2: //SENHA ERRADA
		{		
			stgLcd1[0]  = 'S';
			stgLcd1[1]  = 'e';
			stgLcd1[2]  = 'n';
			stgLcd1[3]  = 'h';
			stgLcd1[4]  = 'a';
			stgLcd1[6]  = 'E';
			stgLcd1[7]  = 'r';
			stgLcd1[8]  = 'r';
			stgLcd1[9]  = 'a';
			stgLcd1[10] = 'd';
			stgLcd1[11] = 'a';		
			BitVaiVoltar = 1;
			if (GvaiVoltar > 3)//3 SEGUNDOS
			{
				F07_CONFIGURA_SISTEMA(1); //REINICIA TODAS A VARIAVEIS
			}
			BitAtualizarLcd = 1;
			break; //SENHA DIGITADA ESTa INCORRETA
		}
		case defPWDOK5: //LOGADO, SENHA CORRETA
		{				
			if ((0 == rb0_CABINE)&(F00_BIT_ON_OFF(defPAG1, _2Bit)))//CABINE ABERTA PARA MENU?
			{
				stgLcd1[0]  = 'A';
				stgLcd1[1]  = 'b';
				stgLcd1[2]  = 'r';
				stgLcd1[3]  = 'a';
				stgLcd1[5]  = 'a';
				stgLcd1[7]  = 'C';
				stgLcd1[8]  = 'a';
				stgLcd1[9]  = 'b';
				stgLcd1[10] = 'i';
				stgLcd1[11] = 'n';
				stgLcd1[12] = 'e';			
				BitVaiVoltar = 1;
				if (GvaiVoltar > 3)//3 SEGUNDOS
				{
					F07_CONFIGURA_SISTEMA(1); //REINICIA TODAS A VARIAVEIS
				}				
			}
			else
			{				
				if ('A' == GteclaPress)//ESC
				{
					switch (Gnivel)
					{
						case defMenu: GloginState = def1PWDDESLOGADO;
						break; //REINICIA TODAS A VARIAVEIS
						case defVisualiza: Gnivel = defMenu;
						break;
						case defEdicao: Gnivel = defVisualiza;
						break;
						default: Gnivel = defVisualiza;
						break;
					}
				}
				if ('B' == GteclaPress)//OK
				{
					switch (Gnivel)
					{
						case defMenu: if (Gmenu > 0)Gnivel = defVisualiza;
						break;
						case defVisualiza: Gnivel = defEdicao;
						break;
						case defEdicao: Gnivel = defVisualiza;
						break;
						default: Gnivel = defVisualiza;
						break;
					}
				}
				if ('C' == GteclaPress)//<--
				{
					BitNaoSeq = 0; //SERVE PARA NÃO DEIXAR AVALIAR
					switch (Gnivel)
					{
						case defMenu: Gmenu--;
						break;
						case defVisualiza: GsubMenu--;
						break;
						case defEdicao: Gseq--;
						break;
						default: Gmenu = 1;
						break;
					}
				}
				if ('D' == GteclaPress)//-->
				{
					BitNaoSeq = 0; //SERVE PARA NÃO DEIXAR AVALIAR
					switch (Gnivel)
					{
						case defMenu: Gmenu++;
						break;
						case defVisualiza: GsubMenu++;
						break;
						case defEdicao: Gseq++;
						break;
						default: Gmenu = 1;
						break;
					}
				}
				F78_MENU(); //PODE ACESSAR MENU PORQUE SENHA DIGITADA ESTa CORRETA
			}
			BitAtualizarLcd = 1;
			break;
		}
		default:
		{
			GloginState = def1PWDDESLOGADO;
			break;
		}
    }
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
void F82_COMANDATPIC(void)
{
	uint8_t F82ReleCmd = 0;
	if (Tecla.IrAte)
	{
		Tecla.IrAte = 0;
		if (32 == GpareAqui)
		{
			GpareAqui = GidOndeCabineEsta;//ponto de partida
		}
		if (Tecla.Sobe & LastTecla.Sobe)
		{
			LastTecla.Sobe = 0;
			if (F00_BIT_ON_OFF(GpareAqui+1, _6Bit))//pesquisa se andar acima está habilitado
			{
				GpareAqui++;				
			}			
		}
		if (Tecla.Desce & LastTecla.Desce)
		{
			LastTecla.Desce = 0;
			if (GpareAqui)	//não pode descer abaixo de zero
			{
				GpareAqui--;										
			}			
		}		
		Tecla.Sobe = 0;//anula para não mecher no elevador...
		Tecla.Desce = 0;//anula para não mecher no elevador...			
	}
	else
	{
		if (GpareAqui<32)
		{
			BitPararAqui = 1;			
		}
	}	
    if (Tecla.Sobe)//botao subir esta pressionado?
    {
        Tecla.Sobe = 0; 
        if (0 == BitCancelaCloseOpen)//pode subir?
			if (0 == BitStopUp)//esta proibido de subir?
				if (0 == rd0_FIM_SUPERIOR)//rd0_FIM_SUPERIOR at rd0_bit ;         
					if (def1STOPPED == GstateELEVA)//tem que estar parado para poder subir
						GstateELEVA = def1COMINGUP;
    }
    if (Tecla.Nivela)//botao nivelar esta pressionado?
    {
        Tecla.Nivela = 0; 
        if (def1STOPPED == GstateELEVA)//somente coloca a nivelar se estiver parado
        {
			if (0 == BitCancelaCloseOpen) 
			{
				GstateELEVA = defLEVELING4;				
			}
        }
    }
    if (Tecla.Desce)//botao descer esta pressionado?
    {
        Tecla.Desce = 0; 
        if (0 == BitCancelaCloseOpen)//pode descer?
			if (0 == BitStopDown)//esta proibido de descer?
				if (0 == rb1_FIM_INFERIOR)//rb1_FIM_INFERIOR at rb1_bit ;
					if (def1STOPPED == GstateELEVA)//tem que estar parado para poder descer
					{
						GstateELEVA = def2COMINGDOWN;						
						BitDescer=1;
					}
    }
    if (Tecla.Para)//botao parar esta pressionado?
    {
		BitPararAqui = 0;		
		GpareAqui = 32;
		// Tecla.Sobe = 0;//anula para não mecher no elevador...
		// Tecla.Desce = 0;//anula para não mecher no elevador...		
        // Tecla.Para = 0; 
        GstateELEVA = def1STOPPED; //isso pode acontecer sob qualquer circunstância
    }		
    if (BitAudioOn) 
	{
		BitAudioOn = 0;
        F82ReleCmd |= defLIGAAUDIO2;
        if (0 == Tecla.Audio) 
		{
            F82ReleCmd = def1FALAAUDIO; //insere primeiro bit                        
        }
    }

    if (rb1_FIM_INFERIOR)//rb1_FIM_INFERIOR 
    {
        if (def2COMINGDOWN == GstateELEVA)//SE FIM DE CURSO INFERIOR ESTIVER PRESSIONADO, NÃO DEIXA DESCER
		{
            GstateELEVA = def1STOPPED;
        }
    }
    if (rd0_FIM_SUPERIOR)//rd0_FIM_SUPERIOR at rd0_bit ;
    {
        if (def1COMINGUP == GstateELEVA)//SE FIM DE CURSO SUPERIOR ESTIVER PRESSIONADO, NÃO DEIXA SUBIR
		{
            GstateELEVA = def1STOPPED;
        }
    }	
    switch (GstateELEVA)//vai escrever o que isso implica
    {
		case def1STOPPED:
		{
			F82ReleCmd &= defOFFALL15; //desliga todos relés de comando
			ContadorDescer=0;
			BitDescer=0;
			break;
		}
		case def1COMINGUP:
		{
			F82ReleCmd |= defTACTORRISES;
			F82ReleCmd |= defTACTORPOWER;
			F82ReleCmd &= 0b10011111; //nAo deixa descer e nAo deixa freiar
			break;
		}
		case def2COMINGDOWN:
		{
			// if (F00_BIT_ON_OFF(defPAG1, _8Bit))//ativar desativar solta freio depois liga motor
			// {
				// if (BitDescer)
				// {
					// ContadorDescer++;
					// if (ContadorDescer>30)
					// {
						// BitDescer=0;
					// }
					// else//mesmo código do nivelando
					// {
						// F82ReleCmd |= defTACTORBRAKE;
						// F82ReleCmd |= defTACTORPOWER;
						// F82ReleCmd &= 0b11001111; //nAo sobe e nAo desce						
					// }
				// }
				// else
				// {
					F82ReleCmd |= defTACTORDOWN;
					F82ReleCmd |= defTACTORPOWER;
					F82ReleCmd &= 0b10101111; //nAo deixa subir e nAo deixa freiar
				//}
			//}
			//else//funciona normalmente
			//{
				F82ReleCmd |= defTACTORDOWN;
				F82ReleCmd |= defTACTORPOWER;
				F82ReleCmd &= 0b10101111; //nAo deixa subir e nAo deixa freiar				
			//}
			break;
		}
		case defLEVELING4:
		{
			if (0 == BitCancelaCloseOpen) 
			{
				F82ReleCmd |= defTACTORBRAKE;
				F82ReleCmd |= defTACTORPOWER;
				F82ReleCmd &= 0b11001111; //nAo sobe e nAo desce
			}
			else 
			{
				F82ReleCmd &= defOFFALL15; //desliga todos relés de comando
			}
			break;
		}
    }
	// if (F00_BIT_ON_OFF(defPAG1, _7Bit))
	// {
		// if ((F82ReleCmd & defTACTORPOWER)==defTACTORPOWER)//CONTACTORA POWER ESTÁ LIGADA?
		// {
			// ContadorPOWER++;
		// }
		// else
		// {
			// ContadorPOWER--;
		// }
		// if ((ContadorPOWER < 50) && (ContadorPOWER > 10))//AQUI ESTÁ ACONTECENDO UM PROCESSO
		// {
			// if (ContadorPOWER > ContadorPOWERlast)//ESTÁ SUBINDO, ENTÃO ESTÁ LIGANDO
			// {
				// F82ReleCmd &= 0b01111111;//MASCARA CONTACTORA POWER, LIGA DEPOIS
				// F82ReleCmdLast = F82ReleCmd;
			// }
			// if (ContadorPOWER < ContadorPOWERlast)//ESTÁ DESCENDO, ENTÃO ESTÁ DESLIGANDO
			// {
				// F82ReleCmdLast &= 01110000;
				// F82ReleCmd |= F82ReleCmdLast;
				// F82ReleCmd &= 0b01111111;//MASCARA CONTACTORA POWER, LIGA DEPOIS
			// }			
		// }
		// if (ContadorPOWER > 50)//LIGOU, NÃO PODE PASSAR DO LIMITE MÁXIMO
		// {
			// ContadorPOWER = 50;
		// }
		// if (ContadorPOWER < 10)//ESTÁ DESCENDO, ISSO PORQUE CONTACTORA POWER NÃO ESTÁ MAIS LIGADA
		// {
			// ContadorPOWER = 10;
		// }
		// ContadorPOWERlast = ContadorPOWER;		
	// }
    F01_IMPRIME_TPIC(Gdezena7SEG);
    F01_IMPRIME_TPIC(Gunidade7SEG);
    F01_IMPRIME_TPIC(F82ReleCmd);
    rc2_REVELA_TPIC = 0; //rc2_REVELA_TPIC at rc2_bit ;
    rc2_REVELA_TPIC = 1; //rc2_REVELA_TPIC at rc2_bit ;
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
void F84_CHAMADAS(void)
{
    switch (GchamadaState)//FATIA SERVICOS EM SEGUNDO PLANO CONFORME PRIORIDADES
    {
		case def7ATUALIZAR://
		{			
			if (def1PWDDESLOGADO == GloginState)
			{
				F06_VERIFICA_SITUACAO();			
			}
			GchamadaState = def8TIMEupdade;	
			break;
		}
		case def8TIMEupdade:
		{
			F03_UPDATE_DS1307(); //ATUALIZA HORA DO SISTEMA
			GchamadaState = def5NORMAL;
			break;
		}		
		case def5NORMAL:
		{
			if (GF03segundos != GsecCountLast)//houve mudanca no segundos
			{
				GsecCountLast = GF03segundos;
				if (BitVaiVoltar) //isso serve para temporização que deve acontecer depois de alguns segundos
				{
					GvaiVoltar++;
				}
				else 
				{
					GvaiVoltar = 0;
				}
			}	
			break;
		}		
		default:
		{
			GchamadaState = def5NORMAL;
			break;
		}
    }	
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
uint8_t F86_HA_JUMPERS(void)//VAI PESQUISAR POR JUMPERS ATIVOS, RETORNA 0 SE NÃO HOUVER QUALQUER JUMP ATIVO
{
	uint8_t F86aa;
	uint8_t F86ee;
	for (F86aa = 0;F86aa != 32;F86aa++)
	{
		F86ee = EEPROM_Read(F86aa);
		F86ee &= 0b00011111;
		if (F86ee != 0b00011111)
		{
			return F86aa+10;//encontrou um jump ativado, pode voltar
		}
	}
	return 0;	
}

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
uint8_t F92_ID_NOVO(void)//PROCURA POR PLACA NOVA NÃO HABILITADA
{
	uint8_t F92aa;
	uint8_t F92oo;
	uint8_t F92uu;
	uint8_t F92stg[5];
	delay_ms(20);
	for (F92aa = 0;F92aa != 32;F92aa++)
	{
		F92oo = EEPROM_Read(F92aa);
		F92oo &= _6Bit;
		if (F92oo  == 0)
		{
			F92uu = F92aa+10;
			F92stg[0] = 244;//INICIO DA TRANSMISSÃO
			F92stg[1] = F92uu;
			F92stg[2] = 0b00000100;//PARA NÃO SER VAZIO - ZERO PARA A TRANSMISSÃO		
			F92stg[3] = F92stg[2]+F92stg[1];
			F92stg[4] = 0;//FIM DA TRANSMISSÃO
			F05_UART_WRITE(F92stg);	
			if (F92uu == GidRecebido)//NOVO ID FOI ENCONTRADO
			{
				return F92uu;//FUNÇÃO É ENCERRADA PORQUE ENCONTROU NOVA ID
			}			
		}
	}
	return 0;//NÃO FOI ENCONTRADA NOVA ID
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
void F94_PROCURA_PROBLEMAS(void)
{
	uint8_t F94aa;
	uint8_t F94oo;
	uint8_t F94ss;
	uint8_t F94pp;
	uint8_t F94par;
	uint8_t F94impar;
	static bit F94BitAvaliar;
	F94oo = Bcd2Dec(GF03segundos);
	F94aa = F94oo/4;//DE QUATRO EM QUATRO SEGUNDOS PESQUISA POR PROBLEMAS
	if (F94aa != GqualMSGlast)//sempre que muda abilita para nova avaliação
	{
		GqualMSGlast = F94aa;//iguala para não entrar aqui novamente
		GqualMSG++;
		GF94temp = 0;//resultado zerado
		F94BitAvaliar = 1;//comando avaliar ativo
	}
	switch (GqualMSG)
	{
		case defPR0:
		{
			break;//do nothing
		}
		case defPR1:
		{
			if (F94BitAvaliar)
			{	
				if (F00_BIT_ON_OFF(defPAG2, _1Bit))
				{
					GF94temp = F92_ID_NOVO();//procura por placa nova não habilitada					
				}				
			}			
			if (GF94temp)
			{	
				GalgumERRO |= _1Bit;
				F94pp = GF94temp - 10;				
				F94ss = F94pp * 2;
				F94par = EEPROM_Read(F94ss+32);
				F94impar = EEPROM_Read(F94ss+33);
				stgLcd1[4] = Num_Let_LCD[F94par];
				stgLcd1[5] = Num_Let_LCD[F94impar];
				if (BitInverter)
				{
					stgLcd1[6] = 	'C';
					stgLcd1[7] = 	'o';
					stgLcd1[8] = 	'n';
					stgLcd1[9] = 	'e';				
					stgLcd1[10] = 	'c';
					stgLcd1[11] = 	't';
					stgLcd1[12] = 	'a';
					stgLcd1[13] = 	'd';
					stgLcd1[14] = 	'o';
					stgLcd1[15] = 	' ';
				}
				else
				{
					stgLcd1[6] = 	'N';
					stgLcd1[7] = 	'o';
					stgLcd1[8] = 	'v';
					stgLcd1[9] = 	'o';				
					stgLcd1[10] = 	' ';
					stgLcd1[11] = 	' ';
					stgLcd1[12] = 	' ';
					stgLcd1[13] = 	' ';
					stgLcd1[14] = 	' ';
					stgLcd1[15] = 	' ';					
				}
				F94BitAvaliar = 0;//ZERO PORQUE FOI 'USADO'
			}
			else
			{
				GqualMSG=defPR2;
				GalgumERRO &= 0b11111110;
			}
			break;			
		}
		case defPR2:
		{
			if (F94BitAvaliar)
			{	
				if (F00_BIT_ON_OFF(defPAG2, _2Bit))			
				{
					GF94temp = F86_HA_JUMPERS();					
				}				
			}
			if (GF94temp)
			{
				GalgumERRO |= _2Bit;
				F94pp = GF94temp - 10;				
				F94ss = F94pp * 2;
				F94par = EEPROM_Read(F94ss+32);
				F94impar = EEPROM_Read(F94ss+33);
				stgLcd1[4] = Num_Let_LCD[F94par];
				stgLcd1[5] = Num_Let_LCD[F94impar];				
				stgLcd1[6] = 	'J';
				stgLcd1[7] = 	'u';
				stgLcd1[8] = 	'm';
				stgLcd1[9] = 	'p';				
				stgLcd1[10] = 	'e';
				stgLcd1[11] = 	'r';
				stgLcd1[12] = 	' ';
				stgLcd1[13] = 	'O';
				stgLcd1[14] = 	'N';
				stgLcd1[15] = 	' ';
				F94BitAvaliar = 0;//ZERO PORQUE FOI 'USADO'
			}
			else
			{
				GqualMSG = defPR3;
				GalgumERRO &= 0b11111101;
			}
			break;
		}
		case defPR3:
		{	
			if (GF94quatID>1)
			{
				if (F00_BIT_ON_OFF(defPAG2, _3Bit))
				{
					
					GalgumERRO |= _3Bit;			
					GF94erroIDcolado = GF94erroIDcolado * 2;
					F94par = EEPROM_Read(GF94erroIDcolado+32);
					F94impar = EEPROM_Read(GF94erroIDcolado+33);
					stgLcd1[4] = Num_Let_LCD[F94par];
					stgLcd1[5] = Num_Let_LCD[F94impar];
					if (BitInverter)
					{
						stgLcd1[6] = 	'I';
						stgLcd1[7] = 	'd';
						stgLcd1[8] = 	' ';
						stgLcd1[9] = 	'S';				
						stgLcd1[10] = 	'e';
						stgLcd1[11] = 	'n';
						stgLcd1[12] = 	's';
						stgLcd1[13] = 	'o';
						stgLcd1[14] = 	'r';
						stgLcd1[15] = 	' ';					
					}
					else
					{
						stgLcd1[6] = 	'C';
						stgLcd1[7] = 	'o';
						stgLcd1[8] = 	'l';
						stgLcd1[9] = 	'a';				
						stgLcd1[10] = 	'd';
						stgLcd1[11] = 	'o';
						stgLcd1[12] = 	' ';
						stgLcd1[13] = 	' ';
						stgLcd1[14] = 	' ';
						stgLcd1[15] = 	' ';
					}				
				}
				else
				{
					GqualMSG = defPR4;
					GalgumERRO &= 0b11111011;
				}				
			}
			else
			{
				GqualMSG = defPR4;
				GalgumERRO &= 0b11111011;
			}
			break;			
		}
		case defPR4:
		{	
			if (GF94naoRESPONDE)//vai ser apagado no próximo case
			{	
				if (F00_BIT_ON_OFF(defPAG2, _4Bit))
				{
					F94pp = GF94naoRESPONDE-10;
					GalgumERRO |= _4Bit;//inclui o sinal de erro de que 			
					F94ss = F94pp * 2;
					F94par = EEPROM_Read(F94ss+32);
					F94impar = EEPROM_Read(F94ss+33);
					stgLcd1[4] = Num_Let_LCD[F94par];
					stgLcd1[5] = Num_Let_LCD[F94impar];	
					if (BitInverter)
					{

						stgLcd1[6] = 	'N';
						stgLcd1[7] = defSIMBaTIL;
						stgLcd1[8] = 	'o';
						stgLcd1[9] = 	' ';
						stgLcd1[10] = 	' ';
						stgLcd1[11] = 	' ';
						stgLcd1[12] = 	' ';
						stgLcd1[13] = 	' ';
						stgLcd1[14] = 	' ';
						stgLcd1[15] = 	' ';						
					}
					else
					{
						stgLcd1[6] = 	'R';
						stgLcd1[7] = 	'e';
						stgLcd1[8] = 	's';
						stgLcd1[9] = 	'p';				
						stgLcd1[10] = 	'o';
						stgLcd1[11] = 	'n';
						stgLcd1[12] = 	'd';
						stgLcd1[13] = 	'e';
						stgLcd1[14] = 	' ';
						stgLcd1[15] = 	' ';						
					}					
				}
				else
				{
					GF94temp = 0;//resultado zerado
					GqualMSG = defPR5;
				}				
			}
			else
			{
				GqualMSG = defPR5;
				GalgumERRO &= 0b11110111;
			}
			break;			
		}	
		case defPR5:
		{
			if (F00_BIT_ON_OFF(defPAG1, _4Bit))	
			{
				GqualMSG = defPR6;
				GalgumERRO &= 0b11101111;//apaga o erro
			}
			else
			{
				if (F00_BIT_ON_OFF(defPAG2, _5Bit))				
				{
					GalgumERRO |= _5Bit;
					if (BitInverter)
					{
						stgLcd1[4] = 	'P';
						stgLcd1[5] = 	'a';
						stgLcd1[6] = 	's';
						stgLcd1[7] = 	's';
						stgLcd1[8] = 	'W';
						stgLcd1[9] = 	'o';
						stgLcd1[10] = 	'r';
						stgLcd1[11] = 	'd';
						stgLcd1[12] = 	' ';
						stgLcd1[13] = 	'O';
						stgLcd1[14] = 	'f';
						stgLcd1[15] = 	'f';						
					}				
				}
				else
				{
					GqualMSG = defPR6;
					GalgumERRO &= 0b11101111;
				}
			}
			break;			
		}	
		case defPR6:
		{				
			if (F00_BIT_ON_OFF(defPAG2, _6Bit))
			{
				if (GF94erroCancela)
				{	
					GalgumERRO |= _6Bit;
					F94pp = GF94erroCancela - 10;		
					F94ss = F94pp * 2;
					F94par = EEPROM_Read(F94ss+32);
					F94impar = EEPROM_Read(F94ss+33);
					stgLcd1[4] = Num_Let_LCD[F94par];
					stgLcd1[5] = Num_Let_LCD[F94impar];						
					if (BitInverter)
					{
						stgLcd1[6] = 	'S';
						stgLcd1[7] = 	'e';
						stgLcd1[8] = 	'n';
						stgLcd1[9] = 	's';
						stgLcd1[10] = 	'o';
						stgLcd1[11] = 	'r';
						stgLcd1[12] = 	' ';
						stgLcd1[13] = 	' ';
						stgLcd1[14] = 	' ';
						stgLcd1[15] = 	' ';						
					}
					else
					{
						stgLcd1[6] = 	'C';
						stgLcd1[7] = 	'a';
						stgLcd1[8] = 	'n';
						stgLcd1[9] = 	'c';
						stgLcd1[10] = 	'e';
						stgLcd1[11] = 	'l';
						stgLcd1[12] = 	'a';
						stgLcd1[13] = 	' ';
						stgLcd1[14] = 	' ';
						stgLcd1[15] = 	' ';						
					}								
				}
				else
				{
					GqualMSG = defPR7;
					GalgumERRO &= 0b11011111;
				}				
			}			
			else
			{
				GqualMSG = defPR7;
				GalgumERRO &= 0b11011111;
			}
			break;			
		}
		case defPR7:
		{
			if (F00_BIT_ON_OFF(defPAG2, _7Bit))
			{
				if (BitErroCRC)
				{
					if (BitInverter)
					{
						GalgumERRO |= _7Bit;
						stgLcd1[4] = 	' ';
						stgLcd1[5] = 	'!';
						stgLcd1[6] = 	'E';
						stgLcd1[7] = 	'R';
						stgLcd1[8] = 	'R';
						stgLcd1[9] = 	'O';
						stgLcd1[10] = 	' ';
						stgLcd1[11] = 	'C';
						stgLcd1[12] = 	'R';
						stgLcd1[13] = 	'C';
						stgLcd1[14] = 	'!';
						stgLcd1[15] = 	' ';						
					}
				}
				else
				{
					GqualMSG=defPR8;
					GalgumERRO &= 0b10111111;
				}
			}
			else
			{
				GqualMSG=defPR8;
				GalgumERRO &= 0b10111111;
			}
			break;			
		}
		case defPR8:
		{
			if (F00_BIT_ON_OFF(defPAG2, _8Bit))
			{
				if (BitErroIPD)
				{
					GalgumERRO |= _8Bit;
					F94ss = GerroIPD * 2;
					F94par = EEPROM_Read(F94ss+32);
					F94impar = EEPROM_Read(F94ss+33);
					stgLcd1[4] = Num_Let_LCD[F94par];
					stgLcd1[5] = Num_Let_LCD[F94impar];
					if (BitInverter)
					{
						stgLcd1[6] = 	'S';
						stgLcd1[7] = 	'e';
						stgLcd1[8] = 	'n';
						stgLcd1[9] = 	's';
						stgLcd1[10] = 	'o';
						stgLcd1[11] = 	'r';
						stgLcd1[12] = 	' ';
						stgLcd1[13] = 	' ';
						stgLcd1[14] = 	' ';
						stgLcd1[15] = 	' ';						
					}
					else					
					{
						stgLcd1[6] = 	'A';
						stgLcd1[7] = 	'n';
						stgLcd1[8] = 	'd';
						stgLcd1[9] = 	'a';
						stgLcd1[10] = 	'r';				
						stgLcd1[11] = 	' ';
						stgLcd1[12] = 	'O';
						stgLcd1[13] = 	'F';
						stgLcd1[14] = 	'F';
						stgLcd1[15] = 	'!';						
					}
				}
				else
				{
					GqualMSG = defPR0;
					GalgumERRO &= 0b01111111;
				}				
			}
			else
			{
				GqualMSG = defPR0;
				GalgumERRO &= 0b01111111;
			}
			F94BitAvaliar = 0;
			break;			
		}		
		default:
		{
			GqualMSG = defPR0;
			break;
		}
	}
	if (GalgumERRO)
	{
		if (!BitInverter)
		{
			stgLcd1[3] = def7SIMBEXCLAM;			
		}
	}
	else
	{
		stgLcd1[3] = 	' ';
	}
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
void F96_IMPRIME_LCD (void)
{	
	uint8_t F96ee;
	uint8_t F96uu = 0;
	if (def1PWDDESLOGADO == GloginState)
	{
		F94_PROCURA_PROBLEMAS();		
	}
	lcd_chr(defLCDLINHA1, 1, stgLcd1[0]);
	for (F96ee = 1; F96ee != 16; F96ee++)
	{
		lcd_chr_cp(stgLcd1[F96ee]);
		stgLcd1[F96ee]=32;
	}
	stgLcd1[0]=32;
	lcd_chr(defLCDLINHA2, 1, stgLcd2[0]);
	for (F96ee = 1; F96ee != 16; F96ee++) 
	{
		lcd_chr_cp(stgLcd2[F96ee]);
		stgLcd2[F96ee]=32;
	}
	stgLcd2[0]=32;	
}

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
void interrupt()
{
    uint8_t ISRrx;
    gie_bit = 0;//desliga todas interrupções
    if (rcif_bit) 
	{
        rcif_bit = 0; 
        ISRrx = uart1_read();	
		switch (GidRXstate)
		{
			case 0:
			{
				if (240 == ISRrx)
				{
					GidRXstate = 1;
				}
				else
				{
					GidRecebido = 0;
					GidCRC = 0;
					GidSensorRX = 0;
				}
				break;
			}
			case 1:
			{
				GidRecebido = ISRrx;
				GidRXstate = 2;
				break;
			}
			case 2:
			{
				GidSensorRX = ISRrx;
				GidRXstate = 3;
				break;
			}
			case 3:
			{
				if (ISRrx == (GidSensorRX+GidRecebido))
				{
					GidCRC = ISRrx;					
				}
				else
				{
					GidRecebido = 0;
					GidCRC = 0;
					GidSensorRX = 0;
					BitErroCRC = 1;
				}
				GidRXstate = 0;
				break;
			}
			default:
			{
				GidRXstate = 0;				
				break;
			}			
		}
    }
    if (tmr0if_bit) 
	{
        tmr0if_bit = 0;
        TMR0H = 0x85; 
        TMR0L = 0xEE; 
		GchamadaState = def7ATUALIZAR;
		GisrInverter++;
		if (GisrInverter>2)
		{
			GisrInverter=0;
			BitInverter=!BitInverter;
		}
    }	
    gie_bit = 1;//liga todas interrupções
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
void main()
{
    F07_CONFIGURA_SISTEMA(0);
    while (1) 
	{			
		F02_LE_TECLADO();
		F84_CHAMADAS();//PRA FATIAR SERVICOS
		F80_LOGIN();//SITUACAO LOGIN
        F82_COMANDATPIC();//COMANDO RELÉS E DISPLAYS	
		GteclaPress = '>';
		if (BitAtualizarLcd)
		{
			F96_IMPRIME_LCD();
			BitAtualizarLcd = 0;			
		}
		asm CLRWDT; //limpa WATCHDOG		
    }
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\////\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//



