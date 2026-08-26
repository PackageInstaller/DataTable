-- chunkname: @modules/logic/fight/system/FightSystem.lua

module("modules.logic.fight.system.FightSystem", package.seeall)

local FightSystem = class("FightSystem")

function FightSystem:dispose()
	FightPlayCardModel.instance:onEndRound()
	FightModel.instance:clear()
end

FightSystem.instance = FightSystem.New()

return FightSystem
