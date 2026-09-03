-- chunkname: @/tmp/or_script/lua_compile/dm/utils/CustomShaderUtils.lua

module("CustomShaderUtils", package.seeall)

CUSTOM_BLUR = "customShader_blur"
CUSTOM_FLUXAY = "customShader_fluxay"
CUSTOM_FLUXAY2 = "customShader_fluxay2"
CUSTOM_FLUXAY_SUPER = "customShader_fluxay_super"
CUSTOM_STAR = "customShader_star"
CUSTOM_CIRCLE = "customShader_circle"
CUSTOM_CIRCLEOUTLINE = "customShader_circleOutline"
CUSTOM_WATER = "customShader_water"
CUSTOM_MASK = "customShader_mask"
CUSTOM_OUTLINE = "customShader_outlineLight"
CUSTOM_CIRCLE_SMOOTH = "customShader_circle_smooth"

local customShaderProgramAche = {}
local shader_f = {}
local commonShaderV = "\n\tattribute vec4 a_position;\n\tattribute vec2 a_texCoord;\n\tattribute vec4 a_color;\n\n\t#ifdef GL_ES\n\tvarying lowp vec4 v_fragmentColor;\n\tvarying mediump vec2 v_texCoord;\n\t#else\n\tvarying vec4 v_fragmentColor;\n\tvarying vec2 v_texCoord;\n\t#endif\n\n\tvoid main()\n\t{\n\t    gl_Position = CC_PMatrix * a_position;\n\t    v_fragmentColor = a_color;\n\t    v_texCoord = a_texCoord;\n\t}\n"
local etc1ExtraStr = "\tvec4 getFragColor(vec2 texCoord)\n\t{\n\t\tvec4 texColor = vec4(texture2D(CC_Texture0, texCoord).rgb, texture2D(CC_Texture1, texCoord).r);\n        texColor.rgb *= texColor.a;\n\t\treturn texColor;\n\t}\n"
local A8ExtraStr = "\tvec4 getFragColor(vec2 texCoord)\n\t{\n\t\tvec4 texColor = vec4(texture2D(CC_Texture0, texCoord).rgb, texture2D(CC_Texture1, texCoord).a);\n        texColor.rgb *= texColor.a;\n\t\treturn texColor;\n\t}\n"
local normalExtraStr = "\tvec4 getFragColor(vec2 texCoord)\n\t{\n\t\treturn texture2D(CC_Texture0, texCoord);\n\t}\n"

local function getOrCreateProgram(type, alphaTextureFormat)
	local baseType = type

	if alphaTextureFormat then
		type = type .. "_" .. alphaTextureFormat
	end

	if customShaderProgramAche[type] then
		return customShaderProgramAche[type]
	end

	assert(shader_f[baseType], "没有此种shader类型：" .. baseType)

	local shader_f_str = shader_f[baseType]

	shader_f_str = alphaTextureFormat and (alphaTextureFormat == "A8" and A8ExtraStr .. shader_f_str or etc1ExtraStr .. shader_f_str) or normalExtraStr .. shader_f_str

	local program = cc.GLProgram:createWithByteArrays(commonShaderV, shader_f_str)

	program:retain()

	customShaderProgramAche[type] = program

	return program
end

function setCustomShaderToNodeByType(node, type)
	local sprite = node

	if not node.getTexture then
		sprite = node:getVirtualRenderer():getSprite()
	end

	local alphaTextureFormat

	if sprite:getTexture():getAlphaTexture() then
		alphaTextureFormat = sprite:getTexture():getAlphaTexture():getStringForFormat()
	end

	local program = getOrCreateProgram(type, alphaTextureFormat)
	local glProgramState = cc.GLProgramState:getOrCreateWithGLProgram(program)

	node:setGLProgramState(glProgramState)

	return glProgramState
end

