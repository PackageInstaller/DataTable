-- chunkname: @modules/logic/fight/model/data/FightEquipRecordData.lua

module("modules.logic.fight.model.data.FightEquipRecordData", package.seeall)

local FightEquipRecordData = FightDataClass("FightEquipRecordData")

function FightEquipRecordData:onConstructor(proto)
	self.equipUid = proto.equipUid
	self.equipId = proto.equipId
	self.equipLv = proto.equipLv
	self.refineLv = proto.refineLv
end

return FightEquipRecordData
