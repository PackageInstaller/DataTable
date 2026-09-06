-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/impl/SeasonTilingScene.lua

module("logicscene.scene.impl.SeasonTilingScene", package.seeall)

local SeasonTilingScene = class("SeasonTilingScene", CityScene)

function SeasonTilingScene:_initComponents()
	self:_addComponent("unitFactory", SeasonTilingSceneUnitFactory)
	self:_addComponent("camera", SceneCompSeasonCamera)
	self:_addComponent("stage", SeasonTilingSceneStage)
	self:_addComponent("pathFindingInfo", SceneCompSeasonGridsInfo)
	self:_addComponent("gridUnitsMgr", SceneCompSeasonGridUnitsMgr)
	self:_addComponent("pathFinder", SceneCompSeasonPathFinder)
	self:_addComponent("joystick", SceneCompDisableJoystickListener)
	self:_addComponent("picker", SceneCompSeasonPicker)
	self:_addComponent("resCache", SceneResObjectCache)
	self:_addComponent("bgm", SceneCompSeasonBgm)
	self:_addComponent("leaders", SceneCompSeasonTeamUnits)
	self:_addComponent("miniMap", SceneCompMiniMap)
	self:_addComponent("eventsData", SceneCompSeasonEvents)
	self:_addComponent("eventsAnimation", SceneCompSeasonAnimation)
	self:_addComponent("navigatePath", SceneCompNavigatePath)
	self:_addComponent("fogsMgr", SceneCompSeasonFogsMgr)
	self:_addComponent("transPoints", SceneCompSeasonTransPoints)
end

function SeasonTilingScene:onEnterFinished()
	SeasonTilingScene.super.onEnterFinished(self)
end

function SeasonTilingScene:lateEnterFinished()
	GlobalDispatcher:addListener(GlobalNotify.ChangeFocusTeam, self.changeFocus, self)
	SeasonTilingScene.super.lateEnterFinished(self)

	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer then
		mainPlayer.syncPos:disable(true)
		mainPlayer:setVisible(false)
	end

	self.joystick:setEnable(false)
	self:changeFocus()
	self.picker:setFindWayFinishedCallback(self._onFindWayFinished, self)
end

function SeasonTilingScene:changeFocus(teamId)
	teamId = teamId or SeasonTeamsModel.instance:getCurrTeamId()

	if not teamId or teamId == 0 then
		return
	end

	local unit = self.leaders:getTeamUnit(teamId)

	if unit then
		self.camera:enablFollowTarget(true)
		self.camera:setFollowUnit(unit)
		self.picker:setFindWayUnit(unit)
	end

	self.navigatePath:navigateUnit(unit)
end

function SeasonTilingScene:onEnter(sceneId, bornX, bornZ)
	SeasonTilingScene.super.onEnter(self, sceneId, bornX, bornZ)
	SeasonController.instance:setSceneSceneId(sceneId)
end

function SeasonTilingScene:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.ChangeFocusTeam, self.changeFocus, self)
	SeasonController.instance:setSceneSceneId(0)
	SeasonTilingScene.super.onExit(self)
end

function SeasonTilingScene:getSceneType()
	return SceneType.SeasonTiling
end

function SeasonTilingScene:getDefaultView()
	local seasonId = SeasonModel.instance:getSeasonId()
	local cfg = SeasonConfig.instance:getSeasonConfigBySeasonId(seasonId)

	if not string.nilorempty(cfg.viewname) then
		return cfg.viewname
	end

	return ViewName.SeasonMainView
end

function SeasonTilingScene:update(deltaTime)
	self.leaders:update(deltaTime)
	self.camera:update(deltaTime)
	self.navigatePath:update(deltaTime)
	self.fogsMgr:update(deltaTime)
	self.miniMap:update(deltaTime)
end

function SeasonTilingScene:lateUpdate()
	local camTF = GlobalModel.instance.mainCamera.transform
	local camX, camY, camZ = Framework.TransformUtil.GetPos(camTF, nil, nil, nil)

	Framework.TransformUtil.SetPos(camTF, camX, camY, -18000)
end

function SeasonTilingScene:isBreakPathFindingWhileHitAirwall()
	return false
