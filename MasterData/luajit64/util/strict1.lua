-- chunkname: @Util\\strict1.lua

local mt = getmetatable(_G)

if mt == nil then
	mt = {}

	setmetatable(_G, mt)
end

__STRICT = true
mt.__declared = {}

function mt.__newindex(t, n, v)
	if __STRICT and not mt.__declared[n] then
		local w = debug.getinfo(2, "S")

		if w ~= nil then
			w = w.what

			if w ~= "main" and w ~= "C" then
				error("assign to undeclared variable '" .. n .. "'", 2)
			end
		end

		mt.__declared[n] = true
	end

	rawset(t, n, v)
end

function mt.__index(t, n)
	if not mt.__declared[n] and debug.getinfo(2, "S").what ~= "C" then
		error("variable '" .. n .. "' is not declared", 2)
	end

	return rawget(t, n)
end

function global(...)
	for _, v in ipairs({
		...
	}) do
		mt.__declared[v] = true
	end
end
