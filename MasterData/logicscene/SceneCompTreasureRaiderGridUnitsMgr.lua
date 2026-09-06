-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/treasureraider/SceneCompTreasureRaiderGridUnitsMgr.lua

module("logicscene.scene.component.treasureraider.SceneCompTreasureRaiderGridUnitsMgr", package.seeall)

local SceneCompTreasureRaiderGridUnitsMgr = class("SceneCompTreasureRaiderGridUnitsMgr", SceneComponentBase)

SceneCompTreasureRaiderGridUnitsMgr.StageResPath = "scene/tiling/treasure_raider/treasure_raider_stage.prefab"

function SceneCompTreasureRaiderGridUnitsMgr:onEnterScene(sceneId, bornX, bornZ)
	SceneCompTreasureRaiderGridUnitsMgr.super.onEnterScene(self, sceneId, bornX, bornZ)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderReloadScene, self._onReloadScene, self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderPlayerClientGridUpdated, self._updatePlayerClientGrid, self)
end

function SceneCompTreasureRaiderGridUnitsMgr:onExitScene()
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderReloadScene, self._onReloadScene, self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderPlayerClientGridUpdated, self._updatePlayerClientGrid, self)

	self._gridUnitsByRowCol = nil
	self._gridUnitsByGridId = nil
	self._pathToArray = nil
	self._pathToMap = nil
end

function SceneCompTreasureRaiderGridUnitsMgr:onEnterSceneFinished(sceneId, bornX, bornZ)
	return
end

function SceneCompTreasureRaiderGridUnitsMgr:getGridUnits()
	return self._gridUnitsByRowCol
end

function SceneCompTreasureRaiderGridUnitsMgr:getGridUnit(row, col)
	if not self._gridUnitsByRowCol or not self._gridUnitsByRowCol[row] then
		return
	end

	return self._gridUnitsByRowCol[row][col]
end

function SceneCompTreasureRaiderGridUnitsMgr:createGridUnit(elementId, row, col)
	local unit = self._scene.unitFactory:createGridUnit(elementId, row, col)

	self._gridUnitsByRowCol = self._gridUnitsByRowCol or {}
	self._gridUnitsByRowCol[row] = self._gridUnitsByRowCol[row] or {}
	self._gridUnitsByRowCol[row][col] = unit
	self._gridUnitsByGridId = self._gridUnitsByGridId or {}

	local gridId = self._scene:getTool():grid2Id(row, col)

	self._gridUnitsByGridId[gridId] = unit

	return unit
end

function SceneCompTreasureRaiderGridUnitsMgr:setUnitElementId(elementId, row, col)
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

function SceneCompTreasureRaiderGridUnitsMgr:_onReloadScene()
	self._pathToArray = nil
	self._pathToMap = nil
	self._pathToPlayerMo = nil

	self:_updatePlayerClientGrid()
end

function SceneCompTreasureRaiderGridUnitsMgr:_updatePlayerClientGrid(userId)
	if self._pathToMap then
		if not self._pathToMap[self._pathToPlayerMo.clientGridId] then
			local pathMap

			if self._pathToMap[self._pathToPlayerMo.clientGridId] < #self._pathToArray then
				pathMap = {}

				for i = self._pathToMap[self._pathToPlayerMo.clientGridId], #self._pathToArray do
					pathMap[self._pathToArray[i]] = true
				end
			end

			for _, unit in pairs(self._gridUnitsByGridId) do
				unit.gridStatus:updateMovePath(pathMap)
			end
		end
	end
end

function SceneCompTreasureRaiderGridUnitsMgr:playerStartMove(playerMo, pathToArray, pathToMap)
	self._pathToPlayerMo = playerMo
	self._pathToArray = pathToArray
	self._pathToMap = pathToMap

	self:_updatePlayerClientGrid()
end

return SceneCompTreasureRaiderGridUnitsMgr
