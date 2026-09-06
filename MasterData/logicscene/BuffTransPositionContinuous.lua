-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffTransPositionContinuous.lua

module("logicscene.scene.battle.skills.buffs.BuffTransPositionContinuous", package.seeall)

local BuffTransPositionContinuous = class("BuffTransPositionContinuous", BuffBase)

function BuffTransPositionContinuous:ctor(buffCo, unit, posArr)
	self.posArr = posArr
	self._maxPosIdx = #self.posArr

	BuffTransPositionContinuous.super.ctor(self, buffCo, unit)
end

function BuffTransPositionContinuous:onBuffBegin()
	BuffTransPositionContinuous.super.onBuffBegin(self)

	self._isDone = false
	self._curPosIdx = 0
	self._delayTimeCount = 0

	self:playNextPosAnim()
end

function BuffTransPositionContinuous:playNextPosAnim()
	local posIdx = self._curPosIdx + 1

	if posIdx > self._maxPosIdx then
		self._isDone = true

		return
	end

	self._curPosIdx = posIdx

	local newX = self.posArr[posIdx][1]
	local newY = self.posArr[posIdx][2]
	local teamId = self._unit.teamId
	local dirTeamId = BattleModel.instance:getTeamDirection(teamId)
	local pos = BattleConfig.instance:getFormationPos(dirTeamId + 1, newY * 3 + newX + 1)

	self._unit.attrs:setBirthPoint(pos[1], pos[2], pos[3])

	self._unit.posRow = newX + 1
	self._unit.x = newX
	self._unit.y = newY

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

function BuffTransPositionContinuous:update(deltaTime)
	if self._isDone then
		return
	end

	if self._delayTimeCount > 0 then
		self._delayTimeCount = self._delayTimeCount - deltaTime

		return
	end

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

	if self._timeCount >= self._duration then
		self:playNextPosAnim()

		self._delayTimeCount = 0.5
	end
end

function BuffTransPositionContinuous:onBuffEnd()
	self._unit.attrs:setTransPosition(false)
	BuffTransPositionContinuous.super.onBuffEnd(self)
end

function BuffTransPositionContinuous:isDone()
	return self._isDone
end

function BuffTransPositionContinuous:getBuffId()
	return UnitCompBuffList.TransPosition
end

function BuffTransPositionContinuous:isCustomBuff()
	return true
end

return BuffTransPositionContinuous
