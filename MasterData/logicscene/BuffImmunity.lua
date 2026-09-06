-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffImmunity.lua

module("logicscene.scene.battle.skills.buffs.BuffImmunity", package.seeall)

local BuffImmunity = class("BuffImmunity", BuffBase)

function BuffImmunity:onBuffBegin()
	self._duration = 0
	self._time = 0

	self._unit.attrs:setImmunity(true)
	self._unit.unitUI:onImmunity()
	BuffImmunity.super.onBuffBegin(self)
end

function BuffImmunity:onBuffEnd()
	self._unit.attrs:setImmunity(false)
	BuffImmunity.super.onBuffEnd(self)
end

function BuffImmunity:update(deltaTime)
	self._time = self._time + deltaTime
end

function BuffImmunity:isDone()
	return self._time >= self._duration
end

function BuffImmunity:getBuffId()
	return UnitCompBuffList.ImmunityId
end

function BuffImmunity:isCustomBuff()
	return true
end

return BuffImmunity
