-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/collisions/CollisionBase.lua

module("logicscene.scene.battle.skills.collisions.CollisionBase", package.seeall)

local CollisionBase = class("CollisionBase")
local threshold = 9999
local battleEffectOrderCtrl

function CollisionBase:ctor(collisionCo, skill)
	self.collisionCo = collisionCo
	self.skill = skill
	self._unit = self.skill.unit
	self._posX = 0
	self._posY = 0
	self._posZ = 0
	self._posStartX = 0
	self._posStartY = 0
	self._posStartZ = 0
	self._dirX = 0
	self._dirY = 0
	self._dirZ = 0
	self._skillTargets = nil
	self._targetCharactorRes = nil
	self._effectObject = nil
	self._isDestroy = nil
	self._runningTime = 0
	self._targetIndex = 1
	self._aliveTime = 0
	self._delayDestroy = 0
	battleEffectOrderCtrl = battleEffectOrderCtrl or BattleEffectOrderCtrl
end

function CollisionBase:getTarget()
	if not self._skillTargets then
		return nil
	end

	return self._skillTargets[self._targetIndex]
end

function CollisionBase:onHurtTarget()
	local tgt = self:getTarget()

	if tgt then
		tgt.unit.attrs:setCollisionLocking(false)
	end

	self._targetIndex = self._targetIndex + 1

	if self:getTarget() then
		self._posStartX = self._posX
		self._posStartY = self._posY
		self._posStartZ = self._posZ

		self:calculateAliveTimeAndDir()
	else
		self._delayDestroy = self.collisionCo.delay or 0
	end
end

function CollisionBase:isLastCollision()
	return self.collisionCo.index == self.collisionCo.count
end

function CollisionBase:getDamgePercent()
	return self.collisionCo.damage
end

function CollisionBase:getDamgeCount()
	return self.collisionCo.damageCount
end

function CollisionBase:getHitSound()
	return self.collisionCo.hitsound
end

function CollisionBase:getDamgeTotalCount()
	local targets = self.skill:getSkillTargets()

	if targets then
		if not #targets then
			local targetsNum = 0

			return self.collisionCo.damageCount * targetsNum
		end
	end
end

function CollisionBase:getRepelingDir(unit)
	if unit.spine:getDirection() == UnitSpineDir.Left then
		return 1, 0, 0
	end

	return -1, 0, 0
end

function CollisionBase:setStartPos(posX, posY, posZ)
	if not posX or not posY or not posZ then
		posX, posY, posZ = Framework.TransformUtil.GetPos(self._unit.go.transform, nil, nil, nil)
	end

	self._posStartX = posX
	self._posStartY = posY
	self._posStartZ = posZ
	self._posX = posX
	self._posY = posY
	self._posZ = posZ

	self:_updateEffectPosition()
end

function CollisionBase:setPos(posX, posY, posZ)
	if not posX or not posY or not posZ then
		posX, posY, posZ = Framework.TransformUtil.GetPos(self._unit.go.transform, nil, nil, nil)
	end

	self._posX = posX
	self._posY = posY
	self._posZ = posZ

	self:_updateEffectPosition()
end

function CollisionBase:setDir(dirX, dirY, dirZ)
	if not dirX or not dirY or not dirZ then
		dirX, dirY, dirZ = AMTargetPosition.GetObjectDir(self._unit.go.transform, nil, nil, nil)
	end

	self._dirX = dirX
	self._dirY = dirY
	self._dirZ = dirZ

	self:_updateEffectDir()
end

function CollisionBase:setTargets(tgts)
	if self._skillTargets then
		local cnt = #self._skillTargets

		for i = 1, cnt do
			self._skillTargets[i].unit.attrs:setCollisionLocking(false)
		end
	end

	self._skillTargets = tgts

	if tgts then
		local cnt = #tgts

		for i = 1, cnt do
			tgts[i].unit.attrs:setCollisionLocking(true)
		end
	end
end

function CollisionBase:setNotSkillEffectTargets(tgts)
	self._notSkillEffectTargets = tgts
end

function CollisionBase:getNotSkillEffectTargets()
	return self._notSkillEffectTargets
end

