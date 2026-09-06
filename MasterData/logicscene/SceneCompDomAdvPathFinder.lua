-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/domainadventure/SceneCompDomAdvPathFinder.lua

module("logicscene.scene.component.domainadventure.SceneCompDomAdvPathFinder", package.seeall)

local SceneCompDomAdvPathFinder = class("SceneCompDomAdvPathFinder", ScenePathFinderEx)

function SceneCompDomAdvPathFinder:ctor(scene)
	self._scene = scene
end

function SceneCompDomAdvPathFinder:onEnterSceneFinished(sceneId, bornX, bornZ)
	SceneCompDomAdvPathFinder.super.onEnterSceneFinished(self, sceneId, bornX, bornZ)
end

function SceneCompDomAdvPathFinder:getPath(unit, startX, startY, endX, endY, state)
	if startX ~= nil and startY ~= nil and endX ~= nil and endY ~= nil and self._scene and self._scene.pathFindingInfo then
		if self._scene.pathFindingInfo:getInternalPathFinder():isConfigReady() then
			local gridStartX, gridStartY = startX, startY
			local gridEndX, gridEndY = endX, endY
			local boo, gridPathTo = SeasonController.instance:checkIfCanMoveByOccupied(gridStartX, gridStartY, gridEndX, gridEndY)

			if gridPathTo == nil then
				gridPathTo = self:getGridPath(gridStartX, gridStartY, gridEndX, gridEndY)
			end

			local pathTo = {}
			local posX, posY

			for j = 1, #gridPathTo, 2 do
				local var_3_0

				var_3_0, posY = self._scene:getPosWithOffsetY(gridPathTo[j], gridPathTo[j + 1])

				table.insert(pathTo, var_3_0)
				table.insert(pathTo, posY)
			end

			return pathTo, gridPathTo
		end
	end

	return {}, {}
end

function SceneCompDomAdvPathFinder:getGridPath(gridStartX, gridStartY, gridEndX, gridEndY)
	if gridStartX ~= nil and gridStartY ~= nil and gridEndX ~= nil and gridEndY ~= nil and self._scene and self._scene.pathFindingInfo then
		local finder = self._scene.pathFindingInfo:getInternalPathFinder()

		if finder:isConfigReady() then
			local startNode = finder:getNode(gridStartX, gridStartY)
			local endNode = finder:getNode(gridEndX, gridEndY)

			if startNode and endNode then
				return finder:search(startNode, endNode)
			end
		end
	end

	return {}
end

function SceneCompDomAdvPathFinder:onEnterScene(sceneId, bornX, bornZ)
	SceneCompDomAdvPathFinder.super.onEnterScene(self, sceneId, bornX, bornZ)
	GlobalDispatcher:addListener(GlobalNotify.SeasonFogStateUpdated, self._onFogStateUpdated, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonOccupiedGrid, self._onOccupiedUpdated, self)
end

function SceneCompDomAdvPathFinder:onExitScene()
	SceneCompDomAdvPathFinder.super.onExitScene(self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonFogStateUpdated, self._onFogStateUpdated, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonOccupiedGrid, self._onOccupiedUpdated, self)
end

function SceneCompDomAdvPathFinder:_onFogStateUpdated(id)
	local seasonModel = SeasonModel.instance
	local mapMo = seasonModel:getMapInfoById(id)
	local gridX, gridY = mapMo:getGridPos()

	if mapMo._fogState == SeasonMapDataMO.Fog_Within then
		self._scene.pathFindingInfo:getInternalPathFinder():setBlockState(gridX, gridY, true)
	else
		self._scene.pathFindingInfo:getInternalPathFinder():setBlockState(gridX, gridY, nil)
	end
end

function SceneCompDomAdvPathFinder:_onOccupiedUpdated(id)
	return
end

function SceneCompDomAdvPathFinder:_onBossInfoUpdated()
	local map = SeasonPVEBossController.instance:getBlockStates()

	for k, v in pairs(map) do
		local gridX, gridY = DomAdvPathFindingDataModel.instance:id2Grid(checknumber(k))

		if v then
			self._scene.pathFindingInfo:getInternalPathFinder():setBlockState(gridX, gridY, true)
		else
			self._scene.pathFindingInfo:getInternalPathFinder():setBlockState(gridX, gridY, nil)
		end
	end
end

function SceneCompDomAdvPathFinder:getFindWayGridWeight(gridX, gridY)
	return 1
end

function SceneCompDomAdvPathFinder:isWalkable(x, y)
	if self._scene and self._scene.pathFindingInfo then
		if self._scene.pathFindingInfo:getInternalPathFinder():isConfigReady() then
			local gridX, gridY = self._scene.pathFindingInfo:pos2Grid(x, y)

			return self:isGridWalkable(gridX, gridY)
		end
	end
end

function SceneCompDomAdvPathFinder:isGridWalkable(gridX, gridY)
	local node = self._scene.pathFindingInfo:getInternalPathFinder():getNode(gridX, gridY)

	return self._scene.pathFindingInfo:getInternalPathFinder():isWalkable(node)
end

