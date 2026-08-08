require "class"
local binary_heap = require "binary_heap"
local IntervalControl = class("IntervalControl")

-- setting格式
local _setting = {
	interval = 500,		-- 相邻两次至少间隔的时间
	-- duration = 10000,	-- 多少时间内限制总次数 实现代价较大
	durationCount = 10,	-- 到达多少次数后进入cooldown
	cooldown = 5000,	-- 到了durationCount后多久之后重新计数
	stampGen = os.time,	-- 时间戳生成器
	capacity = 100,		-- 总容量，一旦达到再加入时会把最早的给踢除
	clearOnce = 10,		-- 一次最多清理过期的个数
	expired = 100000,	-- 多长时间没有访问过算过期可以清理出去
}

function IntervalControl:ctor(setting)
	self.stampGen = setting.stampGen or os.time
	setting = clone(setting)
	self.setting = setting
	self.keyMap = {}
	self.heap = binary_heap(function (a, b)
		return a.lastStamp < b.lastStamp
	end)

	assert(setting.interval)
	assert(setting.durationCount)
	assert(setting.cooldown)
	assert(setting.stampGen)

	if not setting.clearOnce then
		setting.clearOnce = 10
	end
	
	if not setting.capacity then
		setting.capacity = 200
	end
end

-- @param force boolean 强行加入
-- @return boolean[,number]
-- 如果第一个参数为false，表示未到间隔时间，并返回距离下一次可访问的间隔时间
-- true表示可成功访问，并加入数据存储
function IntervalControl:add(key, force)
	local setting = self.setting
	local data = self.keyMap[key]
	local nowStamp = self.stampGen()

	if data then
		local nextDiff
		if nowStamp - setting.interval >= data.lastStamp or force then
			if data.count < setting.durationCount or force then
				data.count = data.count + 1
				data.total = data.total + 1
				data.lastStamp = nowStamp

				if nowStamp - data.lastStamp >= setting.cooldown then
					data.count = 0
				end
			elseif nowStamp - data.lastStamp >= setting.cooldown then
				data.count = 1
				data.total = data.total + 1
				data.lastStamp = nowStamp
			else
				nextDiff = setting.cooldown - (nowStamp - data.lastStamp)
			end
		else
			nextDiff = data.lastStamp + setting.interval - nowStamp
		end

		if nextDiff then
			return false, nextDiff
		end
		
		return true
	else
		data = {key = key, startStamp = nowStamp, count = 1, total = 1, lastStamp = nowStamp,}
		self.keyMap[key] = data
		self.heap:add(data)

		local currCount = self.heap:getSize()
		if currCount > setting.capacity then
			self:removeEarliest()
		end
	end
	
	return true
end

function IntervalControl:removeEarliest()
	if self.heap:empty() then
		return false
	end
	
	local toRmv = self.heap:pop()
	self.keyMap[toRmv.key] = nil

	return true
end

function IntervalControl:hasKey(key)
	return self.keyMap[key] ~= nil
end

function IntervalControl:size()
	assert(tablex.size(self.keyMap), self.heap:getSize())
	return self.heap:getSize()
end

function IntervalControl:clear()
	self.keyMap = {}
	self.heap:clear()
end

function IntervalControl:check()
	local setting = self.setting
	if self.heap:empty() or not setting.expired then
		return
	end
	
	local nowStamp = self.stampGen()
	local clearCnt = 0
	for i = 1, setting.clearOnce do
		local top = self.heap:top()
		if nowStamp - top.lastStamp >= setting.expired then
			self:removeEarliest()
			clearCnt = clearCnt + 1
		else
			break
		end
		
		if self.heap:empty() then
			break
		end
	end

	return clearCnt
end

return IntervalControl