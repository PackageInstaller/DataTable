local BrokenNode = class("BrokenNode", function()
	return cc.Sprite:create()
end)
local var_0_1 = "tilemap/chaizhi/"
local var_0_2 = "tilemap/chaizhi/grey.png"

local function var_0_3(arg_2_0)
	if not arg_2_0 then
		return nil
	end

	local var_2_0 = arg_2_0

	if not arg_2_0:find(var_0_1) then
		var_2_0 = var_0_1 .. var_2_0
	end

	if not arg_2_0:find(".png$") then
		var_2_0 = var_2_0 .. ".png"
	end

	return var_2_0
end

function BrokenNode:create(arg_3_1, arg_3_2, arg_3_3)
	print("filenamefilenamefilenamefilenamefilename", arg_3_1)

	local var_3_0 = BrokenNode.new()

	var_3_0:init(arg_3_1, arg_3_2, arg_3_3)

	return var_3_0
end

function BrokenNode:init(arg_4_1, arg_4_2, arg_4_3)
	self._normalfile = var_0_3(arg_4_1)

	self:setTexture(self._normalfile)

	self._brokenfile = var_0_3(arg_4_2) or var_0_3("broken_" .. arg_4_1)

	if not cc.FileUtils:getInstance():isFileExist(self._brokenfile) then
		self._brokenfile = nil
	end

	self._grayfile = var_0_3(arg_4_3) or var_0_3("grey_" .. arg_4_1)

	if not cc.FileUtils:getInstance():isFileExist(self._grayfile) then
		self._grayfile = var_0_2
	end

	self._needbreak = self._brokenfile ~= nil
	self._threshold = -0.2
	self._isbroken = false

	self:initNodeShader()
end

function BrokenNode:initNodeShader()
	if not self._needbreak then
		return
	end

	self:initBrokenShader()
end

local var_0_4 = "attribute vec4 a_position;\nattribute vec2 a_texCoord;\nattribute vec4 a_color;  \n\n#ifdef GL_ES\n    varying lowp vec4 v_fragmentColor;\n    varying mediump vec2 v_texCoord;\n#else\n    varying vec4 v_fragmentColor;\n    varying vec2 v_texCoord;\n#endif \n\nvoid main()\n{\n    gl_Position = CC_PMatrix * a_position; \n    v_fragmentColor = a_color;\n    v_texCoord = a_texCoord;\n}\n"

function BrokenNode:initBrokenShader()
	local var_6_0 = cc.GLProgram:createWithByteArrays(var_0_4, "    #ifdef GL_ES \n        precision mediump float;\n    #endif \n    varying vec4 v_fragmentColor; \n    varying vec2 v_texCoord;\n\n    uniform sampler2D broken;\n    uniform sampler2D gray;\n    uniform float threshold;\n\n    void main(void) \n    { \n        vec2 uv = v_texCoord.xy;\n\n        vec4 c1 = texture2D(CC_Texture0, uv);\n        vec4 c2 = texture2D(broken, uv);\n        vec4 c3 = texture2D(gray, uv);\n\n        float t = c3.r;\n        float cl = step(t, threshold);\n\n        gl_FragColor = c1 * (1.0 - cl) + c2 * cl;\n    }\n    ")

	var_6_0:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
	var_6_0:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR, cc.VERTEX_ATTRIB_COLOR)
	var_6_0:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD, cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
	var_6_0:link()
	var_6_0:updateUniforms()
	cc.GLProgramState:getOrCreateWithGLProgram(var_6_0):setUniformTexture("broken", (cc.Director:getInstance():getTextureCache():addImage(self._brokenfile)))
	cc.GLProgramState:getOrCreateWithGLProgram(var_6_0):setUniformTexture("gray", (cc.Director:getInstance():getTextureCache():addImage(self._grayfile)))
	cc.GLProgramState:getOrCreateWithGLProgram(var_6_0):setUniformFloat("threshold", self._threshold)
	self:setGLProgram(var_6_0)
end

function BrokenNode:stopAni()
	self:unscheduleUpdate()
end

function BrokenNode:switchBroken()
	if not self._needbreak then
		return
	end

	if self._isbroken then
		return
	end

	self._threshold = 1

	self:getGLProgramState():setUniformFloat("threshold", self._threshold)

	self._isbroken = true
end

function BrokenNode:runBreak(arg_9_1)
	if not self._needbreak then
		return
	end

	if self._isbroken then
		return
	end

	self:stopAni()

	local var_9_0 = {
		threshold = -0.2
	}
	local var_9_1 = require("fight.tween").new(1, var_9_0, {
		threshold = 1
	}, "inQuart")

	self:scheduleUpdateWithPriorityLua(function(arg_10_0)
		if var_9_1:update(arg_10_0) then
			self:stopAni()

			if arg_9_1 then
				arg_9_1()
			end
		end

		self._threshold = var_9_0.threshold

		self:getGLProgramState():setUniformFloat("threshold", self._threshold)
	end, 0)

	self._isbroken = true
end

return BrokenNode
