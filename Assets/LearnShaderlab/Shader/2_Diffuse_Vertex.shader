// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "A_Learn/2_Diffuse_Vertex"
{
    SubShader
    {
        Pass
        {
            Tags{"LightMode"="ForwardBase"}
            CGPROGRAM

            #include "Lighting.cginc"//ȡ�õ�һ��ֱ������ɫ _LightColor0
            #pragma vertex vert
            #pragma fragment frag
            
            struct a2v 
            {
                    float4 vertex:POSITION;//����unity��ģ�Ϳռ��µĶ�����������vertex
                    float3 normal:NORMAL;
            };

            struct v2f
            {
                float4 position:SV_POSITION;
                float3 color:COLOR;
            };

            v2f vert(a2v v)
            {
                v2f f;
                f.position = UnityObjectToClipPos(v.vertex);
                fixed3 normalDir = normalize(mul(v.normal, (float3x3) unity_WorldToObject));
                fixed3 LightDir = normalize(_WorldSpaceLightPos0.xyz);//����ÿ�����㣬���λ���ǹ�ķ�����Ϊ����ƽ�й�
                fixed3 diffuse = _LightColor0.rgb * max(0, dot(normalDir, LightDir));

                f.color = diffuse;
                return f;

            };

            fixed4 frag(v2f f) :SV_Target{
                return fixed4(f.color,1);
            }

            ENDCG
        }
    }
    FallBack "Diffuse"
}
