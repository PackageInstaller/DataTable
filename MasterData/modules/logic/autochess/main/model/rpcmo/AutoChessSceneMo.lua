-- chunkname: @modules/logic/autochess/main/model/rpcmo/AutoChessSceneMo.lua

module("modules.logic.autochess.main.model.rpcmo.AutoChessSceneMo", package.seeall)

local AutoChessSceneMo = pureTable("AutoChessSceneMo")

function AutoChessSceneMo:init(data)
	self.stepEffectsMap = {}
	self.round = data.round

	self:updateSvrFight(data.fight)
	self:updateSvrMall(data.mall)
	self:updateSvrBaseInfo(data.baseInfo)

	self.extInfo = AutoChessSceneExtMo.New()

	self.extInfo:init(data.extInfo)
end

function AutoChessSceneMo:updateSvrFight(fight)
	self.fight = GameUtil.rpcInfoToMo(fight, AutoChessFightMo)
end

function AutoChessSceneMo:updateSvrBaseInfo(baseInfo)
	self.baseInfo = GameUtil.rpcInfoToMo(baseInfo, AutoChessBaseInfoMo)
end

function AutoChessSceneMo:updateSvrMall(data)
	local oldMallId

	if self.mall then
		oldMallId = self.mall:getNormalRegion().mallId
		self.lastRewardProgress = self.mall.rewardProgress
	end

	self.mall = GameUtil.rpcInfoToMo(data, AutoChessMallMo, self.mall)

	local newMallId = self.mall:getNormalRegion().mallId

	if oldMallId and oldMallId ~= newMallId then
		self.mallUpgrade = true
	end
end

function AutoChessSceneMo:updateSvrTurn(data)
	local turn = GameUtil.rpcInfoToMo(data, AutoChessTurnMo)

	self.fightEffectList = {}

	for _, step in ipairs(turn.step) do
		if step.actionType == AutoChessEnum.ActionType.FightData then
			local effect = step.effect[1]

			if effect and effect.effectType == AutoChessEnum.EffectType.FightUpdate then
				self:updateSvrFight(effect.fight)
			end
		else
			self.stepEffectsMap[step.actionType] = step.effect

			if step.actionType == AutoChessEnum.ActionType.Immediately then
				AutoChessController.instance:playStep(AutoChessEnum.ActionType.Immediately)
			end
		end
	end
end

function AutoChessSceneMo:delStepEffects(type)
	self.stepEffectsMap[type] = nil
end

function AutoChessSceneMo:cacheSvrFight()
	self.lastFight = self.fight
end

function AutoChessSceneMo:clearData()
	self.round = nil
	self.fight = nil
	self.mall = nil
	self.baseInfo = nil
	self.lastFight = nil
end

function AutoChessSceneMo:checkCostEnough(costType, cost)
	if costType == AutoChessStrEnum.CostType.Coin then
		if cost <= self.mall.coin then
			return true
		else
			return false, ToastEnum.AutoChessCoinNotEnough
		end
	elseif costType == AutoChessStrEnum.CostType.Hp then
		if cost < self.fight.mySideMaster.hp then
			return true
		else
			return false, ToastEnum.AutoChessHpNotEnough
		end
	end

	return false, ToastEnum.AutoChessCoinNotEnough
end

function AutoChessSceneMo:previewChange()
	self.baseInfo.preview = true

	local previewCoin = self.baseInfo.previewCoin

	if previewCoin ~= 0 then
		self.mall:updateCoin(self.mall.coin - previewCoin)
	end
end

return AutoChessSceneMo
