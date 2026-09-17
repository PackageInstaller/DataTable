local var_0_0 = {
	performWithDelay = function(arg_1_0, arg_1_1, arg_1_2)
		local var_1_0

		var_1_0 = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_1_0)
			arg_1_1()
		end, arg_1_2, false)

		return nil
	end,
	registerDelayPressEvent = function(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		function arg_3_1:startDelayPressEvent()
			self._delay = 0
			self._freq = 0

			self:scheduleUpdateWithPriorityLua(function(arg_5_0)
				self._delay = self._delay + arg_5_0
				self._freq = self._freq + arg_5_0

				if self._delay < arg_3_2 then
					return
				end

				if self._freq > arg_3_3 then
					self._freq = 0

					arg_3_4()
				end
			end, 0)
		end

		function arg_3_1:stopDelayPressEvent()
			self._delay = 0
			self._freq = 0

			self:unscheduleUpdate()
		end
	end,
	performNodeWithDelay = function(self, arg_7_1, arg_7_2)
		if tolua.isnull(arg_7_1) then
			return
		end

		arg_7_1:setBright(false)
		self:performWithDelay(function()
			if tolua.isnull(arg_7_1) then
				return
			end

			arg_7_1:setBright(true)
		end, arg_7_2 or 0.5)
	end
}
local var_0_1 = "shaders/PositionNoMVP.vsh"
local var_0_2 = "attribute vec4 a_position;\nattribute vec2 a_texCoord;\nattribute vec4 a_color;  \n\n#ifdef GL_ES\n    varying lowp vec4 v_fragmentColor;\n    varying mediump vec2 v_texCoord;\n#else\n    varying vec4 v_fragmentColor;\n    varying vec2 v_texCoord;\n#endif \n\nvoid main()\n{\n    gl_Position = CC_PMatrix * a_position; \n    v_fragmentColor = a_color;\n    v_texCoord = a_texCoord;\n}\n"

function var_0_0.shaderNode(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = cc.GLProgram:createWithByteArrays(var_0_2, "    #ifdef GL_ES \n        precision mediump float;\n    #endif \n    varying vec4 v_fragmentColor; \n    varying vec2 v_texCoord; \n\n    void main(void) \n    { \n        vec4 c = texture2D(CC_Texture0, v_texCoord);\n        //gl_FragColor.rgb = vec3(0.3*c.r + 0.3*c.g +0.3*c.b);\n        gl_FragColor.xyz = vec3(0.2126*c.r + 0.7152*c.g + 0.0722*c.b);\n        gl_FragColor.w = c.a; \n    }    \n    ")

	var_9_0:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
	var_9_0:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR, cc.VERTEX_ATTRIB_COLOR)
	var_9_0:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD, cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
	var_9_0:link()
	var_9_0:updateUniforms()
	arg_9_1:setGLProgram(var_9_0)

	local function var_9_1(arg_10_0)
		arg_10_0:setGLProgram(var_9_0)

		for iter_10_0, iter_10_1 in pairs(arg_10_0:getChildren()) do
			var_9_1(iter_10_1)
		end
	end

	if arg_9_2 then
		var_9_1(arg_9_1)
	end
end

function var_0_0.shaderDarkNode(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = cc.GLProgram:createWithByteArrays(var_0_2, "    #ifdef GL_ES \n        precision mediump float;\n    #endif \n    varying vec4 v_fragmentColor; \n    varying vec2 v_texCoord;\n\n    void main(void) \n    { \n        vec4 c = texture2D(CC_Texture0, v_texCoord);\n        gl_FragColor = vec4(0.9*c.r, 0.9*c.g, 0.9*c.b, c.a);\n        gl_FragColor.w = c.w;\n    }\n    ")

	var_11_0:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
	var_11_0:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR, cc.VERTEX_ATTRIB_COLOR)
	var_11_0:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD, cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
	var_11_0:link()
	var_11_0:updateUniforms()
	arg_11_1:setGLProgram(var_11_0)

	local function var_11_1(arg_12_0)
		arg_12_0:setGLProgram(var_11_0)

		for iter_12_0, iter_12_1 in pairs(arg_12_0:getChildren()) do
			var_11_1(iter_12_1)
		end
	end

	if arg_11_2 then
		var_11_1(arg_11_1)
	end
end

function var_0_0.shaderDarkPicNode(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = cc.GLProgram:createWithByteArrays(var_0_2, "    #ifdef GL_ES \n        precision mediump float;\n    #endif \n    varying vec4 v_fragmentColor; \n    varying vec2 v_texCoord;\n    uniform vec3 colorRate; \n\n    void main(void) \n    { \n        vec4 c = texture2D(CC_Texture0, v_texCoord);\n        gl_FragColor = vec4(colorRate.x*c.r, colorRate.y*c.g, colorRate.z*c.b, c.a);\n        gl_FragColor.w = c.w;\n    }\n    ")

	var_13_0:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
	var_13_0:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR, cc.VERTEX_ATTRIB_COLOR)
	var_13_0:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD, cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
	var_13_0:link()
	cc.GLProgramState:getOrCreateWithGLProgram(var_13_0):setUniformVec3("colorRate", arg_13_2)
	var_13_0:updateUniforms()
	arg_13_1:setGLProgram(var_13_0)
end

