-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffRepeling.lua

module("logicscene.scene.battle.skills.buffs.BuffRepeling", package.seeall)

local BuffRepeling = class("BuffRepeling", BuffBase)
local repelDefaultSpeed = 100

function BuffRepeling:ctor(buffCo, unit, playHit)
	BuffRepeling.super.ctor(self, buffCo, unit)

	self._repelDirX = 0
	self._repelDirY = 0
	self._repelDirZ = 0
	self._repelDist = 0
	self._repelSpd = 100
	self._repelTime = 0
	self._duration = 0
	self._startX = 0
	self._startY = 0
	self._startZ = 0
	self._deltaX = 0
	self._deltaY = 0
	self._deltaZ = 0
	self.hitFly = nil

	if playHit == nil then
		playHit = true
	end

	self.playHit = playHit
end

function BuffRepeling:onBuffBegin()
	self._unit.attrs:setRepeling(true)
	self:_calculate()

	if self._unit.attrs:isHitflying() then
		self.hitFly = self._unit.buffList:getBuff(UnitCompBuffList.HitFlyId)
	end

	BuffRepeling.super.onBuffBegin(self)
end

function BuffRepeling:onBuffEnd()
	self._unit.attrs:setRepeling(false)
	BuffRepeling.super.onBuffEnd(self)
end

function BuffRepeling:update(deltaTime)
	self._time = self._time + deltaTime

	local percent = self._time / self._repelTime

	if percent < 0 then
		percent = 0
	end

	if percent > 1 then
		percent = 1
	end

	percent = math.sin(percent * math.pi * 0.5)

	local posX = self._startX + self._deltaX * percent
	local posY = self._startY + self._deltaY * percent
	local posZ = self._startZ + self._deltaZ * percent

	if self.hitFly then
		local posYFL = self.hitFly:getPosY()

		if posYFL then
			posY = posYFL
		end
	end

	Framework.TransformUtil.SetPos(self._unit.go.transform, posX, posY, posZ)
end

function BuffRepeling:setRepelDir(dx, dy, dz)
	dy = 0
	dx, dy, dz = GameUtil.normalize(dx, 0, dz)
	self._repelDirX = dx
	self._repelDirY = dy
	self._repelDirZ = dz
end

function BuffRepeling:setRepelSpd(spd)
	self._repelSpd = spd

	if self._repelSpd == 0 then
		self._repelSpd = repelDefaultSpeed
	end
end

function BuffRepeling:setRepelDist(dist)
	self._repelDist = dist
end

function BuffRepeling:_calculate()
	self._time = 0
	self._repelTime = self._repelDist / self._repelSpd

	local hitTime = 0

	if self.playHit then
		hitTime = self._unit.spine:play("hit")
	end

	self._duration = hitTime <= 0 and self._repelTime + 0.3 or math.max(self._repelTime, hitTime)

	local posX, posY, posZ = Framework.TransformUtil.GetPos(self._unit.go.transform, nil, nil, nil)
	local dist = self._repelTime * self._repelSpd

	self._startX = posX
	self._startY = posY
	self._startZ = posZ
	self._deltaX = self._repelDirX * dist
	self._deltaY = self._repelDirY * dist
	self._deltaZ = self._repelDirZ * dist
end

function BuffRepeling:isDone()
	return self._time >= self._duration
end

function BuffRepeling:getBuffId()
	return UnitCompBuffList.RepelingId
end

function BuffRepeling:isCustomBuff()
	return true
end

return BuffRepeling
