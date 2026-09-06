-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/season/SceneCompSeasonGridUnitsMgr.lua

module("logicscene.scene.component.season.SceneCompSeasonGridUnitsMgr", package.seeall)

local SceneCompSeasonGridUnitsMgr = class("SceneCompSeasonGridUnitsMgr", SceneComponentBase)
local effectPath = "effect/prefabs/scene/fx_scene_saijiwanfa/fx_scene_zhanling_saijiwanfa.prefab"

function SceneCompSeasonGridUnitsMgr:onEnterScene(sceneId, bornX, bornZ)
	SceneCompSeasonGridUnitsMgr.super.onEnterScene(self, sceneId, bornX, bornZ)
	GlobalDispatcher:addListener(GlobalNotify.SeasonSelectGrid_R_C, self.selectGrid, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonMarkGrid, self.markGrid, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonOccupiedGrid, self.occupiedGrid, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonBossInfoUpdated, self._onBossInfoUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonFogStateUpdated, self._onFogStateUpdated, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonApplyClientRotateFire, self._onDanceLionRotate, self)
end

function SceneCompSeasonGridUnitsMgr:onEnterSceneFinished(sceneId, bornX, bornZ)
	return
end

function SceneCompSeasonGridUnitsMgr:aimGrid(aimed)
	if aimed then
		self:showLevel(false)
		self:clearLastSelect()
		SeasonController.instance:closeOperateView()
	end

	self._isAimmingGrid = aimed

	local units = self:getGridUnits()

	if not units then
		return
	end

	for k, v in pairs(units) do
		for k1, v1 in pairs(v) do
			v1.gridStatus:updatePlacedStatus()
		end
	end
end

function SceneCompSeasonGridUnitsMgr:isAimmingGrid()
	return self._isAimmingGrid
end

function SceneCompSeasonGridUnitsMgr:showLevel(isShow)
	if isShow then
		self:aimGrid(false)
		self:clearLastSelect()
		SeasonController.instance:closeOperateView()
	end

	self._isShowLevelGrid = isShow

	local units = self:getGridUnits()

	if not units then
		return
	end

	for k, v in pairs(units) do
		for k1, v1 in pairs(v) do
			v1.gridStatus:updateLevelStatus()
		end
	end
end

function SceneCompSeasonGridUnitsMgr:isShowLevelGrid()
	return self._isShowLevelGrid
end

function SceneCompSeasonGridUnitsMgr:clearLastSelect()
	if self._lastSelectUnit then
		self._lastSelectUnit.gridStatus:setSelected(false)
	end

	self._lastSelectUnit = nil
end

function SceneCompSeasonGridUnitsMgr:selectGrid(row, col)
	if self._lastSelectUnit then
		self._lastSelectUnit.gridStatus:setSelected(false)
	end

	local gridUnit = self:getGridUnit(row, col)

	if gridUnit then
		local isGridWalkable = SeasonPathFindingDataModel.instance:isGridWalkable(row, col)

		if isGridWalkable then
			gridUnit:playSelectedAnimation()
		end

		gridUnit.gridStatus:setSelected(true)
	end

	self._lastSelectUnit = gridUnit
end

function SceneCompSeasonGridUnitsMgr:markGrid(id, marked)
	local row, col = SeasonPathFindingDataModel.instance:id2Grid(id)
	local gridUnit = self:getGridUnit(row, col)

	if gridUnit then
		gridUnit.gridStatus:updateMarkedStatus()
	end
end

function SceneCompSeasonGridUnitsMgr:occupiedGrid(id)
	local row, col = SeasonPathFindingDataModel.instance:id2Grid(id)
	local gridUnit = self:getGridUnit(row, col)

	if gridUnit then
		gridUnit.occupiedStatus:updateOccupiedStatus()

		for i = 1, #LuaPathfinder_Const.Directions do
			local nearRow = gridUnit.row + LuaPathfinder_Const.Directions[i][1]
			local nearCol = gridUnit.col + LuaPathfinder_Const.Directions[i][2]
			local nearBy = self:getGridUnit(nearRow, nearCol)

			if nearBy then
				nearBy.occupiedStatus:updateOccupiedStatus()
			end
		end
	end

	local eventUnit = self._scene.eventsData:getEventUnit(row, col)

	if eventUnit then
		eventUnit.gridEvent:updateOccupiedState()
	end
end

function SceneCompSeasonGridUnitsMgr:getGridUnits()
	return self._gridUnits
end

function SceneCompSeasonGridUnitsMgr:getGridUnit(row, col)
	if not self._gridUnits or not self._gridUnits[row] then
		return
	end

	return self._gridUnits[row][col]
end

function SceneCompSeasonGridUnitsMgr:getBossDoppelgangers()
	return self._bossDoppelgangers
end

function SceneCompSeasonGridUnitsMgr:getBoss()
	return self._boss
end