function var_0_0.shaderGrayDark(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = cc.GLProgram:createWithByteArrays(var_0_2, "    #ifdef GL_ES \n        precision mediump float;\n    #endif \n    varying vec4 v_fragmentColor; \n    varying vec2 v_texCoord; \n\n    void main(void) \n    { \n        vec4 c = texture2D(CC_Texture0, v_texCoord);\n        //gl_FragColor.rgb = vec3(0.3*c.r + 0.3*c.g +0.3*c.b);\n        gl_FragColor.xyz = vec3(0.2126*c.r + 0.7152*c.g + 0.0722*c.b);\n        gl_FragColor.xyz *= 0.5;\n        gl_FragColor.w = c.a; \n    }    \n    ")

	var_14_0:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
	var_14_0:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR, cc.VERTEX_ATTRIB_COLOR)
	var_14_0:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD, cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
	var_14_0:link()
	var_14_0:updateUniforms()
	arg_14_1:setGLProgram(var_14_0)

	local function var_14_1(arg_15_0)
		arg_15_0:setGLProgram(var_14_0)

		for iter_15_0, iter_15_1 in pairs(arg_15_0:getChildren()) do
			var_14_1(iter_15_1)
		end
	end

	if arg_14_2 then
		var_14_1(arg_14_1)
	end
end

function var_0_0.shaderBlackShadowNode(arg_16_0, arg_16_1)
	local var_16_1 = cc.GLProgram:createWithByteArrays(var_0_2, pszFragSource)

	var_16_1:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
	var_16_1:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR, cc.VERTEX_ATTRIB_COLOR)
	var_16_1:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD, cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
	var_16_1:link()
	var_16_1:updateUniforms()
	arg_16_1:setGLProgram(var_16_1)
end

function var_0_0.recoverShader(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = cc.GLProgramState:getOrCreateWithGLProgram(cc.GLProgramCache:getInstance():getGLProgram("ShaderPositionTextureColor_noMVP"))

	arg_17_1:setGLProgramState(var_17_0)

	local function var_17_1(arg_18_0)
		arg_18_0:setGLProgramState(var_17_0)

		for iter_18_0, iter_18_1 in pairs(arg_18_0:getChildren()) do
			var_17_1(iter_18_1)
		end
	end

	if arg_17_2 then
		var_17_1(arg_17_1)
	end
end

function var_0_0.setHSLMode(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5, arg_19_6, arg_19_7)
	local var_19_0 = cc.GLProgram:createWithByteArrays(var_0_2, "    #ifdef GL_ES\n        precision mediump float;\n    #endif\n\n    varying vec2 v_texCoord;\n    uniform float u_dH;\n    uniform float u_dS;\n    uniform float u_dL;\n\n    void main() { \n        vec4 texColor = texture2D(CC_Texture0, v_texCoord); \n        float r = texColor.r; \n        float g = texColor.g; \n        float b = texColor.b; \n        float a = texColor.a; \n        //convert rgb to hsl \n        float h; \n        float s; \n        float l; \n        { \n            float max = max(max(r, g), b); \n            float min = min(min(r, g), b); \n            //----h \n            if (max == min){ \n                h = 0.0; \n            } \n            else if (max == r&&g >= b){ \n                h = 60.0*(g - b) / (max - min) + 0.0; \n            } \n            else if (max == r&&g < b){ \n                h = 60.0*(g - b) / (max - min) + 360.0; \n            } \n            else if (max == g){ \n                h = 60.0*(b - r) / (max - min) + 120.0; \n            } \n            else if (max == b){ \n                h = 60.0*(r - g) / (max - min) + 240.0; \n            } \n            //----l \n            l = 0.5*(max + min); \n            //----s \n            if (l == 0.0 || max == min){ \n                s = 0.0; \n            } \n            else if (0.0 <= l&&l <= 0.5){ \n                s = (max - min) / (2.0*l); \n            } \n            else if (l > 0.5){ \n                s = (max - min) / (2.0 - 2.0*l); \n            } \n        } \n        //(h,s,l)+(dH,dS,dL) -> (h,s,l) \n        h = h + u_dH; \n        s = min(1.0, max(0.0, s + u_dS)); \n        l = l + u_dL; \n        //convert (h,s,l) to rgb and got final color \n        vec4 finalColor; \n        //vec3 finalColor;\n        { \n            float q; \n            if (l < 0.5){ \n                q = l*(1.0 + s); \n            } \n            else if (l >= 0.5){ \n                q = l + s - l*s; \n            } \n            float p = 2.0*l - q; \n            float hk = h / 360.0; \n            \n            float t[3]; \n            t[0] = hk + 1.0 / 3.0; \n            t[1] = hk; \n            t[2] = hk - 1.0 / 3.0;  \n            \n            float c[3]; \n            for (int i = 0; i < 3; i++){ \n                if (t[i] < 0.0)t[i] += 1.0; \n                if (t[i] > 1.0)t[i] -= 1.0; \n                \n                if (t[i] < 1.0 / 6.0){ \n                    c[i] = p + ((q - p)*6.0*t[i]); \n                } \n                else if (1.0 / 6.0 <= t[i] && t[i] < 0.5){ \n                    c[i] = q; \n                } \n                else if (0.5 <= t[i] && t[i] < 2.0 / 3.0){ \n                    c[i] = p + ((q - p)*6.0*(2.0 / 3.0 - t[i])); \n                } \n                else{ \n                    c[i] = p; \n                }\n            } \n            finalColor = vec4(c[0], 0.8*c[1], c[2], a); \n            //finalColor = vec3(c[0], c[1], c[2]);\n        } \n        finalColor += vec4(u_dL, u_dL, u_dL, 0.0); \n        gl_FragColor = finalColor; \n    }\n    ")

	var_19_0:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
	var_19_0:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR, cc.VERTEX_ATTRIB_COLOR)
	var_19_0:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD, cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)

	local var_19_1 = cc.GLProgramState:getOrCreateWithGLProgram(var_19_0)

	var_19_1:setUniformFloat("u_dH", arg_19_2)
	var_19_1:setUniformFloat("u_dS", arg_19_3)
	var_19_1:setUniformFloat("u_dL", arg_19_4)
	arg_19_1:setGLProgramState(var_19_1)
