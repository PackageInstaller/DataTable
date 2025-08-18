-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Framework\\Global.lua

local _GlobalNames = {}

local function __innerDeclare(name, defaultValue)
	if not rawget(_G, name) then
		rawset(_G, name, defaultValue or false)
	end

	_GlobalNames[name] = true

	return _G[name]
end

local function __innerDeclareIndex(tbl, key)
	if not _GlobalNames[key] then
		error("Attempt to access an undeclared global variable : " .. key .. " Trace:" .. debug.traceback(), 2)
	end

	return nil
end

local function __innerDeclareNewindex(tbl, key, value)
	if not _GlobalNames[key] then
		error("Attempt to write an undeclared global variable : " .. key, 2)
	else
		rawset(tbl, key, value)
	end
end

local function __GLDeclare(name, defaultValue)
	local ok, ret = pcall(__innerDeclare, name, defaultValue)

	if not ok then
		return nil
	else
		return ret
	end
end

local function __isGLDeclared(name)
	if _GlobalNames[name] or rawget(_G, name) then
		return true
	else
		return false
	end
end

if not __isGLDeclared("GLDeclare") or not GLDeclare then
	__GLDeclare("GLDeclare", __GLDeclare)
end

if not __isGLDeclared("IsGLDeclared") or not IsGLDeclared then
	__GLDeclare("IsGLDeclared", __isGLDeclared)
end

setmetatable(_G, {
	__index = function(tbl, key)
		local ok, res = pcall(__innerDeclareIndex, tbl, key)

		if not ok then
			-- block empty
		end

		return nil
	end,
	__newindex = function(tbl, key, value)
		local ok, res = pcall(__innerDeclareNewindex, tbl, key, value)

		if not ok then
			-- block empty
		end
	end
})

return __GLDeclare
