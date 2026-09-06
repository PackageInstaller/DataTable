-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffHard.lua

module("logicscene.scene.battle.skills.buffs.BuffHard", package.seeall)

local BuffHard = class("BuffHard", BuffBase)

function BuffHard:onBuffBegin()
	self._duration = self._unit.spine:play("hit", nil, true)
	self._time = 0

	self._unit.attrs:setHadring(true)
	BuffHard.super.onBuffBegin(self)
end

function BuffHard:onBuffEnd()
	self._unit.attrs:setHadring(false)
	BuffHard.super.onBuffEnd(self)
end

function BuffHard:update(deltaTime)
	self._time = self._time + deltaTime
end

function BuffHard:isDone()
	if not self._time then
		if not self._duration then
			local duration = 0

			return duration <= self._time
		end
	end
end

function BuffHard:getBuffId()
	return UnitCompBuffList.HardId
end

function BuffHard:isCustomBuff()
	return true
end

return BuffHard
