-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/OriMatGameBullet.lua

module("logic.extensions.orimatgame.model.OriMatGameBullet", package.seeall)

local OriMatGameBullet = class("OriMatGameBullet", OriMatGameUnit)

function OriMatGameBullet:ctor()
	OriMatGameBullet.super.ctor(self)

	self._hasHitIdMap = {}
	self._curMoveDir = Vector2.New(0, 0)
	self._initRadius = 0

	self:reset()
end

function OriMatGameBullet:getType()
	return OriMatGameEnum.UnitType.Bullet
end

function OriMatGameBullet:setDefineId(bulletId)
	self._defineId = bulletId
	self._bulletCfg = OriMatGameConfig.instance:getBulletCfg(self._defineId)

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

function OriMatGameBullet:getBulletCfg()
	return self._bulletCfg
end

function OriMatGameBullet:setOwnerId(ownerId)
	self._ownerId = ownerId or 0
end

function OriMatGameBullet:getOwnerId()
	return self._ownerId
end

function OriMatGameBullet:setWeaponId(weaponId)
	self._weaponId = weaponId or 0
end

function OriMatGameBullet:getWeaponId()
	return self._weaponId
end

function OriMatGameBullet:setDirection(dirX, dirY)
	self._curMoveDir:Set(dirX or 0, dirY or 0)

	local angle = Mathf.Acos(self._curMoveDir.x) * Mathf.Rad2Deg

	if self._curMoveDir.y > 0 then
		self:setLocRotationZ(angle - 90)
	else
		self:setLocRotationZ(-angle - 90)
	end
end

function OriMatGameBullet:setBaseDamage(damage)
	self._atk = damage or 0
end

function OriMatGameBullet:onEnable()
	OriMatGameBullet.super.onEnable(self)

	self._isActive = true
end

function OriMatGameBullet:beforeUpdate()
	OriMatGameBullet.super.beforeUpdate(self)
end

function OriMatGameBullet:update(deltaTime)
	OriMatGameBullet.super.update(self, deltaTime)
	self:_move(deltaTime)

	if self._isIncreaseRadius and self._containerCom then
		self._containerCom:updateRadius(self.radius)
	end
end

function OriMatGameBullet:afterUpdate()
	OriMatGameBullet.super.afterUpdate(self)
end

function OriMatGameBullet:reset()
	OriMatGameBullet.super.reset(self)
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

	self:resetMode(OriMatGameEnum.BuffChangeMode.Penetrate)
	self:resetMode(OriMatGameEnum.BuffChangeMode.IncreaseRadius)
	self:resetMode(OriMatGameEnum.BuffChangeMode.BulletBounce)

	self._addBounceCount = 0
	self._burningTimeMultiplier = 1
	self._frozenTimeMultiplier = 1
	self._slowDownTimeMultiplier = 1
	self._addExplosiveRate = 0
end

function OriMatGameBullet:destroy()
	OriMatGameBullet.super.destroy(self)
end

function OriMatGameBullet:setLocRotationZ(rotationZ)
	self._locRotationZ = rotationZ

	if self._containerCom then
		self._containerCom:updateRotationZ()
	end
end

function OriMatGameBullet:getLocRotationZ()
	return self._locRotationZ or 0
end

function OriMatGameBullet:onHit(target)
	OriMatGameBullet.super.onHit(self, target)

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

function OriMatGameBullet:canHitTarget(target)
	if not target then
		return false
	end

	local targetId = target:getUnitId()

	if self._hasHitIdMap[targetId] then
		return false
	end

	return true
end

function OriMatGameBullet:_move(deltaTime)
	if not self._isActive then
		return
	end

	local moveDistance = self._speed * deltaTime

	self:updatePosition(self.position.x + self._curMoveDir.x * moveDistance, self.position.y + self._curMoveDir.y * moveDistance)
end

function OriMatGameBullet:setPenetrate(isPenetrate)
	self._isPenetrate = isPenetrate
end

function OriMatGameBullet:setIsIncreaseRadius(isIncrease)
	self._isIncreaseRadius = isIncrease

	if not isIncrease and self._bulletCfg then
		self:setRadius(self._initRadius)
	end
