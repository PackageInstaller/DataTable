-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/DefendCarrotWeapon.lua

module("logic.extensions.defendcarrot.model.DefendCarrotWeapon", package.seeall)

local DefendCarrotWeapon = class("DefendCarrotWeapon", DefendCarrotUnit)

function DefendCarrotWeapon:ctor()
	DefendCarrotWeapon.super.ctor(self)

	self._curDir = Vector2.New(0, 0)
	self._reverseArrowMap = {}
	self._curObliqueAngleInfos = {}
	self._specialGridBuffIds = {}
	self._curAttackBullets = {}

	self:reset()
end

function DefendCarrotWeapon:getType()
	return DefendCarrotEnum.UnitType.Weapon
end

function DefendCarrotWeapon:getWeaponId()
	return self._weaponId
end

function DefendCarrotWeapon:onEnable()
	DefendCarrotWeapon.super.onEnable(self)

	self._isActive = true
end

function DefendCarrotWeapon:setWeaponCfg(weaponCfg)
	if not weaponCfg then
		return
	end

	self._weaponCfg = weaponCfg
	self._weaponId = weaponCfg.weaponId
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
		self._curAttackMode = weaponCfg.atkMode or DefendCarrotEnum.WeaponAttackMode.FaceTarget
	end
end

function DefendCarrotWeapon:getWeaponCfg()
	return self._weaponCfg
end

function DefendCarrotWeapon:setSpecialGridId(specialGridId)
	local specialGridCfg = DefendCarrotConfig.instance:getMapBuffCfg(specialGridId)

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

function DefendCarrotWeapon:getResetReturn()
	if self._weaponCfg then
		return self._weaponCfg.resetReturn or 0
	end

	return 0
end

function DefendCarrotWeapon:beforeUpdate()
	DefendCarrotWeapon.super.beforeUpdate(self)
end

function DefendCarrotWeapon:update(deltaTime)
	DefendCarrotWeapon.super.update(self, deltaTime)

	self._attackTimer = self._attackTimer + deltaTime

	if self._attackTimer >= self:getCurAttackInterval() then
		self:tryAttack()
	end

	if self._curAttackMode == DefendCarrotEnum.WeaponAttackMode.FaceTarget then
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
	elseif self._curAttackMode == DefendCarrotEnum.WeaponAttackMode.FixedDir then
		-- block empty
	end
end

function DefendCarrotWeapon:afterUpdate()
	DefendCarrotWeapon.super.afterUpdate(self)
end

function DefendCarrotWeapon:reset()
	DefendCarrotWeapon.super.reset(self)

	self._weaponId = 0

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

	self._curAttackMode = DefendCarrotEnum.WeaponAttackMode.FaceTarget
	self._attackIntervalChange = 0
	self._attackChange = 0
	self._attackMultiplier = 1
	self._addSkillTriggerCount = 0
	self._isBulletSizeIncreases = false
end

function DefendCarrotWeapon:destroy()
	DefendCarrotWeapon.super.destroy(self)
end

function DefendCarrotWeapon:resetTargets()
	self._target = nil
end

function DefendCarrotWeapon:addTarget(unit)
	self._target = unit
end

function DefendCarrotWeapon:getTarget()
	return self._target
end

function DefendCarrotWeapon:tryAttack()
	local target = self:getTarget()

	if target and target._isActive then
		self:attack(target)

		self._attackTimer = 0
	end
end

function DefendCarrotWeapon:onAttack(target)
	DefendCarrotWeapon.super.onAttack(self, target)

	if self._curAttackMode == DefendCarrotEnum.WeaponAttackMode.FaceTarget then
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
	elseif self._curAttackMode == DefendCarrotEnum.WeaponAttackMode.FixedDir then
		self._curDir:Set(0, 1)

		if target and target._isActive then
			self:shootBullets()
		end
	end
end

function DefendCarrotWeapon:shootBullets()
	table.clear(self._curAttackBullets)
	table.insert(self._curAttackBullets, DefendCarrotGameController.instance:createBullet(self.position.x, self.position.y, self._bulletId, self._weaponId, self.id, self._curDir.x, self._curDir.y, self:getCurAttack()))

	for bulletId, count in pairs(self._reverseArrowMap) do
		for i = 1, count do
			table.insert(self._curAttackBullets, DefendCarrotGameController.instance:createBullet(self.position.x, self.position.y, bulletId, self._weaponId, self.id, -self._curDir.x, -self._curDir.y, self:getCurAttack()))
		end
	end

	local obliqueCount = self._obliqueArrowCount

	if obliqueCount > 0 then
		for _, info in ipairs(self._curObliqueAngleInfos) do
			local dirX = self._curDir.x * info.dirX - self._curDir.y * info.dirY
			local dirY = self._curDir.x * info.dirY + self._curDir.y * info.dirX

			table.insert(self._curAttackBullets, DefendCarrotGameController.instance:createBullet(self.position.x, self.position.y, self._bulletId, self._weaponId, self.id, dirX, dirY, self:getCurAttack()))
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

