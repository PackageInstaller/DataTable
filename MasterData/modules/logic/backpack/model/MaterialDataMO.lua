-- chunkname: @modules/logic/backpack/model/MaterialDataMO.lua

module("modules.logic.backpack.model.MaterialDataMO", package.seeall)

local MaterialDataMO = pureTable("MaterialDataMO")

function MaterialDataMO:ctor()
	self.materilType = nil
	self.materilId = nil
	self.quantity = nil
	self.getApproach = nil
	self.uid = nil
	self.roomBuildingLevel = nil
end

function MaterialDataMO:init(info)
	self.materilType = info.materilType
	self.materilId = info.materilId
	self.quantity = info.quantity
	self.uid = info.uid
	self.roomBuildingLevel = info.roomBuildingLevel
end

function MaterialDataMO:initValue(type, id, quantity, uid, roomBuildingLevel, getApproach)
	self.materilType = type
	self.materilId = id
	self.quantity = quantity
	self.uid = uid
	self.getApproach = getApproach
	self.roomBuildingLevel = roomBuildingLevel
end

return MaterialDataMO