function setBlurToNode(node, blurRadius, sampleNum)
	blurRadius = blurRadius or 4
	sampleNum = sampleNum or 4

	if blurRadius < sampleNum then
		sampleNum = blurRadius
	end

	local glProgramState = setCustomShaderToNodeByType(node, CUSTOM_BLUR)
	local size = not node.getTexture and node:getVirtualRenderer():getSprite():getTexture():getContentSizeInPixels() or node:getTexture():getContentSizeInPixels()

	glProgramState:setUniformVec2("resolution", {
		x = size.width,
		y = size.height
	})
	glProgramState:setUniformFloat("blurRadius", blurRadius)
	glProgramState:setUniformFloat("sampleNum", sampleNum)
end

function setGrayPart(node, left, right, top, bottom)
	left = left or 0
	right = right or 1
	top = top or 0.5
	bottom = bottom or 0

	local glProgramState = setCustomShaderToNodeByType(node, CUSTOM_GrayPart)
	local size = not node.getTexture and node:getVirtualRenderer():getSprite():getTexture():getContentSizeInPixels() or node:getTexture():getContentSizeInPixels()

	glProgramState:setUniformVec2("resolution", {
		x = size.width,
		y = size.height
	})
	glProgramState:setUniformFloat("left", left)
	glProgramState:setUniformFloat("right", right)
	glProgramState:setUniformFloat("top", top)
	glProgramState:setUniformFloat("bottom", bottom)

	local startTime = os.clock()
	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		time = os.clock() - startTime

		glProgramState:setUniformFloat("time", time)
	end))
	local action = cc.RepeatForever:create(sequence)

	node:runAction(action)
end

function setFluxayToNode(node, color)
	color = color or {}

	local glProgramState = setCustomShaderToNodeByType(node, CUSTOM_FLUXAY)
	local delay = cc.DelayTime:create(0)
	local startTime = os.clock()
	local time = 0

	glProgramState:setUniformFloat("time", time)

	local size = node:getTexture():getContentSizeInPixels()

	glProgramState:setUniformVec2("resolution", {
		x = size.width,
		y = size.height
	})

	local sequence = cc.Sequence:create(delay, cc.CallFunc:create(function()
		time = os.clock() - startTime

		glProgramState:setUniformFloat("time", time)
	end))
	local var_6_0 = {}

	var_6_0.x = color.r or 255
	var_6_0.y = color.g or 255
	var_6_0.z = color.b or 255

	glProgramState:setUniformVec3("fluxayColor", var_6_0)

	local action = cc.RepeatForever:create(sequence)

	node:runAction(action)
end

function setFluxaySuperToNode(node, color)
	color = color or {}

	local glProgramState = setCustomShaderToNodeByType(node, CUSTOM_FLUXAY_SUPER)
	local delay = cc.DelayTime:create(0)
	local startTime = os.clock()
	local time = 0

	glProgramState:setUniformFloat("time", time)

	local size = node:getTexture():getContentSizeInPixels()

	glProgramState:setUniformVec2("resolution", {
		x = size.width,
		y = size.height
	})

	local sequence = cc.Sequence:create(delay, cc.CallFunc:create(function()
		time = os.clock() - startTime

		glProgramState:setUniformFloat("time", time)
	end))
	local var_8_0 = {}

	var_8_0.x = (color.r or 255) / 255
	var_8_0.y = (color.g or 255) / 255
	var_8_0.z = (color.b or 255) / 255

	glProgramState:setUniformVec3("fluxayColor", var_8_0)

	local action = cc.RepeatForever:create(sequence)

	node:runAction(action)
end

function setStarToNode(node)
	local glProgramState = setCustomShaderToNodeByType(node, CUSTOM_STAR)
	local delay = cc.DelayTime:create(0)
	local startTime = os.clock()
	local time = 0

	glProgramState:setUniformFloat("time", time)

	local sequence = cc.Sequence:create(delay, cc.CallFunc:create(function()
		time = os.clock() - startTime

		glProgramState:setUniformFloat("time", time)
	end))
	local action = cc.RepeatForever:create(sequence)

	node:runAction(action)
