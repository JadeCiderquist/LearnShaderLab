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

            #include "Lighting.cginc"//取得第一个直射光的颜色 _LightColor0
            #pragma vertex vert
            #pragma fragment frag
            
            struct a2v 
            {
                    float4 vertex:POSITION;//告诉unity把模型空间下的顶点坐标填充给vertex
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
                fixed3 LightDir = normalize(_WorldSpaceLightPos0.xyz);//对于每个顶点，光的位置是光的方向，因为光是平行光
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
