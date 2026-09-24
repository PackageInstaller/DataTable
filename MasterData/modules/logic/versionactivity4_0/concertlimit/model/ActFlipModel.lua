-- chunkname: @modules/logic/versionactivity4_0/concertlimit/model/ActFlipModel.lua

module("modules.logic.versionactivity4_0.concertlimit.model.ActFlipModel", package.seeall)

local ActFlipModel = class("ActFlipModel", BaseModel)

function ActFlipModel:onInit()
	self:reInit()
end

function ActFlipModel:reInit()
	self._cardInfos = {}
	self._curCardIndex = nil
end

function ActFlipModel:setCardInfos(infos)
	self._cardInfos = {}

	for _, info in ipairs(infos) do
		local infoMO = ActFlipCardInfoMo.New()

		infoMO:init(info)

		self._cardInfos[info.cardId] = infoMO
	end
end

function ActFlipModel:updateCardInfo(cardInfo)
	if not cardInfo then
		return
	end

	if self._cardInfos[cardInfo.cardId] then
		self._cardInfos[cardInfo.cardId]:init(cardInfo)
	else
		local infoMO = ActFlipCardInfoMo.New()

		infoMO:init(cardInfo)

		self._cardInfos[cardInfo.cardId] = infoMO
	end
end

function ActFlipModel:getCardInfo(cardId)
	local id = cardId or self:getCurCardIndex()

	return self._cardInfos[id]
end

function ActFlipModel:setCardUnlock(cardId)
	if not self._cardInfos[cardId] then
		return
	end

	self._cardInfos[cardId].unlocked = true
end

function ActFlipModel:getBlockInfo(cardId, itemIndex)
	local cardInfo = self:getCardInfo(cardId)

	if not cardInfo then
		return nil
	end

	return cardInfo:getBlockMoByIndex(itemIndex)
end

function ActFlipModel:isCardUnlock(cardId)
	return self._cardInfos[cardId] and self._cardInfos[cardId].unlocked
end

function ActFlipModel:isBlockRewardGet(cardId, itemIndex)
	local blockInfo = self:getBlockInfo(cardId, itemIndex)

	if not blockInfo then
		return false
	end

	return true
end

function ActFlipModel:isBlockRewardCouldGet(cardId, itemIndex)
	local blockInfo = self:getBlockInfo(cardId, itemIndex)

	if blockInfo then
		return false
	end

	local row, col = self:getBlockPosByIndex(cardId, itemIndex)
	local blockMos = self:getBlockInfos(cardId)

	for _, blockMo in pairs(blockMos) do
		local startRow, startCol = self:getBlockPosByIndex(cardId, blockMo.topLeftIndex)
		local endRow, endCol = self:getBlockPosByIndex(cardId, blockMo.bottomRightIndex)

		if startRow <= row and row <= endRow and startCol <= col and col <= endCol then
			return false
		end
	end

	return true
end

function ActFlipModel:getBlockInfos(cardId)
	local cardInfo = self:getCardInfo(cardId)

	if not cardInfo then
		return nil
	end

	return (cardInfo:getBlockMos())
end

function ActFlipModel:getBlockPosByIndex(cardId, itemIndex)
	local cardCo = ActFlipConfig.instance:getCardCo(cardId)
	local rowCount = cardCo.row
	local row, col = math.floor(itemIndex / rowCount) + 1, itemIndex % rowCount

	return row, col
end

function ActFlipModel:couldGetCardCount(cardId)
	local actCo = ActFlipConfig.instance:getActCo(cardId)

	if not actCo then
		return 0
	end

	local itemCos = string.splitToNumber(actCo.cost, "#")
	local itemQuantity = ItemModel.instance:getItemQuantity(itemCos[1], itemCos[2])

	return (math.floor(itemQuantity / itemCos[3]))
end

function ActFlipModel:isCardRewardAllGet(cardId)
	local isUnlock = self:isCardUnlock(cardId)

	if not isUnlock then
		return false
	end

	local cardCo = ActFlipConfig.instance:getCardCo(cardId)

	if not cardCo then
		return false
	end

	for rowIndex = 1, cardCo.row do
		for colIndex = 1, cardCo.column do
			local index = (rowIndex - 1) * cardCo.column + colIndex - 1
			local isBigReward = self:isBigRewardBlock(cardId, index)
			local isGet = self:isBlockRewardGet(cardId, index)

			if not isBigReward and not isGet then
				return false
			end
		end
	end

	return true
end

function ActFlipModel:isBigRewardBlock(cardId, itemIndex)
	local blockInfo = self:getBlockInfo(cardId, itemIndex)

	if blockInfo then
		local isBig = self:isBigReward(blockInfo.rewardId)

		return isBig, blockInfo.topLeftIndex
	end

	local blockInfos = self:getBlockInfos(cardId)

	for _, getBlockInfo in pairs(blockInfos) do
		local isBig = self:isBigReward(getBlockInfo.rewardId)

		if isBig then
			if itemIndex >= getBlockInfo.topLeftIndex and itemIndex <= getBlockInfo.topLeftIndex + 1 then
				return true, getBlockInfo.topLeftIndex
			end

			if itemIndex <= getBlockInfo.bottomRightIndex and itemIndex >= getBlockInfo.bottomRightIndex - 1 then
				return true, getBlockInfo.topLeftIndex
			end
		end
	end

	return false, itemIndex