end

function var_0_0.shakeNode(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = cc.GLProgram:createWithByteArrays(var_0_2, "    #ifdef GL_ES \n        precision highp float;\n    #endif \n    varying vec4 v_fragmentColor; \n    varying vec2 v_texCoord;\n\n    float nrand(in float x, in float y){\n        return fract(sin(dot(vec2(x, y), vec2(12.9898, 78.233)))*43758.5453);\n        //return fract(sin(dot(vec2(x, y), vec2(12.9898, 78.233)))*758.545);\n    }\n\n    uniform float uColorDrift;\n    uniform vec2 uScanLineJitter;\n\n    void main(void) \n    {\n        float u = v_texCoord.x;\n        float v = v_texCoord.y;\n        float jitter = nrand(v,0.0)*2.0 - 1.0;\n        float offsetParam = step(uScanLineJitter.y, abs(jitter));\n        float drift = uColorDrift;\n        jitter = jitter * offsetParam * uScanLineJitter.x;\n        vec4 color1 = texture2D(CC_Texture0, fract(vec2(u+jitter, v)));\n        vec4 color2 = texture2D(CC_Texture0, fract(vec2(u+jitter+drift*v, v)));\n        gl_FragColor = v_fragmentColor * vec4(color1.r, color2.g, color1.b, color1.a);\n    }\n    ")

	var_20_0:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
	var_20_0:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR, cc.VERTEX_ATTRIB_COLOR)
	var_20_0:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD, cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
	var_20_0:link()
	cc.GLProgramState:getOrCreateWithGLProgram(var_20_0):setUniformFloat("uColorDrift", 0)
	cc.GLProgramState:getOrCreateWithGLProgram(var_20_0):setUniformVec2("uScanLineJitter", cc.p(0, 1))
	var_20_0:updateUniforms()
	arg_20_1:setGLProgram(var_20_0)

	arg_20_2 = arg_20_2 or {}

	local var_20_1 = arg_20_2.shakeframe or 15
	local var_20_2 = arg_20_2.waitframe or 60
	local var_20_3 = arg_20_2.driftpixel or 10
	local var_20_4 = arg_20_2.driftfac or 2
	local var_20_5 = arg_20_2.scanlinedrift or 10
	local var_20_6 = arg_20_2.scanlinedriftfac or 5
	local var_20_7 = arg_20_2.scanlinethreshold or 0.025
	local var_20_8 = arg_20_2.restoreframe or 0
	local var_20_9 = 0
	local var_20_10 = math.sin
	local var_20_11 = math.cos
	local var_20_12 = 3.1415926

	arg_20_1:scheduleUpdateWithPriorityLua(function(arg_21_0)
		local var_21_0 = 0
		local var_21_1 = 1
		local var_21_2 = 0

		var_20_9 = var_20_9 + 1

		if var_20_9 > var_20_2 + var_20_1 then
			var_21_0 = var_20_5
			var_21_1 = var_20_1 > 0 and 1 - var_20_7 * var_20_1 + var_20_7 * (var_20_9 - var_20_2 - var_20_1) or 1 - var_20_7 * (var_20_2 + var_20_8 - var_20_9)

			if var_20_8 > 0 then
				var_21_0 = var_21_0 + var_20_6 * var_20_11((var_20_9 - var_20_2 - var_20_1) * var_20_12 * 0.5 / var_20_8)
				var_21_2 = var_20_3 - var_20_4 * var_20_10((var_20_9 - var_20_2 - var_20_1) * var_20_12 / var_20_8)
			end

			if var_20_9 > var_20_2 + var_20_1 + var_20_8 then
				var_20_9 = 0
			end
		elseif var_20_9 > var_20_2 then
			var_21_0 = var_20_5 + var_20_6 * var_20_11((var_20_9 - var_20_2 - var_20_1) * var_20_12 * 0.5 / var_20_1)
			var_21_1 = 1 - var_20_7 * (var_20_9 - var_20_2)
			var_21_2 = var_20_3 - var_20_4 * var_20_10((var_20_9 - var_20_2 - var_20_1) * var_20_12 / var_20_1)
		end

		arg_20_1:getGLProgramState():setUniformFloat("uColorDrift", var_21_2 / arg_20_1:getContentSize().width)
		arg_20_1:getGLProgramState():setUniformVec2("uScanLineJitter", cc.p(var_21_0 / arg_20_1:getContentSize().width, var_21_1))
	end, 0)
end

function var_0_0:removeNodeShake(arg_22_1)
	arg_22_1:unscheduleUpdate()
	self:recoverShader(arg_22_1)
end

