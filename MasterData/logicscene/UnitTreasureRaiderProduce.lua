-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/treasureraider/UnitTreasureRaiderProduce.lua

module("logicscene.scene.unit.impl.season.UnitTreasureRaiderProduce", package.seeall)

local UnitTreasureRaiderProduce = class("UnitTreasureRaiderProduce", UnitTreasureRaiderGridElem)

UnitTreasureRaiderProduce.ProduceResPath = "scene/tiling/treasure_raider/treasure_raider_resource_icon.prefab"

function UnitTreasureRaiderProduce:_initComponents()
	self:_addComponent("transform", UnitCompTransform)
	self:_addComponent("produceState", UnitCompTreasureRaiderProduceState)
end

function UnitTreasureRaiderProduce:getBuildingMo()
	local gridId = self.scene:getTool():grid2Id(self.row, self.col)
	local sceneMo = self.scene:getSceneMo()

	return sceneMo:getBuildingMo(gridId)
end

function UnitTreasureRaiderProduce:onUnitCreated(params)
	self:_checkWholeScene()
	self.transform:setPos(params.posX, params.posY, params.posZ)
	self.transform:setMoveSpeed(params.moveSpeed)

	if not params.moveSpeed or params.moveSpeed <= 0 then
		self.transform:setMoveSpeed(1)
	end
end

function UnitTreasureRaiderProduce:onUnitVisible(go)
	UnitTreasureRaiderProduce.super.onUnitVisible(self, go)
end

function UnitTreasureRaiderProduce:_checkWholeScene()
	self._wholeScene = self._wholeScene or self.scene.stage.wholeScene
end

function UnitTreasureRaiderProduce:onUnitDestroyed()
	self:OnDestroy()
	self:clearSceneUnit()
end

function UnitTreasureRaiderProduce:resetLayer()
	GoUtil.SetSortingOrder(self.go, 1)
end

return UnitTreasureRaiderProduce
