-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/OriMatGameWeapon.lua

module("logic.extensions.orimatgame.model.OriMatGameWeapon", package.seeall)

local OriMatGameWeapon = class("OriMatGameWeapon", OriMatGameUnit)

function OriMatGameWeapon:ctor()
	OriMatGameWeapon.super.ctor(self)

	self._curDir = Vector2.New(0, 0)
	self._reverseArrowMap = {}
	self._curObliqueAngleInfos = {}
	self._specialGridBuffIds = {}
	self._curAttackBullets = {}

	self:reset()
end

function OriMatGameWeapon:getType()
	return OriMatGameEnum.UnitType.Weapon
end

function OriMatGameWeapon:getWeaponId()
	return self._weaponId
end

function OriMatGameWeapon:onEnable()
	OriMatGameWeapon.super.onEnable(self)

	self._isActive = true
end

function OriMatGameWeapon:setWeaponCfg(weaponCfg)
	if not weaponCfg then
		return
	end

	self._weaponCfg = weaponCfg
	self._weaponId = weaponCfg.weaponId
	self._level = weaponCfg.level or 1
	self._attackInterval = self._weaponCfg.baseAtkInterval or math.huge
	self._attackInterval = Mathf.Max(0.01, self._attackInterval)
	self._attackTimer = self:getCurAttackInterval()

	self:setRadius(weaponCfg.baseAtkRadius)

	self._baseAtk = weaponCfg.baseAtk or 1
	self._baseAtk = Mathf.Max(0, self._baseAtk)

	if not weaponCfg.buffIds then
		local buffIdStr = ""
		local buffIds = string.splitToNumber(buffIdStr, "#")

		for _, buffId in ipairs(buffIds) do
			self.addBuffByBuffId(self, buffId, self)
		end

		self._bulletId = weaponCfg.bulletId
		self._curAttackMode = weaponCfg.atkMode or OriMatGameEnum.WeaponAttackMode.FaceTarget
		self._upgradeCost = 0

		local nextLevel = self._level + 1
		local nextWeaponCfg = OriMatGameConfig.instance:getWeaponLevelCfgByWeapon(self._weaponId, nextLevel)

		if nextWeaponCfg then
			self._upgradeCost = nextWeaponCfg.upgradeCost or 0
		end

		self._maxLevel = OriMatGameConfig.instance:getWeaponMaxLevel(self._weaponId)
	end
end

function OriMatGameWeapon:updateUI()
	if self._containerCom then
		self._containerCom:updateUI()
	end
end

function OriMatGameWeapon:getWeaponCfg()
	return self._weaponCfg
end

function OriMatGameWeapon:setSpecialGridId(specialGridId)
	local specialGridCfg = OriMatGameConfig.instance:getMapBuffCfg(specialGridId)

	if specialGridCfg then
		if not specialGridCfg.weaponId then
			if specialGridCfg.weaponId ~= 0 and specialGridCfg.weaponId ~= self._weaponId then
				return
			end

			if not specialGridCfg.weaponBuffids then
				local buffIdStr = ""
				local buffIds = string.splitToNumber(buffIdStr, "#")

				for _, buffId in ipairs(buffIds) do
					self.addBuffByBuffId(self, buffId, self)
				end

				if not specialGridCfg.bulletBuffids then
					self._specialGridBuffIds = string.splitToNumber(specialGridCfg.bulletBuffids, "#")
				end
			end
		end
	end
end

function OriMatGameWeapon:getResetReturn()
	if self._weaponCfg then
		return self._weaponCfg.resetReturn or 0
	end

	return 0
end

function OriMatGameWeapon:getUpgradeCost()
	return self._upgradeCost
end

function OriMatGameWeapon:getMaxLevel()
	return self._maxLevel
end

function OriMatGameWeapon:isMaxLevel()
	return self._level >= self._maxLevel
end

function OriMatGameWeapon:beforeUpdate()
	OriMatGameWeapon.super.beforeUpdate(self)
end

