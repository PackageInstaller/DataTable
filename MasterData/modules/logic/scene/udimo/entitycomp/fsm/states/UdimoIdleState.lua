-- chunkname: @modules/logic/scene/udimo/entitycomp/fsm/states/UdimoIdleState.lua

module("modules.logic.scene.udimo.entitycomp.fsm.states.UdimoIdleState", package.seeall)

local UdimoIdleState = class("UdimoIdleState", UdimoBaseState)

function UdimoIdleState:onFSMStart()
	self:_clearData()
end

function UdimoIdleState:_clearData()
	self._enterTime = nil
	self._idleWaitTime = nil
	self._nextPlayEmojiTime = nil
	self.param = nil
end

function UdimoIdleState:onEnter(param)
	if self.fsm then
		local entity = self.fsm:getEntity()

		if entity then
			local udimoId = entity:getId()

			UdimoController.instance:playUdimoAnimation(udimoId, UdimoEnum.SpineAnim.Idle, true, true)
		end

		self._enterTime = Time.realtimeSinceStartup

		self:_getWaitTime()

		if param and param.landDecoration then
			local isUseDecoration = UdimoItemModel.instance:isUseDecoration(param.landDecoration)

			if not isUseDecoration then
				self:updateParam({
					forceFly = true
				})
			end
		end
	end
end

function UdimoIdleState:_getWaitTime()
	if not self._idleWaitTime then
		local timeArr = UdimoConfig.instance:getUdimoConst(UdimoEnum.ConstId.IdleWaitTime, false, "#", true)

		self._idleWaitTime = math.random(timeArr[1], timeArr[2])
	end

	return self._idleWaitTime
end

function UdimoIdleState:onUpdate()
	if not self._enterTime or not self.fsm then
		return
	end

	local waitTime = self:_getWaitTime()

	if waitTime <= Time.realtimeSinceStartup - self._enterTime or self.param and self.param.forceFly then
		local param = {}
		local entity = self.fsm:getEntity()

		if entity then
			local udimoId = entity:getId()
			local udimoType = UdimoConfig.instance:getUdimoType(udimoId)
			local startPos = entity:getPosition()

			param.startPos = startPos

			local walkDir

			if udimoType == UdimoEnum.UdimoType.Air then
				local startX = startPos.x
				local riseTargetX = UdimoHelper.getAirUdimoTargetX(udimoId, startX)

				param.riseTargetX = riseTargetX
				param.riseTargetY = UdimoHelper.getUdimoYLevel(udimoId)
				walkDir = startX < riseTargetX and SpineLookDir.Right or SpineLookDir.Left
			else
				walkDir = math.random(0, 1) == 0 and SpineLookDir.Left or SpineLookDir.Right
			end

			if walkDir then
				entity:setSpineLookDir(walkDir)
			end
		end

		self.fsm:triggerEvent(UdimoEvent.UdimoBeginWalk, param)
	end

	local nextPlayEmojiTime = self:_getNextPlayEmojiTime()

	if nextPlayEmojiTime <= Time.realtimeSinceStartup then
		self:_playIdleEmoji()
	end
end

function UdimoIdleState:_getNextPlayEmojiTime()
	if not self._nextPlayEmojiTime then
		local timeArr = UdimoConfig.instance:getUdimoConst(UdimoEnum.ConstId.EmojiIntervalTime, false, "#", true)
		local randomTime = math.random(timeArr[1], timeArr[2])

		self._nextPlayEmojiTime = Time.realtimeSinceStartup + randomTime
	end

	return self._nextPlayEmojiTime
end

function UdimoIdleState:_playIdleEmoji()
	self._nextPlayEmojiTime = nil

	if self.fsm then
		local udimoEntity = self.fsm:getEntity()

		if not udimoEntity then
			return
		end

		local udimoId = udimoEntity:getId()
		local emojiId = UdimoConfig.instance:getStateEmoji(udimoId, self.name)

		udimoEntity:playEmoji(emojiId)
		self:_getNextPlayEmojiTime()
	end
end

function UdimoIdleState:onExit()
	local scene = UdimoController.instance:getUdimoScene()

	if self.fsm then
		local udimoEntity = self.fsm:getEntity()

		if scene and udimoEntity then
			local udimoId = udimoEntity:getId()

			scene.stayPoint:recycleAirPoint(udimoId)
		end

		self:_clearData()
	end
end

function UdimoIdleState:onFSMStop()
	self:_clearData()
end

function UdimoIdleState:onClear()
	self:_clearData()
end

return UdimoIdleState
