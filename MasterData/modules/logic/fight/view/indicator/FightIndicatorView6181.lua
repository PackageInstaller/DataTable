-- chunkname: @modules/logic/fight/view/indicator/FightIndicatorView6181.lua

module("modules.logic.fight.view.indicator.FightIndicatorView6181", package.seeall)

local FightIndicatorView6181 = class("FightIndicatorView6181", FightIndicatorView)

function FightIndicatorView6181:getCardConfig()
	return Season123Config.instance:getSeasonEquipCo(self:getCardId())
end

function FightIndicatorView6181:getCardId()
	return 180040
end

return FightIndicatorView6181
