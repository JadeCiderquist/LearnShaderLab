// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/3_Specular"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _Specular ("Specular", Color) = (1,1,1,1)
        _Gloss ("Gloss", Range(8.0,256)) = 20
    }
    SubShader
    {
        Pass{
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

            fixed4 _Color;
            fixed4 _Specular;
            float _Gloss;

            v2f vert(a2v v){
                v2f o;
                o.position = UnityObjectToClipPos(v.vertex);
                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
                fixed3 worldNormal = normalize(mul(v.normal,(float3x3)unity_WorldToObject));
                fixed3 lightDiraction = normalize(_WorldSpaceLightPos0.xyz);
                fixed3 diffuse = _Color.rgb * _LightColor0.rgb * saturate(dot(worldNormal,lightDiraction));
                fixed3 reflectDir = normalize(reflect(-lightDiraction,worldNormal));
                fixed3 viewDir = normalize(_WorldSpaceCameraPos.xyz - mul(unity_ObjectToWorld, v.vertex).xyz);

                fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(saturate(dot(reflectDir,viewDir)),_Gloss);

                o.color = ambient + diffuse + specular;

                return o;
                }

            fixed4 frag(v2f i):SV_Target{
                return fixed4(i.color,1.0);
                }

             ENDCG

            }

    }
    FallBack "Diffuse"
}
