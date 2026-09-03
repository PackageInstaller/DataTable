-- chunkname: @/tmp/or_script/lua_compile/cocos/cocos2d/Opengl.lua

if not gl then
	return
end

function gl.createTexture()
	local retTable = {}

	retTable.texture_id = gl._createTexture()

	return retTable
end

function gl.createBuffer()
	local retTable = {}

	retTable.buffer_id = gl._createBuffer()

	return retTable
end

function gl.createRenderbuffer()
	local retTable = {}

	retTable.renderbuffer_id = gl._createRenderuffer()

	return retTable
end

function gl.createFramebuffer()
	local retTable = {}

	retTable.framebuffer_id = gl._createFramebuffer()

	return retTable
end

function gl.createProgram()
	local retTable = {}

	retTable.program_id = gl._createProgram()

	return retTable
end

function gl.createShader(shaderType)
	local retTable = {}

	retTable.shader_id = gl._createShader(shaderType)

	return retTable
end

function gl.deleteTexture(texture)
	local texture_id = 0

	if type(texture) == "number" then
		texture_id = texture
	elseif type(texture) == "table" then
		texture_id = texture.texture_id
	end

	gl._deleteTexture(texture_id)
end

function gl.deleteBuffer(buffer)
	local buffer_id = 0

	if type(buffer) == "number" then
		buffer_id = buffer
	elseif type(buffer) == "table" then
		buffer_id = buffer.buffer_id
	end

	gl._deleteBuffer(buffer_id)
end

function gl.deleteRenderbuffer(buffer)
	local renderbuffer_id = 0

	if type(buffer) == "number" then
		renderbuffer_id = buffer
	elseif type(buffer) == "table" then
		renderbuffer_id = buffer.renderbuffer_id
	end

	gl._deleteRenderbuffer(renderbuffer_id)
end

function gl.deleteFramebuffer(buffer)
	local framebuffer_id = 0

	if type(buffer) == "number" then
		framebuffer_id = buffer
	elseif type(buffer) == "table" then
		framebuffer_id = buffer.framebuffer_id
	end

	gl._deleteFramebuffer(framebuffer_id)
end

function gl.deleteProgram(program)
	local program_id = 0

	if type(buffer) == "number" then
		program_id = program
	elseif type(program) == "table" then
		program_id = program.program_id
	end

	gl._deleteProgram(program_id)
end

function gl.deleteShader(shader)
	local shader_id = 0

	if type(shader) == "number" then
		shader_id = shader
	elseif type(shader) == "table" then
		shader_id = shader.shader_id
	end

	gl._deleteShader(shader_id)
end

function gl.bindTexture(target, texture)
	local texture_id = 0

	if type(texture) == "number" then
		texture_id = texture
	elseif type(texture) == "table" then
		texture_id = texture.texture_id
	end

	gl._bindTexture(target, texture_id)
end

function gl.bindBuffer(target, buffer)
	local buffer_id = 0

	if type(buffer) == "number" then
		buffer_id = buffer
	elseif type(buffer) == "table" then
		buffer_id = buffer.buffer_id
	end

	gl._bindBuffer(target, buffer_id)
end

function gl.bindRenderBuffer(target, buffer)
	local buffer_id = 0

	if type(buffer) == "number" then
		buffer_id = buffer
	elseif type(buffer) == "table" then
		buffer_id = buffer.buffer_id
	end

	gl._bindRenderbuffer(target, buffer_id)
end

function gl.bindFramebuffer(target, buffer)
	local buffer_id = 0

	if type(buffer) == "number" then
		buffer_id = buffer
	elseif type(buffer) == "table" then
		buffer_id = buffer.buffer_id
	end

	gl._bindFramebuffer(target, buffer_id)
end

function gl.getUniform(program, location)
	local program_id = 0

	program_id = type(program) == "number" and program or program.program_id

	return gl._getUniform(program_id, type(location) == "number" and location or location.location_id)
end

function gl.compileShader(shader)
	gl._compileShader(shader.shader_id)
end

function gl.shaderSource(shader, source)
	gl._shaderSource(shader.shader_id, source)
end

function gl.getShaderParameter(shader, e)
	return gl._getShaderParameter(shader.shader_id, e)
end

function gl.getShaderInfoLog(shader)
	return gl._getShaderInfoLog(shader.shader_id)
end

function gl.attachShader(program, shader)
	local program_id = 0

	if type(program) == "number" then
		program_id = program
	elseif type(program) == "table" then
		program_id = program.program_id
	end

	gl._attachShader(program_id, shader.shader_id)
end

function gl.linkProgram(program)
	local program_id = 0

	if type(program) == "number" then
		program_id = program
	elseif type(program) == "table" then
		program_id = program.program_id
	end

	gl._linkProgram(program_id)
end

function gl.getProgramParameter(program, e)
	local program_id = 0

	if type(program) == "number" then
		program_id = program
	elseif type(program) == "table" then
		program_id = program.program_id
	end

	return gl._getProgramParameter(program_id, e)
end

function gl.useProgram(program)
	local program_id = 0

	if type(program) == "number" then
		program_id = program
	elseif type(program) == "table" then
		program_id = program.program_id
	end

	gl._useProgram(program_id)
end

function gl.getAttribLocation(program, name)
	local program_id = 0

	if type(program) == "number" then
		program_id = program
	elseif type(program) == "table" then
		program_id = program.program_id
	end

	return gl._getAttribLocation(program_id, name)
end

function gl.getUniformLocation(program, name)
	local program_id = 0

	if type(program) == "number" then
		program_id = program
	elseif type(program) == "table" then
		program_id = program.program_id
	end

	return gl._getUniformLocation(program_id, name)
end

function gl.getActiveAttrib(program, index)
	local program_id = 0

	if type(program) == "number" then
		program_id = program
	elseif type(program) == "table" then
		program_id = program.program_id
	end

	return gl._getActiveAttrib(program_id, index)
end

function gl.getActiveUniform(program, index)
	local program_id = 0

	if type(program) == "number" then
		program_id = program
	elseif type(program) == "table" then
		program_id = program.program_id
	end

	return gl._getActiveUniform(program_id, index)
end

function gl.getAttachedShaders(program)
	local program_id = 0

	if type(program) == "number" then
		program_id = program
	elseif type(program) == "table" then
		program_id = program.program_id
	end

	return gl._getAttachedShaders(program_id)
end

function gl.glNodeCreate()
	return cc.GLNode:create()
end