function var_0_0.spriteOutline(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	arg_23_2 = arg_23_2 or cc.c4b(0, 0, 0, 255)
	arg_23_3 = arg_23_3 or cc.size(1, 1)

	local var_23_0 = cc.GLProgram:createWithByteArrays(var_0_2, "    #ifdef GL_ES\n        precision mediump float;\n    #endif\n    varying vec4 v_fragmentColor;\n    varying vec2 v_texCoord;\n\n    uniform vec4 uOutlineColor;\n    uniform vec2 uOutlineSize;\n\n    void main()\n    {\n        vec2 radius = uOutlineSize;\n        vec4 accum = vec4(0.0);\n        vec4 color = texture2D(CC_Texture0, v_texCoord);\n\n        accum += texture2D(CC_Texture0, vec2(v_texCoord.x - radius.x, v_texCoord.y - radius.x));\n        accum += texture2D(CC_Texture0, vec2(v_texCoord.x + radius.x, v_texCoord.y - radius.x));\n        accum += texture2D(CC_Texture0, vec2(v_texCoord.x + radius.x, v_texCoord.y + radius.x));\n        accum += texture2D(CC_Texture0, vec2(v_texCoord.x - radius.x, v_texCoord.y + radius.x));\n\n        accum *= 1.0;\n        accum = uOutlineColor * accum.a;\n\n        gl_FragColor = v_fragmentColor * (accum * (1.0 - color.a) + color * color.a);\n    }\n    ")

	var_23_0:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
	var_23_0:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR, cc.VERTEX_ATTRIB_COLOR)
	var_23_0:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD, cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
	var_23_0:link()
	cc.GLProgramState:getOrCreateWithGLProgram(var_23_0):setUniformVec2("uOutlineSize", cc.p(arg_23_3.width / arg_23_1:getContentSize().width, arg_23_3.height / arg_23_1:getContentSize().height))
	cc.GLProgramState:getOrCreateWithGLProgram(var_23_0):setUniformVec4("uOutlineColor", {
		x = arg_23_2.r / 255,
		y = arg_23_2.g / 255,
		z = arg_23_2.b / 255,
		w = arg_23_2.a / 255
	})
	var_23_0:updateUniforms()
	arg_23_1:setGLProgram(var_23_0)
end

function var_0_0.spriteOutGlow(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	arg_24_2 = arg_24_2 or cc.c4b(255, 255, 255, 255)
	arg_24_3 = arg_24_3 or 25

	local var_24_0 = cc.GLProgram:createWithByteArrays(var_0_2, "    #ifdef GL_ES\n    precision mediump float;\n    #endif\n\n    varying vec4 v_fragmentColor;\n    varying vec2 v_texCoord;\n\n    uniform vec2 resolution;\n    uniform float u_radius;\n    uniform float uGlowColr_r;\n    uniform float uGlowColr_g;\n    uniform float uGlowColr_b;\n    uniform float uGlowColr_a;\n\n    vec4 blur(vec2 p)\n    {\n        if (u_radius > 0.0)\n        {\n            vec4 col = vec4(0);\n            vec2 unit = 1.0 / resolution.xy;\n            \n            float r = u_radius;\n            float sampleNum = 10.0;\n            float sampleStep = r / sampleNum;\n            \n            float count = 0.0;\n            \n            for(float x = -r; x < r; x += sampleStep)\n            {\n                for(float y = -r; y < r; y += sampleStep)\n                {\n                    float weight = (r - abs(x)) * (r - abs(y));\n                    col += texture2D(CC_Texture0, p + vec2(x * unit.x, y * unit.y)) * weight;\n                    count += weight;\n                }\n            }\n            \n            return col / count;\n        }\n        \n        return texture2D(CC_Texture0, p);\n    }\n\n    float highlight(vec4 color)\n    {\n        float intensityoffset = 1.0;\n        float intensityscale = 2.0;\n        float gray = dot(color.rgb, vec3(0.3, 0.59, 0.11));\n        return (gray + intensityoffset) * intensityscale;\n    }\n\n\n    void mainImage( out vec4 fragColor, in vec2 fragCoord )\n    {\n        vec2 uv = v_texCoord;\n    \n        vec4 t = vec4(uGlowColr_a, uGlowColr_g, uGlowColr_b, uGlowColr_a);\n    \n        vec4 color = texture2D(CC_Texture0, uv);\n        vec4 gauss = blur(uv);\n        gauss = gauss * highlight(gauss) * t;\n    \n        fragColor = v_fragmentColor * (gauss * (1.0 - color.a) + color * color.a);\n    }\n    \n    void main(void)\n    {\n        mainImage(gl_FragColor, gl_FragCoord.xy);\n    }\n    ")

	var_24_0:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
	var_24_0:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR, cc.VERTEX_ATTRIB_COLOR)
	var_24_0:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD, cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
	var_24_0:link()
	cc.GLProgramState:getOrCreateWithGLProgram(var_24_0):setUniformVec2("resolution", cc.p(arg_24_1:getContentSize().width, arg_24_1:getContentSize().height))
	cc.GLProgramState:getOrCreateWithGLProgram(var_24_0):setUniformFloat("u_radius", arg_24_3)
	cc.GLProgramState:getOrCreateWithGLProgram(var_24_0):setUniformFloat("uGlowColr_r", arg_24_2.r / 255)
	cc.GLProgramState:getOrCreateWithGLProgram(var_24_0):setUniformFloat("uGlowColr_g", arg_24_2.g / 255)
	cc.GLProgramState:getOrCreateWithGLProgram(var_24_0):setUniformFloat("uGlowColr_b", arg_24_2.b / 255)
	cc.GLProgramState:getOrCreateWithGLProgram(var_24_0):setUniformFloat("uGlowColr_a", arg_24_2.a / 255)
	var_24_0:updateUniforms()
	arg_24_1:setGLProgram(var_24_0)
end