function OriMatGameWeapon:update(deltaTime)
	OriMatGameWeapon.super.update(self, deltaTime)

	self._attackTimer = self._attackTimer + deltaTime

	if self._attackTimer >= self:getCurAttackInterval() then
		self:tryAttack()
	end

	if self._curAttackMode == OriMatGameEnum.WeaponAttackMode.FaceTarget then
		if self._target then
			self:faceToTarget(self._target)
		end

		local offset = self._finalRotationZ - self._locRotationZ

		if offset > 180 then
			offset = offset - 360
		end

		if math.abs(offset) >= 0.001 then
			offset = offset * 0.33333

			self:setLocRotationZ(self._locRotationZ + offset)
		end
	elseif self._curAttackMode == OriMatGameEnum.WeaponAttackMode.FixedDir then
		-- block empty
	end
end

function OriMatGameWeapon:afterUpdate()
	OriMatGameWeapon.super.afterUpdate(self)
end

function OriMatGameWeapon:reset()
	OriMatGameWeapon.super.reset(self)

	self._weaponId = 0
	self._level = 1

	table.clear(self._specialGridBuffIds)
	table.clear(self._curAttackBullets)

	self._target = nil
	self._attackInterval = math.huge
	self._attackTimer = 0
	self._weaponCfg = nil
	self._baseAtk = 0

	self._curDir:Set(0, 0)

	self._locRotationZ = 0
	self._finalRotationZ = 0

	table.clear(self._reverseArrowMap)

	self._obliqueArrowCount = 0

	table.clear(self._curObliqueAngleInfos)

	self._curAttackMode = OriMatGameEnum.WeaponAttackMode.FaceTarget
	self._attackIntervalChange = 0
	self._attackCdRateList = {}
	self._attackChange = 0
	self._attackMultiplier = 1
	self._addSkillTriggerCount = 0
	self._isBulletSizeIncreases = false
	self._attackRate = 0
end

function OriMatGameWeapon:destroy()
	OriMatGameWeapon.super.destroy(self)
end

function OriMatGameWeapon:resetTargets()
	self._target = nil
end

function OriMatGameWeapon:addTarget(unit)
	self._target = unit
end

function OriMatGameWeapon:getTarget()
	return self._target
end

function OriMatGameWeapon:tryAttack()
	local target = self:getTarget()

	if target and target._isActive then
		self:attack(target)

		self._attackTimer = 0
	end
end

function OriMatGameWeapon:onAttack(target)
	OriMatGameWeapon.super.onAttack(self, target)

	if self._curAttackMode == OriMatGameEnum.WeaponAttackMode.FaceTarget then
		if target and target._isActive then
			local dirX = target.position.x - self.position.x
			local dirY = target.position.y - self.position.y

			self._curDir:Set(dirX, dirY)

			self._curDir = Vector2.Normalize(self._curDir)

			local dirX = target.position.x - self.position.x
			local dirY = target.position.y - self.position.y
			local angle = math.atan2(dirY, dirX) * Mathf.Rad2Deg

			self._finalRotationZ = (angle - 90) % 360

			self:shootBullets()
		end
	elseif self._curAttackMode == OriMatGameEnum.WeaponAttackMode.FixedDir then
		self._curDir:Set(0, 1)

		if target and target._isActive then
			self:shootBullets()
		end
	end
end

function OriMatGameWeapon:shootBullets()
	table.clear(self._curAttackBullets)
	table.insert(self._curAttackBullets, OriMatGameGameController.instance:createBullet(self.position.x, self.position.y, self._bulletId, self._weaponId, self.id, self._curDir.x, self._curDir.y, self:getCurAttack()))

	for bulletId, count in pairs(self._reverseArrowMap) do
		for i = 1, count do
			table.insert(self._curAttackBullets, OriMatGameGameController.instance:createBullet(self.position.x, self.position.y, bulletId, self._weaponId, self.id, -self._curDir.x, -self._curDir.y, self:getCurAttack()))
		end
	end

	local obliqueCount = self._obliqueArrowCount

	if obliqueCount > 0 then
		for _, info in ipairs(self._curObliqueAngleInfos) do
			local dirX = self._curDir.x * info.dirX - self._curDir.y * info.dirY
			local dirY = self._curDir.x * info.dirY + self._curDir.y * info.dirX

			table.insert(self._curAttackBullets, OriMatGameGameController.instance:createBullet(self.position.x, self.position.y, self._bulletId, self._weaponId, self.id, dirX, dirY, self:getCurAttack()))
		end
	end

	if #self._specialGridBuffIds > 0 then
		for _, bullet in ipairs(self._curAttackBullets) do
			for _, buffId in ipairs(self._specialGridBuffIds) do
				bullet:addBuffByBuffId(buffId, self)
			end
		end
	end

	if self._isBulletSizeIncreases then
		for _, bullet in ipairs(self._curAttackBullets) do
			bullet:setBulletScale(2)
		end
	end