end

function setCircleSmoothToNode(node, edge)
	local glProgramState = setCustomShaderToNodeByType(node, CUSTOM_CIRCLE_SMOOTH)
end

function setCircleToNode(node, edge)
	local glProgramState = setCustomShaderToNodeByType(node, CUSTOM_CIRCLE)

	glProgramState:setUniformFloat("u_edge", edge or 0.05)
end

function setCircleOutlineToNode(node)
	local glProgramState = setCustomShaderToNodeByType(node, CUSTOM_CIRCLEOUTLINE)
	local size = node:getContentSize()

	glProgramState:setUniformVec2("resolution", {
		x = size.width,
		y = size.height
	})
end

function setWaterToNode(node)
	local glProgramState = setCustomShaderToNodeByType(node, CUSTOM_WATER)
	local delay = cc.DelayTime:create(0)
	local startTime = os.clock()
	local time = 0

	glProgramState:setUniformFloat("time", time)

	local size = node:getTexture():getContentSizeInPixels()

	glProgramState:setUniformVec2("resolution", {
		x = size.width,
		y = size.height
	})

	local sequence = cc.Sequence:create(delay, cc.CallFunc:create(function()
		time = os.clock() - startTime

		glProgramState:setUniformFloat("time", time)
	end))
	local action = cc.RepeatForever:create(sequence)

	node:runAction(action)
end

function setDynamicOutlineLightToNode(node)
	local glProgramState = setCustomShaderToNodeByType(node, CUSTOM_OUTLINE)
	local delay = cc.DelayTime:create(0)
	local startTime = os.clock()
	local time = 0

	glProgramState:setUniformFloat("time", time)

	local size = node:getTexture():getContentSizeInPixels()
	local sequence = cc.Sequence:create(delay, cc.CallFunc:create(function()
		time = os.clock() - startTime

		glProgramState:setUniformFloat("time", time)
	end))
	local action = cc.RepeatForever:create(sequence)

	node:runAction(action)
end

