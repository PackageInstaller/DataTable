-- chunkname: @modules/logic/versionactivity3_9/hedone/model/entity/HedoneBulletMO.lua

module("modules.logic.versionactivity3_9.hedone.model.entity.HedoneBulletMO", package.seeall)

local HedoneBulletMO = class("HedoneBulletMO", HedoneBaseUnitMO)

function HedoneBulletMO:onCtor(data)
	self._skillUid = data.skillUid
	self._targetUid = data.targetUid
	self._isLinkBullet = data.isLinkBullet
	self._isCombo = data.isCombo
	self._executeCount = data.executeCount or 1
	self._hit = nil

	self:_updateTargetPos()
	self:_updateRotation()
end

function HedoneBulletMO:_updateTargetPos()
	self._targetX, self._targetY = self:getPosition()

	local targetMO = HedoneGameModel.instance:getEntityMO(self._targetUid)

	if targetMO then
		self._targetX, self._targetY = targetMO:getPosition()
	end
end

function HedoneBulletMO:_onUpdateMove(deltaTime)
	local isArrived = self:getIsArrivedTarget()

	if isArrived then
		return
	end

	self:_updateTargetPos()

	local curX, curY = self:getPosition()
	local dis = MathUtil.vec2_length(curX, curY, self._targetX, self._targetY)
	local bulletHitRange = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.BulletHitRange, false, true)

	if dis <= bulletHitRange then
		self._isArrivedTarget = true

		return
	end

	local newX = self._targetX
	local newY = self._targetY
	local moveSpeed = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.BulletSpeed, false, true)
	local moveStep = moveSpeed * deltaTime

	if dis <= moveStep then
		self._isArrivedTarget = true
	else
		local dx = self._targetX - curX
		local dy = self._targetY - curY
		local dirX = dx / dis
		local dirY = dy / dis

		newX = curX + dirX * moveStep
		newY = curY + dirY * moveStep
	end

	self:setPosition(newX, newY)
end

function HedoneBulletMO:_updateRotation()
	local isArrived = self:getIsArrivedTarget()

	if isArrived then
		return
	end

	local curX, curY = self:getPosition()
	local dx = self._targetX - curX
	local dy = self._targetY - curY
	local rad = math.atan2(dy, dx)
	local deg = math.deg(rad)

	self._rotation = deg % 360
end

function HedoneBulletMO:setHit()
	self._hit = true
end

function HedoneBulletMO:getIsAlive()
	return not self._hit
end

function HedoneBulletMO:getBulletSkillUid()
	return self._skillUid
end

function HedoneBulletMO:getBulletTargetUid()
	return self._targetUid
end

function HedoneBulletMO:getIsLinkBullet()
	return self._isLinkBullet
end

function HedoneBulletMO:getIsCombo()
	return self._isCombo
end

function HedoneBulletMO:getExecuteCount()
	return self._executeCount
end

return HedoneBulletMO
