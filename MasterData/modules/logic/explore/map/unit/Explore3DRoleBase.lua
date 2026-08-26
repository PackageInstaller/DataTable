-- chunkname: @modules/logic/explore/map/unit/Explore3DRoleBase.lua

module("modules.logic.explore.map.unit.Explore3DRoleBase", package.seeall)

local Explore3DRoleBase = class("Explore3DRoleBase", ExploreBaseMoveUnit)

function Explore3DRoleBase:onInit()
	self._offsetPos = Vector3(0.5, 0, 0.5)
	self._angle = Vector3(0, 0, 0)
	self._walkDistance = 0
	self.dir = 270
end

function Explore3DRoleBase:isRole()
	return true
end

function Explore3DRoleBase:initComponents()
	self:addComp("animComp", ExploreRoleAnimComp)
	self:addComp("animEffectComp", ExploreRoleAnimEffectComp)
	self:addComp("uiComp", ExploreUnitUIComp)
end

function Explore3DRoleBase:playAnim(animName)
	Explore3DRoleBase.super.playAnim(self, animName)

	self._cacheAnimName = animName
end

function Explore3DRoleBase:setBool(key, value)
	self.animComp:setBool(key, value)
end

function Explore3DRoleBase:setFloat(key, value)
	self.animComp:setFloat(key, value)
end

function Explore3DRoleBase:setMoveState(state)
	self.animComp:setInteger(ExploreAnimEnum.RoleAnimKey.MoveState, state)
end

function Explore3DRoleBase:getHeroStatus()
	return self._curStatus or ExploreAnimEnum.RoleAnimStatus.None
end

function Explore3DRoleBase:setHeroStatus(status, isDelaySetNormal, control)
	if status == self._curStatus and status ~= ExploreAnimEnum.RoleAnimStatus.None then
		self.animEffectComp:setStatus(ExploreAnimEnum.RoleAnimStatus.None)
	end

	self._curStatus = status

	self.animEffectComp:setStatus(status)
	TaskDispatcher.cancelTask(self.delaySetNormalStatus, self)

	if self._statusControl then
		ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.HeroAnim)

		self._statusControl = nil
	end

	local duration

	if isDelaySetNormal then
		duration = ExploreAnimEnum.RoleAnimLen[status]
	end

	if duration and duration > 0 then
		TaskDispatcher.runDelay(self.delaySetNormalStatus, self, duration)
	end

	self._statusControl = control

	if control then
		PopupController.instance:setPause("ExploreHeroLock", true)
		ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.HeroAnim)
	end

	self.animComp:setInteger(ExploreAnimEnum.RoleAnimKey.Status, status)
end

function Explore3DRoleBase:delaySetNormalStatus()
	self._curStatus = ExploreAnimEnum.RoleAnimStatus.None

	self.animEffectComp:setStatus(ExploreAnimEnum.RoleAnimStatus.None)
	self.animComp:setInteger(ExploreAnimEnum.RoleAnimKey.Status, ExploreAnimEnum.RoleAnimStatus.None)

	if self._statusControl then
		PopupController.instance:setPause("ExploreHeroLock", false)
		ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.HeroAnim)

		self._statusControl = nil
	end
end

function Explore3DRoleBase:moveSpeed()
	local speed = ExploreAnimEnum.RoleSpeed.run

	if ExploreController.instance:getMap():getNowStatus() == ExploreEnum.MapStatus.MoveUnit then
		speed = ExploreAnimEnum.RoleSpeed.walk
	end

	self:setMoveSpeed(speed)

	return speed
end

function Explore3DRoleBase:setMoveSpeed(v)
	local moveState = ExploreAnimEnum.RoleMoveState.Idle

	moveState = v == 0 and ExploreAnimEnum.RoleMoveState.Idle or ExploreAnimEnum.RoleMoveState.Move

	if moveState == ExploreAnimEnum.RoleMoveState.Move or not self._tarUnitMO or self._tarUnitMO.type ~= ExploreEnum.ItemType.PipePot then
		TaskDispatcher.cancelTask(self._delaySetIdle, self)
		self:setMoveState(moveState)
	else
		TaskDispatcher.runDelay(self._delaySetIdle, self, 0.2)
	end
