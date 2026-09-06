-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/treasureraider/UnitTreasureRaiderGridElem.lua

module("logicscene.scene.unit.impl.treasureraider.UnitTreasureRaiderGridElem", package.seeall)

local UnitTreasureRaiderGridElem = class("UnitTreasureRaiderGridElem", SceneUnitBase)

function UnitTreasureRaiderGridElem:getTag()
	return UnitTag.TilingSceneElem
end

function UnitTreasureRaiderGridElem:getLayer()
	return SceneLayer.Unit_Value
end

function UnitTreasureRaiderGridElem:_initComponents()
	self:_addComponent("transform", UnitCompTransform)
end

function UnitTreasureRaiderGridElem:update(deltaTime)
	return
end

function UnitTreasureRaiderGridElem:onUnitCreated(params)
	self.transform:setPos(params.posX, params.posY, params.posZ)
	self.transform:setMoveSpeed(0)
end

function UnitTreasureRaiderGridElem:getSortingOrderOffset(layerNum)
	local orderOffset = -(self.row % 2 + 2 * self.col)

	return -10000 + (layerNum - 1) * 2000 + orderOffset
end

function UnitTreasureRaiderGridElem:onUnitVisible(go)
	UnitTreasureRaiderGridElem.super.onUnitVisible(self, go)
	self:resetLayer()
end

function UnitTreasureRaiderGridElem:resetLayer()
	return
end

function UnitTreasureRaiderGridElem:onUnitDestroyed()
	self:OnDestroy()
end

return UnitTreasureRaiderGridElem
