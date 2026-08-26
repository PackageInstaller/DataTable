-- chunkname: @modules/logic/fight/entity/comp/specialeffect/FightSceneSpecialEffect0.lua

module("modules.logic.fight.entity.comp.specialeffect.FightSceneSpecialEffect0", package.seeall)

local FightSceneSpecialEffect0 = class("FightSceneSpecialEffect0", FightBaseClass)

function FightSceneSpecialEffect0:onConstructor(entity)
	self:newClass(FightSceneSpecialEffect0_HuanJingKa, entity)
end

return FightSceneSpecialEffect0
