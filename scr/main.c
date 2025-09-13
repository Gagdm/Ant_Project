#include <stm8s.h>
#include <stm8s_clk.h>
#include <stm8s_gpio.h>
#include <delay.h>

#define SENS_PORT GPIOD
#define SENS1_PIN GPIO_PIN_4
#define SENS2_PIN GPIO_PIN_5
#define SENS3_PIN GPIO_PIN_6

// Contador
volatile uint32_t counter = 0;
volatile uint32_t TIM_SENS1 = 0;
volatile uint32_t TIM_SENS2 = 0;
volatile uint32_t TIM_SENS3 = 0;

void GPIO_Config(void) {

	// Retira configurações existentes da porta
	GPIO_DeInit(SENS_PORT);

	// inicializa a mesma
	GPIO_Init(SENS_PORT, SENS1_PIN, GPIO_MODE_IN_FL_IT);
	GPIO_Init(SENS_PORT, SENS2_PIN, GPIO_MODE_IN_FL_IT);
	GPIO_Init(SENS_PORT, SENS3_PIN, GPIO_MODE_IN_FL_IT);

	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD, EXTI_SENSITIVITY_RISE_ONLY);
	
	enableInterrupts();
}

void SENS_IRQHandler(void) {
	
	// Identifica de qual porta foi a interrupção;
	if((SENS_PORT->IDR & SENS1_PIN) != 0) {
		TIM_SENS1 = counter;
	}
	else if((SENS_PORT->IDR & SENS2_PIN) != 0) {
		TIM_SENS2 = counter;
	}
	else if((SENS_PORT->IDR & SENS3_PIN) != 0) {
		TIM_SENS3 = counter;
	}
}

void CLK_Config(void) {
	//
	CLK_DeInit();
	CLK_HSECmd(DISABLE);
	CLK_LSICmd(DISABLE);
	
	// Desabilita a saida de clock do pino de teste
	CLK_CCOConfig(CLK_OUTPUT_HSI);
	CLK_CCOCmd(DISABLE);
	
	// Divide o clock por 4 saindo entao 4mhz que é o clock
	// Mínimo para que o ssd1306 funcione no i2c
	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV4);
	CLK_HSICmd(ENABLE);

	// Habilita o clock para o I2C
	//CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, ENABLE);
}

void TIM1_Config(void)
{
	TIM1_DeInit();
	// Primeiro parametro e o divisor do clock, basicamente ele diz a quantos pulsos de clock
	// Devemos incrementar o contador assim como 4mhz é o valor do clock configurado anteriormente
	// Entao: 4mhz / 4k = 1000 -> 1 / 1000 = 1ms
	// Segundo parametro indica qual o valor de estouro que pode ser ate no maximo 65535 pois ele so
	// Vai ate 16 bits
	TIM1_TimeBaseInit(4000, TIM1_COUNTERMODE_UP, 65535, 0);
	// Configura para gerar interrupção.
	TIM1_ITConfig(TIM1_IT_UPDATE, ENABLE);
	TIM1_Cmd(ENABLE);

}

void TIM1_IRQHandler(void) {
	// Limpa a flag
	TIM1_ClearITPendingBit(TIM1_IT_UPDATE);

	counter++;
}

int main(void)
{
	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
	CLK_SYSCLKConfig(CLK_PRESCALER_HSIDIV1);

	GPIO_Init(SENS1_PORT, SENS1_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
	
	while (1)
	{

	}
}