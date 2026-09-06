-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/action/UnitActionPathTo.lua

module("logicscene.scene.unit.action.UnitActionPathTo", package.seeall)

local UnitActionPathTo = class("UnitActionPathTo", UnitActionMoveTo)

function UnitActionPathTo:ctor(x, y, fromX, fromY)
	UnitActionPathTo.super.ctor(self)

	self._destX = x
	self._destY = y
	self._fromX = fromX
	self._fromY = fromY
	self._paths = nil
	self._originsPath = nil
	self._pathIdx = nil
	self._pathLen = nil
	self._isDone = nil
	self._isTransmitGroup = nil
	self._onDoNextStepCallBack = nil
	self._onDoNextStepCallBackObj = nil
end

function UnitActionPathTo:start(unit)
	self._pathFinder = unit.scene.pathFinder
	self._scene = unit.scene

	UnitActionPathTo.super.start(self, unit)
	self:_startFindPath()
end

function UnitActionPathTo:getFinalDestPos()
	if self._originsPath then
		local len = #self._originsPath

		if len > 0 then
			return self._originsPath[len - 1], self._originsPath[len]
		end
	end

	if self._paths then
		local len = #self._paths

		return self._paths[len - 1], self._paths[len]
	end
end

function UnitActionPathTo:_startFindPath()
	self._duration = 0

	if not self._fromX or not self._fromY then
		self._fromX, self._fromY = self._transform:getPos()
	else
		self._transform:setPos(self._fromX, self._fromY)
	end

	if self._paths then
		table.clear(self._paths)
	end

	local fromX = self._fromX
	local fromY = self._fromY
	local destX = self._destX
	local destY = self._destY

	self._lastMergeX = nil
	self._lastMergeY = nil
	self._lastDirectX = nil
	self._lastDirectY = nil

	local hasTransM, sx, sy, ex, ey = self._scene:getNearestTransmitGroupPos(fromX, fromY, destX, destY)

	if hasTransM then
		self._fromX = ex
		self._fromY = ey
		self._destX = destX
		self._destY = destY
		destX = sx
		destY = sy
	end

	self._isTransmitGroup = hasTransM
	self._originsPath = self._pathFinder:getPath(self._unit.sceneUnit, fromX, fromY, destX, destY, self._bridgeState)
	self._pathInvalid = not self._originsPath or #self._originsPath == 0

	self:_mergePaths()
	self:_handlePaths()
	self:_setNextDest()
end

function UnitActionPathTo:isInvalid()
	return self._pathInvalid or false
end

function UnitActionPathTo:getRunningPath()
	return self._paths, self._pathIdx
end

function UnitActionPathTo:_setNextDest()
	if self._isDone then
		if self._isTransmitGroup then
			self:_onPathFinished()
		else
			return
		end
	end

	if not self._paths or #self._paths == 0 then
		self:_mergePaths()
		self:_handlePaths()
	end

	if self._paths and #self._paths > 0 then
		self:_setDest(self._paths[self._pathIdx], self._paths[self._pathIdx + 1])

		self._pathIdx = self._pathIdx + 2

		if self._pathIdx >= self._pathLen then
			self._paths = nil
			self._pathIdx = nil
			self._pathLen = nil
		end
	else
		self:_onPathFinished()
	end
end

function UnitActionPathTo:_mergePaths()
	if self._originsPath and #self._originsPath > 0 then
		local scene = SceneMgr.instance:getCurScene()

		if scene:isBreakPathFindingWhileHitAirwall() then
			local checkFromX = self._fromX
			local checkFromY = self._fromY
			local checkTimes = 5

			for i = 1, #self._originsPath, 2 do
				if scene.stage.wholeScene:IsHitAirWall(self._unit.sceneUnit, checkFromX, checkFromY, self._originsPath[i], self._originsPath[i + 1]) then
					self._isDone = true
					self._paths = {}
					self._originsPath = {}

					return
				end

				checkFromX = self._originsPath[i]
				checkFromY = self._originsPath[i + 1]
				checkTimes = checkTimes - 1

				if checkTimes <= 0 then
					break
				end
			end
		end

		if not self._unit.isMainPlayer or not scene:isNeedMergePath() then
			self._paths = self._paths or {}

			table.merge(self._paths, self._originsPath)

			self._originsPath = nil

			return
		end

		if not self._lastMergeX then
			self._lastMergeX = self._fromX
			self._lastMergeY = self._fromY
		end

		local hitAirWal
		local times = 5

		while times > 0 do
			local len = #self._originsPath

			if len == 0 then
				self._originsPath = nil

				break
			end

			if scene.stage.wholeScene:IsHitAirWall(self._unit.sceneUnit, self._lastMergeX, self._lastMergeY, self._originsPath[1], self._originsPath[2]) then
				self:_pushPathNode()

				self._paths = self._paths or {}

				table.insert(self._paths, self._originsPath[1])
				table.insert(self._paths, self._originsPath[2])

				self._lastMergeX = self._originsPath[1]
				self._lastMergeY = self._originsPath[2]
				hitAirWal = true
			else
				times = times - 1
				self._lastDirectX = self._originsPath[1]
				self._lastDirectY = self._originsPath[2]
				hitAirWal = nil
			end

			table.remove(self._originsPath, 1)
			table.remove(self._originsPath, 1)
		end

		self:_pushPathNode()

		self._continueCheck = not hitAirWal and self._originsPath and #self._originsPath > 0 and times <= 0 and true or nil
	end
