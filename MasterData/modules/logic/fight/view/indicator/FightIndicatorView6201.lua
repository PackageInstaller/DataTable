-- chunkname: @modules/logic/fight/view/indicator/FightIndicatorView6201.lua

module("modules.logic.fight.view.indicator.FightIndicatorView6201", package.seeall)

local FightIndicatorView6201 = class("FightIndicatorView6201", FightIndicatorView)

function FightIndicatorView6201:initView(indicatorMgrView, indicatorId, totalIndicatorNum)
	FightIndicatorView6201.super.initView(self, indicatorMgrView, indicatorId, totalIndicatorNum)

	self.totalIndicatorNum = 4
end

function FightIndicatorView6201:getCardConfig()
	return Season123Config.instance:getSeasonEquipCo(self:getCardId())
end

function FightIndicatorView6201:getCardId()
	return 200041
end

return FightIndicatorView6201
