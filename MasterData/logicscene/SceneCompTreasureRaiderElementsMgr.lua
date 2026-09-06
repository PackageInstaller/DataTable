-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/treasureraider/SceneCompTreasureRaiderElementsMgr.lua

module("logicscene.scene.component.treasureraider.SceneCompTreasureRaiderElementsMgr", package.seeall)

local SceneCompTreasureRaiderElementsMgr = class("SceneCompTreasureRaiderElementsMgr", SceneComponentBase)

function SceneCompTreasureRaiderElementsMgr:onInit()
	self._elements = {}
	self._buildingUnits = {}
	self._produceUnits = {}
end

function SceneCompTreasureRaiderElementsMgr:onEnterScene(sceneId, bornX, bornZ)
	SceneCompTreasureRaiderElementsMgr.super.onEnterScene(self, sceneId, bornX, bornZ)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderSingleBuildingUpdated, self._onSingleBuildingChanged, self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderAllBuildingUpdated, self._onAllBuildingChanged, self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderReloadScene, self._onReloadScene, self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderServerActionDone, self._updateActionState, self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderPlayerClientGridUpdated, self._updatePlayerClientGrid, self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderPlayerServerGridUpdated, self._updatePlayerServerGrid, self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderBuildingProduceUpdated, self._onSingleBuildingProduceUpdated, self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderBuildingUpgrade, self._onSingleBuildingUpgrade, self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderSwitchAngle, self._onSwitchAngle, self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderEndEdit, self._onEndEdit, self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderBeginEdit, self._onBeginEdit, self)
end

function SceneCompTreasureRaiderElementsMgr:onExitScene()
	self._elements = {}
	self._buildingUnits = {}
	self._produceUnits = {}

	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderSingleBuildingUpdated, self._onSingleBuildingChanged, self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderAllBuildingUpdated, self._onAllBuildingChanged, self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderReloadScene, self._onReloadScene, self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderServerActionDone, self._updateActionState, self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderPlayerClientGridUpdated, self._updatePlayerClientGrid, self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderPlayerServerGridUpdated, self._updatePlayerServerGrid, self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderBuildingProduceUpdated, self._onSingleBuildingProduceUpdated, self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderBuildingUpgrade, self._onSingleBuildingUpgrade, self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderSwitchAngle, self._onSwitchAngle, self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderEndEdit, self._onEndEdit, self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderBeginEdit, self._onBeginEdit, self)
end

function SceneCompTreasureRaiderElementsMgr:onEnterSceneFinished(sceneId, bornX, bornZ)
	return
end

function SceneCompTreasureRaiderElementsMgr:lateEnterFinished()
	self:_checkZoomState()
end

function SceneCompTreasureRaiderElementsMgr:addBuilding(unit)
	self._buildingUnits[unit.row] = self._buildingUnits[unit.row] or {}
	self._buildingUnits[unit.row][unit.col] = unit
end

function SceneCompTreasureRaiderElementsMgr:getBuilding(row, col)
	if not self._buildingUnits[row] then
		return
	end

	return self._buildingUnits[row][col]
end

function SceneCompTreasureRaiderElementsMgr:getAllBuilding()
	return self._buildingUnits
end

function SceneCompTreasureRaiderElementsMgr:addProduce(unit)
	self._produceUnits[unit.row] = self._produceUnits[unit.row] or {}
	self._produceUnits[unit.row][unit.col] = unit
end

function SceneCompTreasureRaiderElementsMgr:getProduce(row, col)
	if not self._produceUnits[row] then
		return
	end

	return self._produceUnits[row][col]
end

function SceneCompTreasureRaiderElementsMgr:addElement(unit, elem)
	elem.gridUnit = unit
	self._elements[elem.id] = elem

	local parent = unit.go.transform

	elem.go.transform:SetParent(parent)
end

function SceneCompTreasureRaiderElementsMgr:getElement(id)
	return self._elements[id]
end

function SceneCompTreasureRaiderElementsMgr:getElements()
	return self._elements
end

function SceneCompTreasureRaiderElementsMgr:createElement(unit, elementId, row, col)
	local gridElem, produceElem
	local isBuildingSlot = unit:isBuildingGrid()

	if isBuildingSlot then
		gridElem = self._scene.unitFactory:generateGridBuilding(elementId, row, col)

		local posX, posY = self._scene:getTool():grid2Pos(row, col)

		posX = posX - 0.8
		posY = posY + 1.07
		produceElem = self._scene.unitFactory:generateGridProduce(elementId, row, col, posX, posY, 1)
	else
		gridElem = self._scene.unitFactory:generateGridElem(elementId, row, col)
	end

	self:addElement(unit, gridElem)

	if isBuildingSlot then
		self:addProduce(produceElem)
		self:addBuilding(gridElem)
	end

	return gridElem
end

function SceneCompTreasureRaiderElementsMgr:_onSingleBuildingChanged(ownerId, gridId)
	if ownerId == self._scene:getSceneMo().ownerId then
		local gridX, gridY = self._scene:getTool():id2Grid(gridId)
		local building = self:getBuilding(gridX, gridY)

		if building then
			building.gridBuilding:invalidate()
			building.gridBuildingStatus:updateFocusStatus()
		end
	end

	self:_onSingleBuildingProduceUpdated(ownerId, gridId)
end

