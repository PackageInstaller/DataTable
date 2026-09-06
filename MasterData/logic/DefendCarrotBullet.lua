-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/DefendCarrotBullet.lua

module("logic.extensions.defendcarrot.model.DefendCarrotBullet", package.seeall)

local DefendCarrotBullet = class("DefendCarrotBullet", DefendCarrotUnit)

function DefendCarrotBullet:ctor()
	DefendCarrotBullet.super.ctor(self)

	self._hasHitIdMap = {}
	self._curMoveDir = Vector2.New(0, 0)
	self._initRadius = 0

	self:reset()
end

function DefendCarrotBullet:getType()
	return DefendCarrotEnum.UnitType.Bullet
end

function DefendCarrotBullet:setDefineId(bulletId)
	self._defineId = bulletId
	self._bulletCfg = DefendCarrotConfig.instance:getBulletCfg(self._defineId)

	if self._bulletCfg then
		self._initRadius = self._bulletCfg.radius

		self:setRadius(self._initRadius)

		self._speed = self._bulletCfg.speed or 0

		if not self._bulletCfg.buffIds then
			local buffIdStr = ""
			local buffIds = string.splitToNumber(buffIdStr, "#")

			for _, buffId in ipairs(buffIds) do
				self.addBuffByBuffId(self, buffId, self)
			end
		end
	end
end

function DefendCarrotBullet:getBulletCfg()
	return self._bulletCfg
end

function DefendCarrotBullet:setOwnerId(ownerId)
	self._ownerId = ownerId or 0
end

function DefendCarrotBullet:getOwnerId()
	return self._ownerId
end

function DefendCarrotBullet:setWeaponId(weaponId)
	self._weaponId = weaponId or 0
end

function DefendCarrotBullet:getWeaponId()
	return self._weaponId
end

function DefendCarrotBullet:setDirection(dirX, dirY)
	self._curMoveDir:Set(dirX or 0, dirY or 0)

	local angle = Mathf.Acos(self._curMoveDir.x) * Mathf.Rad2Deg

	if self._curMoveDir.y > 0 then
		self:setLocRotationZ(angle - 90)
	else
		self:setLocRotationZ(-angle - 90)
	end
end

function DefendCarrotBullet:setBaseDamage(damage)
	self._atk = damage or 0
end

function DefendCarrotBullet:onEnable()
	DefendCarrotBullet.super.onEnable(self)

	self._isActive = true
end

function DefendCarrotBullet:beforeUpdate()
	DefendCarrotBullet.super.beforeUpdate(self)
end

function DefendCarrotBullet:update(deltaTime)
	DefendCarrotBullet.super.update(self, deltaTime)
	self:_move(deltaTime)

	if self._isIncreaseRadius and self._containerCom then
		self._containerCom:updateRadius(self.radius)
	end
end

function DefendCarrotBullet:afterUpdate()
	DefendCarrotBullet.super.afterUpdate(self)
end

function DefendCarrotBullet:reset()
	DefendCarrotBullet.super.reset(self)
	table.clear(self._hasHitIdMap)
	self._curMoveDir:Set(0, 0)

	self._locRotationZ = 0
	self._speed = 0
	self._atk = 0
	self._weaponId = 0
	self._ownerId = 0
	self._defineId = 0
	self._buffCfg = 0
	self._curHitCount = 0

	self:resetMode(DefendCarrotEnum.BuffChangeMode.Penetrate)
	self:resetMode(DefendCarrotEnum.BuffChangeMode.IncreaseRadius)
	self:resetMode(DefendCarrotEnum.BuffChangeMode.BulletBounce)

	self._addBounceCount = 0
	self._burningTimeMultiplier = 1
	self._frozenTimeMultiplier = 1
	self._slowDownTimeMultiplier = 1
	self._addExplosiveRate = 0
end

function DefendCarrotBullet:destroy()
	DefendCarrotBullet.super.destroy(self)
end

function DefendCarrotBullet:setLocRotationZ(rotationZ)
	self._locRotationZ = rotationZ

	if self._containerCom then
		self._containerCom:updateRotationZ()
	end
end

function DefendCarrotBullet:getLocRotationZ()
	return self._locRotationZ or 0
end

function DefendCarrotBullet:onHit(target)
	DefendCarrotBullet.super.onHit(self, target)

	local targetId = target:getUnitId()

	self._hasHitIdMap[targetId] = true
	self._curHitCount = self._curHitCount + 1

	if self._isPenetrate then
		-- block empty
	elseif self._isBulletBounce then
		-- block empty
	elseif self._isIncreaseRadius then
		-- block empty
	else
		self:preReCycle()
	end

	if self._containerCom then
		-- block empty
	end
end

function DefendCarrotBullet:canHitTarget(target)
	if not target then
		return false
	end

	local targetId = target:getUnitId()

	if self._hasHitIdMap[targetId] then
		return false
	end

	return true
end

