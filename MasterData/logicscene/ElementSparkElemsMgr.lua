-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/mainplayer/ElementSparkElemsMgr.lua

module("logicscene.scene.component.mainplayer.ElementSparkElemsMgr", package.seeall)

local ElementSparkElemsMgr = class("ElementSparkElemsMgr", SceneComponentBase)

ElementSparkElemsMgr.TileBoundX = 2.26
ElementSparkElemsMgr.TileBoundY = 2.26
ElementSparkElemsMgr.TileStep = {
	x = ElementSparkElemsMgr.TileBoundX / 2,
	y = ElementSparkElemsMgr.TileBoundY / 4
}
ElementSparkElemsMgr.TotalRow = 0
ElementSparkElemsMgr.TotalCol = 0
ElementSparkElemsMgr.OffsetX = 0
ElementSparkElemsMgr.OffsetY = 0
ElementSparkElemsMgr.MapSizeX = 0
ElementSparkElemsMgr.MapSizeY = 0

function ElementSparkElemsMgr:ctor(scene)
	ElementSparkElemsMgr.super.ctor(self, scene)

	self._isReady = nil
end

function ElementSparkElemsMgr:onEnterScene(sceneId, bornX, bornZ)
	self._elementCos = {}

	local mapPlanId = ElementSparkController.instance:getMapPlanId()

	self._chunkCfgs = ElementSparkConfig.instance:getMapChunkCfgs(mapPlanId)
end

function ElementSparkElemsMgr:onEnterSceneFinished()
	self._isReady = true

	self:_createAllElements()
end

function ElementSparkElemsMgr:onExitScene()
	self._isReady = nil
end

function ElementSparkElemsMgr:isReady()
	return self._isReady
end

function ElementSparkElemsMgr:_createAllElements()
	self:_createBackGround()

	local resultChunkCfgs = self:_sortChunks(self._chunkCfgs)

	for i, v in ipairs(resultChunkCfgs) do
		v.chunkOrder = i

		local x, y = ElementSparkSceneController.instance:getTilePos(v.pos, v.anotherPos)
		local elemDataCo = {
			offset = 0,
			layer = 0,
			chunkCfg = v,
			assetPath = string.format("scene/elementspark/gezi/%s.prefab", v.assetPath),
			position = {
				x = x,
				y = y
			},
			boundsX = ElementSparkElemsMgr.TileBoundX,
			boundsY = ElementSparkElemsMgr.TileBoundX,
			id = v.chunkId
		}

		self._elementCos[v.chunkId] = elemDataCo

		self._scene.unitFactory:createElementSparkElem(elemDataCo)
		self:_createLevelElem(v)
	end
end

function ElementSparkElemsMgr:_sortChunks(chunkCfgs)
	local result = {}

	for k, v in pairs(chunkCfgs) do
		local insertIndex = #result + 1
		local find = false
		local a = v

		for j = 1, #result do
			local b = result[j]

			if find and self:_isHeigher(a, b) then
				table.remove(result, j)
				table.insert(result, insertIndex, b)

				insertIndex = insertIndex + 1
			end

			if not find and self:_isLower(a, b) then
				insertIndex = j
				find = true
			end
		end

		table.insert(result, insertIndex, a)
	end

	return result
end

function ElementSparkElemsMgr:_isHeigher(a, b)
	if -a.pos[2] >= -b.anotherPos[2] and a.anotherPos[1] > b.pos[1] then
		return true
	end

	if -a.anotherPos[2] > -b.pos[2] and a.pos[1] >= b.anotherPos[1] then
		return true
	end

	return false
end

function ElementSparkElemsMgr:_isLower(a, b)
	if a.pos[1] < b.anotherPos[1] and -a.anotherPos[2] <= -b.pos[2] then
		return true
	end

	if -a.pos[2] < -b.anotherPos[2] and a.anotherPos[1] <= b.pos[1] then
		return true
	end

	return false
end

function ElementSparkElemsMgr:_createBackGround()
	local assetPathGrid = {}

	for k, v in pairs(self._chunkCfgs) do
		for i = v.pos[1], v.anotherPos[1] do
			assetPathGrid[i] = assetPathGrid[i] or {}

			for j = v.pos[2], v.anotherPos[2] do
				assetPathGrid[i][j] = v.bgAssetPath
			end
		end
	end

	local id = -1

	for i = 1, ElementSparkElemsMgr.TotalRow do
		for j = 1, ElementSparkElemsMgr.TotalCol do
			local x, y = ElementSparkSceneController.instance:getBgTilePos(i - 1, j - 1)
			local elemDataCo = {
				offset = 0,
				layer = 0,
				chunkCfg = v,
				assetPath = self:_getBackgroundPrefabPath(assetPathGrid, i - 1, j - 1),
				position = {
					x = x,
					y = y
				},
				boundsX = ElementSparkElemsMgr.TileBoundX,
				boundsY = ElementSparkElemsMgr.TileBoundX,
				id = id
			}

			self._scene.unitFactory:createBackGroundElem(elemDataCo)

			id = id - 1
		end
	end
end

function ElementSparkElemsMgr:_getBackgroundPrefabPath(assetPathGrid, row, col)
	local assetName = ""

	if assetPathGrid[row] and assetPathGrid[row][col] then
		assetName = assetPathGrid[row][col]
	end

	if string.nilorempty(assetName) then
		return "scene/elementspark/gezi/background.prefab"
	end

	return string.format("scene/elementspark/gezi/%s.prefab", assetName)
end

function ElementSparkElemsMgr.getMapWidthHeight()
	local activityId = ElementSparkController.instance:getActivityId()
	local actCfg = ElementSparkConfig.instance:getActivityCfgById(activityId)
	local mapSize = actCfg.mapSize
	local mapSizeX = mapSize[1] * ElementSparkElemsMgr.TileBoundX
	local mapSizeY = mapSize[2] * 1.55

	return mapSizeX, mapSizeY
end

function ElementSparkElemsMgr:getElementCo(elementId)
	return self._elementCos[elementId]
end

function ElementSparkElemsMgr:_createLevelElem(chunkCfg)
	if chunkCfg.chunkType == GameEnum.ElementSparkChunkType.Blank then
		return
	end

	local assetPath = "scene/elementspark/scenelevelcell.prefab"

	for i = chunkCfg.pos[1], chunkCfg.anotherPos[1] do
		for j = chunkCfg.pos[2], chunkCfg.anotherPos[2] do
			local x, y = ElementSparkSceneController.instance:getBgTilePos(i, j)
			local elemDataCo = {
				offset = 0,
				layer = 0,
				assetPath = assetPath,
				position = {
					x = x,
					y = y
				},
				boundsX = ElementSparkElemsMgr.TileBoundX,
				boundsY = ElementSparkElemsMgr.TileBoundX,
				id = chunkCfg.chunkId
			}

			self._scene.unitFactory:createLevelElem(elemDataCo)
		end
	end
end

return ElementSparkElemsMgr
