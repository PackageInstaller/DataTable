-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/model/DragonModel.lua

module("logic.extensions.lottery.model.DragonModel", package.seeall)

local DragonModel = class("DragonModel", BaseModel)

function DragonModel:ctor()
	self._dragonInfo = nil
	self.dragonActType = 112
end

function DragonModel:onInit()
	DragonModel.super.onInit(self)
	self:onReset()
end

function DragonModel:onReset()
	self._dragonInfo = nil
	self._dragonGainLimitPool = {}
end

function DragonModel:getDragonBaseInfo(dcType)
	if self._dragonInfo == nil or self._dragonInfo[dcType] == nil then
		self:_resetDragonInfo(dcType)
	end

	return self._dragonInfo[dcType]
end

function DragonModel:getDragonTaskInfo(dcType)
	local actId = DragonConfig.instance:getOpenTaskActivityId()
	local actCfg = DragonConfig.instance:getActivityCfg(actId, true)

	if actCfg == nil or actCfg.taskPlanId == nil then
		return
	end

	local allCfgs = DragonConfig.instance:getDragonTaskCfgs(actCfg.taskPlanId)
	local tmpInfo = self:getDragonBaseInfo(dcType)
	local targetList = {}

	for _, cfg in pairs(allCfgs or {}) do
		local temp = self:_calculateTaskState(cfg, (tmpInfo and tmpInfo.taskList or nil) and tmpInfo.taskList)

		if temp and temp.type then
			table.insert(targetList, temp)
		end
	end

	if #targetList > 1 then
		table.sort(targetList, function(a, b)
			if a.isFinish == b.isFinish then
				if a.type == b.type then
					return a.id < b.id
				end

				return a.type < b.type
			end

			return not a.isFinish
		end)
	end

	return targetList
end

function DragonModel:_calculateTaskState(cfg, list)
	if cfg == nil then
		return
	end

	local temp = {}

	temp.type = cfg.type
	temp.id = cfg.id
	temp.name = cfg.name
	temp.des = cfg.des
	temp.progress = cfg.progress
	temp.prize = cfg.prize
	temp.jumpTo = cfg.jumpTo
	temp.gainLimit = cfg.gainLimit
	temp.isFinish = false
	temp.haveProgress = 0

	for _, info in pairs(list or {}) do
		if info and info.type == cfg.type then
			temp.haveProgress = info.progress

			for _, index in pairs(info.gainPrizeId or {}) do
				if index and index == temp.id then
					temp.isFinish = true

					break
				end
			end

			return temp
		end
	end

	return temp
end

function DragonModel:getDragonRedpoint()
	local actId = DragonConfig.instance:getOpenDragonActivityId()

	return self:getTaskRedpoint()
end

function DragonModel:getTaskRedpoint()
	local actId = DragonConfig.instance:getOpenTaskActivityId()

	if checknumber(actId) <= 0 then
		return false
	end

	local cfg = DragonConfig.instance:getActivityCfg(actId, true)

	if cfg and cfg.redPointId then
		return RedPointModel.instance:isActiveByServer(cfg.redPointId)
	end

	return false
end

function DragonModel:getCountRedpoint(actId)
	if checknumber(actId) <= 0 then
		return false
	end

	local value = GameUtil.getUserDayData("DragonCountRed_" .. actId)

	if checknumber(value) == 1 then
		return false
	end

	local actCfg = DragonConfig.instance:getActivityCfg(actId)

	if actCfg == nil or actCfg.poolGroupId == nil then
		return false
	end

	local poolCfg = DragonConfig.instance:getDragonPoolCfg(actCfg.poolGroupId)

	if poolCfg == nil or string.nilorempty(poolCfg.lotteryCost) then
		return false
	end

	local have = MaterialMgr.getMatCount(poolCfg.lotteryCost)

	return have > 0
end