function SceneCompDomAdvPathFinder:isGridNearBy(formGridX, formGridY, toGridX, toGridY)
	local fromNode = self._scene.pathFindingInfo:getInternalPathFinder():getNode(formGridX, formGridY)
	local toNode = self._scene.pathFindingInfo:getInternalPathFinder():getNode(toGridX, toGridY)
	local var_13_0 = self._scene.pathFindingInfo:getInternalPathFinder():isValid(fromNode)

	if var_13_0 then
		var_13_0 = self._scene.pathFindingInfo:getInternalPathFinder():isValid(toNode)
		var_13_0 = var_13_0 and self._scene.pathFindingInfo:getInternalPathFinder():isNeighbour(fromNode, toNode)
	end

	return var_13_0
end

function SceneCompDomAdvPathFinder:findNeighbours(gridX, gridY)
	local node = self._scene.pathFindingInfo:getInternalPathFinder():getNode(gridX, gridY)

	if self._scene.pathFindingInfo:getInternalPathFinder():isValid(node) then
		return self._scene.pathFindingInfo:getInternalPathFinder():findNeighbours(node)
	end
end

function SceneCompDomAdvPathFinder:isInMoveRange(formGridX, formGridY, toGridX, toGridY, range)
	local fromNode = self._scene.pathFindingInfo:getInternalPathFinder():getNode(formGridX, formGridY)
	local toNode = self._scene.pathFindingInfo:getInternalPathFinder():getNode(toGridX, toGridY)

	if self._scene.pathFindingInfo:getInternalPathFinder():isValid(fromNode) then
		if self._scene.pathFindingInfo:getInternalPathFinder():isValid(toNode) then
			local distance = self._scene.pathFindingInfo:getInternalPathFinder():calHeuristic(fromNode, toNode, LuaPathfinder_Const.HeuristicFlag_Manhattan)

			if distance <= (range + 2) * 2 then
				local gridPathTo = self._scene.pathFindingInfo:getInternalPathFinder():search(fromNode, toNode)

				return #gridPathTo > 0 and #gridPathTo <= range * 2
			end
		end
	end

	return false
end

function SceneCompDomAdvPathFinder:isPassable(formGridX, formGridY, toGridX, toGridY)
	local fromNode = self._scene.pathFindingInfo:getInternalPathFinder():getNode(formGridX, formGridY)
	local toNode = self._scene.pathFindingInfo:getInternalPathFinder():getNode(toGridX, toGridY)

	if self._scene.pathFindingInfo:getInternalPathFinder():isValid(fromNode) then
		if self._scene.pathFindingInfo:getInternalPathFinder():isValid(toNode) then
			return self._scene.pathFindingInfo:getInternalPathFinder():isPassable(fromNode, toNode)
		end
	end

	return false
end

function SceneCompDomAdvPathFinder:isNeighbourAndPassable(formGridX, formGridY, toGridX, toGridY)
	local getInternalPathFinder = self._scene.pathFindingInfo:getInternalPathFinder()
	local fromNode = getInternalPathFinder:getNode(formGridX, formGridY)
	local toNode = getInternalPathFinder:getNode(toGridX, toGridY)

	if getInternalPathFinder:isValid(fromNode) and getInternalPathFinder:isValid(toNode) then
		return getInternalPathFinder:isPassable(fromNode, toNode) and getInternalPathFinder:isNeighbour(fromNode, toNode)
	end

	return false
end

function SceneCompDomAdvPathFinder:findRandomNotBerrierAround(x, y, checkAirWaill)
	if self._scene and self._scene.pathFindingInfo then
		if self._scene.pathFindingInfo:getInternalPathFinder():isConfigReady() then
			local rows, cols = self._scene.pathFindingInfo:getSceneGridsDimension()
			local gridX, gridY = self._scene.pathFindingInfo:pos2Grid(x, y)
			local list, newGridX, newGridY

			list = {}

			table.insert(list, {
				gridX,
				gridY
			})

			local newList = {}

			while true do
				newList = {}

				for i = 1, #list do
					gridY = list[i][2]
					gridX = list[i][1]

					if cols < list[i][1] and rows < gridY then
						return
					end

					newGridX, newGridY = self:checkGridAroundWalkableOne(gridX, gridY, cols, rows, newList)

					if newGridX ~= nil and newGridY ~= nil then
						return newGridX, newGridY
					end
				end

				if #newList == 0 then
					return
				end

				list = newList
			end
		end
	end
end

function SceneCompDomAdvPathFinder:checkGridAroundWalkableOne(gridX, gridY, cols, rows, list)
	local gridXT, gridYT

	for i = -1, 1 do
		gridXT = gridX + i

		if gridX + i > 0 and gridXT <= cols then
			for j = -1, 1 do
				gridYT = gridY + j

				if i ~= 0 and j ~= 0 and gridYT > 0 and gridYT <= rows then
					local node = self._scene.pathFindingInfo:getInternalPathFinder():getNode(gridXT, gridYT)

					if self._scene.pathFindingInfo:getInternalPathFinder():isWalkable(node) then
						return gridXT, gridYT
					end

					table.insert(list, {
						gridXT,
						gridYT
					})
				end
			end
		end
	end
end

return SceneCompDomAdvPathFinder
