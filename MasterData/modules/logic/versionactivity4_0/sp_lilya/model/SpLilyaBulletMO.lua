-- chunkname: @modules/logic/versionactivity4_0/sp_lilya/model/SpLilyaBulletMO.lua

module("modules.logic.versionactivity4_0.sp_lilya.model.SpLilyaBulletMO", package.seeall)

local SpLilyaBulletMO = class("SpLilyaBulletMO", SpLilyaSceneBaseMo)

function SpLilyaBulletMO:ctor()
	self:reset()
end

function SpLilyaBulletMO:reset()
	SpLilyaBulletMO.super.reset(self)

	self.damage = 0
	self.energy = 0
	self.type = 0
	self.dirX = 0
	self.dirY = 0
	self.speed = 0
	self.trajectorySpeed = 0
	self.explodeRadius = 0
	self.targetUid = nil
	self._speedX = 0
	self._speedY = 0
	self._trajectorySpeedX = 0
	self._trajectorySpeedY = 0
	self._trajectoryElapsed = 0
	self._originX = 0
	self._originY = 0
	self.dying = false
	self.dyingElapsedTime = 0
end

function SpLilyaBulletMO:init(posX, posY, dirX, dirY, trajectorySpeed, damage, energy, radius, explodeRadius, type, uid, moveSpeed)
	self:reset()

	self.uid = uid

	self:setPos(posX, posY)

	self.dirX = dirX
	self.dirY = dirY
	self.speed = moveSpeed or trajectorySpeed
	self.trajectorySpeed = trajectorySpeed
	self.damage = damage
	self.energy = energy or 0
	self.radius = radius or 0
	self.explodeRadius = explodeRadius or 0
	self.type = type
	self._originX = posX
	self._originY = posY
	self._speedX = dirX * self.speed
	self._speedY = dirY * self.speed
	self._trajectorySpeedX = dirX * trajectorySpeed
	self._trajectorySpeedY = dirY * trajectorySpeed

	self:setRotationZ(math.deg(math.atan2(dirY, dirX)))
end

function SpLilyaBulletMO:getLandPos()
	local g = SpLilyaEnum.DefaultGravity
	local gameMO = SpLilyaGameModel.instance:getGameMO()
	local sceneMo = gameMO and gameMO.sceneMo

	if sceneMo then
		if not sceneMo.groundHeight then
			local landY = 0
			local vy = self._trajectorySpeedY
			local t = (vy + math.sqrt(math.max(vy * vy + 2 * g * (self._originY - landY), 0))) / g

			return self._originX + self._trajectorySpeedX * t, landY
		end
	end
end

function SpLilyaBulletMO:_getTrackTarget()
	local gameMO = SpLilyaGameModel.instance:getGameMO()
	local sceneMo = gameMO and gameMO.sceneMo

	if not sceneMo then
		return nil
	end

	if self.targetUid then
		local target = sceneMo.useMoDic[self.targetUid]

		if target and target:isHittable() then
			return target
		end

		if self.type == SpLilyaEnum.BulletType.Energy then
			return self:_findNearestTrackTarget(sceneMo)
		end

		return nil
	end
end

function SpLilyaBulletMO:_findNearestTrackTarget(sceneMo)
	local nearestTarget, nearestDistSq

	for _, enemyMo in pairs(sceneMo.useMoDic) do
		if enemyMo and enemyMo:isHittable() then
			local dx = enemyMo.posX - self.posX
			local dy = enemyMo.posY - self.posY
			local distSq = dx * dx + dy * dy

			if not nearestDistSq or distSq < nearestDistSq or distSq == nearestDistSq and enemyMo.uid < nearestTarget.uid then
				nearestTarget = enemyMo
				nearestDistSq = distSq
			end
		end
	end

	if nearestTarget then
		self.targetUid = nearestTarget.uid
	end

	return nearestTarget
end

function SpLilyaBulletMO:_trackMove(target, deltaTime, angularSpeed)
	local dx = target.posX - self.posX
	local dy = target.posY - self.posY
	local speed = math.sqrt(self._speedX * self._speedX + self._speedY * self._speedY)

	if speed <= 0 or dx == 0 and dy == 0 then
		return
	end

	local curAngle = math.atan2(self._speedY, self._speedX)
	local targetAngle = math.atan2(dy, dx)
	local deltaAngle = targetAngle - curAngle

	while deltaAngle > math.pi do
		deltaAngle = deltaAngle - 2 * math.pi
	end

	while deltaAngle < -math.pi do
		deltaAngle = deltaAngle + 2 * math.pi
	end

	local maxTurn = math.rad(angularSpeed or SpLilyaEnum.BulletTrackAngularSpeed) * deltaTime

	if maxTurn < deltaAngle then
		deltaAngle = maxTurn
	elseif deltaAngle < -maxTurn then
		deltaAngle = -maxTurn
	end

	local newAngle = curAngle + deltaAngle

	self._speedX = math.cos(newAngle) * speed
	self._speedY = math.sin(newAngle) * speed

	self:setPos(self.posX + self._speedX * deltaTime, self.posY + self._speedY * deltaTime)
