-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/model/claw_doll/ClawDollModel.lua

module("logic.extensions.welfare.model.claw_doll.ClawDollModel", package.seeall)

local M = class("ClawDollModel", BaseModel)

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._taskMoLst = {}
	self._taskShowList = {}
	self._exchangeList = {}
	self._exchangeShowList = {}
	self._activityId = {}
	self._dollsInMachineList = {}
	self._dollPath = {}
end

function M:setActivityId(cfgId, id)
	self._activityId[cfgId] = id
end

function M:getActivityId(cfgId)
	return self._activityId[cfgId]
end

function M:getCurCoinNumber(cfgId)
	local coinId = ClawDollConfig.instance:getCoinIdByCfgId(cfgId)
	local curNum = ItemModel.instance:getItemCountByItemId(coinId)

	return curNum
end

function M:setTaskList(msg)
	local tempList = {}

	for k, v in ipairs(msg.tasks) do
		local clawDollMo = ClawDollTaskMo.New()

		clawDollMo:setClawTaskMo(v)

		tempList[v.id] = clawDollMo
	end

	local cfgId = ActivityTaskConfig.instance:getTaskConfigIdByLabel(msg.label)

	if cfgId == nil then
		printError("夹娃娃任务列表传入参数错误")

		return
	end

	self._taskMoLst[cfgId] = tempList

	self:refreshTaskShowLst(msg.label)
end

function M:refreshTaskShowLst(label)
	local cfgId = ActivityTaskConfig.instance:getTaskConfigIdByLabel(label)

	if self._taskMoLst[cfgId] == nil then
		printError("夹娃娃任务列表传入参数错误")

		return
	end

	local tempTaskMoList = {}
	local tempIndex = 0

	for k, v in pairs(self._taskMoLst[cfgId]) do
		tempIndex = tempIndex + 1
		tempTaskMoList[tempIndex] = v
	end

	table.sort(tempTaskMoList, function(a, b)
		local aIsFinish = a:getIsFinish()
		local bIsFinish = b:getIsFinish()

		if aIsFinish < bIsFinish then
			return true
		elseif aIsFinish == bIsFinish then
			if aIsFinish == 1 then
				if a:getPriority() > b:getPriority() then
					return true
				end
			elseif aIsFinish == 0 then
				if a:canGetReward() > b:canGetReward() then
					return true
				elseif a:canGetReward() == b:canGetReward() and a:getPriority() > b:getPriority() then
					return true
				end
			end
		end

		return false
	end)

	self._taskShowList[cfgId] = tempTaskMoList
end

function M:setOneTaskFinish(id)
	local info = ActivityTaskConfig.instance:getTaskInfoById(id)
	local cfgId = info.activityId

	if self._taskMoLst[cfgId] and self._taskMoLst[cfgId][id] then
		self._taskMoLst[cfgId][id]:setIsFinish(true)
		self:refreshTaskShowLst(info.label)

		return true
	end

	return false
end

function M:oneTaskChange(taskNo)
	local info = ActivityTaskConfig.instance:getTaskInfoById(taskNo.id)

	if info == nil or info == 0 then
		return
	end

	local cfgId = info.activityId

	if self._taskMoLst[cfgId] and self._taskMoLst[cfgId][taskNo.id] then
		self._taskMoLst[cfgId][taskNo.id]:setCount(taskNo.count)
		self._taskMoLst[cfgId][taskNo.id]:setIsFinish(taskNo.finish)
		self:refreshTaskShowLst(info.label)

		return true
	end

	return false
end

function M:getClawDollTaskLstByLabel(label)
	local cfgId = ActivityTaskConfig.instance:getTaskConfigIdByLabel(label)

	if cfgId == nil or self._taskShowList[cfgId] == nil then
		return
	end

	return self._taskShowList[cfgId]
end

function M:getClawDollOriginTaskLstByCfgId(cfgId)
	return self._taskMoLst[cfgId]
end

function M:isHasTaskCanReivceByCfgId(cfgId)
	for k, v in pairs(self._taskMoLst[cfgId]) do
		if v:getRewardStatus() == ClawDollConfig.TaskState.CanReceive then
			return true
		end
	end

	return false
end

function M:isFinishAllTask(cfgId)
	for k, v in pairs(self._taskMoLst[cfgId]) do
		if v:getIsFinish() == 0 then
			return false
		end
	end

	return true
end

function M:setExchangeList(cfgId, rewardlist)
	local tempRewardList = {}

	if cfgId == nil then
		return false
	end

	local exchangeList = ClawDollConfig.instance:getExchangeList(cfgId) or {}

	for _, v in pairs(exchangeList) do
		local exchangeMo = ClawDollExchangeMo.New()

		exchangeMo:setClawExchangeMo(v)

		tempRewardList[v.id] = exchangeMo
	end

	for _, v in ipairs(rewardlist) do
		if tempRewardList[v.id] then
			tempRewardList[v.id]:setCount(v.count)
		end
	end

	self._exchangeList[cfgId] = tempRewardList

	self:refreshExchangeShowLst(cfgId)

	return true
end

function M:refreshExchangeShowLst(cfgId)
	local tempList = {}

	for k, v in pairs(self._exchangeList[cfgId]) do
		tempList[k] = v
	end

	table.sort(tempList, function(a, b)
		local aIsFinish = a:getIsFinish()
		local bIsFinish = b:getIsFinish()

		if aIsFinish < bIsFinish then
			return true
		elseif aIsFinish == bIsFinish and a:getId() < b:getId() then
			return true
		end

		return false
	end)

	local index = 0
	local tempExchangeShowList = {}

	for k, v in pairs(tempList) do
		index = index + 1
		tempExchangeShowList[index] = v
	end

	self._exchangeShowList[cfgId] = tempExchangeShowList
end

function M:setOneExchange(msg)
	if msg == nil then
		return
	end

	local cfgId = msg.aConfigId or 0
	local id = msg.redeemPrize.id or 0
	local count = msg.redeemPrize.count or 0

	if self._exchangeList[cfgId] and self._exchangeList[cfgId][id] then
		self._exchangeList[cfgId][id]:setCount(count)
		self:refreshExchangeShowLst(cfgId)

		return true
	end

	return false
end

function M:getClawDollExchangeByCfgId(cfgId)
	if cfgId == nil or self._exchangeShowList[cfgId] == nil then
		return
	end

	return self._exchangeShowList[cfgId]
end

function M:setDollInMachineList(aConfigId, dolls)
	if aConfigId == nil or dolls == nil then
		return
	end

	self._dollsInMachineList[aConfigId] = dolls

	return true
end

function M:getDollInMachineList(cfgId)
	if cfgId == nil then
		return
	end

	return self._dollsInMachineList[cfgId]
end

function M:setOneClawDollBoll(aConfigId, dollId)
	if aConfigId == nil or dollId == nil then
		return
	end

	for k, v in ipairs(self._dollsInMachineList[aConfigId]) do
		if v.id == dollId then
			if v.count > 1 then
				v.count = v.count - 1

				return true
			elseif v.count == 1 then
				v.count = 0

				table.remove(self._dollsInMachineList[aConfigId], k)

				return true
			end
		end
	end

	return false
end

function M:setDollPath(cfgId, list)
	self._dollPath[cfgId] = list
end

function M:getDollPath(cfgId, dollID)
	if self._dollPath[cfgId] then
		return self._dollPath[cfgId][dollID]
	end
end

M.instance = M.New()

return M
