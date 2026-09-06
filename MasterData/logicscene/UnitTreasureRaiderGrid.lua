-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/treasureraider/UnitTreasureRaiderGrid.lua

module("logicscene.scene.unit.impl.treasureraider.UnitTreasureRaiderGrid", package.seeall)

local UnitTreasureRaiderGrid = class("UnitTreasureRaiderGrid", UnitTreasureRaiderGridElem)

function UnitTreasureRaiderGrid:getTag()
	return UnitTag.SceneElement
end

function UnitTreasureRaiderGrid:_initComponents()
	self:_addComponent("transform", UnitCompTransform)
	self:_addComponent("gridStatus", UnitCompTreasureRaiderGridState)
end

function UnitTreasureRaiderGrid:onUnitCreated(params)
	UnitSeasonGrid.super.onUnitCreated(self, params)
end

function UnitTreasureRaiderGrid:getBuildingMo()
	local gridId = self.scene:getTool():grid2Id(self.row, self.col)
	local sceneMo = self.scene:getSceneMo()

	return sceneMo:getBuildingMo(gridId)
end

function UnitTreasureRaiderGrid:getBuildingId()
	local buildingMo = self:getBuildingMo()

	if buildingMo then
		return buildingMo.buildingId
	end

	return 0
end

function UnitTreasureRaiderGrid:isHasBuilding()
	local gridId = self.scene:getTool():grid2Id(self.row, self.col)
	local sceneMo = self.scene:getSceneMo()

	return sceneMo:isHasBuildingMo(gridId)
end

function UnitTreasureRaiderGrid:isBuildingGrid()
	local gridId = self.scene:getTool():grid2Id(self.row, self.col)

	return self.scene:getTool():isBuildingSlot(gridId)
end

function UnitTreasureRaiderGrid:resetLayer()
	if self._gameObject then
		self._gameObject.transform:SetParent(self.go.transform)
		Framework.TransformUtil.SetLocalPos(self._gameObject.transform, 0, 0, 0)

		local layerNum = self.scene:getLayerNumByElementId(self.id)

		if layerNum > 2 then
			return
		end

		GoUtil.SetSortingOrder(self._gameObject, self:getSortingOrderOffset(layerNum))
	end
end

function UnitTreasureRaiderGrid:playSelectedAnimation()
	local startX, startY, startZ = self.transform:getPos()
	local offsetY = -0.1
	local startPos = Vector3.New(startX, startY, startZ)
	local endPos = Vector3.New(startX, startY + offsetY, startZ)

	if not self._selectSinkAnim then
		self._selectSinkAnim = UnityTweens.TweenPosition.Create(self.go, startPos, endPos, 0.1)

		self._selectSinkAnim:AddListener(self._onSelectSinkFinished, self)
	end

	self._selectFloatAnim = self._selectFloatAnim or UnityTweens.TweenPosition.Create(self.go, endPos, startPos, 0.2)

	self._selectSinkAnim:Stop()
	self._selectFloatAnim:Stop()

	self._selectSinkAnim.from = startPos
	self._selectSinkAnim.to = endPos
	self._selectFloatAnim.from = endPos
	self._selectFloatAnim.to = startPos

	self._selectSinkAnim:Begin()
end

function UnitTreasureRaiderGrid:_onSelectSinkFinished()
	self._selectFloatAnim:Begin()
end

function UnitTreasureRaiderGrid:onUnitDestroyed()
	if self._selectSinkAnim then
		self._selectSinkAnim:RemoveListener()
	end

	self._selectFloatAnim = nil
	self._selectSinkAnim = nil

	UnitTreasureRaiderGrid.super.onUnitDestroyed(self)
end

return UnitTreasureRaiderGrid
