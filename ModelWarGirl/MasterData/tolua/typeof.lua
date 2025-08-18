-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ToLua\\typeof.lua

local type = type
local types = {}
local _typeof = tolua.typeof
local _findtype = tolua.findtype

function typeof(obj)
	local t = type(obj)
	local ret

	if t == "table" then
		ret = types[obj]

		if ret == nil then
			ret = _typeof(obj)
			types[obj] = ret
		end
	elseif t == "string" then
		ret = types[obj]

		if ret == nil then
			ret = _findtype(obj)
			types[obj] = ret
		end
	else
		error("attemp to call typeof on type " .. t)
	end

	return ret
end