function var_0_0.flowlightNode(arg_25_0, arg_25_1, arg_25_2)
	arg_25_2 = arg_25_2 or {}

	local var_25_0 = arg_25_2.width or 0.02
	local var_25_1 = arg_25_2.period or 2.221776944837341
	local var_25_2 = arg_25_2.strength or 0.006
	local var_25_3 = arg_25_2.offset or 0.5
	local var_25_4 = cc.GLProgram:createWithByteArrays(var_0_2, "    #ifdef GL_ES\n        //precision mediump float;\n        precision highp float;\n    #endif\n    varying vec4 v_fragmentColor;\n    varying vec2 v_texCoord;\n\n    #define pi 3.1415926\n\n    uniform float u_width;\n    uniform float u_period;\n    uniform float u_strength;\n    uniform float u_offset;\n\n    void main()\n    {\n        float time = CC_Time[1];\n        vec4 color = texture2D(CC_Texture0, v_texCoord);\n        float width = u_width;\n        float start = tan(time*pi/u_period);\n        float strength = u_strength;\n        float offset = u_offset;\n        if ( v_texCoord.x < (start - offset * v_texCoord.y) && v_texCoord.x > (start - offset * v_texCoord.y - width))\n        {\n            vec3 improve = strength * vec3(255, 255, 255);\n            vec3 result = improve * vec3(color.r, color.g, color.b);\n            gl_FragColor = v_fragmentColor*vec4(result, color.a);\n        } else {\n            gl_FragColor = v_fragmentColor*color;\n        }\n    }    \n    ")

	var_25_4:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
	var_25_4:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR, cc.VERTEX_ATTRIB_COLOR)
	var_25_4:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD, cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
	var_25_4:link()
	cc.GLProgramState:getOrCreateWithGLProgram(var_25_4):setUniformFloat("u_width", var_25_0)
	cc.GLProgramState:getOrCreateWithGLProgram(var_25_4):setUniformFloat("u_period", var_25_1)
	cc.GLProgramState:getOrCreateWithGLProgram(var_25_4):setUniformFloat("u_strength", var_25_2)
	cc.GLProgramState:getOrCreateWithGLProgram(var_25_4):setUniformFloat("u_offset", var_25_3)
	var_25_4:updateUniforms()
	arg_25_1:setGLProgram(var_25_4)
end

function var_0_0:removeNodeFlowlight(arg_26_1)
	self:recoverShader(arg_26_1)
end

function var_0_0.waterflowNode(arg_27_0, arg_27_1)
	local var_27_0 = cc.GLProgram:createWithByteArrays(var_0_2, "    #ifdef GL_ES\n        precision mediump float;\n    #endif\n    varying vec4 v_fragmentColor;\n    varying vec2 v_texCoord;\n\n    #define F cos(x-y)*cos(x),sin(x+y)*sin(y)\n\n    uniform vec2 resolution;\n\n    vec2 s(vec2 p, float time)\n    {\n        float d=time*0.2,x=8.*(p.x+d),y=8.*(p.y+d);\n        return vec2(F);\n    }\n\n    void mainImage( out vec4 fragColor, in vec2 fragCoord )\n    {\n        float time = CC_Time[1];\n        vec2 rs = resolution.xy;\n        vec2 uv = v_texCoord.xy;\n        vec2 q = uv+2./resolution.x*(s(uv, time)-s(uv+rs, time));\n        //反转y\n        // q.y = 1.-q.y;\n        fragColor = texture2D(CC_Texture0, q);\n    }\n\n    void main()\n    {\n        mainImage(gl_FragColor, gl_FragCoord.xy);\n    }\n    ")

	var_27_0:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
	var_27_0:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR, cc.VERTEX_ATTRIB_COLOR)
	var_27_0:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD, cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
	var_27_0:link()
	cc.GLProgramState:getOrCreateWithGLProgram(var_27_0):setUniformVec2("resolution", cc.p(arg_27_1:getContentSize().width, arg_27_1:getContentSize().height))
	var_27_0:updateUniforms()
	arg_27_1:setGLProgram(var_27_0)
end

function var_0_0:removeNodeWaterflow(arg_28_1)
	self:recoverShader()
end

