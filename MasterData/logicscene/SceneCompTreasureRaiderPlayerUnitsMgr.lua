-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/treasureraider/SceneCompTreasureRaiderPlayerUnitsMgr.lua

module("logicscene.scene.component.treasureraider.SceneCompTreasureRaiderPlayerUnitsMgr", package.seeall)

local SceneCompTreasureRaiderPlayerUnitsMgr = class("SceneCompTreasureRaiderPlayerUnitsMgr", SceneComponentBase)

function SceneCompTreasureRaiderPlayerUnitsMgr:onEnterScene(sceneId, bornX, bornZ)
	SceneCompTreasureRaiderPlayerUnitsMgr.super.onEnterScene(self, sceneId, bornX, bornZ)
	GlobalDispatcher:addListener(GlobalNotify.TreasureApplyMovePlayer, self._onApplyPlayerMove, self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderReloadScene, self._onReloadScene, self)
end

function SceneCompTreasureRaiderPlayerUnitsMgr:onExitScene()
	GlobalDispatcher:removeListener(GlobalNotify.TreasureApplyMovePlayer, self._onApplyPlayerMove, self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderReloadScene, self._onReloadScene, self)

	self._myPlayerUnit = nil
end

function SceneCompTreasureRaiderPlayerUnitsMgr:onEnterSceneFinished(sceneId, bornX, bornZ)
	return
end

function SceneCompTreasureRaiderPlayerUnitsMgr:update(deltaTime)
	if self._myPlayerUnit then
		self._myPlayerUnit:update(deltaTime)
	end
end

function SceneCompTreasureRaiderPlayerUnitsMgr:createPlayers()
	local sceneMo = self._scene:getSceneMo()
	local playerMo = sceneMo.myPlayerMo

	if not self._myPlayerUnit then
		local x, y = playerMo:getBirthPos()

		self._myPlayerUnit = self._scene.unitFactory:createPlayer(playerMo, x, y, 3)
	end

	self._myPlayerUnit:setPlayerMo(playerMo)
	self._scene.picker:setFindWayUnit(self._myPlayerUnit)
end

function SceneCompTreasureRaiderPlayerUnitsMgr:_onApplyPlayerMove()
	local playerMo = self._myPlayerUnit.data
	local tool = self._scene:getTool()
	local posX, posY = tool:id2Pos(playerMo.serverGridId)

	self._scene.picker:realOnQueryFindWay(posX, posY)

	local gridStartX, gridStartY = tool:id2Grid(playerMo.clientGridId)
	local gridEndX, gridEndY = tool:id2Grid(playerMo.serverGridId)
	local gridPathTo = self._scene.pathFinder:getGridPath(gridStartX, gridStartY, gridEndX, gridEndY)
	local pathToArray = {}
	local pathToMap = {}

	for j = 1, #gridPathTo, 2 do
		local pathGridId = tool:grid2Id(gridPathTo[j], gridPathTo[j + 1])

		table.insert(pathToArray, pathGridId)

		pathToMap[pathGridId] = #pathToArray
	end

	self._scene.gridUnitsMgr:playerStartMove(playerMo, pathToArray, pathToMap)
end

function SceneCompTreasureRaiderPlayerUnitsMgr:_onReloadScene()
	local sceneMo = self._scene:getSceneMo()
	local playerMo = sceneMo.myPlayerMo
	local posX, posY = self._scene:getTool():id2Pos(playerMo.serverGridId)

	self._myPlayerUnit.data = playerMo

	self._myPlayerUnit.transform:setPos(posX, posY, nil, true)
end

return SceneCompTreasureRaiderPlayerUnitsMgr
