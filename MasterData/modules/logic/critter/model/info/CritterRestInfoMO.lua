-- chunkname: @modules/logic/critter/model/info/CritterRestInfoMO.lua

module("modules.logic.critter.model.info.CritterRestInfoMO", package.seeall)

local CritterRestInfoMO = pureTable("CritterRestInfoMO")

function CritterRestInfoMO:init(info)
	self.restBuildingUid = info and info.buildingUid
	self.seatSlotId = info and info.restSlotId
end

return CritterRestInfoMO
