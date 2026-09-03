-- chunkname: @/tmp/or_script/lua_compile/cocos/cocos2d/luaj.lua

local luaj = {}
local callJavaStaticMethod = LuaJavaBridge.callStaticMethod

local function checkArguments(args, sig)
	if type(args) ~= "table" then
		args = {}
	end

	if sig then
		return args, sig
	end

	sig = {
		"("
	}

	for i, v in ipairs(args) do
		local t = type(v)

		sig[#sig + 1] = t == "number" and "F" or t == "boolean" and "Z" or t == "function" and "I" or "Ljava/lang/String;"
	end

	sig[#sig + 1] = ")V"

	return args, table.concat(sig)
end

function luaj.callStaticMethod(className, methodName, args, sig)
	local args, sig = checkArguments(args, sig)

	return callJavaStaticMethod(className, methodName, args, sig)
end

return luaj
