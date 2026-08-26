-- chunkname: @modules/logic/fight/view/indicator/FightIndicatorView6202.lua

module("modules.logic.fight.view.indicator.FightIndicatorView6202", package.seeall)

local FightIndicatorView6202 = class("FightIndicatorView6202", FightIndicatorView)

function FightIndicatorView6202:initView(indicatorMgrView, indicatorId, totalIndicatorNum)
	FightIndicatorView6202.super.initView(self, indicatorMgrView, indicatorId, totalIndicatorNum)

	self.totalIndicatorNum = 4
end

function FightIndicatorView6202:getCardConfig()
	return Season123Config.instance:getSeasonEquipCo(self:getCardId())
end

function FightIndicatorView6202:getCardId()
	return 200042
end

return FightIndicatorView6202