function SceneCompSeasonGridUnitsMgr:createGridUnit(elementId, row, col)
	local unit = self._scene.unitFactory:createGridUnit(elementId, row, col)

	self._gridUnits = self._gridUnits or {}
	self._gridUnits[row] = self._gridUnits[row] or {}
	self._gridUnits[row][col] = unit

	local gridId = SeasonPathFindingDataModel.instance:grid2Id(row, col)
	local seasonId = SeasonModel.instance:getSeasonId()
	local evtCfg = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, gridId)
	local bossDoppelgangers = SeasonPVEBossController.instance:getDoppelgangerReadOnlyPointIds() or {}

	for i, v in ipairs(bossDoppelgangers) do
		if evtCfg and v == evtCfg.id then
			self._bossDoppelgangers = self._bossDoppelgangers or {}

			table.insert(self._bossDoppelgangers, unit)
		end
	end

	if evtCfg and evtCfg.eventType == SeasonGridEvtTypes.EVT_BOSS then
		self._boss = unit
	end

	return unit
end

function SceneCompSeasonGridUnitsMgr:setUnitElementId(elementId, row, col)
	self._mainElemIds = self._mainElemIds or {}
	self._mainElemIds[row] = self._mainElemIds[row] or {}
	self._mainElemIds[row][col] = elementId

	local unit = self:getGridUnit(row, col)

	if not unit or unit.id == elementId then
		return
	end

	local units = self._scene.unitFactory:getUnits(UnitTag.SceneElement)

	units[unit.id] = nil
	unit.id = elementId
	unit.go.name = "grid_unit_" .. elementId .. "_" .. row .. "_" .. col
	units[unit.id] = unit
end

function SceneCompSeasonGridUnitsMgr:getUnitElementId(row, col)
	if not self._mainElemIds or not self._mainElemIds[row] then
		return 0
	end

	return self._mainElemIds[row][col] or 0
end

function SceneCompSeasonGridUnitsMgr:isMainElementId(elementId, row, col)
	local gridId = SeasonPathFindingDataModel.instance:grid2Id(row, col)
	local seasonId = SeasonModel.instance:getSeasonId()
	local evtCfg = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, gridId)

	if evtCfg and evtCfg.eventObjId == elementId then
		return false
	end

	return self:getUnitElementId(row, col) == 0
end

function SceneCompSeasonGridUnitsMgr:onExitScene()
	self._gridUnits = nil
	self._mainElemIds = nil

	GlobalDispatcher:removeListener(GlobalNotify.SeasonBossInfoUpdated, self._onBossInfoUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonSelectGrid_R_C, self.selectGrid, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonMarkGrid, self.markGrid, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonOccupiedGrid, self.occupiedGrid, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonFogStateUpdated, self._onFogStateUpdated, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonApplyClientRotateFire, self._onDanceLionRotate, self)

	if self._occupiedEffects then
		for i, v in pairs(self._occupiedEffects) do
			GameEffectManager.instance:stopEffect(v)
		end

		self._occupiedEffects = nil
	end
end

function SceneCompSeasonGridUnitsMgr:_onBossInfoUpdate(prePhaseId, currPhaseId)
	if self._bossDoppelgangers then
		for i = 1, #self._bossDoppelgangers do
			local eventUnit = self._scene.eventsData:getEventUnit(self._bossDoppelgangers[i].row, self._bossDoppelgangers[i].col)

			if eventUnit then
				eventUnit.gridEvent:handleBossPhaseChange(prePhaseId, currPhaseId)
			end
		end

		local eventBossUnit = self._scene.eventsData:getEventUnit(self._boss.row, self._boss.col)

		if eventBossUnit then
			eventBossUnit.gridEvent:handleBossPhaseChange(prePhaseId, currPhaseId)
		end
	end
end

function SceneCompSeasonGridUnitsMgr:_onFogStateUpdated(id)
	local seasonModel = SeasonModel.instance
	local mapMo = seasonModel:getMapInfoById(id)
	local gridX, gridY = mapMo:getGridPos()
	local evtUnit = self._scene.eventsData:getEventUnit(gridX, gridY)

	if evtUnit then
		evtUnit.gridEvent:updateFogState()
	end
end

function SceneCompSeasonGridUnitsMgr:_onDanceLionRotate(param)
	local evtUnit = self._scene.eventsData:getEventUnit(param.gridX, param.gridY)

	if evtUnit then
		evtUnit.gridEvent:updateOccupiedState()
	end
end

function SceneCompSeasonGridUnitsMgr:tryPlayOccupiedEffect()
	local gridIds = SeasonModel.instance:getLatestOccupiedListAndClear()

	if gridIds then
		self._occupiedEffects = self._occupiedEffects or {}

		for i, gridId in ipairs(gridIds) do
			if not self._occupiedEffects[gridId] then
				local gridX, gridY = SeasonPathFindingDataModel.instance:id2Grid(gridId)
				local gridElement = self:getGridUnit(gridX, gridY)

				if gridElement then
					local eff

					eff = GameEffectManager.instance:playEffect(effectPath, false, nil, 0, 0, 0, function()
						GameEffectManager.instance:stopEffect(eff)

						self._occupiedEffects[gridId] = nil
					end)

					eff:setParent(gridElement.go.transform)
					eff:setScale(1)
					eff:setLocalPos(0, 0, -0.01)
					eff:setSortingOrder(gridElement:getSortingOrderOffset(1))

					self._occupiedEffects[gridId] = eff
				end
			end
		end

		AudioPlayerEx.instance:playEffect(30230)
	end
end

return SceneCompSeasonGridUnitsMgr