end

function OriMatGameBullet:isIncreaseRadius()
	return self._isIncreaseRadius
end

function OriMatGameBullet:setIsBulletBounce(isBounce)
	self._isBulletBounce = isBounce
end

function OriMatGameBullet:isBulletBounce()
	return self._isBulletBounce
end

function OriMatGameBullet:getCurBounceCount()
	return self._curBounceCount
end

function OriMatGameBullet:bounceIgnoreTarget(ignoreTarget, boundRange)
	local target = OriMatGameGameController.instance:findTargetsInRange(self.position.x, self.position.y, boundRange, ignoreTarget)

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

function OriMatGameBullet:changeMode(modeName, ...)
	local params = {
		...
	}

	if modeName == OriMatGameEnum.BuffChangeMode.Penetrate then
		self:setPenetrate(true)
	elseif modeName == OriMatGameEnum.BuffChangeMode.IncreaseRadius then
		self:setIsIncreaseRadius(true)
	elseif modeName == OriMatGameEnum.BuffChangeMode.BulletBounce then
		self:setIsBulletBounce(true)
	end
end

function OriMatGameBullet:resetMode(modeName)
	if modeName == OriMatGameEnum.BuffChangeMode.Penetrate then
		self:setPenetrate(false)
	elseif modeName == OriMatGameEnum.BuffChangeMode.IncreaseRadius then
		self:setIsIncreaseRadius(false)
	elseif modeName == OriMatGameEnum.BuffChangeMode.BulletBounce then
		self:setIsBulletBounce(false)
	end
end

function OriMatGameBullet:getCurAttrValue(attrName)
	if attrName == OriMatGameEnum.UnitAttrName.Attack then
		return self:_getCurAttack()
	elseif attrName == OriMatGameEnum.UnitAttrName.DirX then
		return self._curMoveDir.x
	elseif attrName == OriMatGameEnum.UnitAttrName.DirY then
		return self._curMoveDir.y
	elseif attrName == OriMatGameEnum.UnitAttrName.AddBounceCount then
		return checknumber(self._addBounceCount)
	elseif attrName == OriMatGameEnum.UnitAttrName.BurningTimeMultiplier then
		return checknumber(self._burningTimeMultiplier)
	elseif attrName == OriMatGameEnum.UnitAttrName.FrozenTimeMultiplier then
		return checknumber(self._frozenTimeMultiplier)
	elseif attrName == OriMatGameEnum.UnitAttrName.SlowDownTimeMultiplier then
		return checknumber(self._slowDownTimeMultiplier)
	elseif attrName == OriMatGameEnum.UnitAttrName.AddExplosiveRate then
		return checknumber(self._addExplosiveRate)
	end

	return 0
end

function OriMatGameBullet:updateAttr(attrName, attrValue)
	attrValue = checknumber(attrValue)

	if attrName == OriMatGameEnum.UnitAttrName.AddBounceCount then
		self._addBounceCount = self._addBounceCount + checknumber(attrValue)
	elseif attrName == OriMatGameEnum.UnitAttrName.BurningTimeMultiplier then
		self._burningTimeMultiplier = self._burningTimeMultiplier + checknumber(attrValue)
	elseif attrName == OriMatGameEnum.UnitAttrName.FrozenTimeMultiplier then
		self._frozenTimeMultiplier = self._frozenTimeMultiplier + checknumber(attrValue)
	elseif attrName == OriMatGameEnum.UnitAttrName.SlowDownTimeMultiplier then
		self._slowDownTimeMultiplier = self._slowDownTimeMultiplier + checknumber(attrValue)
	elseif attrName == OriMatGameEnum.UnitAttrName.AddExplosiveRate then
		self._addExplosiveRate = self._addExplosiveRate + checknumber(attrValue)
	end
end

function OriMatGameBullet:_getCurAttack()
	return self._atk or 0
end

function OriMatGameBullet:setBulletScale(scale)
	if self._containerCom then
		self._containerCom:updateScale(scale)
	end
end

return OriMatGameBullet
