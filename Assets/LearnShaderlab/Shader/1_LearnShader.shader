Shader "A_Learn/1Learn"
{
    Properties//����ɹ�������
    {
        _MainColor("MainColor", Color) = (1,1,1,1)
        _Vector("Vector", Vector) = (1,2,3,4)
        _Range("Range", Range(0,10)) = 5
        _2D("Texture", 2D) = "White"{}
    }

        SubShader//��Shader
    {
        Pass//������һ��Pass
        {
            CGPROGRAM//ʹ��CG����
            #pragma vertex vert//���嶥����ɫ��
            #pragma fragment frag//����ƬԪ��ɫ��

            float4 _MainColor;
            float _Range;

            float4 vert(float4 v : POSITION) : SV_POSITION
            {
                float4 pos = UnityObjectToClipPos(v);//��ģ�Ϳռ䵽�ü��ռ�
                return pos;
            }

            float4 frag() : SV_Target
            {
                //Color = _MainColor;
                 return _MainColor * _Range;
            }
            
         //   float4 _Vector;
          //  float _Range;
         //   sampler2D _2D;
    
            ENDCG
        }
    }

        FallBack "Fur/Geometry/Lit"
}
