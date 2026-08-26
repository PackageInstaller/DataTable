-- chunkname: @modules/logic/sp01/act205/controller/Act205CardController.lua

module("modules.logic.sp01.act205.controller.Act205CardController", package.seeall)

local Act205CardController = class("Act205CardController", BaseController)

function Act205CardController:onInit()
	return
end

function Act205CardController:reInit()
	return
end

function Act205CardController:openCardEnterView()
	local gameStageId = Act205CardModel.instance:getGameStageId()
	local isGameStageOpen = Act205Model.instance:isGameStageOpen(gameStageId, true)

	if not isGameStageOpen then
		return
	end

	local actId = Act205Model.instance:getAct205Id()

	Activity205Rpc.instance:sendAct205GetInfoRequest(actId, self._realOpenCardEnterView, self)
end

function Act205CardController:_realOpenCardEnterView(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local viewParam = {}
	local actId = Act205Model.instance:getAct205Id()

	viewParam.activityId = actId
	viewParam.gameStageId = Act205CardModel.instance:getGameStageId()

	Activity205Rpc.instance:sendAct205GetGameInfoRequest(actId)
	ViewMgr.instance:openView(ViewName.Act205GameStartView, viewParam)
end

function Act205CardController:enterCardGame()
	Act205CardModel.instance:clearSelectedCard()

	local gameStageId = Act205CardModel.instance:getGameStageId()
	local isGameStageOpen = Act205Model.instance:isGameStageOpen(gameStageId, true)

	if not isGameStageOpen then
		return
	end

	local gameCount = Act205CardModel.instance:getGameCount()

	if gameCount <= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.Act205CardSelectView)
end

function Act205CardController:openCardShowView()
	ViewMgr.instance:openView(ViewName.Act205CardShowView)
	ViewMgr.instance:closeView(ViewName.Act205CardSelectView)
end

function Act205CardController:openCardResultView(resultPoint, rewardId)
	ViewMgr.instance:openView(ViewName.Act205CardResultView, {
		point = resultPoint,
		rewardId = rewardId
	})
end

function Act205CardController:beginNewCardGame()
	local gameStageId = Act205CardModel.instance:getGameStageId()
	local isGameStageOpen = Act205Model.instance:isGameStageOpen(gameStageId, true)

	if not isGameStageOpen then
		return
	end

	local actId = Act205Model.instance:getAct205Id()

	Activity205Rpc.instance:sendAct205GetInfoRequest(actId, self._onBeginNewCardGame, self)
end

