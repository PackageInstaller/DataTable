-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffStrickBack.lua

module("logicscene.scene.battle.skills.buffs.BuffStrickBack", package.seeall)

local BuffStrickBack = class("BuffStrickBack", BuffBase)

function BuffStrickBack:onBuffBegin()
	self._duration = 0
	self._time = 0

	self._unit.unitUI:onStrickBack()
	BuffStrickBack.super.onBuffBegin(self)
end

function BuffStrickBack:update(deltaTime)
	self._time = self._time + deltaTime
end

function BuffStrickBack:isDone()
	return self._time >= self._duration
end

function BuffStrickBack:getBuffId()
	return UnitCompBuffList.StrickBack
end

function BuffStrickBack:isCustomBuff()
	return true
end

return BuffStrickBack
