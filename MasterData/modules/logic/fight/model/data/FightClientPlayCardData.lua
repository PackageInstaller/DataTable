-- chunkname: @modules/logic/fight/model/data/FightClientPlayCardData.lua

module("modules.logic.fight.model.data.FightClientPlayCardData", package.seeall)

local FightClientPlayCardData = FightDataClass("FightClientPlayCardData", FightCardInfoData)

function FightClientPlayCardData:onConstructor(proto, index)
	self.index = index
end

return FightClientPlayCardData
