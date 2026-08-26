-- chunkname: @modules/logic/fight/model/data/FightCustomDefaultEntityInitData.lua

module("modules.logic.fight.model.data.FightCustomDefaultEntityInitData", package.seeall)

local FightCustomDefaultEntityInitData = FightDataClass("FightCustomDefaultEntityInitData")

function FightCustomDefaultEntityInitData:onConstructor()
	self.entityAlphaWhenInit = 1
end

return FightCustomDefaultEntityInitData
