-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffBlock.lua

module("logicscene.scene.battle.skills.buffs.BuffBlock", package.seeall)

local BuffBlock = class("BuffBlock", BuffBase)

function BuffBlock:onBuffBegin()
	self._duration = 0
	self._time = 0

	self._unit.attrs:setBlocking(true)
	self._unit.unitUI:onBlock()
	BuffBlock.super.onBuffBegin(self)
end

function BuffBlock:onBuffEnd()
	self._unit.attrs:setBlocking(false)
	BuffBlock.super.onBuffEnd(self)
end

function BuffBlock:update(deltaTime)
	self._time = self._time + deltaTime
end

function BuffBlock:isDone()
	return self._time >= self._duration
end

function BuffBlock:getBuffId()
	return UnitCompBuffList.BlockId
end

function BuffBlock:isCustomBuff()
	return true
end

return BuffBlock
