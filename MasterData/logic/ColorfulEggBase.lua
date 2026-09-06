-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/colorfuleggs/model/eggs/ColorfulEggBase.lua

module("logic.extensions.colorfuleggs.model.eggs.ColorfulEggBase", package.seeall)

local ColorfulEggBase = class("ColorfulEggBase")

function ColorfulEggBase:ctor(eggCo)
	self.eggCo = eggCo
	self._state = ColorfulEggsConst.States.UnTriggered
	self._triggedTimeLimit = 0
	self._selectNpcTimes = 0
	self._selectElemTimes = 0
	self.unitNpc = nil
	self._animPlayer = nil
	self._npcEffect = nil
end

function ColorfulEggBase:shouldTriggered()
	if self._triggedTimeLimit > 0 then
		return false
	end

	if self:isAllTimesFinished() then
		return false
	end

	return ColorfulEggsConst.shouldTriggered(self.eggCo)
end

function ColorfulEggBase:setState(state)
	self._state = state
end

function ColorfulEggBase:getState()
	return self._state
end

function ColorfulEggBase:getEggId()
	return self.eggCo.id
end

function ColorfulEggBase:getAnimationTargetNpc()
	if self.eggCo.npcId and #self.eggCo.npcId > 0 then
		return self.eggCo.npcId[1] or 0
	end

	return 0
end

function ColorfulEggBase:onSelectNpc()
	if self:getState() == ColorfulEggsConst.States.Triggered then
		self._selectNpcTimes = self._selectNpcTimes + 1

		if self._selectNpcTimes >= self:getSelectNpcTimes() then
			ColorfulEggsController.instance:startEgg(self)
		end
	end
end

function ColorfulEggBase:getSelectNpcTimes()
	if self.eggCo.npcId and #self.eggCo.npcId > 0 then
		return self.eggCo.npcId[2] or 0
	end

	return 0
end

function ColorfulEggBase:onSelectElement()
	if self:getState() == ColorfulEggsConst.States.Triggered then
		self._selectElemTimes = self._selectElemTimes + 1

		if self._selectElemTimes >= self:getSelectElemTimes() then
			ColorfulEggsController.instance:startEgg(self)
		end
	end
end

function ColorfulEggBase:getSelectElemTimes()
	if self.eggCo.element and #self.eggCo.element > 0 then
		return self.eggCo.element[3] or 0
	end

	return 0
end

function ColorfulEggBase:onEnterTrigger()
	if self:getState() == ColorfulEggsConst.States.Triggered then
		self._stayTriggerTimeCount = 0
		self._isInTrigger = true

		local stayTime = self:getStayTriggerTime()

		if stayTime == 0 then
			ColorfulEggsController.instance:startEgg(self)
		end
	end
end

function ColorfulEggBase:getStayTriggerTime()
	if self.eggCo.trigger and #self.eggCo.trigger > 0 then
		return self.eggCo.trigger[3] or 0
	end

	return 0
end

function ColorfulEggBase:onLeaveTrigger()
	self._stayTriggerTimeCount = 0
	self._isInTrigger = false
end

function ColorfulEggBase:triggerColorfulEgg()
	self._state = ColorfulEggsConst.States.Triggered
	self._selectNpcTimes = 0
	self._selectElemTimes = 0
	self._stayTriggerTimeCount = 0
	self._isInTrigger = false
end

function ColorfulEggBase:startColorfulEgg()
	self._state = ColorfulEggsConst.States.Running

	if self.eggCo.storyId > 0 then
		GlobalDispatcher:dispatch(GlobalNotify.PushStory, self.eggCo.storyId)
	elseif not string.nilorempty(self.eggCo.scene_animation) then
		self._animPlayer = ColorfulEggsController.instance:playAnimation(self)
	elseif not string.nilorempty(self.eggCo.endEffect) then
		self._npcEffect = ColorfulEggsController.instance:playNpcEndEffect(self)
	else
		ColorfulEggsController.instance:finishEgg(self)
	end
end