function Act205CardController:_onBeginNewCardGame(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local actId = Act205Model.instance:getAct205Id()

	Activity205Rpc.instance:sendAct205GetGameInfoRequest(actId)
	self:enterCardGame()
	ViewMgr.instance:closeView(ViewName.Act205CardShowView)
	ViewMgr.instance:closeView(ViewName.Act205CardResultView)
end

function Act205CardController:getEnemyCardIdList()
	local result = Act205CardModel.instance:getCacheKeyData(Act205Enum.CardGameCacheKey.EnemyCard)

	result = result or self:_generateCardIdList(false)

	return result
end

function Act205CardController:getPlayerCardIdList()
	local result = Act205CardModel.instance:getCacheKeyData(Act205Enum.CardGameCacheKey.PlayerCard)

	result = result or self:_generateCardIdList(true)

	return result
end

local function _sortCard(cardA, cardB)
	local cardTypeA = Act205Config.instance:getCardType(cardA)
	local cardTypeB = Act205Config.instance:getCardType(cardB)

	if cardTypeA ~= cardTypeB then
		return cardTypeB < cardTypeA
	end

	return cardA < cardB
end

function Act205CardController:_generateCardIdList(isPlayer, hasAppearedCardList)
	local result = {}

	if isPlayer then
		if not Act205Enum.ConstId.CardGamePlayerCardCount then
			local needCardConstId = Act205Enum.ConstId.CardGameEnemyCardCount
			local needCardCount = Act205Config.instance:getAct205Const(needCardConstId, true)

			if not needCardCount or needCardCount < 0 then
				return result
			end

			local hasAppearedCardDict = {}

			if hasAppearedCardList then
				for _, cardId in ipairs(hasAppearedCardList) do
					hasAppearedCardDict[cardId] = true
				end
			end

			local enemyCardDict = {}

			if isPlayer then
				local enemyCardList = Act205CardModel.instance:getCacheKeyData(Act205Enum.CardGameCacheKey.EnemyCard)

				if enemyCardList then
					for _, enemyCardId in ipairs(enemyCardList) do
						local enemyCardType = Act205Config.instance:getCardType(enemyCardId)

						enemyCardDict[enemyCardType] = enemyCardId
					end
				end
			end

			local strGuarantee = Act205Config.instance:getAct205Const(Act205Enum.ConstId.MinimumGuaranteeCard)
			local arr = string.splitToNumber(strGuarantee, "#")
			local guaranteeFailCount, guaranteeCardId = arr[1], arr[2]
			local continueFailCount = Act205CardModel.instance:getContinueFailCount()
			local type2CardDict = Act205Config.instance:getCardTypeDict()

			for cardType, cardList in pairs(type2CardDict) do
				local restrainEnemyCardId
				local enemyCardId = enemyCardDict[cardType]
				local indices = {}
				local totalWeight = 0
				local tmpNeedCardCount = needCardCount

				for i, cardId in ipairs(cardList) do
					local isSp = Act205Config.instance:isSpCard(cardId)

					if not isSp or isPlayer then
						if cardId == ((enemyCardId or nil) and Act205Config.instance:getBeRestrainedCard(enemyCardId)) or cardId == ((continueFailCount < guaranteeFailCount or nil) and nil) then
							table.insert(result, cardId)

							tmpNeedCardCount = tmpNeedCardCount - 1
						else
							local weight = Act205Config.instance:getCardWeight(cardId, hasAppearedCardDict[cardId])

							totalWeight = totalWeight + weight
							indices[#indices + 1] = i
						end
					end
				end

				for _ = 1, tmpNeedCardCount do
					local remainCardCount = #indices

					if remainCardCount == 0 or totalWeight <= 0 then
						logError("Act205CardController:_generateCardIdList error, card not enough, cardType:%s, hasCount:%s, needCount:%s", cardType, #cardList, tmpNeedCardCount)

						break
					end

					local randomWeight = math.random(totalWeight)
					local compareWeight = 0

					for i = 1, remainCardCount do
						local idx = indices[i]
						local cardId = cardList[idx]
						local cardWeight = Act205Config.instance:getCardWeight(cardId, hasAppearedCardDict[cardId])

						compareWeight = compareWeight + cardWeight

						if randomWeight <= compareWeight then
							table.insert(result, cardId)

							totalWeight = totalWeight - cardWeight

							table.remove(indices, i)

							break
						end
					end
				end
			end

			table.sort(result, _sortCard)

			if isPlayer then
				if not Act205Enum.CardGameCacheKey.PlayerCard then
					local cacheKey = Act205Enum.CardGameCacheKey.EnemyCard

					Act205CardModel.instance:setCacheKeyData(cacheKey, result)

					return result
				end
			end
		end
	end
end

function Act205CardController:playerClickCard(cardId)
	local curIsSelected = Act205CardModel.instance:isCardSelected(cardId)

	Act205CardModel.instance:setSelectedCard(cardId, not curIsSelected)
	self:dispatchEvent(Act205Event.PlayerSelectCard, cardId)
end

function Act205CardController:checkPkPoint()
	local gameStageId = Act205CardModel.instance:getGameStageId()
	local isGameStageOpen = Act205Model.instance:isGameStageOpen(gameStageId, true)

	if not isGameStageOpen then
		return
	end

	local enemyCardList = Act205CardModel.instance:getCacheKeyData(Act205Enum.CardGameCacheKey.EnemyCard)

	if not enemyCardList then
		logError("Act205CardController.checkPkPoint error, no enemyCardList")

		return
	end

	local isCanPK = Act205CardModel.instance:getIsCanBeginPK()

	if not isCanPK then
		return
	end

	local resultPoint = Act205Config.instance:getAct205Const(Act205Enum.ConstId.CardGameBasePoint, true)

	for _, enemyCardId in ipairs(enemyCardList) do
		local cardType = Act205Config.instance:getCardType(enemyCardId)
		local playerCardId = Act205CardModel.instance:getSelectedCard(cardType)

		if not playerCardId then
			return
		end

		local pkResult = self:getCardPKResult(playerCardId, enemyCardId)

		Act205CardModel.instance:setPkResult(cardType, pkResult)

		resultPoint = resultPoint + pkResult
	end

	Act205CardModel.instance:setResultPoint(resultPoint)

	return resultPoint
end

function Act205CardController:getCardPKResult(cardId, targetCardId)
	local PKResult = Act205Enum.CardPKResult
	local result = PKResult.Draw
	local isSpCard = Act205Config.instance:isSpCard(cardId)

	if isSpCard then
		local spEff = Act205Config.instance:getSpEff(cardId)

		if spEff == Act205Enum.SpEffType.All then
			result = PKResult.Restrain
		elseif spEff == Act205Enum.SpEffType.Half then
			local isRestrained = math.random() < 0.5

			result = isRestrained and PKResult.Restrain or PKResult.BeRestrained
		else
			logError(string.format("Act205CardController:getCardPKResult error, spEff not support, spEff:%s", spEff))
		end
	else
		local restrained = Act205Config.instance:getIsCardRestrain(cardId, targetCardId)
		local beRestrained = Act205Config.instance:getIsCardBeRestrained(cardId, targetCardId)

		if restrained then
			result = PKResult.Restrain
		elseif beRestrained then
			result = PKResult.BeRestrained
		end
	end

	return result
end

local GET_REWARD_INTERVAL_TIME = 0.5

function Act205CardController:cardGameFinishGetReward()
	local nowTime = ServerTime.now()
	local lastGetTime = Act205CardModel.instance:getRecordRewardTime()

	if lastGetTime and nowTime - lastGetTime < GET_REWARD_INTERVAL_TIME then
		return
	end

	local gameStageId = Act205CardModel.instance:getGameStageId()
	local isGameStageOpen = Act205Model.instance:isGameStageOpen(gameStageId, true)

	if not isGameStageOpen then
		return
	end

	local resultPoint = Act205CardModel.instance:getResultPoint() or self:checkPkPoint()

	if not resultPoint then
		resultPoint = Act205Config.instance:getMaxPoint()

		Act205CardModel.instance:setResultPoint(resultPoint)
	end

	local isWin = resultPoint > Act205Enum.CardGameFailPoint
	local failCount = 0

	if not isWin then
		local curFailCount = Act205CardModel.instance:getContinueFailCount()

		failCount = curFailCount + 1
	end

	local rewardId = Act205Config.instance:getRewardId(resultPoint)
	local param = {}

	param.activityId = Act205Model.instance:getAct205Id()
	param.gameType = gameStageId
	param.gameInfo = tostring(failCount)
	param.rewardId = rewardId

	Activity205Rpc.instance:sendAct205FinishGameRequest(param, self._onGetCardGameReward, self)
	Act205CardModel.instance:setGetRewardTime(nowTime)
end

function Act205CardController:_onGetCardGameReward(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local resultPoint = Act205CardModel.instance:getResultPoint()

	self:openCardResultView(resultPoint, msg.rewardId)
	Act205CardModel.instance:setResultPoint()

	local actId = Act205Model.instance:getAct205Id()

	Activity205Rpc.instance:sendAct205GetGameInfoRequest(actId, self._generateCard, self)
end

function Act205CardController:_generateCard()
	local enemyAppearedCardList = Act205CardModel.instance:getCacheKeyData(Act205Enum.CardGameCacheKey.EnemyCard)

	self:_generateCardIdList(false, enemyAppearedCardList)

	local playerAppearedCardList = Act205CardModel.instance:getCacheKeyData(Act205Enum.CardGameCacheKey.PlayerCard)

	self:_generateCardIdList(true, playerAppearedCardList)
end

Act205CardController.instance = Act205CardController.New()

return Act205CardController
