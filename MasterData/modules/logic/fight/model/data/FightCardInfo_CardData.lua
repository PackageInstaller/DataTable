-- chunkname: @modules/logic/fight/model/data/FightCardInfo_CardData.lua

module("modules.logic.fight.model.data.FightCardInfo_CardData", package.seeall)

local FightCardInfo_CardData = FightDataClass("FightCardInfo_CardData")

FightCardInfo_CardData.CardDataKey = {
	Unnamed = 1
}

local IsJsonData = {
	[FightCardInfo_CardData.CardDataKey.Unnamed] = true
}

function FightCardInfo_CardData:onConstructor(proto)
	self.key = proto.key
	self.value = proto.value

	if IsJsonData[self.key] then
		self.jsonValue = string.nilorempty(self.value) and {} or cjson.decode(self.value)
	end
end

return FightCardInfo_CardData
