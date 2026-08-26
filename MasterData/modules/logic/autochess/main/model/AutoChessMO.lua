-- chunkname: @modules/logic/autochess/main/model/AutoChessMO.lua

module("modules.logic.autochess.main.model.AutoChessMO", package.seeall)

local AutoChessMO = pureTable("AutoChessMO")

function AutoChessMO:updateSvrScene(data)
	self:updateSvrBaseInfo(data.baseInfo)
	self:updateSvrFight(data.fight)
	self:updateSvrMall(data.mall)
end

function AutoChessMO:updateSvrBaseInfo(data)
	self.sceneRound = data.sceneRound
	self.preview = data.preview
	self.previewCoin = data.previewCoin
	self.buyInfos = data.buyInfos
	self.collectionIds = data.collectionIds
end

function AutoChessMO:updateSvrMall(data, event)
	if self.svrMall then
		local region1 = AutoChessHelper.getMallRegionByType(self.svrMall.regions, AutoChessEnum.MallType.Normal)
		local region2 = AutoChessHelper.getMallRegionByType(data.regions, AutoChessEnum.MallType.Normal)

		if region1.mallId ~= region2.mallId then
			self.mallUpgrade = true
		end

		self.lastRewardProgress = self.svrMall.rewardProgress
	end

	self.svrMall = data
	self.svrMall.coin = tonumber(data.coin)

	if event then
		AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateMallData)
	end
end

function AutoChessMO:updateSvrMallCoin(value)
	value = tonumber(value)
	self.svrMall.coin = value

	AutoChessController.instance:dispatchEvent(AutoChessEvent.MallCoinChange)
end

function AutoChessMO:updateSvrMallRegion(data, event)
	for i = 1, #self.svrMall.regions do
		local region = self.svrMall.regions[i]

		if region.mallId == data.mallId then
			self.svrMall.regions[i] = data

			break
		end
	end

	if event then
		AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateMallRegion)
	end
end

function AutoChessMO:updateSvrTurn(data)
	self:updateSvrStep(data.step)
	self:analyzeStepList(self.svrStepList)
end

function AutoChessMO:analyzeStepList(stepList)
	self.fightEffectList = {}

	for _, step in ipairs(stepList) do
		if step.actionType == AutoChessEnum.ActionType.RoundStart then
			self.fightEffectList = step.effect
		elseif step.actionType == AutoChessEnum.ActionType.StartBuy then
			self.startBuyEffectList = step.effect
		elseif step.actionType == AutoChessEnum.ActionType.EndBuy then
			self.endBuyEffectList = step.effect
		elseif step.actionType == AutoChessEnum.ActionType.Immediately then
			AutoChessController.instance:dispatchEvent(AutoChessEvent.PlayStepList, step.effect)
		elseif step.actionType == AutoChessEnum.ActionType.FightData then
			local effect = step.effect[1]

			if effect and effect.effectType == AutoChessEnum.EffectType.FightUpdate then
				self:updateSvrFight(effect.fight)
			end
		end
	end
end

function AutoChessMO:cacheSvrFight()
	self.lastSvrFight = self.svrFight
end

function AutoChessMO:updateSvrFight(data)
	self.svrFight = AutoChessFightMO.New()

	self.svrFight:init(data)
end

function AutoChessMO:updateSvrStep(data)
	self.svrStepList = data
end

function AutoChessMO:freezeReply(mallId, type)
	local isLock = type == AutoChessEnum.FreeZeType.Freeze

	for _, region in ipairs(self.svrMall.regions) do
		if region.mallId == mallId then
			for _, chessItem in ipairs(region.items) do
				chessItem.freeze = isLock
			end

			break
		end
	end
end

function AutoChessMO:clearData()
	self.sceneRound = nil
	self.svrMall = nil
	self.svrFight = nil
	self.svrStepList = nil
end

function AutoChessMO:getChessPosition(x, y, fight)
	fight = fight or self.svrFight

	if x == AutoChessEnum.WarZone.Four then
		for _, chessPos in ipairs(fight.unwarZone.positions) do
			if chessPos.index == y - 1 then
				return chessPos
			end
		end
	else
		for _, warZone in ipairs(fight.warZones) do
			if warZone.id == x then
				for _, chessPos in ipairs(warZone.positions) do
					if chessPos.index == y - 1 then
						return chessPos
					end
				end
			end
		end
	end

	logError(string.format("异常:不存在战区%s站位%s的ChessPos数据", x, y))
end

function AutoChessMO:getChessPosition1(uid, fight)
	fight = fight or self.svrFight

	for _, warZone in ipairs(fight.warZones) do
		for _, chessPos in ipairs(warZone.positions) do
			if chessPos.chess.uid == uid then
				return chessPos, warZone.id
			end
		end
	end

	logError(string.format("异常:不存在包含棋子%s的ChessPos数据", uid))
end

function AutoChessMO:getEmptyPos(chessType)
	if chessType == AutoChessStrEnum.ChessType.Incubate then
		for _, chessPos in ipairs(self.svrFight.unwarZone.positions) do
			if chessPos.teamType == AutoChessEnum.TeamType.Player and tonumber(chessPos.chess.uid) == 0 then
				return self.svrFight.unwarZone.id, chessPos.index + 1
			end
		end
	else
		for _, warZone in ipairs(self.svrFight.warZones) do
			if chessType == AutoChessEnum.WarZoneType[warZone.type] then
				for _, chessPos in ipairs(warZone.positions) do
					if chessPos.teamType == AutoChessEnum.TeamType.Player and tonumber(chessPos.chess.uid) == 0 then
						return warZone.id, chessPos.index + 1
					end
				end
			end
		end
	end
end

function AutoChessMO:checkCostEnough(costType, cost)
	if costType == AutoChessStrEnum.CostType.Coin then
		if cost <= tonumber(self.svrMall.coin) then
			return true
		else
			return false, ToastEnum.AutoChessCoinNotEnough
		end
	elseif costType == AutoChessStrEnum.CostType.Hp then
		if cost < tonumber(self.svrFight.mySideMaster.hp) then
			return true
		else
			return false, ToastEnum.AutoChessHpNotEnough
		end
	end

	return false, ToastEnum.AutoChessCoinNotEnough
end

return AutoChessMO