function DefendCarrotBullet:_move(deltaTime)
	if not self._isActive then
		return
	end

	local moveDistance = self._speed * deltaTime

	self:updatePosition(self.position.x + self._curMoveDir.x * moveDistance, self.position.y + self._curMoveDir.y * moveDistance)
end

function DefendCarrotBullet:setPenetrate(isPenetrate)
	self._isPenetrate = isPenetrate
end

function DefendCarrotBullet:setIsIncreaseRadius(isIncrease)
	self._isIncreaseRadius = isIncrease

	if not isIncrease and self._bulletCfg then
		self:setRadius(self._initRadius)
	end
end

function DefendCarrotBullet:isIncreaseRadius()
	return self._isIncreaseRadius
end

function DefendCarrotBullet:setIsBulletBounce(isBounce)
	self._isBulletBounce = isBounce
end

function DefendCarrotBullet:isBulletBounce()
	return self._isBulletBounce
end

function DefendCarrotBullet:getCurBounceCount()
	return self._curBounceCount
end

function DefendCarrotBullet:bounceIgnoreTarget(ignoreTarget, boundRange)
	local target = DefendCarrotGameController.instance:findTargetsInRange(self.position.x, self.position.y, boundRange, ignoreTarget)

	if target then
		local dirX = target.position.x - self.position.x
		local dirY = target.position.y - self.position.y
		local len = Mathf.Sqrt(dirX * dirX + dirY * dirY)

		if len > 0 then
			dirX = dirX / len
			dirY = dirY / len

			self:setDirection(dirX, dirY)
		end

		self._hasHitIdMap[target:getUnitId()] = false
	else
		self:preReCycle()
	end
end

function DefendCarrotBullet:changeMode(modeName, ...)
	local params = {
		...
	}

	if modeName == DefendCarrotEnum.BuffChangeMode.Penetrate then
		self:setPenetrate(true)
	elseif modeName == DefendCarrotEnum.BuffChangeMode.IncreaseRadius then
		self:setIsIncreaseRadius(true)
	elseif modeName == DefendCarrotEnum.BuffChangeMode.BulletBounce then
		self:setIsBulletBounce(true)
	end
end

function DefendCarrotBullet:resetMode(modeName)
	if modeName == DefendCarrotEnum.BuffChangeMode.Penetrate then
		self:setPenetrate(false)
	elseif modeName == DefendCarrotEnum.BuffChangeMode.IncreaseRadius then
		self:setIsIncreaseRadius(false)
	elseif modeName == DefendCarrotEnum.BuffChangeMode.BulletBounce then
		self:setIsBulletBounce(false)
	end
end

function DefendCarrotBullet:getCurAttrValue(attrName)
	if attrName == DefendCarrotEnum.UnitAttrName.Attack then
		return self:_getCurAttack()
	elseif attrName == DefendCarrotEnum.UnitAttrName.DirX then
		return self._curMoveDir.x
	elseif attrName == DefendCarrotEnum.UnitAttrName.DirY then
		return self._curMoveDir.y
	elseif attrName == DefendCarrotEnum.UnitAttrName.AddBounceCount then
		return checknumber(self._addBounceCount)
	elseif attrName == DefendCarrotEnum.UnitAttrName.BurningTimeMultiplier then
		return checknumber(self._burningTimeMultiplier)
	elseif attrName == DefendCarrotEnum.UnitAttrName.FrozenTimeMultiplier then
		return checknumber(self._frozenTimeMultiplier)
	elseif attrName == DefendCarrotEnum.UnitAttrName.SlowDownTimeMultiplier then
		return checknumber(self._slowDownTimeMultiplier)
	elseif attrName == DefendCarrotEnum.UnitAttrName.AddExplosiveRate then
		return checknumber(self._addExplosiveRate)
	end

	return 0
end

function DefendCarrotBullet:updateAttr(attrName, attrValue)
	attrValue = checknumber(attrValue)

	if attrName == DefendCarrotEnum.UnitAttrName.AddBounceCount then
		self._addBounceCount = self._addBounceCount + checknumber(attrValue)
	elseif attrName == DefendCarrotEnum.UnitAttrName.BurningTimeMultiplier then
		self._burningTimeMultiplier = self._burningTimeMultiplier + checknumber(attrValue)
	elseif attrName == DefendCarrotEnum.UnitAttrName.FrozenTimeMultiplier then
		self._frozenTimeMultiplier = self._frozenTimeMultiplier + checknumber(attrValue)
	elseif attrName == DefendCarrotEnum.UnitAttrName.SlowDownTimeMultiplier then
		self._slowDownTimeMultiplier = self._slowDownTimeMultiplier + checknumber(attrValue)
	elseif attrName == DefendCarrotEnum.UnitAttrName.AddExplosiveRate then
		self._addExplosiveRate = self._addExplosiveRate + checknumber(attrValue)
	end
end

function DefendCarrotBullet:_getCurAttack()
	return self._atk or 0
end

function DefendCarrotBullet:setBulletScale(scale)
	if self._containerCom then
		self._containerCom:updateScale(scale)
	end
end

return DefendCarrotBullet
