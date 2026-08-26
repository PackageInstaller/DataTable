-- chunkname: @modules/logic/fight/entity/comp/specialskineffect/FightEntitySpecialSkinEffect307301.lua

module("modules.logic.fight.entity.comp.specialskineffect.FightEntitySpecialSkinEffect307301", package.seeall)

local FightEntitySpecialSkinEffect307301 = class("FightEntitySpecialSkinEffect307301", FightBaseClass)

function FightEntitySpecialSkinEffect307301:onConstructor(entity)
	self:newClass(FightEntitySpecialSkinEffect307301_buff4150002, entity)
end

return FightEntitySpecialSkinEffect307301
