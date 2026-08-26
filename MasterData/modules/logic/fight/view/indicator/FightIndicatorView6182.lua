-- chunkname: @modules/logic/fight/view/indicator/FightIndicatorView6182.lua

module("modules.logic.fight.view.indicator.FightIndicatorView6182", package.seeall)

local FightIndicatorView6182 = class("FightIndicatorView6182", FightIndicatorView)

function FightIndicatorView6182:initView(indicatorMgrView, indicatorId, totalIndicatorNum)
	FightIndicatorView6182.super.initView(self, indicatorMgrView, indicatorId, totalIndicatorNum)

	self.totalIndicatorNum = 3
end

function FightIndicatorView6182:getCardConfig()
	return Season123Config.instance:getSeasonEquipCo(self:getCardId())
end

function FightIndicatorView6182:getCardId()
	return 180041
end

return FightIndicatorView6182
