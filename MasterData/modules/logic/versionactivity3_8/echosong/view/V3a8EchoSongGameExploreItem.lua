-- chunkname: @modules/logic/versionactivity3_8/echosong/view/V3a8EchoSongGameExploreItem.lua

module("modules.logic.versionactivity3_8.echosong.view.V3a8EchoSongGameExploreItem", package.seeall)

local V3a8EchoSongGameExploreItem = class("V3a8EchoSongGameExploreItem", LuaCompBase)

function V3a8EchoSongGameExploreItem:init(go)
	self.viewGO = go

	self:_editableInitView()
end

function V3a8EchoSongGameExploreItem:_editableInitView()
	self._pos = self._pos or Vector3.zero
	self._moveSpeed = V3a8EchoSongEnum.ExploreConst.MoveSpeed
	self._lifeTime = V3a8EchoSongEnum.ParticleLifeTime.Explore
	self._startTime = 0
	self._moveDir = self._moveDir or Vector2.New(0, 0)
end

function V3a8EchoSongGameExploreItem:addEventListeners()
	V3a8EchoSongController.instance:registerCallback(V3a8EchoSongEvent.PauseGame, self._onPauseGame, self)
	V3a8EchoSongController.instance:registerCallback(V3a8EchoSongEvent.ResumeGame, self._onResumeGame, self)
end

function V3a8EchoSongGameExploreItem:removeEventListeners()
	V3a8EchoSongController.instance:unregisterCallback(V3a8EchoSongEvent.PauseGame, self._onPauseGame, self)
	V3a8EchoSongController.instance:unregisterCallback(V3a8EchoSongEvent.ResumeGame, self._onResumeGame, self)
end

function V3a8EchoSongGameExploreItem:_onPauseGame()
	self._pauseTime = Time.time
end

function V3a8EchoSongGameExploreItem:_onResumeGame()
	if self._pauseTime then
		local pauseDuration = Time.time - self._pauseTime

		if pauseDuration > 0 then
			self._startTime = self._startTime + pauseDuration
		end

		self._pauseTime = nil
	end
end

function V3a8EchoSongGameExploreItem:getPos()
	return self._pos
end

function V3a8EchoSongGameExploreItem:update(deltaTime)
	if Time.time - self._startTime > self._lifeTime then
		return
	end

	if not self._moveDir or not self.viewGO then
		return
	end

	local frameSpeed = self._moveSpeed * deltaTime
	local moveDisX = self._moveDir.x * frameSpeed
	local moveDisY = self._moveDir.y * frameSpeed
	local moveSqr = moveDisX * moveDisX + moveDisY * moveDisY
	local hit = UnityEngine.Physics2D.Raycast(self._pos, self._moveDir, V3a8EchoSongEnum.ExploreConst.RaycastDist, V3a8EchoSongEnum.ColliderLayer)

	if hit and hit.collider ~= nil then
		local hitPoint = hit.point
		local dx = hitPoint.x - self._pos.x
		local dy = hitPoint.y - self._pos.y

		if moveSqr > dx * dx + dy * dy then
			V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.EmittedParticle, self._pos, V3a8EchoSongEnum.ParticleType.Explore)

			self._isHit = true

			return
		end
	end

	self._pos.x = self._pos.x + moveDisX
	self._pos.y = self._pos.y + moveDisY

	transformhelper.setPosXY(self.viewGO.transform, self._pos.x, self._pos.y)
end

function V3a8EchoSongGameExploreItem:onUpdateMO(angle)
	self._pos.x, self._pos.y = transformhelper.getPos(self.viewGO.transform)
	self._moveDir.x = Mathf.Cos(angle)
	self._moveDir.y = Mathf.Sin(angle)

	self._moveDir:SetNormalize()

	self._startTime = Time.time
	self._isHit = false

	gohelper.setActive(self.viewGO, true)
	AudioMgr.instance:trigger(V3a8EchoSongEnum.Audio.play_ui_shiji3_8_hsy_fashe)
end

function V3a8EchoSongGameExploreItem:isDead()
	if self._isHit then
		return true
	end

	return self._startTime and self._startTime + self._lifeTime < Time.time
end

function V3a8EchoSongGameExploreItem:reset()
	self._isHit = true

	transformhelper.setPosXY(self.viewGO.transform, 10000, 10000)
end

return V3a8EchoSongGameExploreItem