function var_0_0.gaussBlursNode(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = cc.GLProgram:createWithByteArrays(var_0_2, "    #ifdef GL_ES\n        precision highp float;\n    #endif\n    varying vec2 v_texCoord;\n    uniform float bluramount;\n\n    vec4 draw(vec2 uv) {\n        return texture2D(CC_Texture0, uv).rgba;\n    }\n\n    float grid(float var, float size) {\n        return floor(var*size)/size;\n    }\n\n    float nrand(in float x, in float y){\n        return fract(sin(dot(vec2(x, y), vec2(12.9898, 78.233)))*43758.5453);\n        //return fract(sin(dot(vec2(x, y), vec2(12.9898, 78.233)))*758.545);\n    }\n\n    void mainImage( out vec4 fragColor, in vec2 fragCoord )\n    {\n        vec2 uv = v_texCoord.xy;\n        vec4 blurred_image = vec4(0.);\n\n        vec2 q = vec2(cos(degrees((0./5.)*360.)), sin(degrees((0./5.)*360.))) * (nrand(0., uv.x+uv.y)+bluramount);\n        vec2 uv2 = uv+(q*bluramount);\n        blurred_image += draw(uv2)/2;\n        q = vec2(cos(degrees((0./5.)*360.)), sin(degrees((0./5.)*360.))) * (nrand(0.+2., uv.x+uv.y+24.)+bluramount);\n        uv2 = uv+(q*bluramount);\n        blurred_image += draw(uv2)/2.;\n\n        q = vec2(cos(degrees((1./5.)*360.)), sin(degrees((1./5.)*360.))) * (nrand(1., uv.x+uv.y)+bluramount);\n        uv2 = uv+(q*bluramount);\n        blurred_image += draw(uv2)/2;\n        q = vec2(cos(degrees((1./5.)*360.)), sin(degrees((1./5.)*360.))) * (nrand(1.+2., uv.x+uv.y+24.)+bluramount);\n        uv2 = uv+(q*bluramount);\n        blurred_image += draw(uv2)/2.;\n\n        q = vec2(cos(degrees((2./5.)*360.)), sin(degrees((2./5.)*360.))) * (nrand(2., uv.x+uv.y)+bluramount);\n        uv2 = uv+(q*bluramount);\n        blurred_image += draw(uv2)/2;\n        q = vec2(cos(degrees((2./5.)*360.)), sin(degrees((2./5.)*360.))) * (nrand(2.+2., uv.x+uv.y+24.)+bluramount);\n        uv2 = uv+(q*bluramount);\n        blurred_image += draw(uv2)/2.;\n\n        q = vec2(cos(degrees((3./5.)*360.)), sin(degrees((3./5.)*360.))) * (nrand(3., uv.x+uv.y)+bluramount);\n        uv2 = uv+(q*bluramount);\n        blurred_image += draw(uv2)/2;\n        q = vec2(cos(degrees((3./5.)*360.)), sin(degrees((3./5.)*360.))) * (nrand(3.+2., uv.x+uv.y+24.)+bluramount);\n        uv2 = uv+(q*bluramount);\n        blurred_image += draw(uv2)/2.;\n\n        q = vec2(cos(degrees((4./5.)*360.)), sin(degrees((4./5.)*360.))) * (nrand(4., uv.x+uv.y)+bluramount);\n        uv2 = uv+(q*bluramount);\n        blurred_image += draw(uv2)/2;\n        q = vec2(cos(degrees((4./5.)*360.)), sin(degrees((4./5.)*360.))) * (nrand(4.+2., uv.x+uv.y+24.)+bluramount);\n        uv2 = uv+(q*bluramount);\n        blurred_image += draw(uv2)/2.;\n\n        blurred_image /= 5.0;\n        fragColor = vec4(blurred_image);\n    }\n\n    void main()\n    {\n        mainImage(gl_FragColor, gl_FragCoord.xy);\n    }\n    ")

	var_29_0:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
	var_29_0:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR, cc.VERTEX_ATTRIB_COLOR)
	var_29_0:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD, cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
	var_29_0:link()
	cc.GLProgramState:getOrCreateWithGLProgram(var_29_0):setUniformFloat("bluramount", arg_29_2 or 0.02)
	var_29_0:updateUniforms()
	arg_29_1:setGLProgram(var_29_0)
end

function var_0_0.blursNode(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = cc.GLProgram:createWithByteArrays(var_0_2, "    #ifdef GL_ES\n    precision mediump float;\n    #endif\n\n    varying vec4 v_fragmentColor;\n    varying vec2 v_texCoord;\n\n    uniform vec2 resolution;\n    uniform float blurRadius;\n    uniform float sampleNum;\n\n    vec4 blur(vec2);\n\n    void main(void)\n    {\n        vec4 col = blur(v_texCoord); //* v_fragmentColor.rgb;\n        gl_FragColor = vec4(col) * v_fragmentColor;\n    }\n\n    vec4 blur(vec2 p)\n    {\n        if (blurRadius > 0.0 && sampleNum > 1.0)\n        {\n            vec4 col = vec4(0);\n            vec2 unit = 1.0 / resolution.xy;\n            \n            float r = blurRadius;\n            float sampleStep = r / sampleNum;\n            \n            float count = 0.0;\n            \n            for(float x = -r; x < r; x += sampleStep)\n            {\n                for(float y = -r; y < r; y += sampleStep)\n                {\n                    float weight = (r - abs(x)) * (r - abs(y));\n                    col += texture2D(CC_Texture0, p + vec2(x * unit.x, y * unit.y)) * weight;\n                    count += weight;\n                }\n            }\n            \n            return col / count;\n        }\n        \n        return texture2D(CC_Texture0, p);\n    }\n    ")

	var_30_0:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
	var_30_0:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR, cc.VERTEX_ATTRIB_COLOR)
	var_30_0:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD, cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
	var_30_0:link()
	cc.GLProgramState:getOrCreateWithGLProgram(var_30_0):setUniformVec2("resolution", cc.p(arg_30_1:getContentSize().width, arg_30_1:getContentSize().height))
	cc.GLProgramState:getOrCreateWithGLProgram(var_30_0):setUniformFloat("blurRadius", arg_30_2)
	cc.GLProgramState:getOrCreateWithGLProgram(var_30_0):setUniformFloat("sampleNum", arg_30_3)
	var_30_0:updateUniforms()
	arg_30_1:setGLProgram(var_30_0)
end

function var_0_0.celShadingNode(arg_31_0, arg_31_1)
	local var_31_0 = cc.GLProgram:createWithFilenames(var_0_1, "shaders/CelShading.fsh")

	var_31_0:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
	var_31_0:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR, cc.VERTEX_ATTRIB_COLOR)
	var_31_0:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD, cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
	var_31_0:link()
	cc.GLProgramState:getOrCreateWithGLProgram(var_31_0):setUniformVec2("resolution", cc.p(arg_31_1:getContentSize().width, arg_31_1:getContentSize().height))
	var_31_0:updateUniforms()
	arg_31_1:setGLProgram(var_31_0)
end

function var_0_0.addColorBar(arg_32_0, arg_32_1)
	local var_32_0 = cc.GLProgram:createWithFilenames("shaders/ColorBars.vsh", "shaders/ColorBars.fsh")

	var_32_0:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
	var_32_0:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR, cc.VERTEX_ATTRIB_COLOR)
	var_32_0:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD, cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
	var_32_0:link()
	var_32_0:updateUniforms()
	arg_32_1:setGLProgram(var_32_0)
end