end

function Explore3DRoleBase:_delaySetIdle()
	self:setMoveState(ExploreAnimEnum.RoleMoveState.Idle)
end

function Explore3DRoleBase:_endMove(...)
	self:setMoveSpeed(0)
	Explore3DRoleBase.super._endMove(self, ...)
end

function Explore3DRoleBase:stopMoving(force)
	if force then
		self:setMoveSpeed(0)
	end

	return Explore3DRoleBase.super.stopMoving(self, force)
end

function Explore3DRoleBase:onDirChange(tureDir)
	self:setRotate(0, self.dir, 0)
end

function Explore3DRoleBase:onCheckDir(oldTilemapPos, newTilemapPos)
	if not ExploreHelper.isPosEqual(oldTilemapPos, newTilemapPos) then
		self.dir = newTilemapPos.x == oldTilemapPos.x and (newTilemapPos.y > oldTilemapPos.y and 0 or 180) or newTilemapPos.x < oldTilemapPos.x and 270 or 90
	end

	self.dir = self._lockDir or self.dir

	self:onDirChange()
end

function Explore3DRoleBase:onCheckDirByPos(oldPos, newPos)
	if oldPos:Equals(newPos) then
		return
	end

	local x = newPos.x - oldPos.x
	local z = newPos.z - oldPos.z
	local angle = math.deg(math.atan2(x, z))

	angle = self._lockDir or angle

	self:setRotate(0, angle, 0)
end

function Explore3DRoleBase:_onSpineLoaded(spine)
	self:playAnim(self._cacheAnimName or ExploreAnimEnum.RoleAnimName.idle)

	if self._callback then
		if self._callbackObj then
			self._callback(self._callbackObj, spine, self)
		else
			self._callback(spine, self)
		end
	end

	self:setRotate(self._angle.x, self._angle.y, self._angle.z)

	self._callback = nil
	self._callbackObj = nil
end

function Explore3DRoleBase:setRotate(x, y, z)
	self._angle.x = x
	self._angle.y = y
	self._angle.z = z

	if self._displayTr then
		transformhelper.setLocalRotation(self._displayTr, self._angle.x, self._angle.y, self._angle.z)
	end
end

function Explore3DRoleBase:setTrOffset(dir, finalPos, time, callback, callObj, easeType)
	if not self._displayTr then
		return
	end

	if dir then
		self:setRotate(0, dir, 0)
	end

	if self._tweenMoveId then
		ZProj.TweenHelper.KillById(self._tweenMoveId)
	end

	TaskDispatcher.runRepeat(self.onTweenMoving, self, 0, -1)

	self._tweenMoveEndCb = callback
	self._tweenMoveEndCbObj = callObj
	self._tweenMoveId = ZProj.TweenHelper.DOMove(self._displayTr, finalPos.x, finalPos.y, finalPos.z, time or 0.3, self.onTweenMoveEnd, self, nil, easeType or EaseType.Linear)
end

function Explore3DRoleBase:onTweenMoving()
	ExploreController.instance:dispatchEvent(ExploreEvent.HeroTweenDisTr, self._displayTr.position)
end

function Explore3DRoleBase:onTweenMoveEnd()
	self._tweenMoveId = nil

	TaskDispatcher.cancelTask(self.onTweenMoving, self)

	local cb = self._tweenMoveEndCb
	local obj = self._tweenMoveEndCbObj

	self._tweenMoveEndCb = nil
	self._tweenMoveEndCbObj = nil

	if cb then
		self._tweenMoveEndCb(obj)
	end
end

function Explore3DRoleBase:onDestroy()
	PopupController.instance:setPause("ExploreHeroLock", false)
	TaskDispatcher.cancelTask(self._delaySetIdle, self)
	TaskDispatcher.cancelTask(self.onTweenMoving, self)

	if self._tweenMoveId then
		ZProj.TweenHelper.KillById(self._tweenMoveId)

		self._tweenMoveId = nil
	end

	TaskDispatcher.cancelTask(self.delaySetNormalStatus, self)
	Explore3DRoleBase.super.onDestroy(self)
end

return Explore3DRoleBase
