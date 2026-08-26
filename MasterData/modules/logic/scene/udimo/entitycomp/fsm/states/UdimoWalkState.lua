-- chunkname: @modules/logic/scene/udimo/entitycomp/fsm/states/UdimoWalkState.lua

module("modules.logic.scene.udimo.entitycomp.fsm.states.UdimoWalkState", package.seeall)

local UdimoWalkState = class("UdimoWalkState", UdimoBaseState)

function UdimoWalkState:onFSMStart()
	self:_killTween()
	self:_clearData()
end

function UdimoWalkState:_clearData()
	self._nextPlayEmojiTime = nil
	self._startX = nil
	self._startY = nil
	self._startDir = nil
	self._minLeftX = nil
	self._maxRightX = nil
	self._idleY = nil
	self._walkTargetAreaY = nil
	self._toWalkAreaYNeedTime = nil
	self._totalWalkTime = nil
	self._firstWalkTime = nil
	self._lastWalkTime = nil
end

function UdimoWalkState:onEnter(param)
	self._entity = self.fsm and self.fsm:getEntity()

	if self._entity then
		local udimoId = self._entity:getId()

		UdimoController.instance:playUdimoAnimation(udimoId, UdimoEnum.SpineAnim.Walk, true, true)
	end

	self._entity:refreshOrderLayer()

	self._moveSpeed = UdimoConfig.instance:getUdimoConst(UdimoEnum.ConstId.MoveSpeed, false, nil, true)

	self:beginWalk(param)
end

function UdimoWalkState:beginWalk(param)
	self:_killTween()

	if not self._entity then
		return
	end

	local udimoId = self._entity:getId()

	if param then
		if not param.startPos then
			local startPos = self._entity:getPosition()

			self._startX = startPos.x
			self._startY = startPos.y
			self._idleY = param and param.fromPickUpState and self._entity:getIdleY() or self._startY

			local curDir = self._entity:getSpineLookDir()

			if curDir == SpineLookDir.Left then
				self._startDir = UdimoEnum.MoveDir.Left or UdimoEnum.MoveDir.Right
			end

			self._minLeftX, self._maxRightX = UdimoHelper.getUdimoXRange(udimoId)

			local timeArr = UdimoConfig.instance:getUdimoConst(UdimoEnum.ConstId.WalkDurationTime, false, "#", true)
			local randomWalkTime = math.random(timeArr[1], timeArr[2])
			local transTimeArr = UdimoConfig.instance:getUdimoConst(UdimoEnum.ConstId.WalkYTranslationTime, false, "#", true)

			self._firstWalkTime = math.random(transTimeArr[1] * TimeUtil.OneSecondMilliSecond, transTimeArr[2] * TimeUtil.OneSecondMilliSecond) / TimeUtil.OneSecondMilliSecond
			self._lastWalkTime = math.random(transTimeArr[1] * TimeUtil.OneSecondMilliSecond, transTimeArr[2] * TimeUtil.OneSecondMilliSecond) / TimeUtil.OneSecondMilliSecond
			self._walkTargetAreaY, self._toWalkAreaYNeedTime = self._entity:getWalkY()
			self._totalWalkTime = self._firstWalkTime + randomWalkTime + (self._toWalkAreaYNeedTime or 0) + self._lastWalkTime
			self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, self._totalWalkTime, self._totalWalkTime, self._onWalkFrame, self._onWalkFinish, self, nil, EaseType.Linear)
		end
	end
end

function UdimoWalkState:_onWalkFrame(passTime)
	if not self._entity or not passTime then
		self:_killTween()

		return
	end

	local newPosX, moveDir = UdimoHelper.getUidmoCurMoveX(self._startX, self._startDir, self._moveSpeed, self._minLeftX, self._maxRightX, passTime)
	local isLeft = moveDir == UdimoEnum.MoveDir.Left

	self._entity:setSpineLookDir((isLeft or nil) and (SpineLookDir.Left or SpineLookDir.Right))

	local newPosY

	if self._walkTargetAreaY and self._toWalkAreaYNeedTime then
		local passTimeFromFirstWalk = passTime - self._firstWalkTime
		local remainTimeExcludeLastWalk = self._totalWalkTime - passTime - self._lastWalkTime

		if passTimeFromFirstWalk > 0 and passTimeFromFirstWalk <= self._toWalkAreaYNeedTime then
			newPosY = self._startY + (self._walkTargetAreaY - self._startY) * passTimeFromFirstWalk / self._toWalkAreaYNeedTime
		elseif remainTimeExcludeLastWalk > 0 and remainTimeExcludeLastWalk <= self._toWalkAreaYNeedTime then
			newPosY = self._idleY + (self._walkTargetAreaY - self._idleY) * remainTimeExcludeLastWalk / self._toWalkAreaYNeedTime
		end
	end

	self._entity:setPosition(newPosX, newPosY)
end

function UdimoWalkState:_onWalkFinish()
	self:_killTween()

	if self._entity then
		self._entity:checkAndAdjustPos()
	end

	self.fsm:triggerEvent(UdimoEvent.UdimoWalkFinish)
end

function UdimoWalkState:onUpdate()
	if self._isClear then
		return
	end

	local nextPlayEmojiTime = self:_getNextPlayEmojiTime()

	if nextPlayEmojiTime and nextPlayEmojiTime <= Time.realtimeSinceStartup then
		self:_playWalkEmoji()
	end
end

function UdimoWalkState:_getNextPlayEmojiTime()
	if not self._nextPlayEmojiTime then
		local timeArr = UdimoConfig.instance:getUdimoConst(UdimoEnum.ConstId.EmojiIntervalTime, false, "#", true)
		local randomTime = math.random(timeArr[1], timeArr[2])

		self._nextPlayEmojiTime = Time.realtimeSinceStartup + randomTime
	end

	return self._nextPlayEmojiTime
end

function UdimoWalkState:_playWalkEmoji()
	self._nextPlayEmojiTime = nil

	if not self._entity then
		return
	end

	local udimoId = self._entity:getId()
	local emojiId = UdimoConfig.instance:getStateEmoji(udimoId, self.name)

	self._entity:playEmoji(emojiId)
	self:_getNextPlayEmojiTime()
end

function UdimoWalkState:_killTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	self._tweenId = nil
end

function UdimoWalkState:onExit()
	self:_killTween()
	self:_clearData()
end

function UdimoWalkState:onFSMStop()
	self:_killTween()
	self:_clearData()
end

function UdimoWalkState:onClear()
	self:_killTween()
	self:_clearData()
end

return UdimoWalkState
