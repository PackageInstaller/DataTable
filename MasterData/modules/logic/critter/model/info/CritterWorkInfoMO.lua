-- chunkname: @modules/logic/critter/model/info/CritterWorkInfoMO.lua

module("modules.logic.critter.model.info.CritterWorkInfoMO", package.seeall)

local CritterWorkInfoMO = pureTable("CritterWorkInfoMO")

function CritterWorkInfoMO:init(info)
	self.workBuildingUid = info and info.buildingUid
	self.critterSlotId = info and info.critterSlotId
end

function CritterWorkInfoMO:getBuildingInfo()
	return self.workBuildingUid, self.critterSlotId
end

return CritterWorkInfoMO
