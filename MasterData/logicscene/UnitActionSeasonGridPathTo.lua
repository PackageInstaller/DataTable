-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/season/action/UnitActionSeasonGridPathTo.lua

module("logicscene.scene.unit.impl.season.action.UnitActionSeasonGridPathTo", package.seeall)

local UnitActionSeasonGridPathTo = class("UnitActionSeasonGridPathTo", UnitActionPathTo)

function UnitActionSeasonGridPathTo:ctor(x, y, fromX, fromY)
	UnitActionSeasonGridPathTo.super.ctor(self, x, y, fromX, fromY)

	self._gridPaths = nil
end

function UnitActionSeasonGridPathTo:_onPathFinished()
	self._gridPaths = nil

	UnitActionSeasonGridPathTo.super._onPathFinished(self)
end

function UnitActionSeasonGridPathTo:stop()
	UnitActionSeasonGridPathTo.super.stop(self)

	self._gridPaths = nil
end

function UnitActionSeasonGridPathTo:getGridPathsAndIdx()
	return self._gridPaths, self._pathIdx
end

function UnitActionSeasonGridPathTo:_startFindPath()
	self._duration = 0

	if not self._fromX or not self._fromY then
		if enableDebug then
			error(">>>>>>赛季玩法必须传入 fromX fromY")
		end

		return
	else
		local posX, posY = self._scene:getPosWithOffsetY(self._fromX, self._fromY)

		self._transform:setPos(posX, posY)
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
	self._originsPath, self._gridPaths = self._pathFinder:getPath(self._unit.sceneUnit, fromX, fromY, destX, destY, self._bridgeState)
	self._pathInvalid = not self._originsPath or #self._originsPath == 0

	self:_mergePaths()
	self:_handlePaths()
	self:_setNextDest()
end

function UnitActionSeasonGridPathTo:isDone()
	if self._isDone then
		return true
	end

	if self._paths and #self._paths == 0 then
		return true
	end

	local var_6_1

	if self._pathIdx == nil then
		if (self._duration or 0) > (self._elapsed or 0) then
			var_6_1 = false

			goto label_6_0
		end
	end

	::label_6_0::

	return true
end

return UnitActionSeasonGridPathTo
