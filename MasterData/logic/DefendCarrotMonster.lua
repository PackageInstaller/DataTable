-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/DefendCarrotMonster.lua

module("logic.extensions.defendcarrot.model.DefendCarrotMonster", package.seeall)

local DefendCarrotMonster = class("DefendCarrotMonster", DefendCarrotUnit)

function DefendCarrotMonster:ctor()
	DefendCarrotMonster.super.ctor(self)
	self:reset()
end

function DefendCarrotMonster:getType()
	return DefendCarrotEnum.UnitType.Monster
end

function DefendCarrotMonster:beforeUpdate()
	DefendCarrotMonster.super.beforeUpdate(self)
end

function DefendCarrotMonster:update(deltaTime)
	DefendCarrotMonster.super.update(self, deltaTime)

	self._lastPosX = self.position.x

	self:_move(deltaTime)

	if self.position.x >= self._lastPosX then
		if not self._isDirRight then
			self._isDirRight = true

			if self._containerCom then
				self._containerCom:updateDirection(true)
			end
		end
	elseif self._isDirRight then
		self._isDirRight = false

		if self._containerCom then
			self._containerCom:updateDirection(false)
		end
	end
end

function DefendCarrotMonster:afterUpdate()
	DefendCarrotMonster.super.afterUpdate(self)
end

function DefendCarrotMonster:reset()
	DefendCarrotMonster.super.reset(self)

	self._defineId = 0
	self._bornGrid = nil
	self._monsterCfg = nil
	self._curHp = 0
	self._HPMax = 0
	self._speed = 0
	self._movePath = {}
	self._nextNodeId = 0
	self._lastPosX = 0
	self._isDirRight = true
	self._moveRatePercent = 1
end

function DefendCarrotMonster:destroy()
	DefendCarrotMonster.super.destroy(self)
end

function DefendCarrotMonster:initParam(cfg, bornGrid, movePath)
	DefendCarrotMonster.super.initParam(self, cfg)

	if cfg then
		self._monsterCfg = cfg
		self._bornGrid = bornGrid
		self._movePath = movePath
	end

	if self._monsterCfg then
		self._HPMax = self._monsterCfg.Hp or 0
		self._speed = self._monsterCfg.speed or 0

		self:setRadius(self._monsterCfg.radius)
	end

	self._curHp = self._HPMax
	self._isActive = self._curHp > 0
end

local ExtrDistance = 2

function DefendCarrotMonster:_move(deltaTime)
	if not self._isActive then
		return
	end

	if not self._movePath or #self._movePath == 0 then
		return
	end

	if self:checkHasStatus(DefendCarrotEnum.StatusType.Frozen) then
		return
	end

	if self._nextNodeId < #self._movePath then
		local nextNode = self._movePath[self._nextNodeId + 1]
		local curDistance = Mathf.Abs(nextNode.x - self.position.x) + Mathf.Abs(nextNode.y - self.position.y)

		if curDistance < ExtrDistance then
			self:updatePosition(nextNode.x, nextNode.y)

			self._nextNodeId = self._nextNodeId + 1
		end

		local newNextNode = self._movePath[self._nextNodeId + 1]

		if newNextNode then
			local moveDis = self:getCurSpeed() * deltaTime
			local newDistance = Mathf.Abs(newNextNode.x - self.position.x) + Mathf.Abs(newNextNode.y - self.position.y)

			if newDistance < ExtrDistance then
				-- block empty
			elseif newDistance < moveDis then
				self:updatePosition(newNextNode.x, newNextNode.y)
			else
				local newPosx = self.position.x
				local moveX = Mathf.Min(moveDis, Mathf.Abs(newNextNode.x - self.position.x))

				newPosx = newNextNode.x > self.position.x and self.position.x + moveX or self.position.x - moveX
				moveDis = moveDis - moveX

				local moveY = Mathf.Min(moveDis, Mathf.Abs(newNextNode.y - self.position.y))

				self:updatePosition(newPosx, newNextNode.y > self.position.y and self.position.y + moveY or self.position.y - moveY)
			end
		end
	end
end

function DefendCarrotMonster:isArriveEnd()
	if not self._isActive then
		return
	end

	if not self._movePath or #self._movePath == 0 then
		return false
	end

	if self._nextNodeId >= #self._movePath then
		return true
	end
end

function DefendCarrotMonster:beDamage(unit, damValue)
	if not self._isActive then
		return
	end

	DefendCarrotMonster.super.beDamage(self, unit, damValue)

	self._curHp = self._curHp - damValue
	self._curHp = math.max(self._curHp, 0)

	if self._containerCom then
		self._containerCom:beDamage(damValue)
		GlobalDispatcher:dispatch(GlobalNotify.DefendCarrotShowAlertTxt, -Mathf.Ceil(damValue), self.position.x, self.position.y + 50)
	end

	if self._curHp <= 0 then
		self:beKill(unit)
	end
end

function DefendCarrotMonster:getCurHp()
	return self._curHp
end

function DefendCarrotMonster:getHpMax()
	return self._HPMax
end

function DefendCarrotMonster:beKill(unit)
	if not self._isActive then
		return
	end

	DefendCarrotGameController.instance:onMonsterKillByBullet(self, unit)

	if self._containerCom then
		-- block empty
	end

	self:preReCycle()
end

function DefendCarrotMonster:getMonsterCfg()
	return self._monsterCfg
end

function DefendCarrotMonster:getKillCoin()
	if self._monsterCfg then
		return self._monsterCfg.killCoin or 0
	end

	return 0
end

function DefendCarrotMonster:updateFireUI(id)
	if self._containerCom and self._containerCom.updateFireUI then
		self._containerCom:updateFireUI(id)
	end
end

function DefendCarrotMonster:updateAttr(attrName, attrValue)
	attrValue = checknumber(attrValue)

	if attrName == DefendCarrotEnum.UnitAttrName.MoveRate then
		self:addMoveRate(attrValue)
	end
end

function DefendCarrotMonster:addMoveRate(percent)
	percent = checknumber(percent)
	self._moveRatePercent = math.max(self._moveRatePercent + percent, 0)
end

function DefendCarrotMonster:getCurSpeed()
	return self._speed * self._moveRatePercent
end

function DefendCarrotMonster:addNewStatus(statusName)
	DefendCarrotMonster.super.addNewStatus(self, statusName)

	if self._containerCom then
		self._containerCom:updateStatus()
	end
end

function DefendCarrotMonster:removeStatus(statusName)
	DefendCarrotMonster.super.removeStatus(self, statusName)

	if self._containerCom then
		self._containerCom:updateStatus()
	end
end

return DefendCarrotMonster