function CollisionBase:createEffect()
	if not self._effectObject and self.collisionCo.prefabsPath and #self.collisionCo.prefabsPath > 0 then
		local posX = self._posX
		local posY = self._posY

		if self.collisionCo.lockPX then
			posX = 0
		end

		if self.collisionCo.lockPY then
			posY = 0
		end

		self._effectObject = GameEffectManager.instance:playEffect(self.collisionCo.prefabsPath, true, 0, posX, posY, (self.collisionCo.lockPZ or nil) and 0, self._onEffectPlayFinish, self._onEffectLoaded, self)
	end
end

function CollisionBase:destroyEffect()
	if self._eventInstance then
		AudioPlayerEx.instance:stopEvent(self._eventInstance)

		self._eventInstance = nil
	end

	self._isDestroy = true

	if self._effectObject then
		GameEffectManager.instance:stopEffect(self._effectObject)

		self._effectObject = nil
	end
end

function CollisionBase:update(deltaTime)
	if self.collisionCo.prefabsPath and (not self._effectObject or not self._effectObject.effGo) then
		return
	end

	if self._delayDestroy > 0 then
		self._delayDestroy = self._delayDestroy - deltaTime

		self:_updateEffectLayer()
		self:_updateEffectOrder()

		return
	end

	if not self:getTarget() then
		return
	end

	if deltaTime > threshold then
		while deltaTime > threshold do
			if self:isDone() then
				return
			end

			self:_updateInternal(threshold)

			deltaTime = deltaTime - threshold
		end

		if deltaTime > 0 and not self:isDone() then
			self:_updateInternal(deltaTime)
		end
	else
		self:_updateInternal(deltaTime)
	end

	self:_updateEffectLayer()
	self:_updateEffectOrder()
end

function CollisionBase:isDone()
	if self._delayDestroy > 0 then
		return
	end

	return not self:getTarget()
end

function CollisionBase:clear()
	self._skillTargets = nil
	self._notSkillEffectTargets = nil

	self:destroyEffect()
end

function CollisionBase:_updateInternal(time)
	self:_updatePos(time)
	self:_checkCollision()
end

function CollisionBase:_checkCollision()
	if self._runningTime >= self._aliveTime then
		self._unit.battleFlow:collisionHurt(self)
	end
end

function CollisionBase:_updatePos(time)
	self._runningTime = self._runningTime + time

	if self.collisionCo.speed > 0 then
		if not self.collisionCo.spline then
			self:_updatePosDefault()
		else
			self:_updatePosSpline()
		end
	else
		local destX, destY, destZ = self:_getTargetPos()

		self:setPos(destX, destY, destZ)
	end
end

function CollisionBase:_updatePosDefault()
	local runningTime = self._runningTime

	if self._aliveTime > 0 and runningTime > self._aliveTime then
		runningTime = self._aliveTime
	end

	local posX = self._posStartX + self._dirX * runningTime * self.collisionCo.speed
	local posY = self._posStartY + self._dirY * runningTime * self.collisionCo.speed
	local posZ = self._posStartZ + self._dirZ * runningTime * self.collisionCo.speed

	self:setPos(posX, posY, posZ)
	self:setDir(self._dirX, self._dirY, self._dirZ)
end

function CollisionBase:_updatePosSpline()
	if self._aliveTime > 0 and self._runningTime > self._aliveTime then
		self._runningTime = self._aliveTime
	end

	local dx = self._posX
	local dy = self._posY
	local dz = self._posZ
	local posX, posY, posZ = self.collisionCo.spline:Simulate(self._runningTime, nil, nil, nil)

	self:setPos(posX, posY, posZ)

	dx = posX - dx
	dy = posY - dy
	dz = posZ - dz

	self:setDir(dx, dy, dz)
end

function CollisionBase:calculateAliveTimeAndDir()
	if self.collisionCo.spline then
		self._aliveTime = self.collisionCo.spline:GetTimeCount()

		return
	end

	if self.collisionCo.speed > 0 then
		local target = self:getTarget()

		if target then
			local destX, destY, destZ = self:_getTargetPos()
			local dx = destX - self._posStartX
			local dy = destY - self._posStartY
			local dz = destZ - self._posStartZ
			local dist = math.sqrt(dx * dx + dy * dy + dz * dz)

			if dist > 0 then
				local radius = self.collisionCo.radius
				local unitRadius = target.unit.radius

				self._aliveTime = (dist - radius - unitRadius) / self.collisionCo.speed

				if self._aliveTime < 0 then
					self._aliveTime = 0
				end

				self:setDir(dx / dist, dy / dist, dz / dist)

				return
			end
		end
	end

	self._aliveTime = 0
