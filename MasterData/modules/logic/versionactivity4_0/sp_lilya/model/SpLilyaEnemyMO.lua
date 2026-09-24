-- chunkname: @modules/logic/versionactivity4_0/sp_lilya/model/SpLilyaEnemyMO.lua

module("modules.logic.versionactivity4_0.sp_lilya.model.SpLilyaEnemyMO", package.seeall)

local SpLilyaEnemyMO = class("SpLilyaEnemyMO", SpLilyaSceneBaseMo)
local _uid = 0

function SpLilyaEnemyMO:ctor()
	self:reset()
end

function SpLilyaEnemyMO:reset()
	SpLilyaEnemyMO.super.reset(self)

	self.groupId = nil
	self.monsterId = nil
	self.waveId = nil
	self.waveTime = nil
	self.life = nil
	self.curLife = nil
	self.atk = nil
	self.type = nil
	self.speed = nil
	self.res = nil
	self._moveType = nil
	self._waypoints = nil
	self._curWaypointIndex = nil
	self._stayTime = nil
	self._moveFinish = false
	self.state = nil
	self.stateTime = 0
	self._isHit = false
	self.collisionOffsetX = 0
	self.collisionOffsetY = 0
	self.collisionRadiusX = nil
	self.collisionRadiusY = nil
end

function SpLilyaEnemyMO:init(co, halfWidth, halfHeight)
	self:reset()

	_uid = _uid + 1
	self.uid = _uid
	self.id = co.id
	self.monster = co.monster
	self.group = co.group
	self.waveId = co.group
	self.waveTime = co.waveTime

	local pos = string.splitToNumber(co.pos, "#")

	self:setPos(SpLilyaHelper.ConvertOriginPos(pos[1], pos[2], halfWidth, halfHeight))

	self.life = co.life
	self.curLife = co.life
	self.radius = co.radius or 0
	self.collisionRadiusX = self.radius
	self.collisionRadiusY = self.radius
	self.atk = co.atk
	self.type = co.type
	self.speed = co.speed
	self.res = co.res
	self.move = co.move

	self:_parseMoveRoute(co.move, halfWidth, halfHeight)
end

function SpLilyaEnemyMO:setCollisionEllipse(offsetX, offsetY, radiusX, radiusY)
	self.collisionOffsetX = offsetX or 0
	self.collisionOffsetY = offsetY or 0

	local var_4_0

	if not radiusX then
		::label_4_0::

		var_4_0 = self.radius or 0
	end

	self.collisionRadiusX = math.max(var_4_0, 1)

	local var_4_1

	if not radiusY then
		::label_4_1::

		var_4_1 = self.radius or 0
	end

	self.collisionRadiusY = math.max(var_4_1, 1)
end

function SpLilyaEnemyMO:_parseMoveRoute(moveStr, halfWidth, halfHeight)
	self._waypoints = nil

	if string.nilorempty(moveStr) then
		self._moveType = SpLilyaEnum.EnemyMoveType.UniformVelocity

		return
	end

	self._moveType = SpLilyaEnum.EnemyMoveType.Point
	self._waypoints = {}

	local pointList = string.split(moveStr, "|")

	for i = 1, #pointList do
		local point = string.splitToNumber(pointList[i], "#")

		if #point >= 3 then
			local x, y = SpLilyaHelper.ConvertOriginPos(point[1], point[2], halfWidth, halfHeight)

			self._waypoints[i] = {
				x = x,
				y = y,
				stayTime = point[3]
			}
		end
	end

	self._curWaypointIndex = 1
	self._stayTime = nil
	self._moveFinish = false
end

function SpLilyaEnemyMO:changeLife(damage)
	if damage <= 0 then
		return true
	end

	if not self:isHittable() then
		return true
	end

	self.curLife = self.curLife - damage
	self._isHit = true

	logNormal(string.format("[SpLilya] enemy hit uid=%s damage=%s curLife=%s life=%s", self.uid, damage, self.curLife, self.life))

	return self.curLife > 0
end

function SpLilyaEnemyMO:isDead()
	return self.curLife ~= nil and self.curLife <= 0
end

function SpLilyaEnemyMO:isStateLocked()
	return self.state == SpLilyaEnum.EnemyState.Enter or self.state == SpLilyaEnum.EnemyState.Die
end

function SpLilyaEnemyMO:changeState(state)
	if self:isStateLocked() then
		return false
	end

	if self.state == state then
		self.stateTime = 0

		return false
	end

	self.state = state
	self.stateTime = 0

	return true
end

function SpLilyaEnemyMO:isStateExpired()
	local duration = SpLilyaEnum.EnemyStateDuration[self.state]
	local var_10_1

	if duration ~= nil then
		if duration > (self.stateTime or 0) then
			var_10_1 = false

			goto label_10_0
		end
	end

	::label_10_0::

	return true
end

function SpLilyaEnemyMO:isHittable()
	return not self:isDead() and not self:isStateLocked()
end

function SpLilyaEnemyMO:isMoving()
	return self.type ~= SpLilyaEnum.EnemyType.Static and not self._moveFinish and not self:isStateLocked()
end

function SpLilyaEnemyMO:isMoveFinish()
	if self._moveFinish then
		return true
	end

	if self._moveType == SpLilyaEnum.EnemyMoveType.UniformVelocity or self._moveType == SpLilyaEnum.EnemyMoveType.Point then
		local gameMO = SpLilyaGameModel.instance:getGameMO()
		local endPosX = gameMO and gameMO.enemyEndPosX

		if endPosX and self.posX ~= nil then
			local dirX = SpLilyaEnum.EnemyMoveDirection.Horizontal

			if dirX < 0 and endPosX >= self.posX or dirX > 0 and endPosX <= self.posX then
				self._moveFinish = true
			end
		end
	end

	return self._moveFinish
end

function SpLilyaEnemyMO:updateMove(deltaTime)
	if not self:isMoving() then
		return false
	end

	if self._moveType == SpLilyaEnum.EnemyMoveType.UniformVelocity then
		if not self.speed then
			do
				local speed = 0

				self:setPos(self.posX + SpLilyaEnum.EnemyMoveDirection.Horizontal * speed * deltaTime, self.posY + SpLilyaEnum.EnemyMoveDirection.Vertical * speed * deltaTime)

				return true
			end

			if self._stayTime and self._stayTime > 0 then
				self._stayTime = self._stayTime - deltaTime

				return false
			end

			local waypoint = self._waypoints[self._curWaypointIndex]

			if not waypoint then
				self._moveFinish = true

				return false
			end

			local dx = waypoint.x - self.posX
			local dy = waypoint.y - self.posY
			local dist = math.sqrt(dx * dx + dy * dy)
			local step = self.speed * deltaTime

			if dist <= step then
				self:setPos(waypoint.x, waypoint.y)

				self._curWaypointIndex = self._curWaypointIndex + 1
				self._stayTime = waypoint.stayTime or 0

				if self._stayTime <= 0 and not self._waypoints[self._curWaypointIndex] then
					self._moveFinish = true
				end
			else
				self:setPos(self.posX + dx / dist * step, self.posY + dy / dist * step)
			end

			return true
		end
	end
end

return SpLilyaEnemyMO
