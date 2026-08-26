-- chunkname: @modules/logic/fight/model/data/FightHeroAttributeData.lua

module("modules.logic.fight.model.data.FightHeroAttributeData", package.seeall)

local FightHeroAttributeData = FightDataClass("FightHeroAttributeData")

function FightHeroAttributeData:onConstructor(proto)
	self.hp = proto.hp
	self.attack = proto.attack
	self.defense = proto.defense
	self.mdefense = proto.mdefense
	self.technic = proto.technic
	self.multiHpIdx = proto.multiHpIdx
	self.multiHpNum = proto.multiHpNum
end

return FightHeroAttributeData
