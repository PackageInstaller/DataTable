-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/treasureraider/SceneCompTreasureRaiderPathFinder.lua

module("logicscene.scene.component.treasureraider.SceneCompTreasureRaiderPathFinder", package.seeall)

local SceneCompTreasureRaiderPathFinder = class("SceneCompTreasureRaiderPathFinder", ScenePathFinderEx)

function SceneCompTreasureRaiderPathFinder:ctor(scene)
	self._scene = scene
end

function SceneCompTreasureRaiderPathFinder:getPath(unit, startX, startY, endX, endY, state)
	if startX ~= nil and startY ~= nil and endX ~= nil and endY ~= nil and self._scene and self._scene:getTool() then
		local gridStartX, gridStartY = self._scene:getTool():pos2Grid(startX, startY)
		local gridEndX, gridEndY = self._scene:getTool():pos2Grid(endX, endY)
		local gridPathTo = self:getGridPath(gridStartX, gridStartY, gridEndX, gridEndY)
		local pathTo = {}
		local posX, posY

		for j = 1, #gridPathTo, 2 do
			local var_2_0

			var_2_0, posY = self._scene:getTool():grid2Pos(gridPathTo[j], gridPathTo[j + 1])

			table.insert(pathTo, var_2_0)
			table.insert(pathTo, posY)
		end

		return pathTo
	end

	return {}
end

function SceneCompTreasureRaiderPathFinder:getGridPath(gridStartX, gridStartY, gridEndX, gridEndY)
	if gridStartX ~= nil and gridStartY ~= nil and gridEndX ~= nil and gridEndY ~= nil and self._scene and self._scene:getTool() then
		local startNode = self._scene:getTool():getPathFinder():getNode(gridStartX, gridStartY)
		local endNode = self._scene:getTool():getPathFinder():getNode(gridEndX, gridEndY)

		if startNode and endNode then
			return self._scene:getTool():getPathFinder():search(startNode, endNode)
		end
	end

	return {}
end

function SceneCompTreasureRaiderPathFinder:onEnterScene(sceneId, bornX, bornZ)
	SceneCompTreasureRaiderPathFinder.super.onEnterScene(self, sceneId, bornX, bornZ)
end

function SceneCompTreasureRaiderPathFinder:onExitScene()
	SceneCompTreasureRaiderPathFinder.super.onExitScene(self)
end

function SceneCompTreasureRaiderPathFinder:getFindWayGridWeight(gridX, gridY)
	return 1
end

function SceneCompTreasureRaiderPathFinder:findRandomNotBerrierAround(x, y, checkAirWaill)
	return
end

function SceneCompTreasureRaiderPathFinder:checkGridAroundWalkableOne(gridX, gridY, cols, rows, list)
	return
end

return SceneCompTreasureRaiderPathFinder
