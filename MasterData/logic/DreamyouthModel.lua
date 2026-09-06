-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamyouth/model/DreamyouthModel.lua

module("logic.extensions.partyprize.model.DreamyouthModel", package.seeall)

local DreamyouthModel = class("DreamyouthModel", BaseModel)

function DreamyouthModel:ctor()
	DreamyouthModel.super.ctor(self)
end

function DreamyouthModel:onInit()
	self:onReset()
end

function DreamyouthModel:onReset()
	self._taskInfos = nil
	self._strengthenInfos = nil
end

function DreamyouthModel:initTaskData(msg)
	self._taskInfos = {}

	for _, cfg in ipairs(DreamyouthConfig.instance:getTaskCfg()) do
		local serverInfo

		for _, v in ipairs(msg.taskInfos) do
			if v and v.taskId == cfg.id then
				serverInfo = v
			end
		end

		self._taskInfos[cfg.id] = {}

		if serverInfo then
			self._taskInfos[cfg.id].curProcess = serverInfo.curProcess
			self._taskInfos[cfg.id].hasGainPrize = serverInfo.hasGainPrize
		else
			self._taskInfos[cfg.id].curProcess = 0
			self._taskInfos[cfg.id].hasGainPrize = false
		end
	end
end

function DreamyouthModel:initStrengthenData(msg)
	self._useNum = 0
	self._strengthenInfos = {}

	for i = 1, 3 do
		self._strengthenInfos[i] = {}

		local serverInfo

		for _, v in ipairs(msg.infos) do
			if v and v.strengthenType == i then
				serverInfo = v
			end
		end

		if serverInfo then
			self._strengthenInfos[i].curTimes = checknumber(serverInfo.curTimes)
			self._strengthenInfos[i].curProgress = checknumber(serverInfo.curProgress)
		else
			self._strengthenInfos[i].curTimes = 0
			self._strengthenInfos[i].curProgress = 0
		end
	end
end

function DreamyouthModel:gainTaskPrize(msg, taskId)
	self._taskInfos[taskId].hasGainPrize = true
end

function DreamyouthModel:strengthen(msg, strengthenType)
	self._strengthenInfos[strengthenType].curTimes = checknumber(msg.curTimes)
	self._strengthenInfos[strengthenType].curProgress = checknumber(msg.curProgress)

	if strengthenType == DreamyouthConfig.instance.ST_Pet then
		self._useNum = 0
	end
end

function DreamyouthModel:addUseNum(value)
	if self:coinNum() > 0 then
		local max = DreamyouthConfig.instance:coinForStrengthenType(DreamyouthConfig.instance.ST_Pet)
		local addValue = math.min(value, max - self:curProgress())

		addValue = math.min(addValue, self:coinNum())
		self._useNum = self._useNum + addValue

		return true
	end

	return false
end

function DreamyouthModel:hasGainTaskPrize(taskId)
	return self._taskInfos[taskId].hasGainPrize
end

function DreamyouthModel:getTaskCurProcess(taskId)
	return self._taskInfos[taskId].curProcess
end

function DreamyouthModel:coinNum()
	return MaterialMgr.getMatCount(DreamyouthConfig.instance:getCoinItemStr()) - self._useNum
end

function DreamyouthModel:curProgress()
	return self._strengthenInfos[DreamyouthConfig.instance.ST_Pet].curProgress + self._useNum
end

function DreamyouthModel:useNum()
	return self._useNum
end

function DreamyouthModel:curCountTotal(type)
	return self._strengthenInfos[type].curTimes
end

function DreamyouthModel:curCountWeek(type)
	return 0
end

function DreamyouthModel:checkHasGainPet()
	return self:curProgress() >= DreamyouthConfig.instance:coinForStrengthenType(DreamyouthConfig.instance.ST_Pet) or self:checkStrengthenCountTotalMax(DreamyouthConfig.instance.ST_Pet)
end

function DreamyouthModel:checkCanGainStrengthen(type)
	return self:checkCoinEnoughForStrengthen(type) and not self:checkStrengthenCountTotalMax(type) and not self:checkStrengthenCountWeekMax(type)
end

function DreamyouthModel:checkStrengthenCountWeekMax(type)
	return false
end

function DreamyouthModel:checkStrengthenCountTotalMax(type)
	local max = DreamyouthConfig.instance:countMaxStrengthenType(type)
	local cur = self:curCountTotal(type)

	return max <= cur
end

function DreamyouthModel:checkCoinEnoughForStrengthen(type)
	local coin = self:coinNum()

	if type == DreamyouthConfig.instance.ST_Pet then
		return coin > 0
	else
		return coin >= DreamyouthConfig.instance:coinForStrengthenType(type)
	end

	return false
end

DreamyouthModel.instance = DreamyouthModel.New()

return DreamyouthModel
