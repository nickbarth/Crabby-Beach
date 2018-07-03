Shader "Custom/legs" {
  Properties {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _FadeLevel ("Fade Level (y)", Float) = 0.0
        _FadeSize ("Fade Size", Float) = 1.0
    }
    SubShader {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        LOD 500
        ZWrite Off
        Blend SrcAlpha OneMinusSrcAlpha

        CGPROGRAM
            #pragma surface surf Standard fullforwardshadows alpha:blend
            #pragma target 3.0

            sampler2D _MainTex;

            struct Input {
                float2 uv_MainTex;
                float3 worldPos;
            };

            half _Glossiness;
            half _Metallic;
            fixed4 _Color;
            float _FadeLevel;
            float _FadeSize;

            void surf (Input IN, inout SurfaceOutputStandard o) {
                fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
                o.Albedo = c.rgb;
                o.Metallic = _Metallic;
                o.Smoothness = _Glossiness;
                o.Alpha = c.a * (1 - smoothstep(_FadeLevel - _FadeSize, _FadeLevel, IN.worldPos.y));
            }
        ENDCG
    }
    FallBack "Diffuse"
}