end

function SpLilyaBulletMO:updateMove(deltaTime)
	if self.type == SpLilyaEnum.BulletType.Gravity then
		local target = self:_getTrackTarget()

		if target then
			self:_trackMove(target, deltaTime)

			local gameMO = SpLilyaGameModel.instance:getGameMO()
			local sceneMo = gameMO and gameMO.sceneMo

			if sceneMo then
				if not sceneMo.groundHeight then
					local landY = 0

					if landY >= self.posY then
						self:setPos(self.posX, landY)
					end
				end
			end
		else
			local g = SpLilyaEnum.DefaultGravity
			local trajectoryY = self._trajectorySpeedY - g * self._trajectoryElapsed
			local tangentSpeed = math.sqrt(self._trajectorySpeedX * self._trajectorySpeedX + trajectoryY * trajectoryY)
			local moveDistance = self.speed * deltaTime

			if tangentSpeed > 0 then
				if not (moveDistance / tangentSpeed) then
					local trajectoryDelta = 0

					self._trajectoryElapsed = self._trajectoryElapsed + trajectoryDelta

					local landX, landY = self:getLandPos()

					if self._trajectorySpeedX ~= 0 then
						if not ((landX - self._originX) / self._trajectorySpeedX) then
							local maxTime = self._trajectoryElapsed

							self._trajectoryElapsed = math.min(self._trajectoryElapsed, maxTime)

							local t = self._trajectoryElapsed
							local tangentY = self._trajectorySpeedY - g * t
							local tangentLength = math.sqrt(self._trajectorySpeedX * self._trajectorySpeedX + tangentY * tangentY)

							if tangentLength > 0 then
								self._speedX = self._trajectorySpeedX / tangentLength * self.speed
								self._speedY = tangentY / tangentLength * self.speed
							end

							self:setPos(self._originX + self._trajectorySpeedX * t, self._originY + self._trajectorySpeedY * t - 0.5 * g * t * t)

							if maxTime <= t then
								self:setPos(self.posX, landY)
							end
						end
					end
				end
			end
		end
	elseif self.type == SpLilyaEnum.BulletType.Energy then
		local target = self:_getTrackTarget()

		if target then
			self:_trackMove(target, deltaTime, SpLilyaEnum.EnergyBulletTrackAngularSpeed)
		else
			self:setPos(self.posX + self._speedX * deltaTime, self.posY + self._speedY * deltaTime)
		end
	else
		self:setPos(self.posX + self.dirX * self.speed * deltaTime, self.posY + self.dirY * self.speed * deltaTime)
	end

	if self._speedX ~= 0 or self._speedY ~= 0 then
		self:setRotationZ(math.deg(math.atan2(self._speedY, self._speedX)))
	end

	return true
end

function SpLilyaBulletMO:isGrounded()
	if self.type ~= SpLilyaEnum.BulletType.Gravity and self.type ~= SpLilyaEnum.BulletType.Energy then
		return false
	end

	local gameMO = SpLilyaGameModel.instance:getGameMO()

	if self.type == SpLilyaEnum.BulletType.Energy and gameMO and gameMO.isGravity == SpLilyaEnum.UseGravity.Unuse then
		return false
	end

	local sceneMo = gameMO and gameMO.sceneMo

	return self.posY <= ((sceneMo or nil) and (sceneMo.groundHeight or 0))
end

function SpLilyaBulletMO:isConsume()
	if self:isGrounded() then
		return true
	end

	local gameMO = SpLilyaGameModel.instance:getGameMO()
	local sceneMo = gameMO and gameMO.sceneMo

	if sceneMo then
		if (sceneMo.bulletBoundaryPosX or 0) < math.abs(self.posX) then
			return true
		end
	end

	return self.posY < -((sceneMo or nil) and (sceneMo.bulletBoundaryPosY or 0))
end

return SpLilyaBulletMO
