-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\RearHouse\\DispatchTask.lua

local ResRearHouseDispatch = require("ClientData/ResRearHouseDispatch")
local ResStep = require("ClientData/ResStep")
local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local strClassName = "DispatchTask"
local DispatchTask = Class(strClassName)

function DispatchTask:ctor(data)
	self:refreshData(data)
end

function DispatchTask:refreshData(data)
	self.data = data
	self.starTime = data.start_tick

	local dispatchData = ResRearHouseDispatch[data.res_id]

	self:_initAtr(dispatchData)
	self:_initOtherData()
	self:_initAwardData()
	self:refreshState()
end

function DispatchTask:_initOtherData(...)
	return
end

function DispatchTask:_initAtr(data)
	for k, v in pairs(data) do
		self[k] = v
	end

	local idx = 4

	if self.require_camp ~= nil and self.require_camp ~= 0 then
		idx = self.require_camp
	end

	self.iconPath = {}
	self.iconPath[1] = "Atlas/BackyardAtlas/BackyardDispatchAtlas"
	self.iconPath[2] = "BgDispatch0" .. idx
end

function DispatchTask:refreshState(...)
	self.isNew = false
	self.isDoing = false
	self.isDone = false
	self.isLock = false

	if self.data.lock == 1 then
		self.isLock = true
		self.order = 30
	elseif self.starTime == 0 then
		self.isNew = true
		self.order = 40
	elseif self:getEndTime() > ClientUtils.getServerTime() then
		self.isDoing = true
		self.order = 20
	else
		self.isDone = true
		self.order = 10
	end
end

function DispatchTask:getRequireCamp(...)
	if self.require_camp == nil or self.require_camp == 0 then
		return 4
	else
		return self.require_camp
	end
end

function DispatchTask:isRequireCamp(...)
	return self.require_camp ~= nil and self.require_camp ~= 0
end

function DispatchTask:getEndTime(...)
	return self.starTime + self.time
end

function DispatchTask:_initAwardData(...)
	self.awardItems = RearHouseCommon.getAwardData(self.rand_id)
end

function DispatchTask:isTimePassHalf(...)
	return ClientUtils.getServerTime() - self:getEndTime() < self.time * 0.5
end

function DispatchTask:setLockState(lock)
	self.data.lock = lock

	self:refreshState()
end

function DispatchTask:getInTaskHeroInfos(...)
	return self.data.hero
end

function DispatchTask:isHeroLimit(hero)
	local isCampLimit = self.require_camp ~= nil and self.require_camp ~= 0 and hero.camp ~= self.require_camp

	return hero.step < self.require_step or isCampLimit
end

function DispatchTask:getCritDescIds(...)
	return self.crit_desc
end

function DispatchTask:getStepDesc(...)
	local info = ResStep[self.star]

	if info then
		return info.step_name or ""
	end

	return ""
end

return DispatchTask
