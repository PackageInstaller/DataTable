-- chunkname: @modules/logic/versionactivity3_7/anniversary3/model/Anniversary3ActBpModel.lua

module("modules.logic.versionactivity3_7.anniversary3.model.Anniversary3ActBpModel", package.seeall)

local Anniversary3ActBpModel = class("Anniversary3ActBpModel", BaseModel)

function Anniversary3ActBpModel:onInit()
	self:reInit()
end

function Anniversary3ActBpModel:reInit()
	self._actInfos = {}
end

function Anniversary3ActBpModel:setActBpInfo(info)
	self._actId = info.activityId or VersionActivity3_7Enum.ActivityId.Anniversary3ActBp
	self._actInfos[self._actId] = self._actInfos[self._actId] or {}
	self._actInfos[self._actId].bpId = info.bpId
	self._actInfos[self._actId][info.bpId] = self._actInfos[self._actId][info.bpId] or {}
	self._actInfos[self._actId][info.bpId].score = info.score
	self._actInfos[self._actId][info.bpId].payStatus = info.payStatus

	self:buildBonusInfos(info.scoreBonusInfo, info.bpId, self._actId)
end

function Anniversary3ActBpModel:getTaskMo(taskId, bpId, actId)
	if not actId or actId <= 0 then
		actId = self:getCurActId()
	end

	if not self._actInfos[actId] then
		return {}
	end

	bpId = bpId or self:getCurBpId(actId)

	if not self._actInfos[actId][bpId] then
		return {}
	end

	return (TaskModel.instance:getTaskById(taskId))
end

function Anniversary3ActBpModel:getAllTaskByType(type, bpId, actId)
	if not actId or actId <= 0 then
		actId = self:getCurActId()
	end

	if not self._actInfos[actId] then
		return {}
	end

	bpId = bpId or self:getCurBpId(actId)

	if not self._actInfos[actId][bpId] then
		return {}
	end

	local list = {}
	local taskList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActBp, actId)

	for _, task in pairs(taskList) do
		local loopType = task.config.loopType >= 3 and 3 or task.config.loopType

		if loopType == type then
			if LuaUtil.isEmptyStr(task.config.prepose) then
				table.insert(list, task)
			else
				local isPreFinished = self:isTaskFinished(tonumber(task.config.prepose))

				if isPreFinished then
					table.insert(list, task)
				end
			end
		end
	end

	self:_sortTaskList(list)

	return list
end

function Anniversary3ActBpModel:_sortTaskList(taskList)
	table.sort(taskList, function(a, b)
		local aValue = a.finishCount > 0 and 3 or a.progress >= a.config.maxProgress and 1 or 2
		local bValue = b.finishCount > 0 and 3 or b.progress >= b.config.maxProgress and 1 or 2

		if aValue ~= bValue then
			return aValue < bValue
		end

		if a.config.sortId ~= b.config.sortId then
			return a.config.sortId < b.config.sortId
		end

		return a.config.id < b.config.id
	end)
end

function Anniversary3ActBpModel:isTaskFinished(taskId)
	local taskMo = TaskModel.instance:getTaskById(taskId)

	return taskMo and taskMo.finishCount > 0
end

function Anniversary3ActBpModel:buildBonusInfos(infos, bpId, actId)
	if not actId or actId <= 0 then
		actId = self:getCurActId()
	end

	bpId = bpId or self:getCurBpId(actId)

	if not self._actInfos[actId] or not self._actInfos[actId][bpId] then
		return
	end

	self._actInfos[actId][bpId].bonusInfos = self._actInfos[actId][bpId].bonusInfos or {}

	for _, info in ipairs(infos) do
		if not self._actInfos[actId][bpId].bonusInfos[info.level] then
			self._actInfos[actId][bpId].bonusInfos[info.level] = Anniversary3ActBpScoreBonusInfoMO.New()

			self._actInfos[actId][bpId].bonusInfos[info.level]:init()
		end

		self._actInfos[actId][bpId].bonusInfos[info.level]:update(info)
	end
end

function Anniversary3ActBpModel:updateActBpBonusInfo(infos, bpId, actId)
	if not actId or actId <= 0 then
		actId = self:getCurActId()
	end

	bpId = bpId or self:getCurBpId(actId)

	if not self._actInfos[actId] or not self._actInfos[actId][bpId] then
		return
	end

	for _, info in ipairs(infos) do
		if not self._actInfos[actId][bpId].bonusInfos[info.level] then
			self._actInfos[actId][bpId].bonusInfos[info.level] = Anniversary3ActBpScoreBonusInfoMO.New()

			self._actInfos[actId][bpId].bonusInfos[info.level]:init()
		end

		self._actInfos[actId][bpId].bonusInfos[info.level]:update(info)
	end
