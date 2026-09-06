-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/impl/TreasureRaiderScene.lua

module("logicscene.scene.impl.TreasureRaiderScene", package.seeall)

local TreasureRaiderScene = class("TreasureRaiderScene", CityScene)

function TreasureRaiderScene:getTool()
	if not self._tool then
		self._tool = TreasureRaiderSceneModel.instance

		self._tool:initAll()
	end

	return self._tool
end

function TreasureRaiderScene:getSceneMo()
	return TreasureRaiderModel.instance:getCurSceneMo()
end

function TreasureRaiderScene:_initComponents()
	self:_addComponent("unitFactory", TreasureRaiderSceneUnitFactory)
	self:_addComponent("camera", SceneCompTreasureRaiderCamera)
	self:_addComponent("stage", TreasureRaiderSceneStage)
	self:_addComponent("gridUnitsMgr", SceneCompTreasureRaiderGridUnitsMgr)
	self:_addComponent("elementMgr", SceneCompTreasureRaiderElementsMgr)
	self:_addComponent("playerMgr", SceneCompTreasureRaiderPlayerUnitsMgr)
	self:_addComponent("editMgr", SceneCompTreasureRaiderEditMgr)
	self:_addComponent("pathFinder", SceneCompTreasureRaiderPathFinder)
	self:_addComponent("joystick", SceneCompDisableJoystickListener)
	self:_addComponent("resCache", SceneResObjectCache)
	self:_addComponent("picker", SceneCompTreasureRaiderPicker)
	self:_addComponent("animation", SceneCompTreasureRaiderAnimation)
	self:_addComponent("bgm", SceneCompSeasonBgm)
end

function TreasureRaiderScene:onEnterFinished()
	TreasureRaiderScene.super.onEnterFinished(self)
	self.playerMgr:createPlayers()

	local tool = self:getTool()
	local x, y = tool:getCameraMapCenterPos()

	self.camera:setPosFocus(x, y)
end

function TreasureRaiderScene:lateEnterFinished()
	TreasureRaiderScene.super.lateEnterFinished(self)

	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer then
		mainPlayer.syncPos:disable(true)
		mainPlayer:setVisible(false)
	end

	self.joystick:setEnable(false)
	self.picker:setFindWayFinishedCallback(self._onFindWayFinished, self)
	TREnterSceneSequenceController.instance:completeEnterScene()
end

function TreasureRaiderScene:onEnter(sceneId, bornX, bornZ)
	TreasureRaiderScene.super.onEnter(self, sceneId, bornX, bornZ)
	TreasureRaiderController.instance:setSceneId(sceneId)
end

function TreasureRaiderScene:onExit()
	TreasureRaiderScene.super.onExit(self)
	TreasureRaiderController.instance:setSceneId(0)
end

function TreasureRaiderScene:getSceneType()
	return SceneType.TreasureRaider
end

function TreasureRaiderScene:getDefaultView()
	return ViewName.TreasureraidersceneView
end

function TreasureRaiderScene:visibleMainPlayer(visible)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer then
		mainPlayer:setVisible(false)
	end
end

function TreasureRaiderScene:visibleObjects(visible)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer then
		mainPlayer:setVisible(false)
	end

	if self.walkEff then
		self.walkEff:setVisible(false)
	end

	self._otherPlayerVisible = visible

	self.unitFactory:showUnits(visible)
end

function TreasureRaiderScene:update(deltaTime)
	if self.camera:isDragEnabled() then
		self.camera:update(deltaTime)
	end

	if self.editMgr:isDragEnabled() then
		self.editMgr:update(deltaTime)
	end

	self.playerMgr:update(deltaTime)
end

function TreasureRaiderScene:lateUpdate()
	local camTF = GlobalModel.instance.mainCamera.transform
	local camX, camY, camZ = Framework.TransformUtil.GetPos(camTF, nil, nil, nil)

	Framework.TransformUtil.SetPos(camTF, camX, camY, -18000)
end

function TreasureRaiderScene:isBreakPathFindingWhileHitAirwall()
	return false
end

function TreasureRaiderScene:isNeedMergePath()
	return false
end

function TreasureRaiderScene:_onElementCreate(elementId, path, quality, pos)
	TreasureRaiderScene.super._onElementCreate(self, elementId, path, quality, pos)

	local row, col = self:getCellRowAndColIndexByElementId(elementId)
	local layer = self:getTool():getLayerNumByElementId(elementId)

	if layer == SeasonLayerTypes.LAYER_GROUND_DOWN then
		local unit = self.gridUnitsMgr:getGridUnit(row, col)

		unit = unit or self.gridUnitsMgr:createGridUnit(elementId, row, col)

		unit:onUnitCreated({
			posX = pos.x,
			posY = pos.y,
			posZ = pos.z
		})

		local gridElem = self.elementMgr:getElement(elementId)

		gridElem = gridElem or self.elementMgr:createElement(unit, elementId, row, col)

		gridElem:onUnitCreated({
			posX = pos.x,
			posY = pos.y,
			posZ = pos.z
		})
	end
end

function TreasureRaiderScene:_onElementVisible(elementId, go, toSceneId, visible)
	local unit = self.unitFactory:getUnit(UnitTag.TilingSceneElem, elementId)

	if unit then
		if visible then
			if unit.onUnitVisible then
				unit:onUnitVisible(go)
			end
		elseif unit.onUnitInVisible then
			unit:onUnitInVisible()
		end
	end

	TreasureRaiderScene.super._onElementVisible(self, elementId, go, toSceneId, visible)
end

function TreasureRaiderScene:getElementIdByGridId(layer, gridId)
	return self:getTool():getElementIdByGridId(layer, gridId)
end

function TreasureRaiderScene:getGridIdByElementId(elementId)
	return self:getTool():getGridIdByElementId(elementId)
end

function TreasureRaiderScene:getCellRowAndColIndexByElementId(elementId)
	return self:getTool():getCellRowAndColIndexByElementId(elementId)
end

function TreasureRaiderScene:getLayerNumByElementId(elementId)
	return self:getTool():getLayerNumByElementId(elementId)
end

function TreasureRaiderScene:_onFindWayFinished()
	return
end

function TreasureRaiderScene:getCellRowAndColIndexByPosition(x, y)
	return
end

function TreasureRaiderScene:isPositionReachable(unit, x, y)
	return
end

function TreasureRaiderScene:getNearestTransmitGroupPos(startX, startY, endX, endY)
	return
end

function TreasureRaiderScene:findRandomNotBerrierAround(sceneunit, x, y, checkAirWaill)
	return
end

return TreasureRaiderScene
