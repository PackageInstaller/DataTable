-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/behavior/UnitCompBehaviorMgr.lua

module("logic.scene.unit.component.behavior.UnitCompBehaviorMgr", package.seeall)

local M = class("UnitCompBehaviorMgr", UnitComponentBase)
local WorkStatus = HouseEnum.WorkStatus
local BehaviorType = HouseEnum.BehaviorType
local WorkType = HouseEnum.WorkType
local WorkStatusMode = HouseEnum.WorkStatusMode
local kCacheBHCount = 10

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._behaviorList = nil
	self._finishedBehaviorList = nil
	self._idIndex = nil
end

function M:onInit()
	M.super.onInit(self)

	self._behaviorList = {}
	self._finishedBehaviorList = {}
	self._idIndex = 1

	GlobalDispatcher:addEventListener(EventType.FW_CLOCK_TICKHOUR, self._onTickHour, self)
	GlobalDispatcher:addEventListener(EventType.ChangeHouseWorkerSucceed, self._onHouseWorkderChange, self)
end

function M:onReset()
	table.clear(self._behaviorList)
	table.clear(self._finishedBehaviorList)
	GlobalDispatcher:removeEventListener(EventType.FW_CLOCK_TICKHOUR, self._onTickHour, self)
	GlobalDispatcher:removeEventListener(EventType.ChangeHouseWorkerSucceed, self._onHouseWorkderChange, self)

	self._idIndex = 1
	self._curWorkStatus = nil
	self._lastWorkStatus = nil
end

function M:onDestroy()
	M.super.onDestroy(self)
	self:onReset()
end

function M:clearAllBehavior()
	table.clear(self._behaviorList)
end

function M:getCurrBehavior()
	if #self._behaviorList > 0 then
		return self._behaviorList[1]
	end

	return BehaviorData.New()
end

function M:removeFirstBehavior()
	if #self._behaviorList > 0 then
		table.remove(self._behaviorList, 1)
	end
end

function M:_onTickHour()
	self:_refreshBhv()
end

function M:_onHouseWorkderChange()
	self:_refreshBhv()
end

function M:_refreshBhv()
	self._unit.scheduleModel:refreshWorkStatus()

	local curWorkStatus = self._unit.scheduleModel:getCurWorkStatus()

	if curWorkStatus ~= self._lastWorkStatus then
		self:clearAllBehavior()
		self:endCurrBehaviorAndNew()
		self._unit.ai:stopCurrentAI()
		self._unit.ai:setStop(false)
	end
end

function M:endCurrBehaviorAndNew()
	local lastBehavior

	if #self._behaviorList > 0 then
		lastBehavior = table.remove(self._behaviorList, 1)

		table.insert(self._finishedBehaviorList, lastBehavior)

		if #self._finishedBehaviorList > kCacheBHCount then
			table.remove(self._finishedBehaviorList, 1)
		end
	end

	self._unit.scheduleModel:refreshWorkStatus()

	if #self._behaviorList == 0 then
		self:createBehavior()
	end

	HouseDispatcher:dispatchEvent(HouseEventType.END_HERO_CURR_BEHAVIOR, self._unit, lastBehavior, self._behaviorList[1])
end

function M:_getLastBehaviorWithStatus(status)
	local len = #self._finishedBehaviorList

	if len > 0 then
		for idx = len, 1, -1 do
			local behavior = self._finishedBehaviorList[idx]

			if behavior:getWorkStatus() == status then
				return behavior
			end
		end
	end
end

function M:_addBehavior(data, idx)
	if data then
		data.step = 1

		data:setId(self._idIndex)

		self._idIndex = self._idIndex + 1

		if idx then
			table.insert(self._behaviorList, idx, data)
		else
			table.insert(self._behaviorList, data)
		end
	end
end

function M:createBehavior()
	local gmBehavior, gmSchedule = HouseGMController.instance:getEffectBehaviorOrSchedule(self._unit.heroId)

	self._curWorkStatus = gmSchedule or self._unit.scheduleModel:getCurWorkStatus()

	local data1, data2

	if gmBehavior then
		data1 = BehaviorData.New(gmBehavior)
	else
		data1, data2 = self:_createBehaviorByMode()
	end

	if data1 == nil then
		printWarn("小人状态错误，workStatus:", self._curWorkStatus)

		data1 = BehaviorData.New()
	end

	self:_addBehavior(data1)
	self:_addBehavior(data2)

	self._lastWorkStatus = self._curWorkStatus