end

function UnitActionPathTo:_continueMergePaths()
	if self._continueCheck then
		if self._paths then
			if not #self._paths then
				local len = 0

				if len >= 2 then
					local dist = self._transform:dist2D(self._paths[len - 1], self._paths[len])

					if dist > CitySceneCameraEx.orthographicSize then
						return
					end

					self._originsPath = self._originsPath or {}

					table.insert(self._originsPath, 1, self._paths[len])
					table.insert(self._originsPath, 1, self._paths[len - 1])
					table.remove(self._paths, len)
					table.remove(self._paths, len - 1)

					self._pathLen = self._pathLen - 2
					self._lastMergeX, self._lastMergeY = self._transform:getPos()
					self._continueCheck = nil

					self:_mergePaths()

					self._pathLen = #self._paths
				else
					self._continueCheck = nil
				end
			end
		end
	end
end

function UnitActionPathTo:_pushPathNode()
	if self._lastDirectX and self._lastDirectY then
		self._paths = self._paths or {}

		table.insert(self._paths, self._lastDirectX)
		table.insert(self._paths, self._lastDirectY)

		self._lastMergeX = self._lastDirectX
		self._lastMergeY = self._lastDirectY
		self._lastDirectX = nil
		self._lastDirectY = nil
	end
end

function UnitActionPathTo:_handlePaths()
	if self._paths then
		self._pathLen = #self._paths

		if self._pathLen > 0 then
			self._pathIdx = 1
		end
	end
end

function UnitActionPathTo:_onPathFinished()
	if self._isTransmitGroup then
		self._isTransmitGroup = nil

		if self._paths then
			table.clear(self._paths)
		end

		self:_startFindPath()
	else
		self._pathIdx = nil
		self._pathLen = nil
		self._paths = nil
		self._originsPath = nil
		self._lastMergeX = nil
		self._lastMergeY = nil
		self._lastDirectX = nil
		self._lastDirectY = nil
		self._isDone = true
	end
end

function UnitActionPathTo:stop()
	UnitActionPathTo.super.stop(self)

	self._isTransmitGroup = nil
	self._originsPath = nil
	self._lastMergeX = nil
	self._lastMergeY = nil
	self._paths = nil
	self._pathIdx = nil
	self._pathLen = nil
	self._lastDirectX = nil
	self._lastDirectY = nil
	self._posStartX = nil
	self._posStartY = nil
	self._isDone = true
end

function UnitActionPathTo:update(deltaTime)
	if self._isDone then
		return
	end

	UnitActionPathTo.super.update(self, deltaTime)

	if not self._elapsed then
		return
	end

	self:_continueMergePaths()

	if self._elapsed >= self._duration then
		self:_callbackNextStep()
		self:_setNextDest()
	end
end

function UnitActionPathTo:setNextStepCallBack(callback, callbackObj)
	self._onDoNextStepCallBack = callback
	self._onDoNextStepCallBackObj = callbackObj
end

function UnitActionPathTo:_callbackNextStep()
	if self._isDone then
		return
	end

	if self._onDoNextStepCallBack then
		if self._onDoNextStepCallBackObj then
			self._onDoNextStepCallBack(self._onDoNextStepCallBackObj, self)
		else
			self:_onDoNextStepCallBack()
		end
	end
end

function UnitActionPathTo:isDone()
	if self._isDone then
		return true
	end

	if self._paths and #self._paths == 0 then
		return nil
	end

	return (self._duration or 0) <= (self._elapsed or 0)
end

function UnitActionPathTo:reverse()
	if self._fromX and self._fromY then
		return UnitActionPathTo.New(self._fromX, self._fromY, self._destX, self._destY)
	end
end

return UnitActionPathTo
