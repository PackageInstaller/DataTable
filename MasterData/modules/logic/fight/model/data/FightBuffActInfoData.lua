-- chunkname: @modules/logic/fight/model/data/FightBuffActInfoData.lua

module("modules.logic.fight.model.data.FightBuffActInfoData", package.seeall)

local FightBuffActInfoData = FightDataClass("FightBuffActInfoData")

function FightBuffActInfoData:onConstructor(proto)
	self.actId = proto.actId
	self.param = {}

	local protoParam = proto.param

	for i = 1, #protoParam do
		self.param[i] = protoParam[i]
	end

	self.strParam = proto.strParam
end

return FightBuffActInfoData