end

function M:_createBehaviorByMode()
	local isChanged = true

	if self._lastWorkStatus then
		isChanged = self._lastWorkStatus ~= self._curWorkStatus
	end

	local data1, data2

	if isChanged then
		data1 = self:_createBehaviorWithStatus(self._lastWorkStatus, WorkStatusMode.End)
		data2 = self:_createBehaviorWithStatus(self._curWorkStatus, WorkStatusMode.Start)
	end

	if data1 == nil then
		if data2 == nil then
			data1 = self:_createBehaviorWithStatus(self._curWorkStatus, WorkStatusMode.Normal)
		else
			data1 = data2
			data2 = self:_createBehaviorWithStatus(self._curWorkStatus, WorkStatusMode.Normal)
		end
	end

	return data1, data2
end

function M:_createBehaviorWithStatus(workStatus, mode)
	local data

	if workStatus == WorkStatus.Sleep then
		data = self:_createSleepBehavior(mode)
	elseif workStatus == WorkStatus.Eat then
		data = self:_createEatBehavior(mode)
	elseif workStatus == WorkStatus.Work then
		data = self:_createWorkBehavior(mode)
	elseif workStatus == WorkStatus.Rest then
		data = self:_createRestBehavior(mode)
	end

	if data then
		data.mode = mode
	end

	return data
end

function M:_rollOneBehavior(typeList, weights)
	local totalWeight = 0

	for i = 1, #typeList do
		totalWeight = totalWeight + weights[i]
	end

	local randomNum = math.random(1, totalWeight)
	local calculWeight = 0

	for idx, weight in ipairs(weights) do
		calculWeight = calculWeight + weight

		if randomNum <= calculWeight then
			return typeList[idx]
		end
	end
end

function M:_createSleepBehavior(mode)
	local data

	if mode == WorkStatusMode.Start then
		data = BehaviorData.New(BehaviorType.SleepBH_2)
	elseif mode == WorkStatusMode.End then
		if self._unit.pajama:inPajama() then
			data = BehaviorData.New(BehaviorType.SleepBH_2)
		end
	else
		local lastSleepBehavior = self:_getLastBehaviorWithStatus(WorkStatus.Sleep)

		if lastSleepBehavior and lastSleepBehavior:getType() == BehaviorType.SleepBH_2 and lastSleepBehavior.mode == WorkStatusMode.Start then
			data = BehaviorData.New(BehaviorType.SleepBH_1)
		else
			local typeList = {
				BehaviorType.SleepBH_1,
				BehaviorType.SleepBH_2,
				BehaviorType.SleepBH_3
			}
			local weights = HouseConfig.instance:getSleepBehaviorWeights()
			local type = self:_rollOneBehavior(typeList, weights)

			data = BehaviorData.New(type)
		end
	end

	if data then
		data:setWorkStatus(WorkStatus.Sleep)
	end

	return data
end

function M:_createEatBehavior(mode)
	local data

	if mode == WorkStatusMode.Start then
		data = BehaviorData.New(BehaviorType.EatBH_1)
	elseif mode == WorkStatusMode.End then
		-- block empty
	else
		local lastEatBehavior = self:_getLastBehaviorWithStatus(WorkStatus.Eat)

		if lastEatBehavior and lastEatBehavior:getType() == BehaviorType.EatBaseBH then
			local typeList = {
				BehaviorType.EatBH_1,
				BehaviorType.EatBH_2
			}
			local weights = HouseConfig.instance:getEatBehaviorWeights()
			local type = self:_rollOneBehavior(typeList, weights)

			data = BehaviorData.New(type)
		else
			data = BehaviorData.New(BehaviorType.EatBaseBH)
		end
	end

	if data then
		data:setWorkStatus(WorkStatus.Eat)
	end

	return data
end

function M:_createRestBehavior(mode)
	local data

	if mode == WorkStatusMode.Start then
		data = BehaviorData.New(BehaviorType.RestBH_1)
	elseif mode == WorkStatusMode.End then
		-- block empty
	else
		local lastRestBehavior = self:_getLastBehaviorWithStatus(WorkStatus.Rest)

		if lastRestBehavior and lastRestBehavior:getType() == BehaviorType.RestBaseBH then
			data = BehaviorData.New(BehaviorType.RestBH_1)
		else
			data = BehaviorData.New(BehaviorType.RestBaseBH)
		end
	end

	if data then
		data:setWorkStatus(WorkStatus.Rest)
	end

	return data
