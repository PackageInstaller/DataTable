-- chunkname: @modules/logic/fight/model/mo/FightHeroSpAttributeInfoMO.lua

module("modules.logic.fight.model.mo.FightHeroSpAttributeInfoMO", package.seeall)

local FightHeroSpAttributeInfoMO = pureTable("FightHeroSpAttributeInfoMO")

function FightHeroSpAttributeInfoMO:init(info)
	self.uid = info.uid
	self.attribute = {}

	for i, v in ipairs(info.attribute) do
		local attrMo = HeroSpAttributeMO.New()

		attrMo:init(v)

		self.attribute[i] = attrMo
	end
end

return FightHeroSpAttributeInfoMO
