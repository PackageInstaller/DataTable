-- chunkname: @modules/logic/versionactivity3_8/echosong/view/comp/V3a8EchoSongEnemy1EntityComp.lua

module("modules.logic.versionactivity3_8.echosong.view.comp.V3a8EchoSongEnemy1EntityComp", package.seeall)

local V3a8EchoSongEnemy1EntityComp = class("V3a8EchoSongEnemy1EntityComp", V3a8EchoSongEnemyBaseEntityComp)

function V3a8EchoSongEnemy1EntityComp:_onInit(go)
	local enemy1Go = gohelper.findChild(self._go, "Image_Enemy1")
	local enemy2Go = gohelper.findChild(self._go, "Image_Enemy2")

	gohelper.setActive(enemy1Go, true)
	gohelper.setActive(enemy2Go, false)
	gohelper.setActive(self._go, false)
end

function V3a8EchoSongEnemy1EntityComp:_getUnitType()
	return V3a8EchoSongEnum.UnitType.Enemy1
end

function V3a8EchoSongEnemy1EntityComp:_getSpeed()
	return V3a8EchoSongEnum.EnemyConst.Enemy1Speed
end

function V3a8EchoSongEnemy1EntityComp:_getHurtDistance()
	return V3a8EchoSongEnum.EnemyConst.Enemy1HurtDistance
end

function V3a8EchoSongEnemy1EntityComp:_onInitComp()
	self._isMoving = false
end

function V3a8EchoSongEnemy1EntityComp:_canFrameUpdate()
	return self._isMoving
end

function V3a8EchoSongEnemy1EntityComp:rollback(info)
	self._rawRecordInfo = self._rawRecordInfo or self:getRecordInfo()
	info = tabletool.copy(self._rawRecordInfo)
	self._recordInfo = info
	self._isMoving = info.isMoving
	self._triggerTime = nil

	gohelper.setActive(self._go, self._isMoving)

	local pos = info.pos

	if pos and pos.x and pos.y then
		recthelper.setAnchor(self._go.transform, pos.x, pos.y)
	else
		logError("V3a8EchoSongEnemy1EntityComp:rollback pos is nil", self._id)
	end
end

function V3a8EchoSongEnemy1EntityComp:getRecordInfo()
	self._recordInfo.isMoving = false

	local x, y = recthelper.getAnchor(self._params.go.transform)

	self._recordInfo.pos = {
		x = x,
		y = y
	}

	return tabletool.copy(self._recordInfo)
end

function V3a8EchoSongEnemy1EntityComp:_moveDone()
	self._projAnimator:Play("close")

	self._isMoving = false
end

function V3a8EchoSongEnemy1EntityComp:_move(anchorPos)
	self:_setTarget(anchorPos)

	self._isMoving = true
end

function V3a8EchoSongEnemy1EntityComp:_frameUpdate()
	V3a8EchoSongEnemy1EntityComp.super._frameUpdate(self)

	if self._triggerTime and self._triggerType == V3a8EchoSongEnum.ParticleType.MainPlayerShort and Time.time - self._triggerTime > V3a8EchoSongEnum.EnemyConst.Enemy1WaitTime then
		self:_moveDone()

		self._triggerTime = nil
	end
end

function V3a8EchoSongEnemy1EntityComp:checkHitParticle(ballItem)
	if self._isMoving then
		return
	end

	if not ballItem then
		return
	end

	local triggerType = ballItem:getTriggerType()
	local validType = triggerType == V3a8EchoSongEnum.ParticleType.MainPlayer or triggerType == V3a8EchoSongEnum.ParticleType.Explore or triggerType == V3a8EchoSongEnum.ParticleType.Event2 or triggerType == V3a8EchoSongEnum.ParticleType.MainPlayerShort

	if not validType then
		return
	end

	if not self._cachedWorldX or not self._cachedWorldY then
		return
	end

	local worldPos = ballItem:getPos()
	local dx = worldPos.x - self._cachedWorldX
	local dy = worldPos.y - self._cachedWorldY

	if dx * dx + dy * dy < 1 then
		self._triggerType = triggerType

		if triggerType == V3a8EchoSongEnum.ParticleType.MainPlayerShort then
			self._triggerTime = Time.time

			gohelper.setActive(self._go, true)
			self._projAnimator:Play("open")

			self._isMoving = true
			self._targetPos = nil
			self._curPos.x, self._curPos.y = recthelper.getAnchor(self._go.transform)

			return
		else
			self._triggerTime = nil
		end

		gohelper.setActive(self._go, true)
		self._projAnimator:Play("open")
		self:_move(ballItem:getSrcPos())
	end
end

return V3a8EchoSongEnemy1EntityComp