function DefendCarrotWeapon:faceToTarget(target)
	if target and target._isActive then
		local dirX = target.position.x - self.position.x
		local dirY = target.position.y - self.position.y
		local angle = math.atan2(dirY, dirX) * Mathf.Rad2Deg

		self._finalRotationZ = (angle - 90) % 360
	end
end

function DefendCarrotWeapon:setLocRotationZ(rotationZ)
	self._locRotationZ = rotationZ

	if self._containerCom then
		self._containerCom:updateRotationZ()
	end
end

function DefendCarrotWeapon:getLocRotationZ()
	return self._locRotationZ or 0
end

function DefendCarrotWeapon:addReverseArrow(count, bulletId)
	local saveBulletId = bulletId

	if saveBulletId == 0 then
		saveBulletId = self._bulletId
	end

	if not self._reverseArrowMap[saveBulletId] then
		local count = 0

		self._reverseArrowMap[saveBulletId] = count + 1
	end
end

function DefendCarrotWeapon:reduceReverseArrow(count, bulletId)
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

function DefendCarrotWeapon:addObliqueArrow(count)
	self._obliqueArrowCount = self._obliqueArrowCount + (count or 0)

	self:_updateObliqueAngleStep()
end

function DefendCarrotWeapon:reduceObliqueArrow(count)
	self._obliqueArrowCount = math.max(0, self._obliqueArrowCount - (count or 0))

	self:_updateObliqueAngleStep()
end

function DefendCarrotWeapon:_updateObliqueAngleStep()
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

function DefendCarrotWeapon:addBulletCount(dir, count, bulletId)
	if dir == DefendCarrotEnum.ArrowDirection.Back then
		self:addReverseArrow(count, bulletId)
	elseif dir == DefendCarrotEnum.ArrowDirection.Oblique then
		self:addObliqueArrow(count)
	end
end

function DefendCarrotWeapon:reduceBulletCount(dir, count, bulletId)
	if dir == DefendCarrotEnum.ArrowDirection.Back then
		self:reduceReverseArrow(count, bulletId)
	elseif dir == DefendCarrotEnum.ArrowDirection.Oblique then
		self:reduceObliqueArrow(count)
	end
end

function DefendCarrotWeapon:updateAttr(attrName, attrValue)
	attrValue = checknumber(attrValue)

	if attrName == DefendCarrotEnum.UnitAttrName.CD then
		self:addAttackCD(attrValue)
	elseif attrName == DefendCarrotEnum.UnitAttrName.Attack then
		self:addAttack(attrValue)
	elseif attrName == DefendCarrotEnum.UnitAttrName.AtkMultiplier then
		self:addAttackMultiplier(attrValue)
	elseif attrName == DefendCarrotEnum.UnitAttrName.SkillTriggerCount then
		self._addSkillTriggerCount = self._addSkillTriggerCount + checknumber(attrValue)
	end
end

function DefendCarrotWeapon:addAttackCD(addCDTime)
	addCDTime = checknumber(addCDTime)
	self._attackIntervalChange = self._attackIntervalChange + addCDTime
end

function DefendCarrotWeapon:getCurAttackInterval()
	return Mathf.Max(0.01, self._attackInterval + self._attackIntervalChange)
end

function DefendCarrotWeapon:addAttack(addAttack)
	addAttack = checknumber(addAttack)
	self._attackChange = self._attackChange + addAttack
end

function DefendCarrotWeapon:getCurAttack()
	return Mathf.Max(0, (self._baseAtk + self._attackChange) * self._attackMultiplier)
end

function DefendCarrotWeapon:addAttackMultiplier(multiplier)
	multiplier = checknumber(multiplier)
	self._attackMultiplier = self._attackMultiplier + multiplier
	self._attackMultiplier = Mathf.Max(0, self._attackMultiplier)
end

function DefendCarrotWeapon:getCurAttrValue(attrName)
	if attrName == DefendCarrotEnum.UnitAttrName.Attack then
		return self:getCurAttack()
	elseif attrName == DefendCarrotEnum.UnitAttrName.CD then
		return self:getCurAttackInterval()
	elseif attrName == DefendCarrotEnum.UnitAttrName.AtkMultiplier then
		return self._attackMultiplier or 0
	elseif attrName == DefendCarrotEnum.UnitAttrName.SkillTriggerCount then
		return self._addSkillTriggerCount or 0
	end
end

function DefendCarrotWeapon:changeMode(modeName, ...)
	local params = {
		...
	}

	if modeName == DefendCarrotEnum.BuffChangeMode.BulletSizeIncreases then
		self._isBulletSizeIncreases = true
	end
end

function DefendCarrotWeapon:resetMode(modeName)
	if modeName == DefendCarrotEnum.BuffChangeMode.BulletSizeIncreases then
		self._isBulletSizeIncreases = false
	end
end

return DefendCarrotWeapon
