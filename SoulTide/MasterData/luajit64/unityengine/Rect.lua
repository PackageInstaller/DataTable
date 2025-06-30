-- chunkname: @UnityEngine\\Rect.lua

local clamp = Mathf.Clamp
local sqrt = Mathf.Sqrt
local min = Mathf.Min
local max = Mathf.Max
local setmetatable = setmetatable
local rawget = rawget
local Rect = {}
local get = tolua.initget(Rect)

function Rect.__index(t, k)
	local var = rawget(Rect, k)

	if var == nil then
		var = rawget(get, k)

		if var ~= nil then
			return var(t)
		end
	end

	return var
end

function Rect.New(x, y, w, h)
	local rt = {
		x = x,
		y = y,
		w = w,
		h = h
	}

	setmetatable(rt, Rect)

	return rt
end

function Rect.__call(t, x, y, w, h)
	return setmetatable({
		x = x or 0,
		y = y or 0,
		w = w or 0,
		h = h or 0
	}, Rect)
end

function Rect:Get()
	return self.x, self.y, self.w, self.h
end

function Rect:Set(x, y, w, h)
	self.x = x or 0
	self.y = y or 0
	self.w = w or 0
	self.h = h or 0
end

function Rect:__tostring()
	return "(x:" .. self.x .. ", y:" .. self.y .. ", width:" .. self.w .. ", height:" .. self.h .. ")"
end

UnityEngine.Rect = Rect

setmetatable(Rect, Rect)
AddValueType(Rect, 13)

return Rect
