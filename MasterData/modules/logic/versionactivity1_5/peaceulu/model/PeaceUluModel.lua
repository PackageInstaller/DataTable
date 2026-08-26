-- chunkname: @modules/logic/versionactivity1_5/peaceulu/model/PeaceUluModel.lua

module("modules.logic.versionactivity1_5.peaceulu.model.PeaceUluModel", package.seeall)

local PeaceUluModel = class("PeaceUluModel", BaseModel)

function PeaceUluModel:ctor()
	self.super:ctor()

	self.serverTaskModel = BaseModel.New()
end

function PeaceUluModel:setActivityInfo(info)
	self.removeNum = info.removeNum
	self.gameNum = info.gameNum
	self.hasGetBonusIds = info.hasGetBonusIds
	self.lastGameRecord = info.lastGameRecord

	self.serverTaskModel:clear()
	self:setTasksInfo(info.tasks)
end

function PeaceUluModel:onGetRemoveTask(msg)
	self.taskId = msg.taskId
	self.removeNum = msg.removeNum

	self:setTasksInfo(msg.tasks)
	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.OnUpdateInfo)
end

function PeaceUluModel:checkTaskId()
	if self.taskId then
		return true
	end

	return false
end

function PeaceUluModel:cleanTaskId()
	if self.taskId then
		self.taskId = nil
	end
end

function PeaceUluModel:getLastGameRecord()
	return self.lastGameRecord
end

function PeaceUluModel:onGetGameResult(info)
	self.gameRes = info.gameRes
	self.removeNum = info.removeNum
	self.gameNum = info.gameNum
	self.lastSelect = info.content

	self:setOtherChoice()
	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.onGetGameResult)
end

function PeaceUluModel:onUpdateReward(info)
	self.hasGetBonusIds = info.hasGetBonusIds
	self.bonusIds = info.bonusIds
end

function PeaceUluModel:checkBonusIds()
	if self.bonusIds then
		return true
	end

	return false
end

function PeaceUluModel:cleanBonusIds()
	if self.bonusIds then
		self.bonusIds = nil
	end
end

function PeaceUluModel:checkCanRemove()
	if not self.removeNum or self.removeNum == 0 then
		return false
	end

	return true
end

function PeaceUluModel:checkCanPlay()
	if not self.gameNum then
		return
	end

	local configNum = PeaceUluConfig.instance:getGameTimes()

	if configNum > self.gameNum then
		return true
	end

	return false
end

function PeaceUluModel:getRemoveNum()
	if not self.removeNum or self.removeNum == 0 then
		return false
	end

	return self.removeNum
end

function PeaceUluModel:getGameHaveTimes()
	if not self.gameNum then
		return
	end

	local num = PeaceUluConfig.instance:getGameTimes()

	return num - self.gameNum
end

function PeaceUluModel:setOtherChoice()
	self.otherChoice = self.gameRes == PeaceUluEnum.GameResult.Draw and self.lastSelect or self.gameRes == PeaceUluEnum.GameResult.Win and self:_gameRule(self.lastSelect, true) or self:_gameRule(self.lastSelect, false)
end

function PeaceUluModel:_gameRule(select, isWin)
	if select == PeaceUluEnum.Game.Scissors then
		if isWin then
			return PeaceUluEnum.Game.Paper
		else
			return PeaceUluEnum.Game.Rock
		end
	elseif select == PeaceUluEnum.Game.Rock then
		if isWin then
			return PeaceUluEnum.Game.Scissors
		else
			return PeaceUluEnum.Game.Paper
		end
	elseif isWin then
		return PeaceUluEnum.Game.Rock
	else
		return PeaceUluEnum.Game.Scissors
	end
end

function PeaceUluModel:getGameRes()
	return self.gameRes
end

function PeaceUluModel:setPlaying(state)
	self._isPlaying = state
end

function PeaceUluModel:isPlaying()
	if self._isPlaying == true then
		return true
	end

	return false
end

function PeaceUluModel:getSchedule()
	local firstFillAmount = 0.1
	local maxFillAmount = 0.955
	local rewardColist = PeaceUluConfig.instance:getBonusCoList()
	local rewardCount = #rewardColist
	local firstNum = PeaceUluConfig.instance:getProgressByIndex(1)
	local havenum = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act145).quantity
	local currentIndex = 0
	local currentIndexNum = 0
	local nextIndexNum = 0

	for index, rewardco in ipairs(rewardColist) do
		local indexNum = PeaceUluConfig.instance:getProgressByIndex(index)

		if indexNum <= havenum then
			currentIndex = index
			currentIndexNum = PeaceUluConfig.instance:getProgressByIndex(index)
		else
			nextIndexNum = PeaceUluConfig.instance:getProgressByIndex(index)

			break
		end
	end

	local per = (maxFillAmount - firstFillAmount) / (rewardCount - 1)
	local progress = (havenum - currentIndexNum) / (nextIndexNum - currentIndexNum)

	return currentIndex == rewardCount and 1 or currentIndex - 1 + progress <= 0 and havenum / firstNum * firstFillAmount or firstFillAmount + per * (currentIndex - 1 + progress)
end

function PeaceUluModel:checkGetReward(bonusId)
	if self.hasGetBonusIds then
		for i, id in pairs(self.hasGetBonusIds) do
			if id == bonusId then
				return true
			end
		end
	end

	return false
end

function PeaceUluModel:checkGetAllReward()
	if self.hasGetBonusIds then
		local bonusCoList = PeaceUluConfig.instance:getBonusCoList()

		if #bonusCoList == #self.hasGetBonusIds then
			return true
		end
	end

	return false
end

function PeaceUluModel:getOtherChoice()
	return self.otherChoice
end

function PeaceUluModel:getTasksInfo()
	return self.serverTaskModel:getList()
end

function PeaceUluModel:setTasksInfo(taskInfoList)
	local hasChange

	for i, info in ipairs(taskInfoList) do
		local mo = self.serverTaskModel:getById(info.id)

		if mo then
			mo:update(info)
		else
			local co = PeaceUluConfig.instance:getTaskCo(info.id)

			if co then
				mo = TaskMo.New()

				mo:init(info, co)
				self.serverTaskModel:addAtLast(mo)
			end
		end

		hasChange = true
	end

	if hasChange then
		self:sortList()
	end

	return hasChange
end

function PeaceUluModel:sortList()
	self.serverTaskModel:sort(function(a, b)
		local aValue = a.finishCount > 0 and 3 or a.progress >= a.config.maxProgress and 1 or 2
		local bValue = b.finishCount > 0 and 3 or b.progress >= b.config.maxProgress and 1 or 2

		if aValue ~= bValue then
			return aValue < bValue
		else
			return a.config.id < b.config.id
		end
	end)
end

PeaceUluModel.instance = PeaceUluModel.New()

return PeaceUluModel