end

function OriMatGameWeapon:faceToTarget(target)
	if target and target._isActive then
		local dirX = target.position.x - self.position.x
		local dirY = target.position.y - self.position.y
		local angle = math.atan2(dirY, dirX) * Mathf.Rad2Deg

		self._finalRotationZ = (angle - 90) % 360
	end
end

function OriMatGameWeapon:setLocRotationZ(rotationZ)
	self._locRotationZ = rotationZ

	if self._containerCom then
		self._containerCom:updateRotationZ()
	end
end

function OriMatGameWeapon:getLocRotationZ()
	return self._locRotationZ or 0
end

function OriMatGameWeapon:addReverseArrow(count, bulletId)
	local saveBulletId = bulletId

	if saveBulletId == 0 then
		saveBulletId = self._bulletId
	end

	if not self._reverseArrowMap[saveBulletId] then
		local count = 0

		self._reverseArrowMap[saveBulletId] = count + 1
	end
end

function OriMatGameWeapon:reduceReverseArrow(count, bulletId)
	local saveBulletId = bulletId

	if saveBulletId == 0 then
		saveBulletId = self._bulletId
	end

	if not self._reverseArrowMap[saveBulletId] then
		local curCount = 0

		curCount = math.max(0, curCount - (count or 0))

		if curCount <= 0 then
			self._reverseArrowMap[saveBulletId] = nil
		else
			self._reverseArrowMap[saveBulletId] = curCount
		end
	end
end

function OriMatGameWeapon:addObliqueArrow(count)
	self._obliqueArrowCount = self._obliqueArrowCount + (count or 0)

	self:_updateObliqueAngleStep()
end

function OriMatGameWeapon:reduceObliqueArrow(count)
	self._obliqueArrowCount = math.max(0, self._obliqueArrowCount - (count or 0))

	self:_updateObliqueAngleStep()
end

function OriMatGameWeapon:_updateObliqueAngleStep()
	local curObliqueAngleStep = 90 / (self._obliqueArrowCount + 1)

	table.clear(self._curObliqueAngleInfos)

	for i = 1, self._obliqueArrowCount do
		local angle1 = i * curObliqueAngleStep
		local info = {}

		info.angle = angle1
		info.dirX = Mathf.Cos(angle1 * Mathf.Deg2Rad)
		info.dirY = Mathf.Sin(angle1 * Mathf.Deg2Rad)

		table.insert(self._curObliqueAngleInfos, info)
	end

	for i = 1, self._obliqueArrowCount do
		local angle1 = -i * curObliqueAngleStep
		local info = {}

		info.angle = angle1
		info.dirX = Mathf.Cos(angle1 * Mathf.Deg2Rad)
		info.dirY = Mathf.Sin(angle1 * Mathf.Deg2Rad)

		table.insert(self._curObliqueAngleInfos, info)
	end
end

function OriMatGameWeapon:addBulletCount(dir, count, bulletId)
	if dir == OriMatGameEnum.ArrowDirection.Back then
		self:addReverseArrow(count, bulletId)
	elseif dir == OriMatGameEnum.ArrowDirection.Oblique then
		self:addObliqueArrow(count)
	end
end