end

function SeasonTilingScene:isNeedMergePath()
	return false
end

function SeasonTilingScene:_onElementCreate(elementId, path, quality, pos)
	SeasonTilingScene.super._onElementCreate(self, elementId, path, quality, pos)

	local seasonId = SeasonModel.instance:getSeasonId()
	local row, col = self:getCellRowAndColIndexByElementId(elementId)

	if SeasonConfig.instance:isFogElement(seasonId, elementId) then
		local fogElem = self.unitFactory:createGridFog(elementId, row, col)

		fogElem:onUnitCreated({
			posX = pos.x,
			posY = pos.y,
			posZ = pos.z
		})
		self.fogsMgr:addFogElement(fogElem)

		return
	end

	local unit = self.gridUnitsMgr:getGridUnit(row, col)

	unit = unit or self.gridUnitsMgr:createGridUnit(elementId, row, col)

	unit:onUnitCreated({
		posX = pos.x,
		posY = pos.y,
		posZ = pos.z
	})

	local isMainElement = self.gridUnitsMgr:isMainElementId(elementId, row, col)

	if isMainElement then
		self.gridUnitsMgr:setUnitElementId(elementId, row, col)

		return
	end

	local gridElem

	if unit:getEventObjectId() == elementId then
		gridElem = self.unitFactory:createGridEvent(elementId, row, col)

		self.eventsData:addEventUnit(gridElem)
	else
		gridElem = self.unitFactory:createGridElem(elementId, row, col)
	end

	gridElem:onUnitCreated({
		posX = pos.x,
		posY = pos.y,
		posZ = pos.z
	})
	unit.elements:addElement(gridElem)
end

function SeasonTilingScene:_onElementVisible(elementId, go, toSceneId, visible)
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

	SeasonTilingScene.super._onElementVisible(self, elementId, go, toSceneId, visible)
end

function SeasonTilingScene:getElementIdByGridId(layer, gridId)
	return SeasonPathFindingDataModel.instance:getElementIdByGridId(layer, gridId)
end

function SeasonTilingScene:getGridIdByElementId(elementId)
	return SeasonPathFindingDataModel.instance:getGridIdByElementId(elementId)
end

function SeasonTilingScene:getCellRowAndColIndexByElementId(elementId)
	return SeasonPathFindingDataModel.instance:getCellRowAndColIndexByElementId(elementId)
end

function SeasonTilingScene:getLayerNumByElementId(elementId)
	return SeasonPathFindingDataModel.instance:getLayerNumByElementId(elementId)
end

function SeasonTilingScene:getGridUnitOffsetY(gridX, gridY)
	local offsetY = 0

	if not self.gridUnitsMgr then
		return offsetY
	end

	local gridUnit = self.gridUnitsMgr:getGridUnit(gridX, gridY)

	if gridUnit then
		offsetY = gridUnit:getPositionOffsetY()
	end

	return offsetY
end

function SeasonTilingScene:getPosWithOffsetY(gridX, gridY)
	local posX, posY = SeasonPathFindingDataModel.instance:grid2Pos(gridX, gridY)
	local offsetY = self:getGridUnitOffsetY(gridX, gridY)

	return posX, posY + offsetY
end

function SeasonTilingScene:_onFindWayFinished()
	return
end

function SeasonTilingScene:getCellRowAndColIndexByPosition(x, y)
	return SeasonPathFindingDataModel.instance:getCellRowAndColIndexByPosition(x, y)
end

function SeasonTilingScene:isPositionReachable(unit, x, y)
	return self.pathFinder:isWalkable(x, y)
end

function SeasonTilingScene:getNearestTransmitGroupPos(startX, startY, endX, endY)
	return
end

function SeasonTilingScene:findRandomNotBerrierAround(sceneunit, x, y, checkAirWaill)
	return self.pathFinder:findRandomNotBerrierAround(x, y, checkAirWaill)
end

function SeasonTilingScene:visibleMainPlayer(visible)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer then
		mainPlayer:setVisible(false)
	end
end

function SeasonTilingScene:visibleObjects(visible)
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

return SeasonTilingScene
