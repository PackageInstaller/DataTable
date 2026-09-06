-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/action/UnitActionPatrolInRect.lua

module("logicscene.scene.unit.action.UnitActionPatrolInRect", package.seeall)

local UnitActionPatrolInRect = class("UnitActionPatrolInRect", UnitActionPathTo)

function UnitActionPatrolInRect:ctor(rect, stayTime)
	self._rect = rect

	local scene = SceneMgr.instance:getCurScene()

	self._wholeScene = scene.stage.wholeScene

	local x, y = self._wholeScene:GetWalkablePosInRectangle(nil, rect.x, rect.y, rect.width, rect.height, nil, nil)

	UnitActionPatrolInRect.super.ctor(self, x, y)

	self._stayTime = stayTime or math.random(3, 7)
	self._stayTimeCount = 0
	self._isPlayingIdle = nil
end

function UnitActionPatrolInRect:update(deltaTime)
	UnitActionPatrolInRect.super.update(self, deltaTime)

	if UnitActionPatrolInRect.super.isDone(self) then
		self._stayTimeCount = self._stayTimeCount + deltaTime

		if self._stayTimeCount >= self._stayTime then
			self._stayTimeCount = 0
			self._isDone = nil
			self._fromX = nil
			self._fromY = nil

			local x, y = self._wholeScene:GetWalkablePosInRectangle(nil, self._rect.x, self._rect.y, self._rect.width, self._rect.height, nil, nil)

			self._destX = x
			self._destY = y
			self._isPlayingIdle = nil

			self:_startFindPath()
		elseif not self._isPlayingIdle then
			self._isPlayingIdle = true

			self._spineMover:playIdleAnim()
		end
	else
		self._stayTimeCount = 0
	end
end

function UnitActionPatrolInRect:isDone()
	return false
end

return UnitActionPatrolInRect
