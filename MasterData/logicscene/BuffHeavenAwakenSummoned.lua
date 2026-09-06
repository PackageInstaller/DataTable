-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffHeavenAwakenSummoned.lua

module("logicscene.scene.battle.skills.buffs.BuffHeavenAwakenSummoned", package.seeall)

local BuffHeavenAwakenSummoned = class("BuffHeavenAwakenSummoned", BuffBase)

function BuffHeavenAwakenSummoned:onBuffBegin()
	BuffHeavenAwakenSummoned.super.onBuffBegin(self)

	self._time = 0

	self._unit.attrs:setBeingTJSummoned(true)
end

function BuffHeavenAwakenSummoned:onBuffEnd()
	BuffHeavenAwakenSummoned.super.onBuffEnd(self)
	self._unit.attrs:setBeingTJSummoned(false)
end

function BuffHeavenAwakenSummoned:update(deltaTime)
	self._time = self._time + deltaTime
end

function BuffHeavenAwakenSummoned:isDone()
	return self._time >= 1
end

function BuffHeavenAwakenSummoned:getBuffId()
	return UnitCompBuffList.HeavenAwakenSummoned
end

function BuffHeavenAwakenSummoned:isCustomBuff()
	return true
end

return BuffHeavenAwakenSummoned