function OriMatGameWeapon:reduceBulletCount(dir, count, bulletId)
	if dir == OriMatGameEnum.ArrowDirection.Back then
		self:reduceReverseArrow(count, bulletId)
	elseif dir == OriMatGameEnum.ArrowDirection.Oblique then
		self:reduceObliqueArrow(count)
	end
end

function OriMatGameWeapon:updateAttr(attrName, attrValue)
	attrValue = checknumber(attrValue)

	if attrName == OriMatGameEnum.UnitAttrName.CD then
		self:addAttackCD(attrValue)
	elseif attrName == OriMatGameEnum.UnitAttrName.CDRate then
		self:addAttackCDRate(attrValue)
	elseif attrName == OriMatGameEnum.UnitAttrName.Attack then
		self:addAttack(attrValue)
	elseif attrName == OriMatGameEnum.UnitAttrName.AtkRate then
		self:addAttackRate(attrValue)
	elseif attrName == OriMatGameEnum.UnitAttrName.AtkMultiplier then
		self:addAttackMultiplier(attrValue)
	elseif attrName == OriMatGameEnum.UnitAttrName.SkillTriggerCount then
		self._addSkillTriggerCount = self._addSkillTriggerCount + checknumber(attrValue)
	end
end

function OriMatGameWeapon:addAttackCD(addCDTime)
	addCDTime = checknumber(addCDTime)
	self._attackIntervalChange = self._attackIntervalChange + addCDTime
end

function OriMatGameWeapon:addAttackCDRate(value)
	table.insert(self._attackCdRateList, checknumber(value))
end

function OriMatGameWeapon:getCurAttackInterval()
	local rate = 1

	for _, value in ipairs(self._attackCdRateList) do
		rate = rate * (1 + value)
	end

	return Mathf.Max(0.01, self._attackInterval * rate + self._attackIntervalChange)
end

function OriMatGameWeapon:addAttack(addAttack)
	self._attackChange = self._attackChange + checknumber(addAttack)
end

function OriMatGameWeapon:getCurAttack()
	local change = Mathf.Max(0, self._attackChange)
	local atkRate = self:getAttackRate()
	local multiplier = self:getAttackMultiplier()

	return Mathf.Max(0, self._baseAtk * (1 + atkRate) + change) * multiplier
end

function OriMatGameWeapon:getTotalCurAttack()
	return
end

function OriMatGameWeapon:addAttackMultiplier(value)
	self._attackMultiplier = self._attackMultiplier + checknumber(value)
end

function OriMatGameWeapon:getAttackMultiplier()
	return Mathf.Max(0, self._attackMultiplier)
end

function OriMatGameWeapon:addAttackRate(value)
	self._attackRate = self._attackRate + checknumber(value)
end

function OriMatGameWeapon:getAttackRate()
	return Mathf.Max(0, self._attackRate)
end

function OriMatGameWeapon:getCurAttrValue(attrName)
	if attrName == OriMatGameEnum.UnitAttrName.Attack then
		return self:getCurAttack()
	elseif attrName == OriMatGameEnum.UnitAttrName.AtkRate then
		return self:getAttackRate()
	elseif attrName == OriMatGameEnum.UnitAttrName.CD then
		return self:getCurAttackInterval()
	elseif attrName == OriMatGameEnum.UnitAttrName.AtkMultiplier then
		return self:getAttackMultiplier()
	elseif attrName == OriMatGameEnum.UnitAttrName.SkillTriggerCount then
		return self._addSkillTriggerCount or 0
	end
end

function OriMatGameWeapon:changeMode(modeName, ...)
	local params = {
		...
	}

	if modeName == OriMatGameEnum.BuffChangeMode.BulletSizeIncreases then
		self._isBulletSizeIncreases = true
	end
end

function OriMatGameWeapon:resetMode(modeName)
	if modeName == OriMatGameEnum.BuffChangeMode.BulletSizeIncreases then
		self._isBulletSizeIncreases = false
	end
end

function OriMatGameWeapon:getLevel()
	return self._level or 1
end

function OriMatGameWeapon:setLevel(level)
	self._level = checknumber(level)
end

return OriMatGameWeapon
