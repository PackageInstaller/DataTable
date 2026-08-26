-- chunkname: @modules/logic/partygame/model/mo/BattleCardRewardMo.lua

module("modules.logic.partygame.model.mo.BattleCardRewardMo", package.seeall)

local BattleCardRewardMo = class("BattleCardRewardMo")

function BattleCardRewardMo:ctor()
	self.selectCount = 0
	self.cardIds = {}
	self.rewardHp = 0
end

function BattleCardRewardMo:update(data)
	tabletool.clear(self.cardIds)

	self.selectCount = data.SelectCount

	for i = 0, data.CardIds.Count - 1 do
		table.insert(self.cardIds, data.CardIds[i])
	end

	self.rewardHp = data.RewardHp
end

function BattleCardRewardMo:canSelect()
	logNormal("BattleCardRewardMo-canSelect->" .. self.selectCount .. " 奖励数量：" .. tabletool.len(self.cardIds))

	return self.selectCount ~= nil and self.selectCount ~= 0 and tabletool.len(self.cardIds) > 0
end

return BattleCardRewardMo