function var_0_0.addNoisy(arg_33_0, arg_33_1)
	local var_33_0 = cc.GLProgram:createWithFilenames(var_0_1, "shaders/Noisy.fsh")

	var_33_0:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
	var_33_0:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR, cc.VERTEX_ATTRIB_COLOR)
	var_33_0:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD, cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
	var_33_0:link()
	cc.GLProgramState:getOrCreateWithGLProgram(var_33_0):setUniformVec2("resolution", cc.p(arg_33_1:getContentSize().width, arg_33_1:getContentSize().height))
	var_33_0:updateUniforms()
	arg_33_1:setGLProgram(var_33_0)
end

function var_0_0.sepiaNode(arg_34_0, arg_34_1)
	local var_34_0 = cc.GLProgram:createWithFilenames(var_0_1, "shaders/Sepia.fsh")

	var_34_0:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
	var_34_0:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR, cc.VERTEX_ATTRIB_COLOR)
	var_34_0:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD, cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
	var_34_0:link()
	var_34_0:updateUniforms()
	arg_34_1:setGLProgram(var_34_0)
end

function var_0_0.maskNode(arg_35_0, arg_35_1)
	local var_35_0 = cc.GLProgram:createWithByteArrays(var_0_2, "    #ifdef GL_ES\n        precision mediump float;\n    #endif\n    varying vec4 v_fragmentColor;\n    varying vec2 v_texCoord;\n    \n    uniform vec2 resolution;\n\n    // SNOISE function from: https://www.shadertoy.com/view/lsf3RH\n    float snoise(vec3 uv, float res)\n    {\n        const vec3 s = vec3(1e0, 1e2, 1e3);\n        \n        uv *= res;\n        \n        vec3 uv0 = floor(mod(uv, res))*s;\n        vec3 uv1 = floor(mod(uv+vec3(1.), res))*s;\n        \n        vec3 f = fract(uv); f = f*f*(3.0-2.0*f);\n    \n        vec4 v = vec4(uv0.x+uv0.y+uv0.z, uv1.x+uv0.y+uv0.z,\n                      uv0.x+uv1.y+uv0.z, uv1.x+uv1.y+uv0.z);\n    \n        vec4 r = fract(sin(v*1e-1)*1e3);\n        float r0 = mix(mix(r.x, r.y, f.x), mix(r.z, r.w, f.x), f.y);\n        \n        r = fract(sin((v + uv1.z - uv0.z)*1e-1)*1e3);\n        float r1 = mix(mix(r.x, r.y, f.x), mix(r.z, r.w, f.x), f.y);\n        \n        return mix(r0, r1, f.z)*2.-1.;\n    }\n\n    float noise(vec2 uv, float baseres)\n    {\n        float n = 0.0;\n        for (int i = 0; i < 4; i++)\n        {\n            float v = pow(2.0, float(i));\n            n += (1.5 / v) * snoise(vec3(uv + vec2(1.,1.) * (float(i) / 17.), 1), v * baseres);\n        }\n        \n        \n        return clamp((1.0 - n) * .5, 0., 1.) * 2.0;\n    }\n\n    void mainImage( out vec4 fragColor, in vec2 fragCoord )\n    {\n        float iTime = CC_Time[1];\n    \n        float aspectRatio = resolution.y/resolution.x;\n        vec2 uv = v_texCoord;\n        uv.y *= aspectRatio;\n        \n        // Tweaking vars\n        vec4 color = vec4(0.125, 0.291, 0.923, 1.0);\n        vec4 leaving = vec4(0.925, 0.791, 0.323, 1.0);\n        float noise_sz = 7.0f;\n        float speed = 0.4;\n        vec2 center = vec2(0.5, 0.5 * aspectRatio);\n        \n        float dc = 1. - (distance(uv, center) * 2.75);\n        float pdc = pow(dc, 3.5);\n        \n        vec2 dir = -normalize(uv - center) * speed;\n        \n        float phase0 = fract(iTime * 0.3 + 0.5);\n        float phase1 = fract(iTime * 0.3 + 0.0);\n        \n        vec2 uv0 = uv + phase0 * dir;\n        vec2 uv1 = uv + phase1 * dir;\n        \n        // Rotation\n        float as = pdc * sin(iTime * 0.9) * 1.2;\n        float ca = cos(as);\n        float sa = sin(as);                 \n        \n        mat2 rot;\n        rot[0] = vec2(ca, -sa);\n        rot[1] = vec2(sa, ca);\n        \n        uv0 = center + ((uv0 - center) * rot);\n        uv1 = center + ((uv1 - center) * rot);\n    \n        // Samplings\n        float tex0 = max(noise(uv0, noise_sz), noise(uv0 * 1.2, noise_sz));\n        float tex1 = max(noise(uv1, noise_sz), noise(uv1 * 1.4, noise_sz));\n        \n        float lerp = abs((0.5 - phase0) / 0.5);\n        float samplings = mix(tex0, tex1, lerp);\n        \n        vec4 c = vec4(samplings, samplings, samplings, 1.0) * mix(color, leaving, pdc) * pdc;\n        c += pow(dc, 16.0) * mix(color, leaving, pow(dc, 16.0)) * 2.3;\n        \n        float cl = clamp(max(c.r, max(c.g, c.b)), 0.0, 1.0);\n        \n        c.rgb += texture2D(CC_Texture0, v_texCoord).rgb * cl;\n        \n        // Output to screen\n        fragColor = c;\n        fragColor.a = cl;\n    }\n    \n    void main()\n    {\n        mainImage(gl_FragColor, gl_FragCoord.xy);\n    }\n    ")

	var_35_0:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
	var_35_0:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR, cc.VERTEX_ATTRIB_COLOR)
	var_35_0:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD, cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
	var_35_0:link()
	cc.GLProgramState:getOrCreateWithGLProgram(var_35_0):setUniformVec2("resolution", cc.p(arg_35_1:getContentSize().width, arg_35_1:getContentSize().height))
	var_35_0:updateUniforms()
	arg_35_1:setGLProgram(var_35_0)
