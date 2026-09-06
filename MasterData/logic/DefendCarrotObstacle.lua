-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/DefendCarrotObstacle.lua

module("logic.extensions.defendcarrot.model.DefendCarrotObstacle", package.seeall)

local DefendCarrotObstacle = class("DefendCarrotObstacle", DefendCarrotUnit)
local ObstacleRadius = 40

function DefendCarrotObstacle:ctor()
	DefendCarrotObstacle.super.ctor(self)
	self:reset()
end

function DefendCarrotObstacle:getType()
	return DefendCarrotEnum.UnitType.Obstacle
end

function DefendCarrotObstacle:beforeUpdate()
	DefendCarrotObstacle.super.beforeUpdate(self)
end

function DefendCarrotObstacle:update(deltaTime)
	DefendCarrotObstacle.super.update(self, deltaTime)
end

function DefendCarrotObstacle:afterUpdate()
	DefendCarrotObstacle.super.afterUpdate(self)
end

function DefendCarrotObstacle:reset()
	DefendCarrotObstacle.super.reset(self)

	self._obstacleCfg = nil
	self._curHp = 0
	self._HPMax = 0
	self._killCoin = 0
	self._curRow = 0
	self._curCol = 0
end

function DefendCarrotObstacle:destroy()
	DefendCarrotObstacle.super.destroy(self)
end

function DefendCarrotObstacle:onEnable()
	DefendCarrotObstacle.super.onEnable(self)

	self._isActive = self._curHp > 0
end

function DefendCarrotObstacle:beDamage(unit, damValue)
	if not self._isActive then
		return
	end

	DefendCarrotObstacle.super.beDamage(self, unit, damValue)

	self._curHp = self._curHp - damValue
	self._curHp = math.max(self._curHp, 0)

	if self._containerCom then
		self._containerCom:beDamage(damValue)
	end

	if self._curHp <= 0 then
		self:beKill(unit)
	end
end

function DefendCarrotObstacle:beKill(unit)
	if not self._isActive then
		return
	end

	DefendCarrotGameController.instance:onObstacleKillByBullet(self, unit)

	if self._containerCom then
		-- block empty
	end

	self._isActive = false
end

function DefendCarrotObstacle:getCurHp()
	return self._curHp
end

function DefendCarrotObstacle:getHpMax()
	return self._HPMax
end

function DefendCarrotObstacle:setObstacleCfg(cfg)
	self._obstacleCfg = cfg

	if self._obstacleCfg then
		local paramstr = self._obstacleCfg.params
		local params = string.split(paramstr, "#")

		if params and #params > 0 then
			self._HPMax = checknumber(params[1])
			self._killCoin = checknumber(params[2])
		end

		self._curHp = self._HPMax
	end

	self:setRadius(ObstacleRadius)
end

function DefendCarrotObstacle:getKillCoin()
	return self._killCoin
end

function DefendCarrotObstacle:getObstacleCfg()
	return self._obstacleCfg
end

function DefendCarrotObstacle:getCurRowCol()
	return self._curRow, self._curCol
end

function DefendCarrotObstacle:setCurRowCol(row, col)
	self._curRow = row or 0
	self._curCol = col or 0
end

function DefendCarrotObstacle:updateFireUI(id)
	if self._containerCom and self._containerCom.updateFireUI then
		self._containerCom:updateFireUI(id)
	end
end

return DefendCarrotObstacle
