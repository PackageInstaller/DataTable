-- chunkname: @modules/logic/fight/fightcomponent/FightFlowComponent.lua

module("modules.logic.fight.fightcomponent.FightFlowComponent", package.seeall)

local FightFlowComponent = class("FightFlowComponent", FightBaseClass)

function FightFlowComponent:onConstructor()
	return
end

function FightFlowComponent:registCustomFlow(customFlow)
	return self:newClass(customFlow)
end

function FightFlowComponent:onDestructor()
	return
end

return FightFlowComponent