end

function var_0_0.numberlabelRandomAction(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4, arg_36_5)
	arg_36_3 = arg_36_3 or 0.5
	arg_36_4 = arg_36_4 or "linear"
	arg_36_5 = arg_36_5 or 10

	local function var_36_0()
		return (string.gsub(string.gsub(arg_36_2, "[^%d]", ""), "%d", function()
			return tostring(math.random(0, 9))
		end))
	end

	arg_36_1:setString(var_36_0())

	local var_36_1 = {
		time = 0
	}
	local var_36_2 = require("fight.tween").new(arg_36_3, var_36_1, {
		time = arg_36_5
	}, arg_36_4)
	local var_36_3 = 0

	arg_36_1:scheduleUpdateWithPriorityLua(function(arg_39_0)
		if var_36_2:update(arg_39_0) then
			arg_36_1:setString(arg_36_2)
			arg_36_1:unscheduleUpdate()
		elseif math.floor(var_36_1.time) ~= math.floor(var_36_3) then
			arg_36_1:setString(var_36_0())

			var_36_3 = var_36_1.time
		end
	end, 0)
end

function var_0_0.showStrPerChar(arg_40_0, arg_40_1, arg_40_2, arg_40_3, arg_40_4, arg_40_5)
	local utf8 = require("controller.utf8")
	local var_40_1 = utf8.len(arg_40_2)

	arg_40_3 = arg_40_3 or var_40_1 * arg_40_4
	arg_40_5 = arg_40_5 or "linear"

	local var_40_2 = {
		pos = 0
	}
	local var_40_3 = require("fight.tween").new(arg_40_3, var_40_2, {
		pos = var_40_1
	}, arg_40_5)
	local var_40_4 = 0

	arg_40_1:scheduleUpdateWithPriorityLua(function(arg_41_0)
		if var_40_3:update(arg_41_0) then
			arg_40_1:setString(arg_40_2)
			arg_40_1:unscheduleUpdate()
		elseif math.floor(var_40_2.pos) ~= math.floor(var_40_4) then
			arg_40_1:setString(utf8.sub(arg_40_2, 1, (math.floor(var_40_2.pos))))

			var_40_4 = var_40_2.pos
		end
	end, 0)
end

function var_0_0.captureScreenGaussBlur(arg_42_0, arg_42_1, arg_42_2)
	arg_42_2 = arg_42_2 or "CaptureScreen/" .. os.time()

	cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("cleanTouchEffect"))
	cc.utils:captureScreenGaussBlur(function(arg_43_0, arg_43_1)
		if arg_43_0 then
			local var_43_0 = cc.Sprite:createWithTexture(arg_43_1)

			var_43_0:setScaleX(GameDisplay.width / var_43_0:getContentSize().width)
			var_43_0:setScaleY((GameDisplay.height + GameDisplay.statusbar_height) / var_43_0:getContentSize().height)
			var_43_0:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy + GameDisplay.statusbar_height / 2))

			if arg_42_1 then
				arg_42_1(var_43_0)
			end
		elseif arg_42_1 then
			arg_42_1((cc.LayerColor:create(cc.c4b(0, 0, 0, 153), GameDisplay.width, GameDisplay.height)))
		end
	end, arg_42_2)
end

function var_0_0.fadeNode(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4, arg_44_5, arg_44_6, arg_44_7)
	arg_44_2 = arg_44_2 or 0.8
	arg_44_3 = arg_44_3 or 1
	arg_44_4 = arg_44_4 or 1
	arg_44_5 = arg_44_5 or 0
	arg_44_6 = arg_44_6 or 1
	arg_44_7 = arg_44_7 or 0

	arg_44_1:setBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)

	local var_44_0 = cc.GLProgram:createWithByteArrays(var_0_2, "    #ifdef GL_ES \n        precision mediump float;\n    #endif \n    varying vec4 v_fragmentColor; \n    varying vec2 v_texCoord;\n\n\n    void main(void) \n    {\n        vec4 c = texture2D(CC_Texture0, v_texCoord);\n        float u = 1 - smoothstep(0.5, 0.9, v_texCoord.x);\n        gl_FragColor = v_fragmentColor * c * u; \n    }\n    ")

	var_44_0:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
	var_44_0:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR, cc.VERTEX_ATTRIB_COLOR)
	var_44_0:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD, cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
	var_44_0:link()
	var_44_0:updateUniforms()
	arg_44_1:setGLProgram(var_44_0)
end

function var_0_0.circularCilpNode(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	local var_45_0 = cc.GLProgram:createWithFilenames(var_0_1, "shaders/CircularCilpNode.fsh")

	var_45_0:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
	var_45_0:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR, cc.VERTEX_ATTRIB_COLOR)
	var_45_0:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD, cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
	var_45_0:link()
	cc.GLProgramState:getOrCreateWithGLProgram(var_45_0):setUniformVec2("resolution", cc.p(arg_45_1:getContentSize().width, arg_45_1:getContentSize().height))
	cc.GLProgramState:getOrCreateWithGLProgram(var_45_0):setUniformFloat("radius", arg_45_2 or 100)
	cc.GLProgramState:getOrCreateWithGLProgram(var_45_0):setUniformVec2("circleCenter", arg_45_3 or cc.p(arg_45_1:getContentSize().width / 2, arg_45_1:getContentSize().height / 2))
	var_45_0:updateUniforms()
	arg_45_1:setGLProgram(var_45_0)
end

return var_0_0
