-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/action/UnitActionPatrolInZone.lua

module("logicscene.scene.unit.action.UnitActionPatrolInZone", package.seeall)

local UnitActionPatrolInZone = class("UnitActionPatrolInZone", UnitActionPathTo)

function UnitActionPatrolInZone:ctor(zoneId, stayTime)
	local scene = SceneMgr.instance:getCurScene()

	self._wholeScene = scene.stage.wholeScene
	self._zoneId = zoneId

	local x, y = self._wholeScene:GetRandomWalkablePosInZone(nil, self._zoneId, nil, nil)

	UnitActionPatrolInZone.super.ctor(self, x, y)

	self._stayTime = stayTime or math.random(3, 7)
	self._stayTimeCount = 0
	self._isPlayingIdle = nil
end

function UnitActionPatrolInZone:stop()
	UnitActionPatrolInZone.super.stop(self)
end

function UnitActionPatrolInZone:update(deltaTime)
	UnitActionPatrolInZone.super.update(self, deltaTime)

	if UnitActionPatrolInZone.super.isDone(self) then
		self._stayTimeCount = self._stayTimeCount + deltaTime

		if self._stayTimeCount >= self._stayTime then
			self._stayTimeCount = 0
			self._isDone = nil
			self._fromX = nil
			self._fromY = nil

			local x, y = self._wholeScene:GetRandomWalkablePosInZone(self._unit.sceneUnit, self._zoneId, nil, nil)

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

function UnitActionPatrolInZone:isDone()
	return false
end

return UnitActionPatrolInZone
