-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/model/fingergame/ChatRoomFingerGameModel.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.model.fingergame.ChatRoomFingerGameModel", package.seeall)

local ChatRoomFingerGameModel = class("ChatRoomFingerGameModel", BaseModel)

function ChatRoomFingerGameModel:onInit()
	self:reInit()
end

function ChatRoomFingerGameModel:reInit()
	self._resultType = ChatRoomEnum.GameResultType.None
end

function ChatRoomFingerGameModel:getBeginningToNow()
	local actId = VersionActivity3_4Enum.ActivityId.LaplaceChatRoom
	local actInfoMo = ActivityModel.instance:getActMO(actId)
	local startTimS = ServerTime.now() - actInfoMo:getRealStartTimeStamp()
	local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(startTimS)

	return startTimS, day, hour, min, sec
end

function ChatRoomFingerGameModel:initGameData()
	local _, day, _, _, _ = self:getBeginningToNow()

	day = day + 1

	if day <= 0 then
		day = 1
	end

	local difficultyCos = Activity225Config.instance:getFingerGameDifficultyCos()

	if day >= #difficultyCos then
		day = 1
	end

	self._difficulty = tonumber(difficultyCos[day].difficulty)
	self._resultType = ChatRoomEnum.GameResultType.None
	self._aiCards = {}
	self._playerCards = {}
	self._cardNum = 3
	self._isDiscardFlip = false

	math.randomseed(os.time())
end

function ChatRoomFingerGameModel:getDifficulty()
	return self._difficulty
end

function ChatRoomFingerGameModel:getResultType()
	return self._resultType
end

function ChatRoomFingerGameModel:getPlayerCards()
	return self._playerCards
end

function ChatRoomFingerGameModel:getAiCards()
	return self._aiCards
end

function ChatRoomFingerGameModel:endGame()
	return
end

function ChatRoomFingerGameModel:abandon()
	self._resultType = ChatRoomEnum.GameResultType.Defeat
end

function ChatRoomFingerGameModel:settleGame()
	local relation = self:getRestrainRelation(self._playerCards[1].cardType, self._aiCards[1].cardType)

	self._resultType = relation == 1 and ChatRoomEnum.GameResultType.Victory or relation == 3 and ChatRoomEnum.GameResultType.Defeat or ChatRoomEnum.GameResultType.Draw
end

function ChatRoomFingerGameModel:enterRound(round)
	self._round = round
end

function ChatRoomFingerGameModel:getRound()
	return self._round
end

function ChatRoomFingerGameModel:playerPlayACard(mo)
	table.insert(self._playerCards, mo)
end

function ChatRoomFingerGameModel:aiPlayACard(mo)
	table.insert(self._aiCards, mo)
end

function ChatRoomFingerGameModel:flipPlayerCard()
	for i, mo in ipairs(self._playerCards) do
		mo:setIsFlipped(true)
	end
end

function ChatRoomFingerGameModel:flipAICard()
	for i, mo in ipairs(self._aiCards) do
		mo:setIsFlipped(true)
	end
end

function ChatRoomFingerGameModel:playerDiscard(posIndex)
	table.remove(self._playerCards, posIndex)
end

function ChatRoomFingerGameModel:keepAIOneCard(index)
	self._aiCards[1] = self._aiCards[index]

	for i = 2, #self._aiCards do
		self._aiCards[i] = nil
	end
end

function ChatRoomFingerGameModel:getPlayerOneRoundCard()
	return self._playerCards[1]
end

function ChatRoomFingerGameModel:getPlayerThreeRoundCard()
	return self._playerCards[1]
end

function ChatRoomFingerGameModel:createRestrainCard(cardType, isFlipped)
	local restrainCardType = self:getRestrainCard(cardType)

	return (self:createCard(restrainCardType, isFlipped))
end

function ChatRoomFingerGameModel:createBeRestrainCard(cardType, isFlipped)
	local restrainCardType = self:getBeRestrainCard(cardType)

	return (self:createCard(restrainCardType, isFlipped))
end

function ChatRoomFingerGameModel:createCardRandom(isFlipped)
	local cardType = math.random(1, self._cardNum)

	return (self:createCard(cardType, isFlipped))
end

function ChatRoomFingerGameModel:createCard(cardType, isFlipped)
	local mo = ChatRoomFingerGameCardMO.New()

	mo:setData(cardType, isFlipped)

	return mo
end

function ChatRoomFingerGameModel:getRestrainCard(cardType)
	local card = cardType - 1

	if card < 1 then
		card = self._cardNum
	elseif card > self._cardNum then
		card = 1
	end

	return card
end

function ChatRoomFingerGameModel:getBeRestrainCard(cardType)
	local card = cardType + 1

	if card < 1 then
		card = self._cardNum
	elseif card > self._cardNum then
		card = 1
	end

	return card
end

function ChatRoomFingerGameModel:getRestrainRelation(a, b)
	if a == b then
		return 2
	elseif self:getRestrainCard(a) == b then
		return 3
	else
		return 1
	end
end

function ChatRoomFingerGameModel:setCurDayFingerGameCount(count)
	self._curDayGameCount = count
end

function ChatRoomFingerGameModel:getCurDayFingerGameCount()
	return self._curDayGameCount or 0
end

function ChatRoomFingerGameModel:setIsDiscardFlip(discard)
	self._isDiscardFlip = discard
end

function ChatRoomFingerGameModel:isDiscardFlip()
	return self._isDiscardFlip
end

ChatRoomFingerGameModel.instance = ChatRoomFingerGameModel.New()

return ChatRoomFingerGameModel