end

function ActFlipModel:isBigReward(rewardId)
	local rewardCo = ActFlipConfig.instance:getRewardCo(rewardId)

	if not rewardCo then
		return false
	end

	return rewardCo.area > 1
end

function ActFlipModel:setCurCardIndex(page)
	self._curCardIndex = page

	PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActFlipCardIndex), self._curCardIndex)
end

function ActFlipModel:getCurCardIndex()
	local actCos = ActFlipConfig.instance:getActCos()

	if not self._curCardIndex then
		self._curCardIndex = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActFlipCardIndex), 1)

		return self._curCardIndex
	end

	return self._curCardIndex
end

function ActFlipModel:getTotalCardCount(actId)
	actId = actId or VersionActivity4_0Enum.ActivityId.ConcertActFlip

	local actCos = ActFlipConfig.instance:getActCos(actId)

	if not actCos then
		return 0
	end

	return #actCos
end

function ActFlipModel:setCurBlockIndex(index)
	self._blockIndex = index
end

function ActFlipModel:getCurBlockIndex()
	return self._blockIndex
end

function ActFlipModel:getCardRewardsDetail(cardId)
	local getRewards = {}
	local notGetRewards = {}
	local cardCo = ActFlipConfig.instance:getCardCo(cardId)
	local rewardCos = GameUtil.splitString2(cardCo.reward)

	for _, rewardCo in ipairs(rewardCos) do
		local rewardId = tonumber(rewardCo[1])
		local rewardCount = tonumber(rewardCo[2])
		local rewardGetCount = self:getRewardCount(cardId, rewardId)

		for i = 1, rewardGetCount do
			table.insert(getRewards, rewardId)
		end

		if rewardGetCount < rewardCount then
			for i = 1, rewardCount - rewardGetCount do
				table.insert(notGetRewards, rewardId)
			end
		end
	end

	return notGetRewards, getRewards
end

function ActFlipModel:getRewardCount(cardId, rewardId)
	local count = 0
	local blockInfos = self:getBlockInfos(cardId)

	for _, blockInfo in pairs(blockInfos) do
		if blockInfo.rewardId == rewardId then
			count = count + 1
		end
	end

	return count
end

function ActFlipModel:getTaskList()
	local typeId = TaskEnum.TaskType.ConcerActFlip
	local actId = VersionActivity4_0Enum.ActivityId.ConcertActFlip
	local taskMos = TaskModel.instance:getTaskMoList(typeId, actId)
	local taskList = {}

	for _, taskMo in pairs(taskMos) do
		local isActFinished = ActivityModel.instance:getRemainTimeSec(taskMo.config.openLimitActId) <= 0
		local isTaskExist = self:isTaskFinished(taskMo.id, actId) or self:isTaskCanGet(taskMo.id, actId)

		if not isActFinished or isTaskExist then
			local isFinished = self:isTaskFinished(taskMo.id, actId)

			if isFinished then
				table.insert(taskList, taskMo)
			elseif LuaUtil.isEmptyStr(taskMo.config.prepose) then
				table.insert(taskList, taskMo)
			else
				local isPreFinished = self:isTaskFinished(tonumber(taskMo.config.prepose), actId)

				if isPreFinished then
					table.insert(taskList, taskMo)
				end
			end
		end
	end

	table.sort(taskList, function(a, b)
		local aCanGet = self:isTaskCanGet(a.id)
		local bCanGet = self:isTaskCanGet(b.id)
		local aFinish = self:isTaskFinished(a.id)
		local bFinish = self:isTaskFinished(b.id)
		local aValue = aFinish and 3 or aCanGet and 1 or 2
		local bValue = bFinish and 3 or bCanGet and 1 or 2

		if aValue ~= bValue then
			return aValue < bValue
		elseif a.config.sorting ~= b.config.sorting then
			return a.config.sorting < b.config.sorting
		else
			return a.config.id < b.config.id
		end
	end)

	return taskList
end

function ActFlipModel:isTaskCanGet(taskId, actId)
	actId = actId or VersionActivity4_0Enum.ActivityId.ConcertActFlip

	local taskMo = TaskModel.instance:getTaskById(taskId)

	return taskMo and taskMo.progress >= taskMo.config.maxProgress and taskMo.finishCount == 0
end

function ActFlipModel:isTaskFinished(taskId, actId)
	actId = actId or VersionActivity4_0Enum.ActivityId.ConcertActFlip

	local taskMo = TaskModel.instance:getTaskById(taskId)

	return taskMo and taskMo.finishCount > 0
end

ActFlipModel.instance = ActFlipModel.New()

return ActFlipModel
