-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffTransPosition.lua

module("logicscene.scene.battle.skills.buffs.BuffTransPosition", package.seeall)

local BuffTransPosition = class("BuffTransPosition", BuffBase)

function BuffTransPosition:ctor(buffCo, unit, newX, newY)
	self.newX = newX
	self.newY = newY

	BuffTransPosition.super.ctor(self, buffCo, unit)
end

function BuffTransPosition:onBuffBegin()
	BuffTransPosition.super.onBuffBegin(self)

	local teamId = self._unit.teamId
	local dirTeamId = BattleModel.instance:getTeamDirection(teamId)
	local pos = BattleConfig.instance:getFormationPos(dirTeamId + 1, self.newY * 3 + self.newX + 1)

	self._unit.attrs:setBirthPoint(pos[1], pos[2], pos[3])

	self._unit.posRow = self.newX + 1
	self._unit.x = self.newX
	self._unit.y = self.newY

	self._unit:updateSortingOrder()

	local sx, sy, sz = self._unit.transform:getPos()

	self._startX = sx
	self._startY = sy
	self._startZ = sz
	self._deltaX = pos[1] - sx
	self._deltaY = pos[2] - sy
	self._deltaZ = pos[3] - sz
	self._timeCount = 0
	self._duration = 0.3333333333333333

	self._unit.attrs:setTransPosition(true)
end

function BuffTransPosition:update(deltaTime)
	self._timeCount = deltaTime + self._timeCount

	local percent = self._timeCount / self._duration

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

	self._unit.transform:setPos(posX, posY, posZ)
end

function BuffTransPosition:onBuffEnd()
	self._unit.attrs:setTransPosition(false)
	BuffTransPosition.super.onBuffEnd(self)
end

function BuffTransPosition:isDone()
	return self._timeCount >= self._duration
end

function BuffTransPosition:getBuffId()
	return UnitCompBuffList.TransPosition
end

function BuffTransPosition:isCustomBuff()
	return true
end

return BuffTransPosition
