#ifndef GRASS_SURFACE
#define GRASS_SURFACE

inline void surf(FS_INPUT i, inout SurfaceOutputStandardSpecular o)
{
	fixed4 color = 0.0;

	#if defined(SIMPLE_GRASS) || defined(SIMPLE_GRASS_DENSITY)
		#ifndef SHADOWPASS
			color = i.color;
			o.Smoothness = _Smoothness00;
			o.Specular = _SpecColor00;
		#endif
	#else
		fixed2 uv = i.uv;

		#if !defined(ONE_GRASS_TYPE)
		switch(i.texIndex)
		{
			case 0:
		#endif
				#ifdef GRASS_USE_TEXTURE_ATLAS
					float width = 1.0 / _TextureAtlasWidth00;
					float height = 1.0 / _TextureAtlasHeight00;
					int row = (int)(i.textureAtlasIndex / _TextureAtlasWidth00);
					int column = i.textureAtlasIndex % _TextureAtlasWidth00;

					uv.x *= width;
					uv.y *= height;
					uv.x += column * width;
					uv.y += row * height;
				#endif

				color = tex2D(_GrassTex00, uv);
				#ifndef SHADOWPASS
					o.Smoothness = _Smoothness00;
					o.Specular = _SpecColor00;
				#endif
		#if !defined(ONE_GRASS_TYPE)
				break;

			case 1:
				#ifdef GRASS_USE_TEXTURE_ATLAS
					float width = 1.0 / _TextureAtlasWidth01;
					float height = 1.0 / _TextureAtlasHeight01;
					int row = (int)(i.textureAtlasIndex / _TextureAtlasWidth01);
					int column = i.textureAtlasIndex % _TextureAtlasWidth01;

					uv.x *= width;
					uv.y *= height;
					uv.x += column * width;
					uv.y += row * height;
				#endif

				color = tex2D(_GrassTex01, uv);
				#ifndef SHADOWPASS
					o.Smoothness = _Smoothness01;
					o.Specular = _SpecColor01;
				#endif
				break;
		
		#if !defined(TWO_GRASS_TYPES)
			case 2:
				#ifdef GRASS_USE_TEXTURE_ATLAS
					float width = 1.0 / _TextureAtlasWidth02;
					float height = 1.0 / _TextureAtlasHeight02;
					int row = (int)(i.textureAtlasIndex / _TextureAtlasWidth02);
					int column = i.textureAtlasIndex % _TextureAtlasWidth02;

					uv.x *= width;
					uv.y *= height;
					uv.x += column * width;
					uv.y += row * height;
				#endif

				color = tex2D(_GrassTex02, uv);
				#ifndef SHADOWPASS
					o.Smoothness = _Smoothness02;
					o.Specular = _SpecColor02;
				#endif
				break;
		
		#if !defined(THREE_GRASS_TYPES)
			case 3:
				#ifdef GRASS_USE_TEXTURE_ATLAS
					float width = 1.0 / _TextureAtlasWidth03;
					float height = 1.0 / _TextureAtlasHeight03;
					int row = (int)(i.textureAtlasIndex / _TextureAtlasWidth03);
					int column = i.textureAtlasIndex % _TextureAtlasWidth03;

					uv.x *= width;
					uv.y *= height;
					uv.x += column * width;
					uv.y += row * height;
				#endif

				color = tex2D(_GrassTex03, uv);
				#ifndef SHADOWPASS
					o.Smoothness = _Smoothness03;
					o.Specular = _SpecColor03;
				#endif
				break;
		#endif
		#endif

			default:
				discard;
				break;
		}
		#endif

		#ifndef SHADOWPASS
		color *= i.color;
		#endif

		//Cuts off the texture when texture alpha is smaller than 0.1
		clip(color.a - _TextureCutoff);
	#endif // !SIMPLE_GRASS

	o.Albedo = color.rgb;
	o.Alpha = color.a;
}

#endif