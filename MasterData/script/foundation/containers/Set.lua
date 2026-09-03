-- chunkname: @/tmp/or_script/lua_compile/foundation/containers/Set.lua

local pairs = _G.pairs
local ipairs = _G.ipairs

Set = {}

local SetMeta = {
	__index = Set
}

Set.__meta = SetMeta

function SetMeta.__add(a, b)
	local r = Set:new()

	for k, v in pairs(a) do
		if v then
			r[k] = true
		end
	end

	for k, v in pairs(b) do
		if v then
			r[k] = true
		end
	end

	return r
end

function SetMeta.__sub(a, b)
	local r = Set:new()

	for k, v in pairs(a) do
		if v and not b[k] then
			r[k] = true
		end
	end

	return r
end

function SetMeta.__unm(a)
	assert(false, "negation not defined for set")
end

function SetMeta.__mul(a, b)
	local r = Set:new()

	for k, v in pairs(a) do
		if v and b[k] then
			r[k] = true
		end
	end

	return r
end

function SetMeta.__concat(a, b)
	local r = Set:new()

	for k, v in pairs(a) do
		if v and not b[k] then
			r[k] = true
		end
	end

	for k, v in pairs(b) do
		if v and not a[k] then
			r[k] = true
		end
	end

	return r
end

function SetMeta.__le(a, b)
	for k, v in pairs(a) do
		if v and not b[k] then
			return false
		end
	end

	return true
end

function SetMeta.__lt(a, b)
	return a <= b and b > a
end

function SetMeta.__eq(a, b)
	return a <= b and b <= a
end

function SetMeta.__tostring(s)
	return "{" .. table.concat(s:list(), ", ") .. "}"
end

function Set:new(l)
	local set = {}

	setmetatable(set, self.__meta)

	if l then
		for _, v in ipairs(l) do
			set[v] = true
		end
	end

	return set
end

function Set:add(e)
	self[e] = true
end

function Set:remove(e)
	self[e] = nil
end

function Set:contains(e)
	return self[e]
end

function Set:clone()
	local s = Set:new()

	for k, v in pairs(self) do
		s[k] = v
	end

	return s
end

function Set:list()
	local l, i = {}, 1

	for k, v in pairs(self) do
		if v then
			i = i + 1
			l[i] = k
		end
	end

	return l
end

function Set:count()
	local count = 0

	for k, v in pairs(self) do
		if v then
			count = count + 1
		end
	end

	return count
end

function Set:empty()
	return next(self) ~= nil
end

function compileSetFormula(source)
	local comps = {}

	source = string.gsub(source, "%b{}", function(s)
		comps[#comps + 1] = s:sub(2, -2)

		return ""
	end)
	comps[#comps + 1] = "return"
	comps[#comps + 1] = source

	return loadstring(table.concat(comps, " "))
end

function execSetFormula(f, env)
	setfenv(f, env)

	return f()
end
