-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffDead.lua

module("logicscene.scene.battle.skills.buffs.BuffDead", package.seeall)

local BuffDead = class("BuffDead", BuffBase)

function BuffDead:onBuffBegin()
	self._duration = self._unit.spine:play("die", nil, nil) or 0
	self._time = 0
	self._unit.attrs.deadAnimFinished = nil

	self._unit:stopSkill()
	self._unit.attrs:setDead(true)
	self._unit.unitUI:setVisible(false)

	self._isVisible = true

	GlobalDispatcher:dispatch(GlobalNotify.BattleUnitDead, self._unit)
	BuffDead.super.onBuffBegin(self)
end

function BuffDead:onBuffEnd()
	self._unit.attrs.deadAnimFinished = nil

	self._unit.attrs:setDead(false)
	self._unit.unitUI:setVisible(true)

	self._isVisible = true

	GoUtil.SetVisible(self._unit.go, self._isVisible)
	BuffDead.super.onBuffEnd(self)
end

function BuffDead:update(deltaTime)
	self._time = self._time + deltaTime

	if self._time >= self._duration then
		self:_onDeadAnimFinish()
	end
end

function BuffDead:_onDeadAnimFinish()
	self._unit.attrs.deadAnimFinished = true

	if self._isVisible == true then
		self._isVisible = false

		GoUtil.SetVisible(self._unit.go, false)
	end
end

function BuffDead:getBuffId()
	return UnitCompBuffList.DeadId
end

function BuffDead:isCustomBuff()
	return true
end

return BuffDead
