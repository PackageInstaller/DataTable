-- chunkname: @modules/logic/versionactivity3_3/igor/model/IgorBaseEntityMO.lua

module("modules.logic.versionactivity3_3.igor.model.IgorBaseEntityMO", package.seeall)

local IgorBaseEntityMO = class("IgorBaseEntityMO")

function IgorBaseEntityMO:initEntity(id, SoldierType, campType)
	self.entityId = id
	self.type = SoldierType
	self.campType = campType
	self.config = self:getConfig()
	self.posX = 0
	self.exDamage = 0
	self.health = self.config.health
	self.healthBaseMax = self.health
	self.unitId = nil
	self.gameMo = nil
	self.createTime = 1

	self:setAttackSpeed(self.config.attackSpeed)

	self.windupDeltaTime = 0
	self.attackDeltaTime = 0
	self.state = IgorEnum.EntityState.Idle
	self.target = nil
	self.tempState = nil
	self.dir = self.campType == IgorEnum.CampType.Ourside and 1 or -1

	self:onInit()
end

function IgorBaseEntityMO:onInit()
	return
end

function IgorBaseEntityMO:getConfig()
	logError("IgorBaseEntityMO:getConfig() not implemented")
end

function IgorBaseEntityMO:setParam(unitId, gameMo)
	self.unitId = unitId
	self.gameMo = gameMo
end

function IgorBaseEntityMO:initPos(posX, posY)
	self.posX = posX or 0
	self.posY = posY or 0
end

function IgorBaseEntityMO:getAttackRange()
	return self.config.attackRange
end

function IgorBaseEntityMO:getSpeed()
	return self.config.speed
end

function IgorBaseEntityMO:setAttackSpeed(speed)
	speed = speed or 0
	self.attackSpeed = speed

	if speed > 0 then
		self.cachedAttackInterval = 1 / speed or 0
	end

	self.cachedWindupTime = self.cachedAttackInterval * 2
end

function IgorBaseEntityMO:addExDamage(val)
	self.exDamage = self.exDamage + val
end

function IgorBaseEntityMO:getDamage()
	return self.config.damage + self.exDamage
end

function IgorBaseEntityMO:getDamageCounter(targetType)
	return 1000
end

function IgorBaseEntityMO:getHealth()
	return self.health
end

function IgorBaseEntityMO:getMaxHealth()
	return self.healthBaseMax
end

function IgorBaseEntityMO:getPos()
	return self.posX, self.posY
end

function IgorBaseEntityMO:isCreated()
	return self.createTime <= 0
end

function IgorBaseEntityMO:isLived()
	local health = self:getHealth()

	return health > 0
end

function IgorBaseEntityMO:isDead()
	local health = self:getHealth()

	return health <= 0
end

function IgorBaseEntityMO:update(deltaTime)
	self:setTempState(IgorEnum.EntityState.Idle)

	if not self:isLived() then
		self:setTempState(IgorEnum.EntityState.Die)

		return
	end

	if not self:isCreated() then
		self.createTime = self.createTime - deltaTime

		self:setTempState(IgorEnum.EntityState.In)

		return
	end

	if self:tryAttack(deltaTime) then
		return
	end

	self:move(deltaTime)
end

function IgorBaseEntityMO:tryAttack(deltaTime)
	if not self:isTargetCanAttack(self.target) then
		self.target = self:findAttackTarget()
		self.windupDeltaTime = self.cachedWindupTime
	end

	if self.target then
		if self.windupDeltaTime > 0 then
			self.windupDeltaTime = self.windupDeltaTime - deltaTime
		end

		if self.attackDeltaTime > 0 then
			self.attackDeltaTime = self.attackDeltaTime - deltaTime
		end

		if self:isWindupComplete() and self:isInAttackTime() then
			self.attackDeltaTime = self.cachedAttackInterval

			self:attack(self.target)
			self:setTempState(IgorEnum.EntityState.Attack)
		else
			self:setTempState(IgorEnum.EntityState.WaitAttack)
		end
	end

	return self.target ~= nil
end

function IgorBaseEntityMO:findAttackTarget()
	local list, count = self.gameMo:getOtherCampEntityList(self.campType)

	if not list or count <= 0 then
		return
	end

	local startIndex = self.campType == IgorEnum.CampType.Ourside and 1 or count
	local endIndex = self.campType == IgorEnum.CampType.Ourside and count or 1
	local step = self.campType == IgorEnum.CampType.Ourside and 1 or -1

	for i = startIndex, endIndex, step do
		local target = list[i]

		if self:isTargetCanAttack(target) then
			return target
		end
	end
end

function IgorBaseEntityMO:isWindupComplete()
	return self.windupDeltaTime <= 0
end

function IgorBaseEntityMO:isInAttackTime()
	return self.attackDeltaTime <= 0
end

function IgorBaseEntityMO:isTargetCanAttack(target)
	if not target or not target:isLived() or not target:isCreated() then
		return false
	end

	local attackRange = self:getAttackRange()
	local posX = self:getPos()
	local targetPosX = target:getPos()
	local distance = (targetPosX - posX) * self.dir

	return distance >= 0 and distance <= attackRange
end

function IgorBaseEntityMO:attack(target)
	local damage = self:getDamage()
	local damageCounter = self:getDamageCounter(target.type)
	local lastDamage = damage * damageCounter * 0.001

	if lastDamage <= 0 then
		return
	end

	target:attacked(lastDamage)
end

function IgorBaseEntityMO:attacked(damage)
	self.health = self.health - damage

	IgorController.instance:dispatchEvent(IgorEvent.OnEntityHpChange, self)

	if self.health <= 0 then
		self:dead()
	end
end

function IgorBaseEntityMO:move(deltaTime)
	local speed = self:getSpeed()

	self.posX = self.posX + speed * deltaTime * self.dir

	self:setTempState(IgorEnum.EntityState.Move)
end

function IgorBaseEntityMO:dead()
	self.gameMo:delEntity(self)
end

function IgorBaseEntityMO:addHealthAndMaxHealth(addHealth, addMaxHealth)
	addHealth = addHealth or 0
	addMaxHealth = addMaxHealth or 0

	local lastHealth = self.health

	self.healthBaseMax = self.healthBaseMax + addMaxHealth
	self.health = math.min(lastHealth + addMaxHealth, self.healthBaseMax)

	IgorController.instance:dispatchEvent(IgorEvent.OnEntityHpChange, self)
end

function IgorBaseEntityMO:setTempState(state)
	self.tempState = state
end

function IgorBaseEntityMO:updateState()
	self.isStateChange = self.state ~= self.tempState

	if not self.isStateChange then
		return
	end

	self.state = self.tempState
end

function IgorBaseEntityMO:getIsStateChange()
	return self.isStateChange
end

function IgorBaseEntityMO:getCurState()
	return self.state
end

function IgorBaseEntityMO:getEntityName()
	self._debugName = self._debugName or string.format("%s%s%s", compName, self.config.name or "大本营", self.unitId)

	return self._debugName
end

return IgorBaseEntityMO
