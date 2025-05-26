function Temp=Ham_nhan_2_vector(u,p)
Temp = [-u(3)*p(2) + u(2)*p(3);
        u(3)*p(1) - u(1)*p(3);
        -u(2)*p(1) + u(1)*p(2)];
end


int scankey()
{
     GPIO_SetBits(GPIOA,GPIO_Pin_0);
     GPIO_ResetBits(GPIOA,GPIO_Pin_1);
     if((GPIO_ReadInputDataBit(GPIOA,GPIO_Pin_2)==1) return 0;
     if((GPIO_ReadInputDataBit(GPIOA,GPIO_Pin_3)==1) return 1;
     GPIO_ResetBits(GPIOA,GPIO_Pin_0);
     GPIO_SetBits(GPIOA,GPIO_Pin_1);
     if((GPIO_ReadInputDataBit(GPIOA,GPIO_Pin_2)==1) return 2;
      if((GPIO_ReadInputDataBit(GPIOA,GPIO_Pin_3)==1) return 3;
      return 0xFF;
}