shader_f.customShader_grayPart = "\t#ifdef GL_ES\n\tprecision mediump float;\n\t#endif\n\n\tvarying vec4 v_fragmentColor;\n\tvarying vec2 v_texCoord;\n\n\tuniform vec2 resolution;\n\tuniform float left;\n\tuniform float right;\n\tuniform float top;\n\tuniform float bottom;\n\tuniform float time;\n\tvoid main(void)\n\t{\t\n\t\tvec2 uv = v_texCoord.xy;\n\t\tfloat aaa = (sin(time * 30.) + 1.) / 2.;\n\t\tif (uv.x >= aaa && uv.x <= right)\n\t\t{\n\t\t\tif (uv.y >= bottom && uv.y <= top){\n\t\t\t\tvec4 c = getFragColor(v_texCoord);\n\t\t\t\tfloat clrbright = (c.r + c.g + c.b) * (1. / 3.);\n\t\t\t\tfloat gray = (0.6) * clrbright;\n\t\t\t\tgl_FragColor = vec4(gray,gray+ 0.1,gray + 0.2,1.);\n\t\t\t}else{\n\t\t\t\tgl_FragColor = getFragColor(v_texCoord);\n\t\t\t}\n\t\t}else{\n\t\t\tgl_FragColor = getFragColor(v_texCoord);\n\t\t}\n\t}\n"
shader_f.customShader_circle_smooth = "\t#ifdef GL_ES\n\tprecision mediump float;\n\t#endif\n\n\tvarying vec4 v_fragmentColor;\n\tvarying vec2 v_texCoord;\n\n\tvoid main(void)\n\t{\t\n\t\tvec2 uv = v_texCoord.xy;\n\t\tuv-=0.5;\n\t\tfloat detal = smoothstep(0.48,0.5,distance(uv.xy, vec2(0.)));\t\n\t\tvec4 finalColor = getFragColor(v_texCoord);\t\n\t\tfinalColor.a *= (1.-detal);\n\t\tif (1.-detal == 0.)\n\t\t{\n\t\t\tgl_FragColor = vec4(0.);\n\t\t}else{\n\t\t\tgl_FragColor = finalColor;\n\t\t}\n\t}\n"
shader_f.customShader_blur = "\t#ifdef GL_ES\n\tprecision mediump float;\n\t#endif\n\n\tvarying vec4 v_fragmentColor;\n\tvarying vec2 v_texCoord;\n\n\tuniform vec2 resolution;\n\tuniform float blurRadius;\n\tuniform float sampleNum;\n\n\tvec4 blur(vec2);\n\n\tvoid main(void)\n\t{\n\t\tvec4 col = blur(v_texCoord);\n\t\tgl_FragColor = vec4(col) * v_fragmentColor;\n\t}\n\n\tvec4 blur(vec2 p)\n\t{\n\t\tif (blurRadius > 0.0 && sampleNum > 1.0)\n\t\t{\n\t\t\tvec4 col = vec4(0);\n\t\t\tvec2 unit = 1.0 / resolution.xy;\n\n\t\t\tfloat r = blurRadius;\n\t\t\tfloat sampleStep = r / sampleNum;\n\n\t\t\tfloat count = 0.0;\n\n\t\t\tfor(float x = -r; x < r; x += sampleStep)\n\t\t\t{\n\t\t\t\tfor(float y = -r; y < r; y += sampleStep)\n\t\t\t\t{\n\t\t\t\t\tfloat weight = (r - abs(x)) * (r - abs(y));\n\t\t\t\t\tcol += getFragColor(p + vec2(x * unit.x, y * unit.y)) * weight;\n\t\t\t\t\tcount += weight;\n\t\t\t\t}\n\t\t\t}\n\t\t\treturn col / count;\n\t\t}\n\n\t\treturn getFragColor(p);\n\t}\n"
shader_f.customShader_fluxay = "#ifdef GL_ES\nprecision mediump float;\n#endif\nvarying vec4 v_fragmentColor;\nvarying vec2 v_texCoord;\nuniform float time;\nuniform vec3 fluxayColor;\nvoid main()\n{\nvec4 src_color = getFragColor(v_texCoord).rgba;\n\nfloat width = 0.04;       //流光的宽度范围 (调整该值改变流光的宽度)\nfloat start = tan(time*2.0/1.414);  //流光的起始x坐标\nfloat strength = 0.006;   //流光增亮强度   (调整该值改变流光的增亮强度)\nfloat offset = 0.5;      //偏移值         (调整该值改变流光的倾斜程度)\nif( v_texCoord.x < (start - offset * v_texCoord.y) &&  v_texCoord.x > (start - offset * v_texCoord.y - width))\n{\nvec3 improve = strength * fluxayColor;\nvec3 result = improve * vec3( src_color.r, src_color.g, src_color.b);\ngl_FragColor = vec4(result, src_color.a)*v_fragmentColor;\n\n}else{\ngl_FragColor = src_color*v_fragmentColor;\n}\n}\n"
shader_f.customShader_fluxay2 = "#ifdef GL_ES\nprecision mediump float;\n#endif\n\nvarying vec4 v_fragmentColor;\nvarying vec2 v_texCoord;\n\n// uniform float factor;\n// uniform float width;\nuniform float time;\n// uniform vec3 color;\nvoid main()\n{\nfloat factor = .06;\nfloat width = .02;\n// float offset = .5;\nvec3 color = vec3(10.,10.,10.);\nvec4 texColor = getFragColor(v_texCoord);\n\nfloat distance = abs(v_texCoord[0]+v_texCoord[1]-tan(time))/1.414;\n\ndistance = 1.0-(1.0/width)*distance;\ndistance = max(distance, 0.0);\nvec4 sample = vec4(0.0,0.0,0.0,0.0);\nsample[0] = color[0] * distance;\nsample[1] = color[1] * distance;\nsample[2] = color[2] * distance;\nsample[3] = distance;\n\nfloat alpha = sample[3]*texColor[3];\ntexColor[0] = texColor[0] + sample[0]*alpha*factor;\ntexColor[1] = texColor[1] + sample[1]*alpha*factor;\ntexColor[2] = texColor[2] + sample[2]*alpha*factor;\ngl_FragColor = v_fragmentColor * texColor;\n}\n"
shader_f.customShader_star = "#ifdef GL_ES\nprecision mediump float;\n#endif\n\n#define M_PI 3.1415926535897932384626433832795\nvarying vec4 v_fragmentColor;\nvarying vec2 v_texCoord;\nuniform float time;\nuniform vec2 resolution;\nfloat rand(vec2 co)\n{\n\treturn fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);\n}\n\nvoid mainImage( out vec4 fragColor, in vec2 fragCoord )\n{\n\tfloat size = 10.0;\n\tfloat prob = 0.95;\n\n\tvec2 pos = floor(1.0 / size * fragCoord.xy);\n\n\tfloat color = 0.0;\n\tfloat g = .0;\n\tfloat b = .0;\n\tfloat starValue = rand(pos);\n\n\tif (starValue > prob)\n\t{\n\t\tvec2 center = size * pos + vec2(size, size) * 0.5;\n\n\t\tfloat t = 0.9 + .9*sin(.3*time) * sin(time + (starValue - prob) / (1.0 - prob) * 45.0);\n\n\t\tcolor = 1.0 - distance(fragCoord.xy, center) / (0.5 * size);\n\t\tcolor = color * t/ (abs(fragCoord.y - center.y)) * t / (abs(fragCoord.x - center.x));\n\t\tb = color *sin(t)*t;\n\t\tg = color*t;\n\t}\n\telse if (rand(fragCoord.xy / resolution.xy) > 0.996)\n\t{\n\t\tfloat r = rand(fragCoord.xy);\n\t\tcolor = r * (0.35 * sin(time * (r * 5.0) + 720.0 * r) + 0.75);\n\t\tg = r * (0.35 * sin(time * (r * 5.0) + 720.0 * r) + 0.75);\n\t\tb = r * (0.35 * sin(time * (r * 5.0) + 720.0 * r) + 0.75);\n\t}\n\tvec4 textureColor = getFragColor(v_texCoord);\n\tfragColor = textureColor * v_fragmentColor;\n\tif (fragColor.a + fragColor.g + fragColor.r + fragColor.b > 0.1)\n\t{\n\t\tfragColor = vec4(fragColor.rgb + vec3(color,g,b),fragColor.a);\n\t}\n}\nvoid main()\n{\n\tmainImage(gl_FragColor, gl_FragCoord.xy);\n}\n"
shader_f.customShader_circle = "\t#ifdef GL_ES\n\tprecision mediump float;\n\t#endif\n\n\tvarying vec4 v_fragmentColor;\n\tvarying vec2 v_texCoord;\n\n\tuniform float u_edge;\n\tvoid main()\n\t{\n\t\tfloat edge = u_edge;\n\t\tfloat dis = 0.0;\n\t\tvec2 texCoord = v_texCoord;\n\t\tif ( texCoord.x < edge )\n\t\t{\n\t\t\tif ( texCoord.y < edge )\n\t\t\t{\n\t\t\t\tdis = distance( texCoord, vec2(edge, edge) );\n\t\t\t}\n\t\t\tif ( texCoord.y > (1.0 - edge) )\n\t\t\t{\n\t\t\t\tdis = distance( texCoord, vec2(edge, (1.0 - edge)) );\n\t\t\t}\n\t\t\t}\n\t\t\telse if ( texCoord.x > (1.0 - edge) )\n\t\t\t{\n\t\t\t\tif ( texCoord.y < edge )\n\t\t\t{\n\t\t\t\tdis = distance( texCoord, vec2((1.0 - edge), edge ) );\n\t\t\t}\n\t\t\tif ( texCoord.y > (1.0 - edge) )\n\t\t\t{\n\t\t\t\tdis = distance( texCoord, vec2((1.0 - edge), (1.0 - edge) ) );\n\t\t\t}\n\t\t}\n\n\t\tif(dis > 0.001)\n\t\t{\n\t\t\t// 外圈沟\n\t\t\tfloat gap = edge * 0.02;\n\t\t\tif(dis <= edge - gap)\n\t\t\t{\n\t\t\t\tgl_FragColor = getFragColor(texCoord);\n\t\t\t}\n\t\t\telse if(dis <= edge)\n\t\t\t{\n\t\t\t\t// 平滑过渡\n\t\t\t\tfloat t = smoothstep(0.,gap,edge-dis);\n\t\t\t\tvec4 color = getFragColor(texCoord);\n\t\t\t\tif ( color.a < 0.05 ){\n\t\t\t\t\tt = color.a;\n\t\t\t\t}\n\t\t\t\tgl_FragColor = vec4(color.rgb,t);\n\t\t\t}else{\n\t\t\t\tgl_FragColor = vec4(0.,0.,0.,0.);\n\t\t\t}\n\t\t}\n\t\telse\n\t\t{\n\t\t\tgl_FragColor = getFragColor(texCoord);\n\t\t}\n\t}\n"
shader_f.customShader_circleOutline = "#ifdef GL_ES\nprecision mediump float;\n#endif\n\nuniform float time;\nuniform vec2 resolution;\nvarying vec2 v_texCoord;\n\nfloat ringWidth = 0.49;\nvec3 ringColor = vec3(1.0,0.3,0.3);\n\nvec4 outline(float width, vec2 tc, vec3 color, sampler2D tex){\nvec4 t = getFragColor(tc);\ntc -= 0.5;\ntc.x *= resolution.x / resolution.y;\n\nfloat grad = length(tc);\nfloat circle = smoothstep(0.5, 0.48, grad);\nfloat ring = circle - smoothstep(width, width-0.03, grad);\n\nt = (t * (circle - ring));\nt.rgb += (ring * ringColor);\n\nreturn t;\n}\n\nvoid mainImage( out vec4 fragColor, in vec2 fragCoord )\n{\nvec2 uv = v_texCoord.xy;\n\nvec4 t = outline(ringWidth, uv, ringColor, CC_Texture0);\n\nfragColor = t;\n}\n\nvoid main()\n{\nmainImage(gl_FragColor, gl_FragCoord.xy);\n}\n"
shader_f.customShader_fluxay_super = "#define TAU 6.120470874064187\n#define MAX_ITER 5\nuniform float time;\nvarying vec2 v_texCoord;\nvarying vec4 v_fragmentColor;\nuniform vec3 fluxayColor;\nvoid mainImage( out vec4 fragColor, in vec2 fragCoord )\n{\nfloat time = time * .5+5.;\n// uv should be the 0-1 uv of texture...\nvec2 uv = v_texCoord.xy;\n\n\nvec2 p = mod(uv*TAU, TAU)-250.0;\n\nvec2 i = vec2(p);\nfloat c = 1.0;\nfloat inten = .0045;\n\nfor (int n = 0; n < MAX_ITER; n++)\n{\nfloat t =  time * (1.0 - (3.5 / float(n+1)));\ni = p + vec2(cos(t - i.x) + sin(t + i.y), sin(t - i.y) + cos(1.5*t + i.x));\nc += 1.0/length(vec2(p.x / (cos(i.x+t)/inten),p.y / (cos(i.y+t)/inten)));\n}\nc /= float(MAX_ITER);\nc = 1.17-pow(c, 1.4);\nvec4 tex = getFragColor(uv);\nvec3 colour = vec3(pow(abs(c), 20.0));\ncolour = clamp(colour + vec3(0.0, 0.0, .0), 0.0, tex.a)*fluxayColor;\n\n// 混合波光\nfloat alpha = c*tex[3];\ntex[0] = tex[0] + colour[0]*alpha;\ntex[1] = tex[1] + colour[1]*alpha;\ntex[2] = tex[2] + colour[2]*alpha;\nfragColor = v_fragmentColor * tex;\n}\nvoid main()\n{\nmainImage(gl_FragColor, gl_FragCoord.xy);\n}\n"
shader_f.customShader_water = " #ifdef GL_ES\n    precision mediump float;\n    #endif\n\n    #define F cos(x-y)*cos(y),sin(x+y)*sin(y)\n\n    uniform float time;\n    uniform vec2 resolution;\n    varying vec2 v_texCoord;\n\n    vec2 s(vec2 p)\n    {\n        float d=time*0.2,x=8.*(p.x+d),y=8.*(p.y+d);\n        return vec2(F);\n    }\n    void mainImage( out vec4 fragColor, in vec2 fragCoord )\n    {\n        // 换成resolution\n        vec2 rs = resolution.xy;\n        // 换成纹理坐标v_texCoord.xy\n        vec2 uv = v_texCoord.xy;\n        vec2 q = uv+2./resolution.x*(s(uv)-s(uv+rs));\n        //反转y\n        // q.y=1.-q.y;\n        fragColor = getFragColor(q);\n    }\n    void main()\n    {\n        mainImage(gl_FragColor, gl_FragCoord.xy);\n    }\n"
shader_f.customShader_mask = "#ifdef GL_ES\nprecision mediump float;\n#endif\n\nvarying vec4 v_fragmentColor;\nvarying vec2 v_texCoord;\n\n// uniform float factor;\n// uniform float width;\nuniform float time;\n// uniform vec3 color;\nvoid main()\n{\nfloat w = 0.5;\nvec4 texColor = getFragColor(v_texCoord);\ngl_FragColor = v_fragmentColor * texColor;\nif(abs(0.5 - v_texCoord.x) > w/2.0 && texColor.a > 0.1){\n    gl_FragColor.a = 1.0 - (abs(0.5 - v_texCoord.x) - w/2.0)/((1.0-w)/4.0);\n}\n\ngl_FragColor = vec4(gl_FragColor.rgb * gl_FragColor.a,gl_FragColor.a);\n}\n"
shader_f.customShader_outlineLight = "                                           \n#ifdef GL_ES                                \nprecision mediump float;                    \n#endif                                      \n\nvarying vec4 v_fragmentColor;               \nvarying vec2 v_texCoord;                                 \nuniform float time;\nvoid main()                                 \n{                                           \nfloat radius = 0.03*sin(16.0*time + 1.7);\nvec4 accum = vec4(0.0);\nvec4 normal = vec4(0.0);\nnormal = getFragColor(vec2(v_texCoord.x, v_texCoord.y));\naccum += getFragColor(vec2(v_texCoord.x - radius, v_texCoord.y - radius));\naccum += getFragColor(vec2(v_texCoord.x + radius, v_texCoord.y - radius));\naccum += getFragColor(vec2(v_texCoord.x + radius, v_texCoord.y + radius));\naccum += getFragColor(vec2(v_texCoord.x - radius, v_texCoord.y + radius));\naccum += normal;\naccum += getFragColor(vec2(v_texCoord.x - radius, v_texCoord.y));\naccum += getFragColor(vec2(v_texCoord.x + radius, v_texCoord.y));\naccum += getFragColor(vec2(v_texCoord.x, v_texCoord.y - radius));\naccum += getFragColor(vec2(v_texCoord.x, v_texCoord.y + radius));\naccum.a *= 1.0/4.0;\naccum =  v_fragmentColor * accum.a;\nnormal = ( accum * (1.0 - normal.a)) + (normal * normal.a);\ngl_FragColor = v_fragmentColor.a * normal;\n}\n"
