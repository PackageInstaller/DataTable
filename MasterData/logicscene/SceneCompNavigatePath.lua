-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/season/SceneCompNavigatePath.lua

module("logicscene.scene.component.season.SceneCompNavigatePath", package.seeall)

local SceneCompNavigatePath = class("SceneCompNavigatePath", SceneComponentBase)

SceneCompNavigatePath.navigateResPath = "scene/season/board_saijiwanfa_way_dir.prefab"

function SceneCompNavigatePath:onEnterScene(sceneId, bornX, bornZ)
	SceneCompNavigatePath.super.onEnterScene(self, sceneId, bornX, bornZ)

	self._navigationUnit = nil
	self._wayDirObjects = nil
	self._targetGridId = -1
end

function SceneCompNavigatePath:onEnterSceneFinished(sceneId, bornX, bornZ)
	GlobalDispatcher:addListener(GlobalNotify.SeasonMinimapOpenedOrClosed, self._onSeasonMinimapOpenedOrClosed, self)
end

function SceneCompNavigatePath:onExitScene()
	GlobalDispatcher:removeListener(GlobalNotify.SeasonMinimapOpenedOrClosed, self._onSeasonMinimapOpenedOrClosed, self)

	self._navigationUnit = nil
	self._targetGridId = nil
	self._lastUnitGridRow = nil
	self._lastUnitGridCol = nil
	self._pathStartIdx = nil
	self._ingCameraClipping = nil

	self:_clearWayObjects()
end

function SceneCompNavigatePath:navigateUnit(unit)
	self._navigationUnit = unit
	self._targetGridId = -1
	self._lastUnitGridRow = -1
	self._lastUnitGridCol = -1
	self._pathStartIdx = -1

	self:_checkGeneratePath()
end

function SceneCompNavigatePath:_checkGeneratePath()
	if not self._navigationUnit then
		self:_clearWayObjects()

		self._targetGridId = -1
		self._runningPath = nil

		return
	end

	local targetGridId = SeasonTeamsModel.instance:getTeamAimingId(self._navigationUnit.teamData.teamId)

	if self._targetGridId ~= targetGridId then
		self._targetGridId = targetGridId

		self:_generatePath()

		return
	end

	if self._targetGridId == -1 then
		return
	end

	if not self._runningPath or #self._runningPath == 0 then
		self:_clearWayObjects()
	end

	local row, col = self._navigationUnit.teamData:getClientCurGridXY()

	if self._lastUnitGridRow == row and self._lastUnitGridCol == col then
		self:_navigatePath()

		return
	end

	self._lastUnitGridRow = row
	self._lastUnitGridCol = col

	local idx = self:_getCurPathIndex(row, col)

	if idx == -1 then
		self:_generatePath()

		return
	end

	self._pathStartIdx = idx

	self:_navigatePath()
end

function SceneCompNavigatePath:_getCurPathIndex(row, col)
	local idx = -1

	if self._runningPath then
		for i = 1, #self._runningPath, 2 do
			if self._runningPath[i] == row and self._runningPath[i + 1] == col then
				idx = i + 2

				break
			end
		end
	end

	return idx
end

function SceneCompNavigatePath:_generatePath()
	self._runningPath = nil
	self._lastUnitGridRow = -1
	self._lastUnitGridCol = -1
	self._pathStartIdx = 1

	if self._navigationUnit and self._targetGridId ~= -1 then
		local destRow, destCol = SeasonPathFindingDataModel.instance:id2Grid(self._targetGridId)
		local lastRow, lastCol = 0, 0
		local startX, startY = self._navigationUnit.transform:getPos()

		if self._navigationUnit.teamData then
			lastRow, lastCol = self._navigationUnit.teamData:getClientCurGridXY()
		else
			lastRow, lastCol = SeasonPathFindingDataModel.instance:pos2Grid(startX, startY)
		end

		if lastRow ~= destRow or lastCol ~= destCol then
			self._runningPath = self._scene.transPoints:getPathWithtranspoints(lastRow, lastCol, destRow, destCol)
		end

		self._lastUnitGridRow = lastRow
		self._lastUnitGridCol = lastCol
	end

	self:_navigatePath()
end

function SceneCompNavigatePath:update(deltaTime)
	self:_checkGeneratePath()
end

function SceneCompNavigatePath:_navigatePath()
	if not self._runningPath or #self._runningPath == 0 then
		self:_clearWayObjects()

		return
	end

	self:_buildWayObjects()
end

function SceneCompNavigatePath:_buildWayObjects()
	self._wayDirObjects = self._wayDirObjects or {}

	local runningPath = self._runningPath
	local pathIndex = self._pathStartIdx
	local pointIndex = 1
	local prex, prey = self._navigationUnit.transform:getPos()
	local minX, minY, maxX, maxY = GameUtil.getCameraBoundingBox()
	local lastAngle = 0

	for i = pathIndex, #runningPath, 2 do
		local x = runningPath[i]
		local y = runningPath[i + 1]
		local posX, posY = self._scene:getPosWithOffsetY(x, y)

		if self._ingCameraClipping or minX <= posX and posX <= maxX and minY <= posY and posY <= maxY then
			local wayObj = self._wayDirObjects[pointIndex]

			if not wayObj then
				wayObj = self._scene.resCache:newObject(SceneCompNavigatePath.navigateResPath)

				table.insert(self._wayDirObjects, wayObj)
			end

			wayObj:setActive(true)
			wayObj:setPos(posX, posY)
			wayObj:setSortingOrder(1)

			pointIndex = pointIndex + 1

			local dirPosY = posY

			if runningPath[i + 2] and runningPath[i + 3] then
				local var_10_0, var_10_1 = self._scene:getPosWithOffsetY(runningPath[i + 2], runningPath[i + 3])

				dirPosY = var_10_1

				local dirX = var_10_0 - posX
				local dirY = dirPosY - posY
				local angle = GoUtil.SignedAngleWithX(dirX, dirY)

				wayObj:setRotation(0, 0, -angle)

				lastAngle = angle
			else
				wayObj:setRotation(0, 0, -lastAngle)
			end
		end

		prex = posX
		prey = posY
	end

	for i = pointIndex, #self._wayDirObjects do
		local wayObj = self._wayDirObjects[i]

		wayObj:setActive(false)
	end
end

function SceneCompNavigatePath:_clearWayObjects()
	if self._wayDirObjects then
		for i = 1, #self._wayDirObjects do
			self._scene.resCache:recycleObject(self._wayDirObjects[i])
		end

		self._wayDirObjects = nil
	end
end

function SceneCompNavigatePath:_onSeasonMinimapOpenedOrClosed(opened)
	self._ingCameraClipping = opened

	if self._runningPath then
		self:_buildWayObjects()
	end
end

return SceneCompNavigatePath
