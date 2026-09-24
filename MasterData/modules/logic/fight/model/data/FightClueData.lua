-- chunkname: @modules/logic/fight/model/data/FightClueData.lua

module("modules.logic.fight.model.data.FightClueData", package.seeall)

local FightClueData = FightDataClass("FightClueData")

function FightClueData:onConstructor(proto)
	if proto then
		self.uid = proto.uid or 0
	end

	if proto then
		self.entityUid = proto.entityUid or 0
	end

	if proto then
		self.clueId = proto.clueId or 0
	end
end

function FightClueData:updateByInfo(info)
	if not info then
		return
	end

	self.uid = info.uid
	self.entityUid = info.entityUid
	self.clueId = info.clueId
end

return FightClueData
