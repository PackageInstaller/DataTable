-- chunkname: @modules/logic/versionactivity3_8/echosong/view/comp/V3a8EchoSongEnemyBaseEntityComp.lua

module("modules.logic.versionactivity3_8.echosong.view.comp.V3a8EchoSongEnemyBaseEntityComp", package.seeall)

local V3a8EchoSongEnemyBaseEntityComp = class("V3a8EchoSongEnemyBaseEntityComp", LuaCompBase)

function V3a8EchoSongEnemyBaseEntityComp:init(go)
	self._go = go
	self._projAnimator = ZProj.ProjAnimatorPlayer.Get(go)

	self:_onInit(go)
end

function V3a8EchoSongEnemyBaseEntityComp:initComp(view, id, params)
	self._view = view
	self._id = id
	self._params = params
	self._tempPos = Vector2()
	self._curPos = Vector2()
	self._recordInfo = {
		type = self:_getUnitType(),
		id = id
	}

	self:_onInitComp()
end

function V3a8EchoSongEnemyBaseEntityComp:_frameUpdate()
	self._cachedWorldX, self._cachedWorldY = transformhelper.getPos(self._go.transform)

	if not self:_canFrameUpdate() then
		return
	end

	self:_checkMainPlayerHurt()
	self:_updateMovement()
end

function V3a8EchoSongEnemyBaseEntityComp:_checkMainPlayerHurt()
	if V3a8EchoSongController.instance:isGameOver() then
		return
	end

	local mainPlayer = self._view:getMainPlayerGo()

	if mainPlayer then
		self._tempPos.x, self._tempPos.y = recthelper.getAnchor(mainPlayer.transform)

		if not self._hurtDistance then
			local hurtDistance = self:_getHurtDistance()
			local dx = self._curPos.x - self._tempPos.x
			local dy = self._curPos.y - self._tempPos.y

			if dx * dx + dy * dy <= self._hurtDistance * self._hurtDistance then
				V3a8EchoSongController.instance:dispatchGameResult(false)
			end
		end
	end
end

function V3a8EchoSongEnemyBaseEntityComp:_setTarget(targetPos)
	if not targetPos then
		return
	end

	self._curPos.x, self._curPos.y = recthelper.getAnchor(self._go.transform)
	self._startPos = self._startPos or Vector2()
	self._startPos.x = self._curPos.x
	self._startPos.y = self._curPos.y
	self._targetPos = targetPos
	self._moveStartTime = Time.time

	local dx = targetPos.x - self._startPos.x
	local dy = targetPos.y - self._startPos.y
	local dist = math.sqrt(dx * dx + dy * dy)

	if not self._speed then
		local speed = self:_getSpeed()

		self._moveDuration = self._speed > 0 and dist / self._speed or 0

		if self._moveDuration <= 0 then
			self._moveDuration = 0.001
		end
	end
end

function V3a8EchoSongEnemyBaseEntityComp:_easing(t)
	return -(math.cos(math.pi * t) - 1) / 2
end

function V3a8EchoSongEnemyBaseEntityComp:_updateMovement()
	if not self._targetPos or not self._moveStartTime then
		return
	end

	local t = (Time.time - self._moveStartTime) / self._moveDuration

	if t >= 1 then
		t = 1
	end

	local easedT = self:_easing(t)

	self._curPos.x = self._startPos.x + (self._targetPos.x - self._startPos.x) * easedT
	self._curPos.y = self._startPos.y + (self._targetPos.y - self._startPos.y) * easedT

	recthelper.setAnchor(self._go.transform, self._curPos.x, self._curPos.y)

	if t >= 1 then
		self._moveStartTime = nil

		self:_moveDone()
	end
end

function V3a8EchoSongEnemyBaseEntityComp:startLogic()
	self:_onStartLogic()
	TaskDispatcher.runRepeat(self._frameUpdate, self, 0)
end

function V3a8EchoSongEnemyBaseEntityComp:addEventListeners()
	self.addEventCb(self, V3a8EchoSongController.instance, V3a8EchoSongEvent.ShowResultView, self._onShowResultView, self)
	self.addEventCb(self, V3a8EchoSongController.instance, V3a8EchoSongEvent.RestartGame, self._onRestartGame, self)
	self.addEventCb(self, V3a8EchoSongController.instance, V3a8EchoSongEvent.PauseGame, self._onPauseGame, self)
	self.addEventCb(self, V3a8EchoSongController.instance, V3a8EchoSongEvent.ResumeGame, self._onResumeGame, self)
end

function V3a8EchoSongEnemyBaseEntityComp:removeEventListeners()
	return
end

function V3a8EchoSongEnemyBaseEntityComp:_onRestartGame()
	TaskDispatcher.cancelTask(self._frameUpdate, self)
	TaskDispatcher.runRepeat(self._frameUpdate, self, 0)
end

function V3a8EchoSongEnemyBaseEntityComp:_onShowResultView()
	TaskDispatcher.cancelTask(self._frameUpdate, self)
end

function V3a8EchoSongEnemyBaseEntityComp:_onPauseGame()
	self._pauseElapsed = self._moveStartTime and Time.time - self._moveStartTime or nil

	TaskDispatcher.cancelTask(self._frameUpdate, self)
end

function V3a8EchoSongEnemyBaseEntityComp:_onResumeGame()
	if self._pauseElapsed and self._moveStartTime then
		self._moveStartTime = Time.time - self._pauseElapsed
	end

	self._pauseElapsed = nil

	TaskDispatcher.cancelTask(self._frameUpdate, self)
	TaskDispatcher.runRepeat(self._frameUpdate, self, 0)
end

function V3a8EchoSongEnemyBaseEntityComp:onDestroy()
	TaskDispatcher.cancelTask(self._frameUpdate, self)
end

function V3a8EchoSongEnemyBaseEntityComp:_onInit(go)
	return
end

function V3a8EchoSongEnemyBaseEntityComp:_onInitComp()
	return
end

function V3a8EchoSongEnemyBaseEntityComp:_getUnitType()
	return 0
end

function V3a8EchoSongEnemyBaseEntityComp:_getSpeed()
	return 200
end

function V3a8EchoSongEnemyBaseEntityComp:_getHurtDistance()
	return 100
end

function V3a8EchoSongEnemyBaseEntityComp:_canFrameUpdate()
	return true
end

function V3a8EchoSongEnemyBaseEntityComp:_moveDone()
	return
end

function V3a8EchoSongEnemyBaseEntityComp:_onStartLogic()
	return
end

return V3a8EchoSongEnemyBaseEntityComp
