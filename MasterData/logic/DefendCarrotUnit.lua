-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/DefendCarrotUnit.lua

module("logic.extensions.defendcarrot.model.DefendCarrotUnit", package.seeall)

local DefendCarrotUnit = class("DefendCarrotUnit")

function DefendCarrotUnit:ctor()
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

function DefendCarrotUnit:setCom(containerCom)
	self._containerCom = containerCom

	if self._containerCom then
		self._containerCom:setUnit(self)
	end
end

function DefendCarrotUnit:isActive()
	return self._isActive
end

function DefendCarrotUnit:getUnitId()
	return self.id
end

function DefendCarrotUnit:setUnitId(id)
	self.id = id
end

function DefendCarrotUnit:getName()
	return string.format("%s_%d", self:getType(), self.id)
end

function DefendCarrotUnit:getType()
	return
end

function DefendCarrotUnit:setRadius(radius)
	self.radius = checknumber(radius)
	self.rect.w = 2 * self.radius
	self.rect.h = 2 * self.radius

	self:updatePosition(self.position.x, self.position.y)

	self._radiusPow = self.radius * self.radius
end

function DefendCarrotUnit:getRadius()
	return self.radius
end

function DefendCarrotUnit:getRadiusPow()
	return self._radiusPow
end

function DefendCarrotUnit:updatePosition(x, y)
	self.position.x = checknumber(x)
	self.position.y = checknumber(y)
	self.rect.x = self.position.x - self.radius
	self.rect.y = self.position.y - self.radius

	if self._containerCom then
		self._containerCom:updatePosition(self.position.x, self.position.y)
	end
end

function DefendCarrotUnit:getContainer()
	if self._containerCom then
		return self._containerCom:getContainer()
	end

	return nil
end

function DefendCarrotUnit:getDistancePowTo(other)
	if not other then
		return math.huge
	end

	local dx = self.position.x - other.position.x
	local dy = self.position.y - other.position.y

	return dx * dx + dy * dy
end

function DefendCarrotUnit:initParam(param)
	return
end

function DefendCarrotUnit:onEnable()
	return
end

function DefendCarrotUnit:beforeUpdate()
	return
end

function DefendCarrotUnit:update(deltaTime)
	DefendCarrotBuffMgr.instance:onUpdate(self, deltaTime)
end

function DefendCarrotUnit:afterUpdate()
	return
end

function DefendCarrotUnit:preReCycle()
	self._isActive = false
end

function DefendCarrotUnit:beOutOfBounds()
	self._isActive = false
end

function DefendCarrotUnit:reset()
	for k, v in pairs(self.buffList) do
		DefendCarrotBuffMgr.instance:disposeBuff(v)

		self.buffList[k] = nil
	end

	self:updatePosition(0, 0)
	self:setRadius(0)

	self.id = 0

	if self._containerCom then
		DefendCarrotGameController.instance:destroyUnitCom(self._containerCom)
	end

	self._containerCom = nil

	table.clear(self._statusMap)
end

function DefendCarrotUnit:destroy()
	self:reset()
end

function DefendCarrotUnit:attack(target)
	self:onAttack(target)
end

function DefendCarrotUnit:onAttack(target)
	DefendCarrotBuffMgr.instance:onAttack(self, target)
end

function DefendCarrotUnit:hit(target)
	self:onHit(target)
end

function DefendCarrotUnit:onHit(target)
	DefendCarrotBuffMgr.instance:onHit(self, target)
end

function DefendCarrotUnit:beHit(target)
	self:onBeHit(target)
end

function DefendCarrotUnit:onBeHit(target)
	DefendCarrotBuffMgr.instance:onBeHit(self, target)
end

function DefendCarrotUnit:beforeDoDamage(target)
	self:onBeforeDoDamage(target)
end

function DefendCarrotUnit:onBeforeDoDamage(target)
	DefendCarrotBuffMgr.instance:onBeforeBeDamage(self, target)
end

function DefendCarrotUnit:afterDoDamage(target, damValue)
	self:onAfterDoDamage(target, damValue)
end

function DefendCarrotUnit:onAfterDoDamage(target, damValue)
	DefendCarrotBuffMgr.instance:onAfterBeDamage(self, target, damValue)
end

function DefendCarrotUnit:beDamage(unit, damValue)
	self:onBeforeBeDamage(unit, damValue)
	self:onBeDamage(unit, damValue)
	self:onAfterBeDamage(unit, damValue)
end

function DefendCarrotUnit:onBeforeBeDamage(target, damValue)
	DefendCarrotBuffMgr.instance:onBeforeBeDamage(self, target, damValue)
end

function DefendCarrotUnit:onBeDamage(target, damValue)
	return
end

function DefendCarrotUnit:onAfterBeDamage(target, damValue)
	DefendCarrotBuffMgr.instance:onAfterBeDamage(self, target, damValue)
end

function DefendCarrotUnit:addBuffByBuffId(buffId, target)
	DefendCarrotBuffMgr.instance:addBuffToUnitByBuffId(self, buffId)
	DefendCarrotBuffMgr.instance:onAdd(self, target)
end

function DefendCarrotUnit:addBuff(buff, target)
	if not buff then
		return
	end

	DefendCarrotBuffMgr.instance:onAdd(self, target)
end

function DefendCarrotUnit:removeBuff(buff)
	if not buff then
		return
	end

	buff:onRemove(self)
	DefendCarrotBuffMgr.instance:disposeBuff(buff)
	table.removebyvalue(self.buffList, buff)
end

function DefendCarrotUnit:addNewStatus(statusName)
	self._statusMap[statusName] = checknumber(self._statusMap[statusName]) + 1

	GlobalDispatcher:dispatch(GlobalNotify.AQAFUnitStatusChange, self.id)
end

function DefendCarrotUnit:removeStatus(statusName)
	self._statusMap[statusName] = checknumber(self._statusMap[statusName]) - 1

	if checknumber(self._statusMap[statusName]) <= 0 then
		self._statusMap[statusName] = nil

		GlobalDispatcher:dispatch(GlobalNotify.AQAFUnitStatusChange, self.id)
	end
end

function DefendCarrotUnit:checkHasStatus(statusName)
	return checknumber(self._statusMap[statusName]) > 0
end

function DefendCarrotUnit:addBulletCount(dir, count, bulletId)
	return
end

function DefendCarrotUnit:reduceBulletCount(dir, count, bulletId)
	return
end

function DefendCarrotUnit:setPenetrate(isPenetrate)
	return
end

function DefendCarrotUnit:changeMode(modeName, ...)
	return
end

function DefendCarrotUnit:resetMode(modeName)
	return
end

function DefendCarrotUnit:setDirection(dirX, dirY)
	return
end

function DefendCarrotUnit:getCurAttrValue(attrName)
	return
end

function DefendCarrotUnit:updateAttr(attrName, attrValue)
	return
end

return DefendCarrotUnit
