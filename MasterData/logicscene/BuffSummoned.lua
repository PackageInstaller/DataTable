-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffSummoned.lua

module("logicscene.scene.battle.skills.buffs.BuffSummoned", package.seeall)

local BuffSummoned = class("BuffSummoned", BuffBase)

function BuffSummoned:onBuffBegin()
	BuffSummoned.super.onBuffBegin(self)

	self._time = 0

	self._unit.attrs:setBeingSummoned(true)
end

function BuffSummoned:onBuffEnd()
	BuffSummoned.super.onBuffEnd(self)
	self._unit.attrs:setBeingSummoned(false)
end

function BuffSummoned:update(deltaTime)
	self._time = self._time + deltaTime
end

function BuffSummoned:isDone()
	return self._time >= 1
end

function BuffSummoned:getBuffId()
	return UnitCompBuffList.Summoned
end

function BuffSummoned:isCustomBuff()
	return true
end

return BuffSummoned
