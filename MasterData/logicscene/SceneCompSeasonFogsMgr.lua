-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/season/SceneCompSeasonFogsMgr.lua

module("logicscene.scene.component.season.SceneCompSeasonFogsMgr", package.seeall)

local SceneCompSeasonFogsMgr = class("SceneCompSeasonFogsMgr", SceneComponentBase)

SceneCompSeasonFogsMgr.unlockTranspointsEffPath = "effect/prefabs/story/saiji/cjsaiji/fx_scene_huo.prefab"

function SceneCompSeasonFogsMgr:onEnterScene(sceneId, bornX, bornZ)
	SceneCompSeasonFogsMgr.super.onEnterScene(self, sceneId, bornX, bornZ)
	GlobalDispatcher:addListener(GlobalNotify.SeasonServerNotifyOccupiedGrid, self._onNotifyOccupiedGrid, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonOccupiedGrid, self._onOccupiedGrid, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonDanceLionUpdated, self._onOccupiedGrid, self)
end

function SceneCompSeasonFogsMgr:onEnterSceneFinished(sceneId, bornX, bornZ)
	return
end

function SceneCompSeasonFogsMgr:lateEnterFinished()
	local fogs = self:getFogElements()

	if fogs then
		local seasonId = SeasonModel.instance:getSeasonId()

		for k, v in pairs(fogs) do
			local gridElemId = SeasonConfig.instance:getFogRelateToGridElementId(seasonId, k)
			local row, col = SeasonPathFindingDataModel.instance:id2Grid(gridElemId or 0)
			local gridUnit = self._scene.gridUnitsMgr:getGridUnit(row, col)

			if gridUnit then
				gridUnit.elements:addElement(v)

				local gridId = SeasonPathFindingDataModel.instance:grid2Id(v.row, v.col)
				local evtCfg = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, gridId)

				if evtCfg and evtCfg.eventType == SeasonGridEvtTypes.EVT_CONVEY then
					self._unlockTranspointGrid = gridUnit
				end
			end
		end
	end

	self:_checkCreateUnlockTranspointEff()
	self._scene.eventsAnimation:playUnlockFogsAnim()
end

function SceneCompSeasonFogsMgr:update(deltaTime)
	if self._fogElements then
		for k, v in pairs(self._fogElements) do
			v:update(deltaTime)
		end
	end
end

function SceneCompSeasonFogsMgr:addFogElement(fogElem)
	self._fogElements = self._fogElements or {}
	self._fogElements[fogElem.id] = fogElem
	self._fogElementsMap = self._fogElementsMap or {}
	self._fogElementsMap[fogElem.row] = self._fogElementsMap[fogElem.row] or {}
	self._fogElementsMap[fogElem.row][fogElem.col] = fogElem
end

function SceneCompSeasonFogsMgr:getFogElementByRowAndCol(row, col)
	if not self._fogElementsMap or not self._fogElementsMap[row] then
		return
	end

	return self._fogElementsMap[row][col]
end

function SceneCompSeasonFogsMgr:getFogElement(id)
	if not self._fogElements then
		return
	end

	return self._fogElements[id]
end

function SceneCompSeasonFogsMgr:getFogElements()
	return self._fogElements
end

function SceneCompSeasonFogsMgr:onExitScene()
	self._fogElements = nil
	self._fogElementsMap = nil

	GlobalDispatcher:removeListener(GlobalNotify.SeasonDanceLionUpdated, self._onOccupiedGrid, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonOccupiedGrid, self._onOccupiedGrid, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonServerNotifyOccupiedGrid, self._onNotifyOccupiedGrid, self)
end

function SceneCompSeasonFogsMgr:getFogRelateToElements(id)
	local gridElements
	local seasonId = SeasonModel.instance:getSeasonId()
	local evtCfg = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, id)

	if not evtCfg or string.nilorempty(evtCfg.fogObjIds) then
		return
	end

	local fogObjIds = string.splitToNumber(evtCfg.fogObjIds, ",")

	for i = 1, #fogObjIds do
		local fogElem = self:getFogElement(fogObjIds[i])

		if fogElem then
			gridElements = gridElements or {}

			table.insert(gridElements, fogElem)
		end
	end

	return gridElements
end

function SceneCompSeasonFogsMgr:_onNotifyOccupiedGrid(id)
	self._scene.eventsAnimation:playUnlockFogsAnim()
end

function SceneCompSeasonFogsMgr:_onOccupiedGrid(id)
	if id == self:getUnlockTranspointGridId() then
		self:_checkCreateUnlockTranspointEff()
	end

	if self._fogElements then
		for k, v in pairs(self._fogElements) do
			local seasonId = SeasonModel.instance:getSeasonId()
			local gridId = SeasonConfig.instance:getFogRelateToGridElementId(seasonId, v.id)

			if id == gridId then
				v:updateOccupiedStatus()
			end
		end
	end
end

function SceneCompSeasonFogsMgr:getUnlockTranspointEff()
	return self._unlockTransEff
end

function SceneCompSeasonFogsMgr:getUnlockTranspointGridId()
	if not self._unlockTranspointGrid then
		return 0
	end

	return SeasonPathFindingDataModel.instance:grid2Id(self._unlockTranspointGrid.row, self._unlockTranspointGrid.col)
end

function SceneCompSeasonFogsMgr:_checkCreateUnlockTranspointEff()
	if not self._unlockTranspointGrid and SeasonModel.instance:getSeasonId() ~= 1 and SeasonModel.instance:getSeasonId() ~= 3 then
		return
	end

	local gridId = self:getUnlockTranspointGridId()
	local unlockFogGridId = SeasonController.instance:getRecentlyUnlockedFogsGrid()
	local preparedPlayAnim = unlockFogGridId == gridId
	local mapData = SeasonModel.instance:getMapInfoById(gridId)
	local isOccupied = mapData and mapData:isInitServerData() and SeasonModel.instance:isOccupied(gridId)

	if preparedPlayAnim or not isOccupied then
		self:_createUnlockTranspointEff()
	else
		self:destroyUnlockTranspointEff()
	end
end

function SceneCompSeasonFogsMgr:_createUnlockTranspointEff()
	if self._unlockTransEff then
		return
	end

	self._unlockTransEff = self._scene.unitFactory:createCustomSeasonUnit(self._unlockTranspointGrid.id, SceneCompSeasonFogsMgr.unlockTranspointsEffPath, 22.66, 63.1)
end

function SceneCompSeasonFogsMgr:destroyUnlockTranspointEff()
	if self._unlockTransEff then
		self._scene.unitFactory:destroyCustomSeasonUnit(self._unlockTransEff.id)

		self._unlockTransEff = nil
	end
end

return SceneCompSeasonFogsMgr
