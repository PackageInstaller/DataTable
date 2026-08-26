-- chunkname: @modules/logic/scene/udimo/entitycomp/fsm/states/UdimoFlyWalkState.lua

module("modules.logic.scene.udimo.entitycomp.fsm.states.UdimoFlyWalkState", package.seeall)

local UdimoFlyWalkState = class("UdimoFlyWalkState", UdimoWalkState)

function UdimoFlyWalkState:_clearData()
	self._entity = nil
	self._moveSpeed = nil
	self._riseStartPos = nil
	self._riseTargetX = nil
	self._riseTargetY = nil
	self._startFlyDir = nil
	self._flyMinLeftX = nil
	self._flyMaxRightX = nil
	self._landStartPos = nil
	self._landTargetPos = nil

	UdimoFlyWalkState.super._clearData(self)
end

function UdimoFlyWalkState:onEnter(param)
	self._entity = self.fsm and self.fsm:getEntity()

	if self._entity then
		self._entity:refreshOrderLayer()

		local udimoId = self._entity:getId()

		UdimoController.instance:playUdimoAnimation(udimoId, UdimoEnum.SpineAnim.Walk, true, true)
	end

	self._moveSpeed = UdimoConfig.instance:getUdimoConst(UdimoEnum.ConstId.MoveSpeed, false, nil, true)

	self:beginRise()
end

function UdimoFlyWalkState:beginRise(param)
	self:_killTween()

	if not self._entity then
		return
	end

	local udimoId = self._entity:getId()

	if param then
		self._riseStartPos = param.startPos or self._entity:getPosition()
	end

	local riseStartX = self._riseStartPos.x

	if param and param.riseTargetX and param.riseTargetY then
		self._riseTargetX = param.riseTargetX
		self._riseTargetY = param.riseTargetY
	else
		self._riseTargetX = UdimoHelper.getAirUdimoTargetX(udimoId, riseStartX)
		self._riseTargetY = UdimoHelper.getUdimoYLevel(udimoId)
	end

	if riseStartX < self._riseTargetX then
		if not SpineLookDir.Right then
			do
				local dir = SpineLookDir.Left

				self._entity:setSpineLookDir(dir)
			end

			local riseTime = math.abs(riseStartX - self._riseTargetX) / self._moveSpeed

			self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, riseTime, self._onRiseFrame, self._onRiseFinished, self, nil, EaseType.Linear)
		end
	end
end

function UdimoFlyWalkState:_onRiseFrame(value)
	if not self._entity or not self._riseStartPos or not self._riseTargetX or not self._riseTargetY or not value then
		self:_killTween()

		return
	end

	local riseStartX = self._riseStartPos.x
	local riseStartY = self._riseStartPos.y
	local posX = riseStartX + (self._riseTargetX - riseStartX) * value
	local posY = riseStartY + (self._riseTargetY - riseStartY) * value

	self._entity:setPosition(posX, posY)
end

function UdimoFlyWalkState:_onRiseFinished()
	self._riseStartPos = nil
	self._riseTargetY = nil

	self:beginFly()
end

function UdimoFlyWalkState:beginFly()
	self:_killTween()

	if not self._entity then
		return
	end

	local udimoId = self._entity:getId()
	local curDir = self._entity:getSpineLookDir()
	local isLeft = curDir == SpineLookDir.Left

	self._startFlyDir = isLeft and -1 or 1
	self._flyMinLeftX, self._flyMaxRightX = UdimoHelper.getUdimoXRange(udimoId)

	local timeArr = UdimoConfig.instance:getUdimoConst(UdimoEnum.ConstId.WalkDurationTime, false, "#", true)
	local flyTime = math.random(timeArr[1], timeArr[2])

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, flyTime, flyTime, self._onFlyFrame, self._onFlyFinished, self, nil, EaseType.Linear)
end

function UdimoFlyWalkState:_onFlyFrame(passTime)
	if not self._entity or not passTime then
		self:_killTween()

		return
	end

	local newPosX, moveDir = UdimoHelper.getUidmoCurMoveX(self._riseTargetX, self._startFlyDir, self._moveSpeed, self._flyMinLeftX, self._flyMaxRightX, passTime)
	local isLeft = moveDir == UdimoEnum.MoveDir.Left

	self._entity:setSpineLookDir((isLeft or nil) and (SpineLookDir.Left or SpineLookDir.Right))
	self._entity:setPosition(newPosX)
end

function UdimoFlyWalkState:_onFlyFinished()
	self._startFlyDir = nil
	self._riseTargetX = nil
	self._flyMinLeftX = nil
	self._flyMaxRightX = nil

	self:beginLand()
end

function UdimoFlyWalkState:beginLand()
	self:_killTween()

	if not self._entity then
		return
	end

	local scene = UdimoController.instance:getUdimoScene()

	if not scene or not scene.stayPoint then
		return
	end

	local udimoId = self._entity:getId()

	self._landStartPos = self._entity:getPosition()
	self._landTargetPos = scene.stayPoint:getAirPointPos(udimoId, self._landStartPos)

	local startX = self._landStartPos.x
	local targetX = self._landTargetPos.x

	if startX < targetX then
		if not SpineLookDir.Right then
			local dir = SpineLookDir.Left

			self._entity:setSpineLookDir(dir)

			local landTime = math.abs(startX - targetX) / self._moveSpeed

			self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, landTime, self._onLandFrame, self._onLandFinished, self, nil, EaseType.Linear)
		end
	end
end

function UdimoFlyWalkState:_onLandFrame(value)
	if not self._entity or not self._landStartPos or not self._landTargetPos or not value then
		self:_killTween()

		return
	end

	local startX = self._landStartPos.x
	local startY = self._landStartPos.y
	local targetX = self._landTargetPos.x
	local targetY = self._landTargetPos.y
	local posX = startX + (targetX - startX) * value
	local posY = startY + (targetY - startY) * value

	self._entity:setPosition(posX, posY)
end

function UdimoFlyWalkState:_onLandFinished()
	self._landStartPos = nil

	if self._landTargetPos then
		self._landTargetPos = nil

		self:_killTween()
		self.fsm:triggerEvent(UdimoEvent.UdimoWalkFinish, {
			landDecoration = self._landTargetPos
		})
	end
end

return UdimoFlyWalkState
