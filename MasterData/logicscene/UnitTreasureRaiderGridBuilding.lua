-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/treasureraider/UnitTreasureRaiderGridBuilding.lua

module("logicscene.scene.unit.impl.treasureraider.UnitTreasureRaiderGridBuilding", package.seeall)

local UnitTreasureRaiderGridBuilding = class("UnitTreasureRaiderGridBuilding", UnitTreasureRaiderGridElem)

function UnitTreasureRaiderGridBuilding:_initComponents()
	self:_addComponent("transform", UnitCompTransform)
	self:_addComponent("gridBuilding", UnitCompTreasureRaiderBuilding)
	self:_addComponent("gridBuildingStatus", UnitCompTreasureRaiderBuildingState)
end

function UnitTreasureRaiderGridBuilding:prepareDrag()
	self:_createFake()
	self:setVisible(false)

	return self._fakeGridElem
end

function UnitTreasureRaiderGridBuilding:resetDrag()
	self:setVisible(true)
	self:_destroyFake()
end

function UnitTreasureRaiderGridBuilding:_createFake()
	self:_destroyFake()

	self._fakeGridElem = self.scene.unitFactory:generateGridBuilding(-self.id, self.row, self.col)
	self._fakeGridElem.gridUnit = self.gridUnit

	self._fakeGridElem.go.transform:SetParent(self.gridUnit.go.transform)
	self._fakeGridElem.gridBuilding:invalidate(true)
	GoUtil.SetSortingOrder(self._fakeGridElem.go, 1)
end

function UnitTreasureRaiderGridBuilding:_destroyFake()
	if self._fakeGridElem then
		self.scene.unitFactory:destroyCommonObject(UnitTag.TilingSceneElem, -self.id)

		self._fakeGridElem = nil
	end
end

function UnitTreasureRaiderGridBuilding:resetLayer()
	return
end

return UnitTreasureRaiderGridBuilding
