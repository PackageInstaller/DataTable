-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/OriMatGameUnit.lua

module("logic.extensions.orimatgame.model.OriMatGameUnit", package.seeall)

local OriMatGameUnit = class("OriMatGameUnit")

function OriMatGameUnit:ctor()
	self.position = {
		x = 0,
		y = 0
	}
	self.rect = SimpleQuadTree.createRect(0, 0, 0, 0)
	self.id = 0
	self.radius = 0
	self.buffList = {}
	self._statusMap = {}
	self._isActive = true
	self._containerCom = nil
end

function OriMatGameUnit:setCom(containerCom)
	self._containerCom = containerCom

	if self._containerCom then
		self._containerCom:setUnit(self)
	end
end

function OriMatGameUnit:isActive()
	return self._isActive
end

function OriMatGameUnit:getUnitId()
	return self.id
end

function OriMatGameUnit:setUnitId(id)
	self.id = id
end

function OriMatGameUnit:getName()
	return string.format("%s_%d", self:getType(), self.id)
end

function OriMatGameUnit:getType()
	return
end

function OriMatGameUnit:setRadius(radius)
	self.radius = checknumber(radius)
	self.rect.w = 2 * self.radius
	self.rect.h = 2 * self.radius

	self:updatePosition(self.position.x, self.position.y)

	self._radiusPow = self.radius * self.radius
end

function OriMatGameUnit:getRadius()
	return self.radius
end

function OriMatGameUnit:getRadiusPow()
	return self._radiusPow
end

function OriMatGameUnit:updatePosition(x, y)
	self.position.x = checknumber(x)
	self.position.y = checknumber(y)
	self.rect.x = self.position.x - self.radius
	self.rect.y = self.position.y - self.radius

	if self._containerCom then
		self._containerCom:updatePosition(self.position.x, self.position.y)
	end
end

function OriMatGameUnit:getContainer()
	if self._containerCom then
		return self._containerCom:getContainer()
	end

	return nil
end

function OriMatGameUnit:getDistancePowTo(other)
	if not other then
		return math.huge
	end

	local dx = self.position.x - other.position.x
	local dy = self.position.y - other.position.y

	return dx * dx + dy * dy
end

function OriMatGameUnit:initParam(param)
	return
end

function OriMatGameUnit:onEnable()
	return
end

function OriMatGameUnit:beforeUpdate()
	return
end

function OriMatGameUnit:update(deltaTime)
	OriMatGameBuffMgr.instance:onUpdate(self, deltaTime)
end

function OriMatGameUnit:afterUpdate()
	return
end

function OriMatGameUnit:preReCycle()
	self._isActive = false
end

function OriMatGameUnit:beOutOfBounds()
	self._isActive = false
end

function OriMatGameUnit:reset()
	for k, v in pairs(self.buffList) do
		OriMatGameBuffMgr.instance:disposeBuff(v)

		self.buffList[k] = nil
	end

	self:updatePosition(0, 0)
	self:setRadius(0)

	self.id = 0

	if self._containerCom then
		OriMatGameGameController.instance:destroyUnitCom(self._containerCom)
	end

	self._containerCom = nil

	table.clear(self._statusMap)
end

function OriMatGameUnit:destroy()
	self:reset()
end

function OriMatGameUnit:attack(target)
	self:onAttack(target)
end

function OriMatGameUnit:onAttack(target)
	OriMatGameBuffMgr.instance:onAttack(self, target)
end

function OriMatGameUnit:hit(target)
	self:onHit(target)
end

function OriMatGameUnit:onHit(target)
	OriMatGameBuffMgr.instance:onHit(self, target)
end

function OriMatGameUnit:beHit(target)
	self:onBeHit(target)
end

function OriMatGameUnit:onBeHit(target)
	OriMatGameBuffMgr.instance:onBeHit(self, target)
end

function OriMatGameUnit:beforeDoDamage(target)
	self:onBeforeDoDamage(target)
end

function OriMatGameUnit:onBeforeDoDamage(target)
	OriMatGameBuffMgr.instance:onBeforeBeDamage(self, target)
end

function OriMatGameUnit:afterDoDamage(target, damValue)
	self:onAfterDoDamage(target, damValue)
end

function OriMatGameUnit:onAfterDoDamage(target, damValue)
	OriMatGameBuffMgr.instance:onAfterBeDamage(self, target, damValue)
end

function OriMatGameUnit:beDamage(unit, damValue)
	self:onBeforeBeDamage(unit, damValue)
	self:onBeDamage(unit, damValue)
	self:onAfterBeDamage(unit, damValue)
end

function OriMatGameUnit:onBeforeBeDamage(target, damValue)
	OriMatGameBuffMgr.instance:onBeforeBeDamage(self, target, damValue)
end

function OriMatGameUnit:onBeDamage(target, damValue)
	return
end

function OriMatGameUnit:onAfterBeDamage(target, damValue)
	OriMatGameBuffMgr.instance:onAfterBeDamage(self, target, damValue)
end

function OriMatGameUnit:addBuffByBuffId(buffId, target)
	OriMatGameBuffMgr.instance:addBuffToUnitByBuffId(self, buffId)
	OriMatGameBuffMgr.instance:onAdd(self, target)
end

function OriMatGameUnit:addBuff(buff, target)
	if not buff then
		return
	end

	OriMatGameBuffMgr.instance:onAdd(self, target)
end

function OriMatGameUnit:removeBuff(buff)
	if not buff then
		return
	end

	buff:onRemove(self)
	OriMatGameBuffMgr.instance:disposeBuff(buff)
	table.removebyvalue(self.buffList, buff)
end

function OriMatGameUnit:addNewStatus(statusName)
	self._statusMap[statusName] = checknumber(self._statusMap[statusName]) + 1

	GlobalDispatcher:dispatch(GlobalNotify.AQAFUnitStatusChange, self.id)
end

function OriMatGameUnit:removeStatus(statusName)
	self._statusMap[statusName] = checknumber(self._statusMap[statusName]) - 1

	if checknumber(self._statusMap[statusName]) <= 0 then
		self._statusMap[statusName] = nil

		GlobalDispatcher:dispatch(GlobalNotify.AQAFUnitStatusChange, self.id)
	end
end

function OriMatGameUnit:checkHasStatus(statusName)
	return checknumber(self._statusMap[statusName]) > 0
end

function OriMatGameUnit:addBulletCount(dir, count, bulletId)
	return
end

function OriMatGameUnit:reduceBulletCount(dir, count, bulletId)
	return
end

function OriMatGameUnit:setPenetrate(isPenetrate)
	return
end

function OriMatGameUnit:changeMode(modeName, ...)
	return
end

function OriMatGameUnit:resetMode(modeName)
	return
end

function OriMatGameUnit:setDirection(dirX, dirY)
	return
end

function OriMatGameUnit:getCurAttrValue(attrName)
	return
end

function OriMatGameUnit:updateAttr(attrName, attrValue)
	return
end

return OriMatGameUnit
