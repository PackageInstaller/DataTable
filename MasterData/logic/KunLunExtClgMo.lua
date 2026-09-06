-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kunlunchallenge/view/KunLunExtClgMo.lua

module("logic.extensions.kunlunchallenge.view.KunLunExtClgMo", package.seeall)

local KunLunExtClgMo = class("KunLunExtClgMo")

function KunLunExtClgMo:ctor(activityId)
	self._activityId = activityId
	self._actData = KunLunChallengeConfig.instance:getKlActData(self._activityId)
	self._cardCfgs = KunLunChallengeConfig.instance:getKlExtCardCfgs(self._activityId)
	self._stageDataList = KunLunChallengeConfig.instance:getKlExtStageDataList(self._activityId)
	self._cardDataList = KunLunChallengeConfig.instance:getKlExtCardDataListById(self._activityId)
	self._extremeCardNum = self._actData.extremeCardNum
	self._isAllStagePass = false
	self._passInfos = {}
	self._jumpStageId = 0
	self._cardIdListsOfStage = {}

	for stageId, stageData in ipairs(self._stageDataList) do
		self._cardIdListsOfStage[stageId] = {}

		for i = 1, self._extremeCardNum do
			table.insert(self._cardIdListsOfStage[stageId], 0)
		end
	end

	self._cardIdListOfGroup = {}

	for groupId, cardCfg in ipairs(self._cardCfgs) do
		self._cardIdListOfGroup[groupId] = {}

		for index, cardData in ipairs(cardCfg) do
			self._cardIdListOfGroup[groupId][index] = cardData.cardId
		end
	end

	self._cardIdInfoList = {}

	for _, data in ipairs(self._cardDataList) do
		local info = {}

		info.cardId = data.cardId
		info.groupId = data.groupId
		info.useStageId = 0
		self._cardIdInfoList[info.cardId] = info
	end
end

function KunLunExtClgMo:getActivityId()
	return self._activityId
end

function KunLunExtClgMo:deepcopy()
	return TableUtil.deepcopy(self)
end

function KunLunExtClgMo:isAllStagePass()
	return self._isAllStagePass
end

function KunLunExtClgMo:setAllStagePass(isPass)
	self._isAllStagePass = isPass
end

function KunLunExtClgMo:isPassStage(stageId)
	return self._passInfos[stageId]
end

function KunLunExtClgMo:setPassStage(stageId, isPass)
	self._passInfos[stageId] = isPass
end