end

function Anniversary3ActBpModel:getActBpBonusInfo(lv, bpId, actId)
	if not actId or actId <= 0 then
		actId = self:getCurActId()
	end

	if not self._actInfos[actId] then
		return {}
	end

	bpId = bpId or self:getCurBpId(actId)

	if not self._actInfos[actId][bpId] then
		return {}
	end

	return self._actInfos[actId][bpId].bonusInfos[lv]
end

function Anniversary3ActBpModel:getCurActId()
	return self._actId or VersionActivity3_7Enum.ActivityId.Anniversary3ActBp
end

function Anniversary3ActBpModel:getCurBpId(actId)
	if not actId or actId <= 0 then
		actId = self:getCurActId()
	end

	if not self._actInfos[actId] then
		return 1
	end

	return self._actInfos[actId].bpId
end

function Anniversary3ActBpModel:updateScore(score, bpId, actId)
	if not actId or actId <= 0 then
		actId = self:getCurActId()
	end

	bpId = bpId or self:getCurBpId(actId)

	if not self._actInfos[actId] or not self._actInfos[actId][bpId] then
		return
	end

	self._actInfos[actId][bpId].score = score
end

function Anniversary3ActBpModel:getActBpScore(bpId, actId)
	if not actId or actId <= 0 then
		actId = self:getCurActId()
	end

	if not self._actInfos[actId] then
		return 0
	end

	bpId = bpId or self:getCurBpId(actId)

	if not self._actInfos[actId][bpId] then
		return 0
	end

	return self._actInfos[actId][bpId].score or 0
end

function Anniversary3ActBpModel:getActBpLevel(bpId, actId)
	if not actId or actId <= 0 then
		actId = self:getCurActId()
	end

	if not self._actInfos[actId] then
		return 0
	end

	bpId = bpId or self:getCurBpId(actId)

	if not self._actInfos[actId][bpId] then
		return 0
	end

	local levelScore = Activity233Config.instance:getLevelScore(bpId)
	local score = self:getActBpScore(bpId, actId)
	local level = math.floor(score / levelScore)
	local maxLv = #Activity233Config.instance:getBonusCos(self._bpId)

	return math.min(level, maxLv)
end

function Anniversary3ActBpModel:getActBpMinUngetRewardLevel(bpId, actId)
	if not actId or actId <= 0 then
		actId = self:getCurActId()
	end

	if not self._actInfos[actId] then
		return 0
	end

	bpId = bpId or self:getCurBpId(actId)

	if not self._actInfos[actId][bpId] then
		return 0
	end

	local curLevel = self:getActBpLevel(bpId, actId)

	for i = 1, curLevel do
		local mo = self:getActBpBonusInfo(i, bpId, actId)
		local hasGetFree = mo and mo.hasGetFreeBonus

		if not hasGetFree then
			return i
		end
	end

	return curLevel
end

function Anniversary3ActBpModel:isMaxLevel(bpId, actId)
	if not actId or actId <= 0 then
		actId = self:getCurActId()
	end

	if not self._actInfos[actId] then
		return false
	end

	bpId = bpId or self:getCurBpId(actId)

	if not self._actInfos[actId][bpId] then
		return false
	end

	local curLevel = self:getActBpLevel(bpId, actId)
	local bonusCos = Activity233Config.instance:getBonusCos(bpId)

	return curLevel >= #bonusCos
end

function Anniversary3ActBpModel:updatePayStatus(payStatus, bpId, actId)
	if not actId or actId <= 0 then
		actId = self:getCurActId()
	end

	bpId = bpId or self:getCurBpId(actId)

	if not self._actInfos[actId] or not self._actInfos[actId][bpId] then
		return
	end

	self._actInfos[actId][bpId].payStatus = payStatus
end

function Anniversary3ActBpModel:getPayStatus(bpId, actId)
	if not actId or actId <= 0 then
		actId = self:getCurActId()
	end

	if not self._actInfos[actId] then
		return 0
	end

	bpId = bpId or self:getCurBpId(actId)

	if not self._actInfos[actId][bpId] then
		return 0
	end

	return self._actInfos[actId][bpId].payStatus or 0
end

function Anniversary3ActBpModel:isPremiumPayed(bpId, actId)
	if not actId or actId <= 0 then
		actId = self:getCurActId()
	end

	if not self._actInfos[actId] then
		return false
	end

	bpId = bpId or self:getCurBpId(actId)

	if not self._actInfos[actId][bpId] then
		return false
	end

	return self._actInfos[actId][bpId].payStatus == Anniversary3ActBpEnum.PayStatus.Payed
