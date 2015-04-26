Shader "Custom/DrawBuffer2" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}

	CGINCLUDE

	#include "UnityCG.cginc"

	#pragma target 5.0

	struct Vert
	{
		float4 position;
		float3 normal;
	};

#ifdef SHADER_API_D3D11
	StructuredBuffer<Vert> _Buffer;
	int _IdOffset;
#endif
	
	ENDCG

	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM

		#pragma surface surf Standard fullforwardshadows vertex:vert

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;

		void vert(inout appdata_full v) {
			Vert vert = _Buffer[v.texcoord.x + _IdOffset];
			v.vertex.xyz = vert.position.xyz;
			v.normal = vert.normal;
		}

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
