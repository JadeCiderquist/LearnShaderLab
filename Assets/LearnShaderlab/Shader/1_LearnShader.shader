Shader "A_Learn/1Learn"
{
    Properties//定义可公开变量
    {
        _MainColor("MainColor", Color) = (1,1,1,1)
        _Vector("Vector", Vector) = (1,2,3,4)
        _Range("Range", Range(0,10)) = 5
        _2D("Texture", 2D) = "White"{}
    }

        SubShader//子Shader
    {
        Pass//至少有一个Pass
        {
            CGPROGRAM//使用CG语言
            #pragma vertex vert//定义顶点着色器
            #pragma fragment frag//定义片元着色器

            float4 _MainColor;
            float _Range;

            float4 vert(float4 v : POSITION) : SV_POSITION
            {
                float4 pos = UnityObjectToClipPos(v);//从模型空间到裁剪空间
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
