-- chunkname: @modules/logic/scene/pushbox/logic/PushBoxElementFan.lua

module("modules.logic.scene.pushbox.logic.PushBoxElementFan", package.seeall)

local PushBoxElementFan = class("PushBoxElementFan", UserDataDispose)

function PushBoxElementFan:ctor(gameObject, cell)
	self:__onInit()

	self._game_mgr = GameSceneMgr.instance:getCurScene().gameMgr
	self._gameObject = gameObject
	self._transform = gameObject.transform
	self._cell = cell
	self._ani = gohelper.findChildComponent(gameObject, "fengshan", typeof(UnityEngine.Animator))

	self.addEventCb(self, PushBoxController.instance, PushBoxEvent.RefreshElement, self._onRefreshElement, self)
	self.addEventCb(self, PushBoxController.instance, PushBoxEvent.StepFinished, self._onStepFinished, self)
	self.addEventCb(self, PushBoxController.instance, PushBoxEvent.RevertStep, self._onRevertStep, self)
	self.addEventCb(self, PushBoxController.instance, PushBoxEvent.StartElement, self._onStartElement, self)
	self.addEventCb(self, PushBoxController.instance, PushBoxEvent.RefreshFanElement, self._onRefreshElement, self)
end

function PushBoxElementFan:setRendererIndex()
	local final_renderer_index = self._cell:getRendererIndex()
	local meshRenderer = self._transform:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))

	for i = 0, meshRenderer.Length - 1 do
		meshRenderer[i].sortingOrder = final_renderer_index
	end

	self._smoke = gohelper.findChild(self._gameObject, "vx_smoke")

	local particle = self._smoke.transform:GetComponentsInChildren(typeof(UnityEngine.ParticleSystem))

	for i = 0, particle.Length - 1 do
		ZProj.ParticleSystemHelper.SetSortingOrder(particle[i], 30000)
	end

	gohelper.setActive(self._smoke, false)
end

function PushBoxElementFan:_onStartElement()
	local episode_config = self._game_mgr:getConfig()

	self._duration_time = episode_config.fan_duration
	self._active = false
end

function PushBoxElementFan:_onRevertStep(step_data)
	if step_data.fan_time then
		for i, v in ipairs(step_data.fan_time) do
			if v.pos_x == self._cell:getPosX() and v.pos_y == self._cell:getPosY() then
				self._active = v.active

				self:_releaseTimer()

				if v.left_time and v.left_time > 0 then
					self._timer = true
					self._start_time = Time.realtimeSinceStartup - (self._duration_time - v.left_time)

					TaskDispatcher.runDelay(self._onEffectDone, self, v.left_time)

					if self._active then
						gohelper.setActive(self._smoke, true)
						self._ani:Play("click")
					end
				end

				if not self._active then
					self:_onEffectDone()
				end

				self._game_mgr:setCellInvincible(self._active, self._cell:getPosX(), self._cell:getPosY())
			end
		end
	end
end

function PushBoxElementFan:_onRefreshElement()
	if self:_characterInArea() then
		if not self._active then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_exhaust)
		end

		TaskDispatcher.cancelTask(self._onEffectDone, self)

		self._active = true

		gohelper.setActive(self._smoke, true)
		self._ani:Play("click")

		self._timer = nil

		self._game_mgr:setCellInvincible(true, self._cell:getPosX(), self._cell:getPosY())
	elseif self._active and not self._timer then
		self._start_time = Time.realtimeSinceStartup
		self._timer = true

		TaskDispatcher.runDelay(self._onEffectDone, self, self._duration_time)
	end
end

function PushBoxElementFan:_onStepFinished()
	return
end

function PushBoxElementFan:getState()
	return self._active
end

function PushBoxElementFan:_onEffectDone()
	self._start_time = nil
	self._active = false

	gohelper.setActive(self._smoke, false)
	self._ani:Play("loop")
	self._game_mgr:setCellInvincible(false, self._cell:getPosX(), self._cell:getPosY())
end

function PushBoxElementFan:_characterInArea()
	return self._game_mgr:characterInArea(self._cell:getPosX(), self._cell:getPosY())
end

function PushBoxElementFan:getIndex()
	return self._index
end

function PushBoxElementFan:getPosX()
	return self._cell:getPosX()
end

function PushBoxElementFan:getPosY()
	return self._cell:getPosY()
end

function PushBoxElementFan:getObj()
	return self._gameObject
end

function PushBoxElementFan:getCell()
	return self._cell
end

function PushBoxElementFan:_releaseTimer()
	self._start_time = nil

	TaskDispatcher.cancelTask(self._onEffectDone, self)

	self._timer = nil
end

function PushBoxElementFan:releaseSelf()
	self:_releaseTimer()
	self:__onDispose()
end

return PushBoxElementFan