end

function Anniversary3ActBpModel:hasKeyBonusBetweenLvs(fromLv, toLv, bpId, actId)
	if not actId or actId <= 0 then
		actId = self:getCurActId()
	end

	if not self._actInfos[actId] then
		return false
	end

	bpId = bpId or self:getCurBpId(actId)

	if not self._actInfos[actId][bpId] then
		return false
	end

	if toLv <= fromLv then
		return false
	end

	local level = self:getActBpLevel(bpId, actId)
	local bonusCos = Activity233Config.instance:getBonusCos(bpId)

	for i = fromLv, toLv do
		if bonusCos[i] and bonusCos[i].keyBonus >= 1 then
			local mo = self:getActBpBonusInfo(i, bpId, actId)
			local hasGetFree = mo and mo.hasGetFreeBonus
			local canGetFree = level >= bonusCos[i].level

			if not hasGetFree and canGetFree then
				return true
			end
		end
	end

	return false
end

function Anniversary3ActBpModel:setWaitShowRewards(rewards)
	self._waitShowRewards = rewards
end

function Anniversary3ActBpModel:getWaitShowRewards()
	return self._waitShowRewards
end

function Anniversary3ActBpModel:hasBonusRewardCouldGet(bpId, actId)
	if not actId or actId <= 0 then
		actId = self:getCurActId()
	end

	if not self._actInfos[actId] then
		return false
	end

	bpId = bpId or self:getCurBpId(actId)

	if not self._actInfos[actId][bpId] then
		return false
	end

	local level = self:getActBpLevel(bpId, actId)
	local bonusCos = Activity233Config.instance:getBonusCos(bpId)

	for i = 1, #bonusCos do
		local mo = self:getActBpBonusInfo(bonusCos[i].level, bpId, actId)
		local hasGetFree = mo and mo.hasGetFreeBonus
		local canGetFree = level >= bonusCos[i].level
		local canget = canGetFree and not hasGetFree

		if canget then
			return true
		end

		local hasGetPay = mo and mo.hasGetPayBonus
		local hasPay = self:isPremiumPayed(bpId, actId)
		local canGetPay = canGetFree and hasPay and not hasGetPay

		if canGetPay then
			return true
		end
	end

	return false
end

function Anniversary3ActBpModel:hasTaskRewardCouldGet(bpId, actId)
	if not actId or actId <= 0 then
		actId = self:getCurActId()
	end

	if not self._actInfos[actId] then
		return false
	end

	bpId = bpId or self:getCurBpId(actId)

	if not self._actInfos[actId][bpId] then
		return false
	end

	local weekCouldGet = self:isTaskLoopTypeHasRewardCouldGet(TaskEnum.TaskLoopType.Weekly, bpId, actId)

	if weekCouldGet then
		return true
	end

	local permanentCouldGet = self:isTaskLoopTypeHasRewardCouldGet(TaskEnum.TaskLoopType.Permanent, bpId, actId)

	if permanentCouldGet then
		return true
	end

	return false
end

function Anniversary3ActBpModel:isTaskLoopTypeHasRewardCouldGet(loopType, bpId, actId)
	if not actId or actId <= 0 then
		actId = self:getCurActId()
	end

	if not self._actInfos[actId] then
		return false
	end

	bpId = bpId or self:getCurBpId(actId)

	if not self._actInfos[actId][bpId] then
		return false
	end

	local taskList = Anniversary3ActBpModel.instance:getAllTaskByType(loopType, bpId, actId)

	for _, taskMo in pairs(taskList) do
		if taskMo.finishCount < 1 and taskMo.progress >= taskMo.config.maxProgress then
			return true
		end
	end

	return false
end

function Anniversary3ActBpModel.sortRewardsByRare(objA, objB)
	local aConfig = ItemModel.instance:getItemConfig(objA.materilType, objA.materilId)
	local bConfig = ItemModel.instance:getItemConfig(objB.materilType, objB.materilId)

	if aConfig.rare then
		if not aConfig.rare then
			local aRare = 5

			if bConfig.rare then
				if not bConfig.rare then
					local bRare = 5

					if aRare ~= bRare then
						return bRare < aRare
					end

					return objA.materilId < objB.materilId
				end
			end
		end
	end
end

Anniversary3ActBpModel.instance = Anniversary3ActBpModel.New()

return Anniversary3ActBpModel