function SceneCompTreasureRaiderElementsMgr:_onSingleBuildingUpgrade(ownerId, gridId)
	if ownerId == self._scene:getSceneMo().ownerId then
		local gridX, gridY = self._scene:getTool():id2Grid(gridId)
		local building = self:getBuilding(gridX, gridY)

		if building then
			building.gridBuilding:playUpgradeEffect()
		end
	end
end

function SceneCompTreasureRaiderElementsMgr:_onAllBuildingChanged(ownerId, bForce)
	if ownerId == self._scene:getSceneMo().ownerId then
		for _, map in pairs(self._buildingUnits) do
			for _, building in pairs(map) do
				building.gridBuilding:invalidate(bForce)
				building.gridBuildingStatus:updateFocusStatus()
			end
		end

		for _, map in pairs(self._produceUnits) do
			for _, produceElem in pairs(map) do
				if produceElem then
					produceElem.produceState:updateProduceStatus()
				end
			end
		end
	end
end

function SceneCompTreasureRaiderElementsMgr:_onReloadScene()
	self:_onAllBuildingChanged(self._scene:getSceneMo().ownerId, true)
end

function SceneCompTreasureRaiderElementsMgr:_updateActionState(ownerId, actionDone)
	if ownerId == self._scene:getSceneMo().ownerId then
		for _, map in pairs(self._buildingUnits) do
			for _, building in pairs(map) do
				building.gridBuildingStatus:updateFocusStatus()
			end
		end

		if actionDone then
			self:_zoomOut()
			self._scene.camera:setDragEnabled(true)
		end
	end
end

function SceneCompTreasureRaiderElementsMgr:_onSingleBuildingProduceUpdated(ownerId, gridId)
	if ownerId == self._scene:getSceneMo().ownerId then
		local gridX, gridY = self._scene:getTool():id2Grid(gridId)
		local produceElem = self:getProduce(gridX, gridY)

		if produceElem then
			produceElem.produceState:updateProduceStatus()
		end
	end
end

function SceneCompTreasureRaiderElementsMgr:_zoomIn(bIgnoreModifyCameraDragEnable)
	local sceneMo = self._scene:getSceneMo()
	local myPlayerMo = sceneMo.myPlayerMo
	local tool = self._scene:getTool()
	local x, y = tool:getNeighbourBuildingCenter(myPlayerMo.serverGridId)

	self._scene.animation:playCameraZoom(x, y, SceneCompTreasureRaiderAnimation.ZoomIn, function()
		local zoomType = self._scene.animation:getZoomType()

		GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderZoomStateChange, zoomType)
	end)

	if not bIgnoreModifyCameraDragEnable then
		self._scene.camera:setDragEnabled(false)
	end
end

function SceneCompTreasureRaiderElementsMgr:_zoomOut(bIgnoreModifyCameraDragEnable)
	local tool = self._scene:getTool()
	local x, y = tool:getCameraMapCenterPos()

	self._scene.animation:playCameraZoom(x, y, SceneCompTreasureRaiderAnimation.ZoomOut, function()
		local zoomType = self._scene.animation:getZoomType()

		GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderZoomStateChange, zoomType)
	end)

	if not bIgnoreModifyCameraDragEnable then
		self._scene.camera:setDragEnabled(true)
	end
end

function SceneCompTreasureRaiderElementsMgr:_updatePlayerClientGrid(userId)
	for _, map in pairs(self._buildingUnits) do
		for _, building in pairs(map) do
			building.gridBuildingStatus:updateFocusStatus()
		end
	end

	self:_checkZoomState()
end

function SceneCompTreasureRaiderElementsMgr:_updatePlayerServerGrid(userId)
	local sceneMo = self._scene:getSceneMo()
	local myPlayerMo = sceneMo.myPlayerMo

	if not myPlayerMo:isClientServerSameGrid() then
		self:_zoomOut()
	end
end

function SceneCompTreasureRaiderElementsMgr:_checkZoomState()
	local sceneMo = self._scene:getSceneMo()
	local myPlayerMo = sceneMo.myPlayerMo

	if myPlayerMo:isClientServerSameGrid() then
		if sceneMo.actionDone then
			self:_zoomOut()
		else
			self:_zoomIn()
		end
	end
end

function SceneCompTreasureRaiderElementsMgr:_onEndEdit()
	self:_checkZoomState()

	for _, map in pairs(self._buildingUnits) do
		for _, building in pairs(map) do
			building.gridBuildingStatus:updateFocusStatus()
		end
	end

	for _, map in pairs(self._produceUnits) do
		for _, produceElem in pairs(map) do
			if produceElem then
				produceElem.produceState:updateProduceStatus()
			end
		end
	end
end

function SceneCompTreasureRaiderElementsMgr:_onBeginEdit()
	self:_zoomOut(true)

	for _, map in pairs(self._buildingUnits) do
		for _, building in pairs(map) do
			building.gridBuildingStatus:updateFocusStatus()
		end
	end

	for _, map in pairs(self._produceUnits) do
		for _, produceElem in pairs(map) do
			if produceElem then
				produceElem.produceState:updateProduceStatus()
			end
		end
	end
end

function SceneCompTreasureRaiderElementsMgr:_onSwitchAngle()
	local zoomType = self._scene.animation:getZoomType()

	if zoomType == SceneCompTreasureRaiderAnimation.ZoomIn then
		self:_zoomOut()
	elseif zoomType == SceneCompTreasureRaiderAnimation.ZoomOut then
		self:_zoomIn()
	end
end

return SceneCompTreasureRaiderElementsMgr
