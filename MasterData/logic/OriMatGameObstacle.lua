-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/OriMatGameObstacle.lua

module("logic.extensions.orimatgame.model.OriMatGameObstacle", package.seeall)

local OriMatGameObstacle = class("OriMatGameObstacle", OriMatGameUnit)
local ObstacleRadius = 40

function OriMatGameObstacle:ctor()
	OriMatGameObstacle.super.ctor(self)
	self:reset()
end

function OriMatGameObstacle:getType()
	return OriMatGameEnum.UnitType.Obstacle
end

function OriMatGameObstacle:beforeUpdate()
	OriMatGameObstacle.super.beforeUpdate(self)
end

function OriMatGameObstacle:update(deltaTime)
	OriMatGameObstacle.super.update(self, deltaTime)
end

function OriMatGameObstacle:afterUpdate()
	OriMatGameObstacle.super.afterUpdate(self)
end

function OriMatGameObstacle:reset()
	OriMatGameObstacle.super.reset(self)

	self._obstacleCfg = nil
	self._curHp = 0
	self._HPMax = 0
	self._killCoin = 0
	self._curRow = 0
	self._curCol = 0
end

function OriMatGameObstacle:destroy()
	OriMatGameObstacle.super.destroy(self)
end

function OriMatGameObstacle:onEnable()
	OriMatGameObstacle.super.onEnable(self)

	self._isActive = self._curHp > 0
end

function OriMatGameObstacle:beDamage(unit, damValue)
	if not self._isActive then
		return
	end

	OriMatGameObstacle.super.beDamage(self, unit, damValue)

	self._curHp = self._curHp - damValue
	self._curHp = math.max(self._curHp, 0)

	if self._containerCom then
		self._containerCom:beDamage(damValue)
	end

	if self._curHp <= 0 then
		self:beKill(unit)
	end
end

function OriMatGameObstacle:beKill(unit)
	if not self._isActive then
		return
	end

	OriMatGameGameController.instance:onObstacleKillByBullet(self, unit)

	if self._containerCom then
		-- block empty
	end

	self._isActive = false
end

function OriMatGameObstacle:getCurHp()
	return self._curHp
end

function OriMatGameObstacle:getHpMax()
	return self._HPMax
end

function OriMatGameObstacle:setObstacleCfg(cfg)
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

function OriMatGameObstacle:getKillCoin()
	return self._killCoin
end

function OriMatGameObstacle:getObstacleCfg()
	return self._obstacleCfg
end

function OriMatGameObstacle:getCurRowCol()
	return self._curRow, self._curCol
end

function OriMatGameObstacle:setCurRowCol(row, col)
	self._curRow = row or 0
	self._curCol = col or 0
end

function OriMatGameObstacle:updateFireUI(id)
	if self._containerCom and self._containerCom.updateFireUI then
		self._containerCom:updateFireUI(id)
	end
end

return OriMatGameObstacle
