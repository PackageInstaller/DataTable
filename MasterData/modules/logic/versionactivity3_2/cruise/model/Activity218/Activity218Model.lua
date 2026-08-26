-- chunkname: @modules/logic/versionactivity3_2/cruise/model/Activity218/Activity218Model.lua

module("modules.logic.versionactivity3_2.cruise.model.Activity218.Activity218Model", package.seeall)

local Activity218Model = class("Activity218Model", BaseModel)

function Activity218Model:onInit()
	self:reInit()
end

function Activity218Model:reInit()
	self._actInfos = {}
end

function Activity218Model:getBeginningToNow()
	local actInfoMo = ActivityModel.instance:getActMO(self.activityId)
	local startTimS = ServerTime.now() - actInfoMo:getRealStartTimeStamp()
	local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(startTimS)

	return startTimS, day, hour, min, sec
end

function Activity218Model:setAct218Info(msg)
	self.activityId = msg.activityId
	self._actInfos[self.activityId] = self._actInfos[self.activityId] or {}
	self._actInfos[self.activityId].finishGameCount = msg.finishGameCount
	self._actInfos[self.activityId].totalCoinNum = msg.totalCoinNum
	self._actInfos[self.activityId].acceptedRewardId = self:convertAcceptedRewardId(msg.acceptedRewardId)

	if self._actInfos[self.activityId].gameRecord == nil then
		self._actInfos[self.activityId].gameRecord = Activity218GameRecordMo.New()
	end

	self._actInfos[self.activityId].gameRecord:parseJson(msg.gameRecord)
	self:refreshRedPoint()
end

function Activity218Model:convertAcceptedRewardId(acceptedRewardId)
	local value = acceptedRewardId - 1

	if value < 0 then
		value = 0
	end

	return value
end

function Activity218Model:updateFinishGameCount(count, actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseGame

	if not self._actInfos[actId] then
		return
	end

	self._actInfos[actId].finishGameCount = count
end

function Activity218Model:updateTotalCoinNum(num, actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseGame

	if not self._actInfos[actId] then
		return
	end

	self._actInfos[actId].totalCoinNum = num
end

function Activity218Model:updateAcceptedRewardId(rewardId, actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseGame

	if not self._actInfos[actId] then
		return
	end

	self._actInfos[actId].acceptedRewardId = self:convertAcceptedRewardId(rewardId)
end

function Activity218Model:refreshRedPoint()
	return
end

function Activity218Model:getRewardState(rewardId)
	local coinNum = Activity218Model.instance:getTotalCoinNum()
	local acceptedRewardId = Activity218Model.instance:getAcceptedRewardId()
	local cfg = Activity218Config.instance:getMilestoneBonusCfg(nil, rewardId)
	local isLock = coinNum < cfg.coinNum
	local isReceive = acceptedRewardId >= cfg.rewardId
	local canGet = not isReceive and not isLock

	return isLock, isReceive, canGet
end

function Activity218Model:getFinishGameCount()
	return self._actInfos[self.activityId].finishGameCount
end

function Activity218Model:getTotalCoinNum()
	return self._actInfos[self.activityId].totalCoinNum
end

function Activity218Model:getAcceptedRewardId()
	return self._actInfos[self.activityId].acceptedRewardId
end

function Activity218Model:getGameRecordMo()
	return self._actInfos[self.activityId].gameRecord
end

function Activity218Model:startGame()
	local startTimS, day, hour, min, sec = self:getBeginningToNow()

	day = day + 1

	if day <= 0 then
		day = 1
	end

	self.difficulty = Activity218Config.instance:getDifficultly(day)
	self.resultType = Activity218Enum.GameResultType.None
	self.isGuarantee = self:getGameRecordMo():getNotWinCount() >= 3
	self.aiCards = {}
	self.playerCards = {}
	self.cardNum = 3

	math.randomseed(os.time())
	Activity218Controller.instance:log(string.format("游戏天数:%s", day))
	Activity218Controller.instance:log(string.format("是否触发保底:%s", self.isGuarantee))
	Activity218Controller.instance:log(string.format("游戏难度:%s", self.difficulty))
end

function Activity218Model:endGame()
	return
end

function Activity218Model:abandon()
	self.resultType = Activity218Enum.GameResultType.Defeat
end

function Activity218Model:settleGame()
	local relation = self:getRestrainRelation(self.playerCards[1].cardType, self.aiCards[1].cardType)

	self.resultType = relation == 1 and Activity218Enum.GameResultType.Victory or relation == 3 and Activity218Enum.GameResultType.Defeat or Activity218Enum.GameResultType.Draw
end

function Activity218Model:enterRound(round)
	self.round = round
end

function Activity218Model:playerPlayACard(mo)
	table.insert(self.playerCards, mo)
end

function Activity218Model:aiPlayACard(mo)
	table.insert(self.aiCards, mo)
end

function Activity218Model:flipPlayerCard()
	for i, mo in ipairs(self.playerCards) do
		mo:setIsFlipped(true)
	end
end

function Activity218Model:flipAICard()
	for i, mo in ipairs(self.aiCards) do
		mo:setIsFlipped(true)
	end
end

function Activity218Model:playerDiscard(posIndex)
	table.remove(self.playerCards, posIndex)
end

function Activity218Model:keepAIOneCard(index)
	self.aiCards[1] = self.aiCards[index]

	for i = 2, #self.aiCards do
		self.aiCards[i] = nil
	end
end

function Activity218Model:getPlayerOneRoundCard()
	return self.playerCards[1]
end

function Activity218Model:getPlayerThreeRoundCard()
	return self.playerCards[1]
end

function Activity218Model:createRestrainCard(cardType, isFlipped)
	local restrainCardType = self:getRestrainCard(cardType)

	return (self:createCard(restrainCardType, isFlipped))
end

function Activity218Model:createBeRestrainCard(cardType, isFlipped)
	local restrainCardType = self:getBeRestrainCard(cardType)

	return (self:createCard(restrainCardType, isFlipped))
end

function Activity218Model:createCardRandom(isFlipped)
	local cardType = math.random(1, self.cardNum)

	return (self:createCard(cardType, isFlipped))
end

function Activity218Model:createCard(cardType, isFlipped)
	local mo = CruiseGameCardMO.New()

	mo:setData(cardType, isFlipped)

	return mo
end

function Activity218Model:getRestrainCard(cardType)
	local card = cardType - 1

	if card < 1 then
		card = self.cardNum
	elseif card > self.cardNum then
		card = 1
	end

	return card
end

function Activity218Model:getBeRestrainCard(cardType)
	local card = cardType + 1

	if card < 1 then
		card = self.cardNum
	elseif card > self.cardNum then
		card = 1
	end

	return card
end

function Activity218Model:getRestrainRelation(a, b)
	if a == b then
		return 2
	elseif self:getRestrainCard(a) == b then
		return 3
	else
		return 1
	end
end

function Activity218Model:getCardTypeDebugName(cardType)
	if cardType == Activity218Enum.CardType.Rock then
		return "石头"
	elseif cardType == Activity218Enum.CardType.Scissors then
		return "剪刀"
	elseif cardType == Activity218Enum.CardType.Paper then
		return "布"
	else
		return "未知"
	end
end

Activity218Model.instance = Activity218Model.New()

return Activity218Model