function KunLunExtClgMo:getTryDiscardCardResultAndTips(stageId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not KunLunChallengeController.instance:isInActivityTime(self._activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self:isAllStagePass() then
		result = GameEnum.ResultCode.Error
		tips = "已通关 不可弃牌"
	elseif self:getUseNumOfCardInStage(stageId) <= 0 then
		result = GameEnum.ResultCode.Error
		tips = "没有可丢弃的牌"
	end

	return result, tips
end

function KunLunExtClgMo:getTryAutoCardResultAndTips(stageId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not KunLunChallengeController.instance:isInActivityTime(self._activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self:getLeftNumOfCardInStage(stageId) <= 0 then
		result = GameEnum.ResultCode.Error
		tips = "没有可填入的空位"
	end

	return result, tips
end

function KunLunExtClgMo:getTryEnterExtFmtResultAndTips(stageId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not KunLunChallengeController.instance:isInActivityTime(self._activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self:isAllStagePass() then
		result = GameEnum.ResultCode.Error
		tips = "已通关 不可挑战"
	elseif self:isPassStage(stageId) then
		result = GameEnum.ResultCode.Error
		tips = "本关卡已通关"
	end

	return result, tips
end

function KunLunExtClgMo:getTryStartExtFightResultAndTips(stageId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not KunLunChallengeController.instance:isInActivityTime(self._activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self:isPassStage(stageId) then
		result = GameEnum.ResultCode.Error
		tips = "本关卡已通关"
	elseif self:isAllStagePass() then
		result = GameEnum.ResultCode.Error
		tips = "已通关 不可挑战"
	elseif self:getLeftNumOfCardInStage(stageId) > 0 then
		result = GameEnum.ResultCode.Error
		tips = "请退出该界面 必须填满三张卡牌后进行挑战"
	end

	return result, tips
end

function KunLunExtClgMo:getLeftNumOfCardInGroup(groupId)
	local totalNum = self:getTotalNumOfCardInGroup(groupId)
	local useNum = self:getUseNumOfCardInGroup(groupId)

	return Mathf.Max(totalNum - useNum, 0)
end

function KunLunExtClgMo:getUseNumOfCardInGroup(groupId)
	local useNum = 0

	if not self._cardIdListOfGroup[groupId] then
		for _, cardId in ipairs(self._cardIdListOfGroup[groupId]) do
			if self:isHasUseOfCard(cardId) then
				useNum = useNum + 1
			end
		end

		return useNum
	end
end

function KunLunExtClgMo:getTotalNumOfCardInGroup(groupId)
	return #self._cardIdListOfGroup[groupId]
end

function KunLunExtClgMo:getLeftNumOfCardInStage(stageId)
	local totalNum = self:getTotalNumOfCardInStage(stageId)
	local useNum = self:getUseNumOfCardInStage(stageId)

	return Mathf.Max(totalNum - useNum, 0)
end

function KunLunExtClgMo:getUseNumOfCardInStage(stageId)
	local useNum = 0
	local cardIdList = self:getCardIdListOfStage(stageId)

	for _, cardId in ipairs(cardIdList) do
		if cardId > 0 then
			useNum = useNum + 1
		end
	end

	return useNum
end

function KunLunExtClgMo:getTotalNumOfCardInStage()
	return self._extremeCardNum
end

function KunLunExtClgMo:isHasUseOfCard(cardId)
	return self:getUseStageId(cardId) > 0
end

function KunLunExtClgMo:getUseStageId(cardId)
	local info = self._cardIdInfoList[cardId]

	return (info or nil) and info.useStageId
end

function KunLunExtClgMo:isHasUseOfCardInStage(stageId, cardId)
	return self:getUseStageId(cardId) == stageId
end

function KunLunExtClgMo:getGroupIdOfCardBelong(cardId)
	local info = self._cardIdInfoList[cardId]

	return (info or nil) and info.groupId
end

function KunLunExtClgMo:getCardIdOfStageByIdx(stageId, index)
	return checknumber(self._cardIdListsOfStage[stageId][index])
end

function KunLunExtClgMo:getCardIdListOfStage(stageId)
	return self._cardIdListsOfStage[stageId]
end

function KunLunExtClgMo:setCardIdListOfStage(stageId, cardIdList)
	cardIdList = cardIdList or {}

	local totalNum = self:getTotalNumOfCardInStage()

	for index = 1, totalNum do
		local cardId = checknumber(cardIdList[index])

		self:addCardToStage(stageId, cardId, index)
	end
end

function KunLunExtClgMo:addCardToStage(stageId, newCardId, index)
	index = checknumber(index)

	local cardIdList = self._cardIdListsOfStage[stageId]

	if index <= 0 then
		local totalNum = self:getTotalNumOfCardInStage()

		for idx = 1, totalNum do
			local id = checknumber(cardIdList[idx])

			if id <= 0 then
				index = idx

				break
			end
		end
	end

	local oldCardId = cardIdList[index]
	local oldInfo = self._cardIdInfoList[oldCardId]

	if oldInfo then
		oldInfo.useStageId = 0
	end

	local newInfo = self._cardIdInfoList[newCardId]

	if newInfo then
		newInfo.useStageId = stageId
	end

	for i = 1, index - 1 do
		if checknumber(cardIdList[i]) <= 0 then
			cardIdList[i] = 0
		end
	end

	cardIdList[index] = newCardId

	return index
end

function KunLunExtClgMo:getSameGroupCardIndex(stageId, tarCardId)
	local index = 0

	if tarCardId > 0 then
		local tarGroupId = self:getGroupIdOfCardBelong(tarCardId)

		for idx, cardId in ipairs(self._cardIdListsOfStage[stageId]) do
			if cardId > 0 then
				local groupId = self:getGroupIdOfCardBelong(cardId)

				if groupId == tarGroupId then
					index = idx

					break
				end
			end
		end
	end

	return index
end

function KunLunExtClgMo:getAutoFullCardIdList(stageId)
	local newCardIdList = {}
	local oldCardIdList = self._cardIdListsOfStage[stageId]
	local cardIdListGroup = {}

	for groupId, cardIdList in ipairs(self._cardIdListOfGroup) do
		cardIdListGroup[groupId] = {}

		for _, cardId in ipairs(cardIdList) do
			if not self:isHasUseOfCard(cardId) then
				table.insert(cardIdListGroup[groupId], cardId)
			end
		end
	end

	local totalNum = self:getTotalNumOfCardInStage()

	for index = 1, totalNum do
		local oldCardId = checknumber(oldCardIdList[index])

		if oldCardId > 0 then
			newCardIdList[index] = oldCardId

			table.clear(cardIdListGroup[self:getGroupIdOfCardBelong(oldCardId)])
		end
	end

	for index = 1, totalNum do
		local oldCardId = checknumber(oldCardIdList[index])

		if oldCardId <= 0 then
			local fitGroupId = 0
			local fitCardId = 0
			local maxLeftNum = 0

			for groupId, cardIdList in ipairs(cardIdListGroup) do
				local leftNum = #cardIdList

				if maxLeftNum < leftNum then
					fitGroupId = groupId
					maxLeftNum = leftNum
				end
			end

			if fitGroupId > 0 then
				fitCardId = cardIdListGroup[fitGroupId][Mathf.Random(1, #cardIdListGroup[fitGroupId])]

				table.clear(cardIdListGroup[fitGroupId])
			end

			newCardIdList[index] = fitCardId
		end
	end

	return newCardIdList
end

function KunLunExtClgMo:getJumpStageId()
	return self._jumpStageId
end

function KunLunExtClgMo:setJumpStageId(stageId)
	self._jumpStageId = stageId
end

function KunLunExtClgMo:clearJumpStageId()
	self:setJumpStageId(0)
end

return KunLunExtClgMo