end

function M:_createWorkBehavior(mode)
	local data
	local workType = self._unit.scheduleModel:getWorkType()

	if workType == WorkType.Supervisor then
		data = self:_createWorkSupervisorBehavior(mode)
	elseif workType == WorkType.Trading then
		data = self:_createWorkTradingBehavior(mode)
	elseif workType == WorkType.Manufacturing then
		data = self:_createWorkManufacturBehavior(mode)
	elseif workType == WorkType.Shelter then
		data = self:_createWorkShelterBehavior(mode)
	end

	if data then
		data:setWorkStatus(WorkStatus.Work)
	end

	return data
end

function M:_createWorkSupervisorBehavior(mode)
	local data

	if mode == WorkStatusMode.Start then
		data = BehaviorData.New(BehaviorType.WorkSupervisorBH_1)
	elseif mode == WorkStatusMode.End then
		-- block empty
	else
		local lastWorkBehavior = self:_getLastBehaviorWithStatus(WorkStatus.Work)

		if lastWorkBehavior and lastWorkBehavior:getType() == BehaviorType.WorkSupervisorBaseBH then
			data = BehaviorData.New(BehaviorType.WorkSupervisorBH_1)
		else
			data = BehaviorData.New(BehaviorType.WorkSupervisorBaseBH)
		end
	end

	return data
end

function M:_createWorkTradingBehavior(mode)
	local data

	if mode == WorkStatusMode.Start then
		data = BehaviorData.New(BehaviorType.WorkTradingBH_1)
	elseif mode == WorkStatusMode.End then
		-- block empty
	else
		local lastWorkBehavior = self:_getLastBehaviorWithStatus(WorkStatus.Work)

		if lastWorkBehavior and lastWorkBehavior:getType() == BehaviorType.WorkTradingBaseBH then
			local typeList = {
				BehaviorType.WorkTradingBH_1,
				BehaviorType.WorkTradingBH_2,
				BehaviorType.WorkTradingBH_3
			}
			local weights = HouseConfig.instance:getTradingBehaviorWeights()
			local type = self:_rollOneBehavior(typeList, weights)

			data = BehaviorData.New(type)
		else
			data = BehaviorData.New(BehaviorType.WorkTradingBaseBH)
		end
	end

	return data
end

function M:_createWorkManufacturBehavior(mode)
	local data

	if mode == WorkStatusMode.Start then
		data = BehaviorData.New(BehaviorType.WorkManufacturBH_1)
	elseif mode == WorkStatusMode.End then
		-- block empty
	else
		local lastWorkBehavior = self:_getLastBehaviorWithStatus(WorkStatus.Work)

		if lastWorkBehavior and lastWorkBehavior:getType() == BehaviorType.WorkManufacturBaseBH then
			data = BehaviorData.New(BehaviorType.WorkManufacturBH_1)
		else
			data = BehaviorData.New(BehaviorType.WorkManufacturBaseBH)
		end
	end

	return data
end

function M:_createWorkShelterBehavior(mode)
	local data

	if mode == WorkStatusMode.Start then
		data = BehaviorData.New(BehaviorType.WorkShelterBH_1)
	elseif mode == WorkStatusMode.End then
		-- block empty
	else
		local lastWorkBehavior = self:_getLastBehaviorWithStatus(WorkStatus.Work)

		if lastWorkBehavior and lastWorkBehavior:getType() == BehaviorType.WorkShelterBaseBH then
			local typeList = {
				BehaviorType.WorkShelterBH_1,
				BehaviorType.WorkShelterBH_2
			}
			local weights = HouseConfig.instance:getShelterBehaviorWeights()
			local type = self:_rollOneBehavior(typeList, weights)

			data = BehaviorData.New(type)
		else
			data = BehaviorData.New(BehaviorType.WorkShelterBaseBH)
		end
	end

	return data
end

function M:createBehaviorInFirst(behaviorType)
	local data = BehaviorData.New(behaviorType)

	self:_addBehavior(data, 1)
end

return M
