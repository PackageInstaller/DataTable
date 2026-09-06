-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/treasureraider/SceneCompTreasureRaiderEditMgr.lua

module("logicscene.scene.component.treasureraider.SceneCompTreasureRaiderEditMgr", package.seeall)

local SceneCompTreasureRaiderEditMgr = class("SceneCompTreasureRaiderEditMgr", SceneComponentBase)

function SceneCompTreasureRaiderEditMgr:ctor(scene)
	SceneCompTreasureRaiderEditMgr.super.ctor(self, scene)

	self._dragEnabled = false
	self._dragging = false
end

function SceneCompTreasureRaiderEditMgr:setDragEnabled(value)
	self._dragEnabled = value

	if not self._dragEnabled then
		self:_onTouchUp()
	end
end

function SceneCompTreasureRaiderEditMgr:isDragEnabled()
	return self._dragEnabled
end

function SceneCompTreasureRaiderEditMgr:onEnterScene(sceneId, bornX, bornZ)
	SceneCompTreasureRaiderEditMgr.super.onEnterScene(self, sceneId, bornX, bornZ)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderEndEdit, self._onEndEdit, self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderBeginEdit, self._onBeginEdit, self)

	self._mainCamera = CameraTargetMgr.instance:getMainCameraTarget():getCamera()
end

function SceneCompTreasureRaiderEditMgr:onExitScene()
	SceneCompTreasureRaiderEditMgr.super.onExitScene(self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderEndEdit, self._onEndEdit, self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderBeginEdit, self._onBeginEdit, self)
end

function SceneCompTreasureRaiderEditMgr:_getTouchLocalPos()
	local pos = UGUIToolHelper.GetTouchPosition()

	pos.z = 100
	pos = self._mainCamera:ScreenToWorldPoint(pos)

	local parentTransform = self._scene:getContainer().gameObject.transform

	return parentTransform:InverseTransformPoint(pos)
end

function SceneCompTreasureRaiderEditMgr:_onTouchDown()
	if self._dragEnabled and not self._dragging then
		local tool = self._scene:getTool()
		local pos = self:_getTouchLocalPos()
		local gridX, gridY = tool:pos2Grid(pos.x, pos.y)
		local gridId = tool:grid2Id(gridX, gridY)

		if not tool:isGridDisableToEditAndShowTips(gridId, false) then
			local buildingUnit = self._scene.elementMgr:getBuilding(gridX, gridY)

			if buildingUnit and buildingUnit.gridUnit:isHasBuilding() then
				self._operateBuildingUnit = buildingUnit
				self._fakeOperateBuildingUnit = self._operateBuildingUnit:prepareDrag()
				self._dragging = true

				self._scene.camera:setDragEnabled(false)
				self._fakeOperateBuildingUnit.transform:setPos(pos.x, pos.y)
			end
		end
	end
end

function SceneCompTreasureRaiderEditMgr:_onTouchUp()
	self._dragging = false
	self._touchTime = 0

	if self._dragEnabled and self._operateBuildingUnit then
		local sceneMo = self._scene:getSceneMo()
		local tool = self._scene:getTool()

		self._operateBuildingUnit:resetDrag()

		local pos = self:_getTouchLocalPos()
		local gridX, gridY = tool:pos2Grid(pos.x, pos.y)
		local gridId = tool:grid2Id(gridX, gridY)

		if not tool:isGridDisableToEditAndShowTips(gridId, true) then
			local targetGrid = self._scene.elementMgr:getBuilding(gridX, gridY)

			if targetGrid then
				local fromGridId = tool:grid2Id(self._operateBuildingUnit.row, self._operateBuildingUnit.col)
				local toGridId = tool:grid2Id(targetGrid.row, targetGrid.col)

				sceneMo:exchangeBuilding(fromGridId, toGridId)
			end
		end

		self._operateBuildingUnit = nil
		self._fakeOperateBuildingUnit = nil

		self._scene.camera:setDragEnabled(true)
	end
end

function SceneCompTreasureRaiderEditMgr:_onTouchMove()
	if self._dragEnabled and self._dragging and self._fakeOperateBuildingUnit then
		if self._touchTime < 0.1 then
			return
		end

		local pos = self:_getTouchLocalPos()

		self._fakeOperateBuildingUnit.transform:setPos(pos.x, pos.y)
	end
end

function SceneCompTreasureRaiderEditMgr:update(deltaTime)
	if self._scene.eventsAnimation and self._scene.eventsAnimation:isPlaying() then
		return
	end

	if not self._dragEnabled then
		return
	end

	if not self._dragging then
		if UGUIToolHelper.IsTouchDown() and not UGUIToolHelper.IsOverUI() then
			self:_onTouchDown()
		end
	elseif UGUIToolHelper.IsTouchUp() then
		self:_onTouchUp()
	else
		self._touchTime = (self._touchTime or 0) + deltaTime

		self:_onTouchMove()
	end
end

function SceneCompTreasureRaiderEditMgr:_onEndEdit()
	self:setDragEnabled(false)
end

function SceneCompTreasureRaiderEditMgr:_onBeginEdit()
	self:setDragEnabled(true)
	self._scene.camera:setDragEnabled(true)
end

return SceneCompTreasureRaiderEditMgr
