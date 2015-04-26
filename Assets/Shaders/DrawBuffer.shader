Shader "Custom/DrawBuffer"
{
	Properties
	{
		_Color ("Color", Color) = (1,1,1,1)
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}
	SubShader
	{
		Tags { "RenderType"="MarchingCubes" }
		
		CGPROGRAM

		#pragma surface surf Standard fullforwardshadows vertex:vert
		#pragma target 5.0

		struct Vertex
		{
			float4 position;
			float3 normal;
		};

		half4 _Color;
		half _Glossiness;
		half _Metallic;

#ifdef SHADER_API_D3D11
		StructuredBuffer<Vertex> _Buffer;
		int _IdOffset;
#endif

		void vert(inout appdata_full v)
		{
#ifdef SHADER_API_D3D11
			Vertex vert = _Buffer[v.texcoord.x + _IdOffset];
			v.vertex.xyz = vert.position.xyz;
			v.normal = vert.normal;
#endif
		}

		struct Input
		{
			float not_in_use;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			o.Albedo = _Color.rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = _Color.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
