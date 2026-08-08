---@class Random
local Random = class("Random")

local MTRandom = require "mt_random"
-- r:value() 当没有参数时返回的是[0,1)的浮点型
-- r:value(a, b) 返回的是[a,b]的整形，如果a，b是浮点数，则a向上取整，b向下取整
-- r:value(*) = r(*)

function Random:ctor(seed)
	if not seed then
		seed = 1234
		LuaLogger.w("No seed input")
	end

	self.seed = seed
	self.random = MTRandom.new(seed)
	self.cnt = 0
	--初始化散列次数
	--local count = 30
	--for i=1,count do
	--	self:next()
	--end
end

function Random:setSeed(seed)
	self.seed = seed
	self.random.seed = seed
end

function Random:next()
	local r1 = self.random:value()
	-- self.cnt = self.cnt + 1
	-- LuaLogger.ws("next()", self.cnt, r1, self.seed)
	return r1
	-- return self.random:value()
end

function Random:range(a, b)
	-- self.cnt = self.cnt + 1
	-- LuaLogger.ws("range()", self.cnt, self.seed)
	return self.random:value(a, b)
end

-- 在value上下随机percent百分比(percent为小数, 0.03表示百分之三)
function Random:aroundValuePercent(value, percent)
	percent = self:range(0, percent * 10000) / 10000
	if self:next() >= 0.5 then
		percent = -percent
	end

	value = value * (1 + percent)
	return value
end

-- 在value上下随机数量num
function Random:aroundValueNum(value, num)
	local added = self:next() * num
	if self:next() >= 0.5 then
		added = -added
	end

	return value + added
end

function Random:isProb(prob)
	if prob <= 0 then
		return false
	end

	if prob >= 1 then
		return true
	end
	
	local r = self:next()
	self.cnt = self.cnt + 1
    if Config.DebugBattle then
		LuaLogger.ds("isProb()", self.cnt, r, self.seed)
	end

	-- if Config.Debug then
	-- 	LuaLogger.d("random %.2f", r)
	-- end
	return r <= prob
end

return Random