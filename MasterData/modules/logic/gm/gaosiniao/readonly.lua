-- chunkname: @modules/logic/gm/gaosiniao/readonly.lua

local type = _G.type
local assert = _G.assert
local setmetatable = _G.setmetatable
local tostring = _G.tostring
local next = _G.next
local format = string.format

local function __newindex(_, k, v)
	assert(false, format("readonly !! k=%s, v=%s", tostring(k), tostring(v)))
end

return function(tbl)
	assert(type(tbl) == "table")

	local function __pairs(_)
		return next, tbl, nil
	end

	local function __tostring()
		tostring(tbl)
	end

	local function __len()
		return #tbl
	end

	local _mt = getmetatable(tbl)

	if _mt then
		__pairs = _mt.__pairs
		__tostring = _mt.__tostring
		__len = _mt.__len
	end

	local mt = {
		__index = tbl,
		__newindex = __newindex,
		__pairs = __pairs,
		__tostring = __tostring,
		__len = __len
	}

	return setmetatable({}, mt)
end
