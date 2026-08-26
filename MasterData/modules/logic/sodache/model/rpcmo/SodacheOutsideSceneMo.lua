-- chunkname: @modules/logic/sodache/model/rpcmo/SodacheOutsideSceneMo.lua

module("modules.logic.sodache.model.rpcmo.SodacheOutsideSceneMo", package.seeall)

local SodacheOutsideSceneMo = pureTable("SodacheOutsideSceneMo")

function SodacheOutsideSceneMo:init(data)
	self.inside = data.inside
	self.prop = GameUtil.rpcInfoToMo(data.prop, SodacheOutsidePropMo, self.prop)
	self.buildingBox = GameUtil.rpcInfoToMo(data.buildingBox, SodacheBuildingBoxMo, self.buildingBox)
	self.taskBox = GameUtil.rpcInfoToMo(data.taskBox, SodacheTaskBoxMo, self.taskBox)
	self.bags = GameUtil.rpcInfosToMap(data.bags, SodacheBagMo, "type", self.bags)
	self.attrContainer = GameUtil.rpcInfoToMo(data.attrContainer, SodacheAttrContainerMo, self.attrContainer)
	self.handBookBox = GameUtil.rpcInfoToMo(data.handBookBox, SodacheHandBookBoxMo, self.handBookBox)
	self.functionBox = GameUtil.rpcInfoToMo(data.functionBox, SodacheFunctionBoxMo, self.functionBox)
	self.relicBox = GameUtil.rpcInfoToMo(data.relicBox, SodacheRelicBoxMo, self.relicBox)
end

function SodacheOutsideSceneMo:updateBag(bagType, data)
	if not self.bags[bagType] then
		return
	end

	self.bags[bagType]:updateBag(data)
end

function SodacheOutsideSceneMo:getBag(bagType)
	return self.bags[bagType]
end

function SodacheOutsideSceneMo:updateBuilding(building)
	local buildingMo = self.buildingBox:getBuildingMo(building.type)

	buildingMo:update(building.level)
end

return SodacheOutsideSceneMo
