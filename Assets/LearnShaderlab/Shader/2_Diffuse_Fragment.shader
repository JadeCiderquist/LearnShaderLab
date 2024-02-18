// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'


Shader "A_Learn/2_Diffuse_Fragment"
{
    Properties{
        _Diffuse("Diffuse", Color) = (1,1,1,1)
        }
    SubShader
    {
        Pass
        {
            Tags{"LightMode"="ForwardBase"}
            CGPROGRAM

            #include "Lighting.cginc"//取得第一个直射光的颜色 _LightColor0
            #pragma vertex vert
            #pragma fragment frag
            fixed4 _Diffuse;
            
            struct a2v 
            {
                    float4 vertex:POSITION;//告诉unity把模型空间下的顶点坐标填充给vertex
                    float3 normal:NORMAL;
            };

            struct v2f
            {
                float4 position:SV_POSITION;
                float3 worldNormal:TEXCOORD0;
            };

            v2f vert(a2v v)
            {
                v2f f;
                f.position = UnityObjectToClipPos(v.vertex);
                f.worldNormal = mul(v.normal, (float3x3)unity_WorldToObject);
                return f;

            };

            fixed4 frag(v2f f) :SV_Target{
                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
                fixed3 worldNormal = normalize(f.worldNormal);
                fixed3 lightDiraction = normalize(_WorldSpaceLightPos0.xyz);
                fixed3 diffuse = _Diffuse.rgb * _LightColor0.rgb * saturate(dot(worldNormal,lightDiraction));
                fixed3 color = ambient + diffuse;
                return fixed4(color, 0);

            }

            ENDCG
        }
    }
    FallBack "Diffuse"
}
