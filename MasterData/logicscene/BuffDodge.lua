-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffDodge.lua

module("logicscene.scene.battle.skills.buffs.BuffDodge", package.seeall)

local BuffDodge = class("BuffDodge", BuffBase)

function BuffDodge:onBuffBegin()
	self._duration = 0
	self._time = 0

	self._unit.attrs:setDodging(true)
	self._unit.unitUI:onDodge()
	BuffDodge.super.onBuffBegin(self)
end

function BuffDodge:onBuffEnd()
	self._unit.attrs:setDodging(false)
	BuffDodge.super.onBuffEnd(self)
end

function BuffDodge:update(deltaTime)
	self._time = self._time + deltaTime
end

function BuffDodge:isDone()
	return self._time >= self._duration
end

function BuffDodge:getBuffId()
	return UnitCompBuffList.DodgeId
end

function BuffDodge:isCustomBuff()
	return true
end

return BuffDodge
