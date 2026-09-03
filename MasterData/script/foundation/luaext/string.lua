-- chunkname: @/tmp/or_script/lua_compile/foundation/luaext/string.lua

function string.split(str, delimiter, maxnum, useregex)
	local plain = not useregex
	local result = {}
	local n = 0
	local p = delimiter
	local nextpos = 1

	if maxnum == nil or maxnum < 1 then
		maxnum = 0
	end

	while true do
		n = n + 1

		if maxnum > 0 and maxnum <= n then
			break
		end

		local s, e = string.find(str, p, nextpos, plain)

		if s == nil then
			break
		end

		result[n] = string.sub(str, nextpos, s - 1)
		nextpos = e + 1
	end

	result[n] = string.sub(str, nextpos)

	return result
end