function DragonModel:scGodLotteryGetInfo(msg, dcType)
	self:_resetDragonInfo(dcType, true)

	if msg == nil then
		return
	end

	self._dragonInfo[dcType].accumulateTime = msg.accumulateTime
	self._dragonInfo[dcType].rankList = msg.rankList
	self._dragonInfo[dcType].dailyTime = msg.dailyTime
	self._dragonInfo[dcType].totalTimes = msg.totalTimes
end

function DragonModel:scGodLotteryDone(msg, dcType)
	if self._dragonInfo == nil or self._dragonInfo[dcType] == nil then
		self:_resetDragonInfo(dcType)
	end

	self._dragonInfo[dcType].dailyTime = checknumber(msg.dailyTime)
	self._dragonInfo[dcType].accumulateTime = checknumber(msg.accumulateTime)
	self._dragonInfo[dcType].totalTimes = checknumber(msg.totalTimes)
end

function DragonModel:scGodLotteryGetTasks(taskList, dcType)
	if self._dragonInfo == nil or self._dragonInfo[dcType] == nil then
		self:_resetDragonInfo(dcType)
	end

	self._dragonInfo[dcType].taskList = GameUtil.pbToTable(taskList)
end

function DragonModel:onGetGodLotteryGainLimit(gainLimit, dcType)
	self._dragonGainLimitPool[dcType] = GameUtil.pbToTable(gainLimit)
end

function DragonModel:getGodLotteryGainLimit(dcType)
	return self._dragonGainLimitPool[dcType]
end

function DragonModel:scGodLotteryGainPrize(typeId, index, dcType)
	if self._dragonInfo == nil or self._dragonInfo[dcType] == nil then
		self:_resetDragonInfo(dcType)
	end

	for _, info in pairs(self._dragonInfo[dcType].taskList) do
		if info and info.type == typeId then
			info.gainPrizeId = info.gainPrizeId or {}

			table.insert(info.gainPrizeId, index)

			return
		end
	end

	printError("sr---超神龙召唤  会出现这种情况 = " .. typeId .. " ," .. index)
end

function DragonModel:getDragonProgressCfgs(id)
	if not id or not id then
		::label_17_0::

		local actId = DragonConfig.instance:getOpenDragonActivityId()
		local actCfg = DragonConfig.instance:getActivityCfg(actId, false)
		local poolCfg = DragonConfig.instance:getDragonPoolCfg(actCfg.poolGroupId)
		local allCfgs = DragonConfig.instance:getDragonProgressCfgs(poolCfg.progressPlanId)
		local tab = {}

		for _, v in pairs(allCfgs) do
			table.insert(tab, v)
		end

		ArraySort.sortOn(tab, "times")

		return tab, poolCfg
	end
end

function DragonModel:getDragonProgressCurInfo(curProgress, id)
	local cfgs = self:getDragonProgressCfgs(id)
	local upTimes, nextTimes, prize = 0, 0, 0

	for i, v in ipairs(cfgs) do
		local k = v.times

		nextTimes = k

		if curProgress < k then
			nextTimes = k
			prize = v.prize

			break
		end

		upTimes = k
	end

	local gapTimes = nextTimes - upTimes
	local curTimes = curProgress - upTimes
	local overTimes = nextTimes - curProgress

	return nextTimes, gapTimes, curTimes, overTimes, prize
end

function DragonModel:_resetDragonInfo(dcType, isReset)
	if self._dragonInfo == nil then
		self._dragonInfo = {}
	end

	if isReset then
		self._dragonInfo[dcType] = {}
	end

	if self._dragonInfo[dcType] == nil then
		self._dragonInfo[dcType] = {}
	end

	self._dragonInfo[dcType].accumulateTime = 0
	self._dragonInfo[dcType].totalTimes = 0
	self._dragonInfo[dcType].rankList = {}
	self._dragonInfo[dcType].dailyTime = 0
	self._dragonInfo[dcType].taskList = {}
end

DragonModel.instance = DragonModel.New()

return DragonModel