function ColorfulEggBase:finishColorfulEgg()
	self:stopAnimation()

	self._state = ColorfulEggsConst.States.Finished

	local curFinishedTimes = self:getCurrFinishTimes()

	self:setCurrFinishTimes(curFinishedTimes + 1)

	self._triggedTimeLimit = self.eggCo.cd
end

function ColorfulEggBase:stopAnimation()
	if self._animPlayer then
		self._animPlayer:Stop()

		self._animPlayer = nil
	end

	if self._npcEffect then
		GameEffectManager.instance:stopEffect(self._npcEffect)

		self._npcEffect = nil
	end

	ColorfulEggsController.instance:clearAnimation()
end

function ColorfulEggBase:getCurrFinishTimes()
	if not self._curFinishedTimes and LoginModel.instance.userId then
		local key = string.format("%s_caidan_ft_%s", LoginModel.instance.userId, self.eggCo.id)

		if #self.eggCo.t_hours_start > 0 then
			key = key .. ServerTime.formatNow("%Y/%m/%d")
		end

		self._curFinishedTimes = UnityEngine.PlayerPrefs.GetInt(key)
	end

	return self._curFinishedTimes or 0
end

function ColorfulEggBase:setCurrFinishTimes(times)
	self._curFinishedTimes = times

	if LoginModel.instance.userId then
		local key = string.format("%s_caidan_ft_%s", LoginModel.instance.userId, self.eggCo.id)

		if #self.eggCo.t_hours_start > 0 then
			key = key .. ServerTime.formatNow("%Y/%m/%d")
		end

		UnityEngine.PlayerPrefs.SetInt(key, self._curFinishedTimes)
		UnityEngine.PlayerPrefs.Save()
	end
end

function ColorfulEggBase:isAllTimesFinished()
	if self.eggCo.finishTimes < 0 then
		return false
	end

	if self.eggCo.finishTimes == 0 then
		return self:getCurrFinishTimes() >= 1
	end

	return self:getCurrFinishTimes() >= self.eggCo.finishTimes
end

function ColorfulEggBase:closeColorfulEgg()
	self._state = ColorfulEggsConst.States.UnTriggered

	self:stopAnimation()
end

function ColorfulEggBase:update(deltaTime)
	if self._state == ColorfulEggsConst.States.Triggered then
		if self.eggCo.t_timeStart and self.eggCo.t_timeEnd then
			if not GameUtil.checkIsInTimePeriod(self.eggCo.t_timeStart, self.eggCo.t_timeEnd) or not ((#self.eggCo.t_hours_start > 0 and #self.eggCo.t_hours_end > 0 or nil) and GameUtil.checkIsInTimePeriod(self.eggCo.t_hours_start, self.eggCo.t_hours_end, true)) then
				ColorfulEggsController.instance:closeEgg(self)

				return
			end
		end

		if self._isInTrigger and self.eggCo.trigger and #self.eggCo.trigger > 0 then
			self._stayTriggerTimeCount = self._stayTriggerTimeCount + deltaTime

			local stayTime = self:getStayTriggerTime()

			if stayTime <= self._stayTriggerTimeCount then
				ColorfulEggsController.instance:startEgg(self)
			end
		end
	elseif self._state == ColorfulEggsConst.States.UnTriggered and self._triggedTimeLimit > 0 then
		self._triggedTimeLimit = self._triggedTimeLimit - deltaTime
	end
end

function ColorfulEggBase:_onAnimPlayFinish()
	local isNext = false

	if self._animPlayer then
		self._animPlayer = nil

		if self.tempTargetGo then
			goutil.destroy(self.tempTargetGo)

			self.tempTargetGo = nil
		end

		if self.animPlayGo then
			goutil.destroy(self.animPlayGo)

			self.animPlayGo = nil
		end

		isNext = true
	end

	if self._npcEffect then
		self._npcEffect = nil
		isNext = true
	end

	if isNext then
		ColorfulEggsController.instance:clearAnimation()
		ColorfulEggsController.instance:finishEgg(self)
	end
end

return ColorfulEggBase
