-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffBackBirthPoint.lua

module("logicscene.scene.battle.skills.buffs.BuffBackBirthPoint", package.seeall)

local BuffBackBirthPoint = class("BuffBackBirthPoint", BuffBase)

function BuffBackBirthPoint:ctor(buffCo, unit, speed)
	BuffBackBirthPoint.super.ctor(self, buffCo, unit)

	local birthX, birthY, birthZ = unit.attrs:getBirthPoint()

	self._birthX = birthX
	self._birthY = birthY
	self._birthZ = birthZ
	self._speed = speed or 0
	self._spineMover = nil
	self._isFinish = nil
end

function BuffBackBirthPoint:onBuffBegin()
	self._unit.attrs:setBacking(true)

	self._bounds = {}

	if self._speed == 0 then
		self._speed = 100
	end

	self._timeCount = 0
	self._spineMover = self._unit.spineMover

	BuffBackBirthPoint.super.onBuffBegin(self)
end

function BuffBackBirthPoint:onBuffEnd()
	self._unit.attrs:setBacking(false)

	self._bounds = nil
	self._timeCount = nil

	if self._unit.battleFlow:isIdle(self._unit) then
		self._spineMover:playIdleAnim()

		local rightTeamId = BattleModel.instance:getTeamDirection(self._unit.teamId)

		if rightTeamId == GameEnum.BattleTeam.Right then
			self._unit.spine:setDirection(UnitSpineDir.Left)
		else
			self._unit.spine:setDirection(UnitSpineDir.Right)
		end
	end

	BuffBackBirthPoint.super.onBuffEnd(self)
end

function BuffBackBirthPoint:update(deltaTime)
	if self._unit.battleFlow:isMoveable(self._unit) then
		self._timeCount = self._timeCount or 0
		self._timeCount = self._timeCount + deltaTime

		local posX, posY, posZ = Framework.TransformUtil.GetPos(self._unit.go.transform, nil, nil, nil)
		local dx = self._birthX - posX
		local dy = self._birthY - posY
		local dz = self._birthZ - posZ

		dx, dy, dz = GameUtil.normalize(dx, dy, dz)

		if not dx or not dy or not dz then
			self._isFinish = true

			return
		end

		local dist = self._speed * deltaTime
		local nextX = posX + dx * dist
		local nextY = posY + dy * dist
		local nextZ = posZ + dz * dist

		GameUtil.getBounds(posX, posY, posZ, self._birthX, self._birthY, self._birthZ, self._bounds)

		if self._timeCount >= 3 or nextX == self._birthX and nextY == self._birthY and nextZ == self._birthZ or not GameUtil.isBoundsContains(self._bounds, nextX, nextY, nextZ) then
			Framework.TransformUtil.SetPos(self._unit.go.transform, self._birthX, self._birthY, self._birthZ)

			self._isFinish = true
		else
			Framework.TransformUtil.SetPos(self._unit.go.transform, nextX, nextY, nextZ)
		end

		self._spineMover:playWalkAnim(dx, dy, dz)
	end
end

function BuffBackBirthPoint:isDone()
	return self._isFinish
end

function BuffBackBirthPoint:getBuffId()
	return UnitCompBuffList.BackId
end

function BuffBackBirthPoint:isCustomBuff()
	return true
end

return BuffBackBirthPoint
