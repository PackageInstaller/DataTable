-- chunkname: @modules/logic/sp01/act205/model/Act205CardModel.lua

module("modules.logic.sp01.act205.model.Act205CardModel", package.seeall)

local Act205CardModel = class("Act205CardModel", BaseModel)

function Act205CardModel:onInit()
	self:reInit()
end

function Act205CardModel:reInit()
	self:clearData()
end

function Act205CardModel:clearData()
	self:setResultPoint()
	self:setGetRewardTime()
	self:clearSelectedCard()

	self._playerCacheData = nil
end

function Act205CardModel:_getPlayerCacheData()
	if not self._playerCacheData then
		local strCacheData = GameUtil.playerPrefsGetStringByUserId(Act205Enum.CardGameCacheDataPrefsKey, "")

		if not string.nilorempty(strCacheData) then
			self._playerCacheData = cjson.decode(strCacheData)
		end

		self._playerCacheData = self._playerCacheData or {}
	end

	return self._playerCacheData
end

function Act205CardModel:_savePlayerCacheData()
	if not self._playerCacheData then
		return
	end

	GameUtil.playerPrefsSetStringByUserId(Act205Enum.CardGameCacheDataPrefsKey, cjson.encode(self._playerCacheData))
end

function Act205CardModel:setSelectedCard(cardId, isSelected)
	local cardType = Act205Config.instance:getCardType(cardId)

	self._selectedCardTypeDict[cardType] = isSelected and cardId or nil
end

function Act205CardModel:clearSelectedCard()
	self._pkResult = {}
	self._selectedCardTypeDict = {}
end

function Act205CardModel:setResultPoint(point)
	self._resultPoint = point
end

function Act205CardModel:setCacheKeyData(key, data)
	local playerCacheData = self:_getPlayerCacheData()

	playerCacheData[key] = data

	self:_savePlayerCacheData()
end

function Act205CardModel:setCacheKeyDataByDict(keyDataDict)
	if not keyDataDict then
		return
	end

	local playerCacheData = self:_getPlayerCacheData()

	for key, data in pairs(keyDataDict) do
		playerCacheData[key] = data
	end

	self:_savePlayerCacheData()
end

function Act205CardModel:clearCacheKeyDataByList(keyList)
	if not keyList then
		return
	end

	local playerCacheData = self:_getPlayerCacheData()

	for _, key in ipairs(keyList) do
		playerCacheData[key] = nil
	end

	self:_savePlayerCacheData()
end

function Act205CardModel:setPkResult(cardType, result)
	self._pkResult[cardType] = result
end

function Act205CardModel:setGetRewardTime(time)
	self._getRewardTime = time
end

function Act205CardModel:getGameStageId()
	return Act205Enum.GameStageId.Card
end

function Act205CardModel:getGameCount()
	local actId = Act205Model.instance:getAct205Id()
	local stageId = self:getGameStageId()
	local gameInfoMo = Act205Model.instance:getGameInfoMo(actId, stageId)

	return (gameInfoMo or nil) and gameInfoMo:getHaveGameCount()
end

function Act205CardModel:getSelectedCard(cardType)
	return self._selectedCardTypeDict[cardType]
end

function Act205CardModel:isSelectedCardTypeCard(cardType)
	local playerCardId = self:getSelectedCard(cardType)

	return not not playerCardId
end

function Act205CardModel:getIsCanBeginPK()
	local result = true

	for _, cardType in pairs(Act205Enum.CardType) do
		local isSelected = self:isSelectedCardTypeCard(cardType)

		if not isSelected then
			result = false

			break
		end
	end

	return result
end

function Act205CardModel:isCardSelected(cardId)
	if not cardId then
		return
	end

	local cardType = Act205Config.instance:getCardType(cardId)
	local selectedCard = self:getSelectedCard(cardType)

	return selectedCard == cardId
end

local function _sortCard(cardA, cardB)
	local cardTypeA = Act205Config.instance:getCardType(cardA)
	local cardTypeB = Act205Config.instance:getCardType(cardB)

	if cardTypeA ~= cardTypeB then
		return cardTypeB < cardTypeA
	end

	return cardA < cardB
end

function Act205CardModel:getSelectedCardList()
	local result = {}

	if self._selectedCardTypeDict then
		for _, cardId in pairs(self._selectedCardTypeDict) do
			result[#result + 1] = cardId
		end
	end

	table.sort(result, _sortCard)

	return result
end

function Act205CardModel:getResultPoint()
	return self._resultPoint
end

function Act205CardModel:getCacheKeyData(key)
	local result

	if key then
		local playerCacheData = self:_getPlayerCacheData()

		result = playerCacheData[key]
	end

	return result
end

function Act205CardModel:getContinueFailCount()
	local result = 0
	local actId = Act205Model.instance:getAct205Id()
	local stageId = self:getGameStageId()
	local gameInfoMo = Act205Model.instance:getGameInfoMo(actId, stageId)

	if gameInfoMo then
		local gameInfo = gameInfoMo:getGameInfo()

		result = tonumber(gameInfo) or result
	end

	return result
end

function Act205CardModel:getPKResult(cardType)
	return self._pkResult[cardType] or Act205Enum.CardPKResult.Draw
end

function Act205CardModel:getRecordRewardTime()
	return self._getRewardTime
end

Act205CardModel.instance = Act205CardModel.New()

return Act205CardModel