end

function CollisionBase:_getTargetPos()
	local target = self:getTarget().unit

	if not target then
		return self._posX, self._posZ, self._posZ
	else
		local hagPoint = target:getHangPoint(self.collisionCo.hagPoint)

		hagPoint = hagPoint or target.go

		local destX, destY, destZ = Framework.TransformUtil.GetPos(hagPoint.transform, nil, nil, nil)

		return destX, destY, destZ
	end
end

function CollisionBase:_getDir(destX, destY, destZ)
	local dx = destX - self._posX
	local dy = destY - self._posY
	local dz = destZ - self._posZ
	local dist = math.sqrt(dx * dx + dy * dy + dz * dz)

	if dist > 0 then
		dx = dx / dist
		dy = dy / dist
		dz = dz / dist

		return dx, dy, dz
	end
end

function CollisionBase:_onEffectLoaded(eff)
	self._effectObject = eff

	if self._isDestroy then
		self:destroyEffect()
	else
		local sound = self.collisionCo.sound

		if not string.nilorempty(sound) then
			AudioPlayerEx.instance:playEffectByEvtName(sound, UnityEngine.Time.timeScale, function(eventInstance)
				self._eventInstance = eventInstance

				if self._isDestroy and self._eventInstance then
					AudioPlayerEx.instance:stopEvent(self._eventInstance)

					self._eventInstance = nil
				end
			end)
		end

		self:_updateEffectPosition()
		self:_updateEffectDir()
		self:_updateEffectLayer()
	end
end

function CollisionBase:_onEffectPlayFinish()
	if self._effectObject then
		self._effectObject = nil
	end
end

function CollisionBase:_updateEffectPosition()
	if self._effectObject and self._effectObject.effGo then
		if self.collisionCo.speed > 0 then
			local posX = self._posX
			local posY = self._posY

			if self.collisionCo.height > 0 then
				posY = self.collisionCo.height
			end

			if self.collisionCo.lockPX then
				posX = 0
			end

			if self.collisionCo.lockPY then
				posY = 0
			end

			Framework.TransformUtil.SetPos(self._effectObject.effGo.transform, posX, posY, (self.collisionCo.lockPZ or nil) and 0)
		elseif self.collisionCo.hitEffect then
			local target = self:getTarget().unit

			target.battleEffects:updateEffectPosition(self.collisionCo.hitEffect, self._effectObject)
		end
	end
end

function CollisionBase:_updateEffectLayer()
	if self._effectObject and self._effectObject.effGo then
		self.skill.unit.battleEffects:updateEffectLayer(self._effectObject.effGo, self._effectObject.effectCo)
	end
end

function CollisionBase:_updateEffectOrder()
	if self._effectObject and self._effectObject.effGo then
		local order = battleEffectOrderCtrl.getOrderByPosIndex(self.skill.unit.posRow)

		if order then
			self._effectObject:setSortingOrderGreatZero(order)
		end
	end
end

function CollisionBase:_updateEffectDir()
	if self._effectObject and self._effectObject.effGo then
		local dirX = self._dirX
		local dirY = self._dirY
		local dirZ = self._dirZ

		if not self.collisionCo.lockRotate then
			if self.collisionCo.lockX then
				dirX = 0
			end

			if self.collisionCo.lockY then
				dirY = 0
			end

			if self.collisionCo.lockZ then
				dirZ = 0
			end
		end

		AMTargetPosition.SetObjectDir(self._effectObject.effGo.transform, dirX, dirY, dirZ)

		if self.collisionCo.lockRotate and (self.collisionCo.lockX or self.collisionCo.lockY or self.collisionCo.lockZ) then
			local rx, ry, rz = Framework.TransformUtil.GetLocalRotation(self._effectObject.effGo.transform, nil, nil, nil)

			if self.collisionCo.lockX then
				rx = 0
			end

			if self.collisionCo.lockY then
				ry = 0
			end

			Framework.TransformUtil.SetLocalRotation(self._effectObject.effGo.transform, rx, ry, (self.collisionCo.lockZ or nil) and 0)
		end
	end
end

return CollisionBase
