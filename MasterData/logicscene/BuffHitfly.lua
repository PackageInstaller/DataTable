-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffHitfly.lua

module("logicscene.scene.battle.skills.buffs.BuffHitfly", package.seeall)

local BuffHitfly = class("BuffHitfly", BuffBase)
local gravity = 180

function BuffHitfly:ctor(buffCo, unit, height)
	BuffHitfly.super.ctor(self, buffCo, unit)

	self._hitFlySpeed = 0
	self._startY = 999999
	self._posY = nil

	self:setHeight(height)
end

function BuffHitfly:setHeight(height)
	self._height = height

	local speed = math.sqrt(2 * gravity * self._height)

	if speed > self._hitFlySpeed then
		self._hitFlySpeed = speed
	end

	local _, posY, _ = Framework.TransformUtil.GetPos(self._unit.go.transform, nil, nil, nil)

	if posY < self._startY then
		self._startY = posY
	end
end

function BuffHitfly:getPosY()
	return self._posY
end

function BuffHitfly:onBuffBegin()
	self._unit.attrs:setHitflying(true)

	local buffRepeling = self._unit.buffList:getBuff(UnitCompBuffList.RepelingId)

	if buffRepeling then
		buffRepeling.hitFly = self
	end

	BuffHitfly.super.onBuffBegin(self)
end

function BuffHitfly:onBuffEnd()
	local buffRepeling = self._unit.buffList:getBuff(UnitCompBuffList.RepelingId)

	if buffRepeling then
		buffRepeling.hitFly = nil
	end

	self._unit.attrs:setHitflying(false)
	BuffHitfly.super.onBuffEnd(self)
end

function BuffHitfly:update(deltaTime)
	self._hitFlySpeed = self._hitFlySpeed - deltaTime * gravity

	local posX, posY, posZ = Framework.TransformUtil.GetPos(self._unit.go.transform, nil, nil, nil)

	posY = posY + self._hitFlySpeed * deltaTime

	if posY < self._startY then
		posY = self._startY
		self._isFinish = true
	end

	self._posY = posY

	Framework.TransformUtil.SetPos(self._unit.go.transform, posX, posY, posZ)
end

function BuffHitfly:isDone()
	return self._isFinish
end

function BuffHitfly:isCustomBuff()
	return true
end

return BuffHitfly
