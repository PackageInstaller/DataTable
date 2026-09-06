-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffUseUtlSkill.lua

module("logicscene.scene.battle.skills.buffs.BuffUseUtlSkill", package.seeall)

local BuffUseUtlSkill = class("BuffUseUtlSkill", BuffBase)

function BuffUseUtlSkill:onBuffBegin()
	BuffUseUtlSkill.super.onBuffBegin(self)

	self._time = 0
end

function BuffUseUtlSkill:_buildEffects()
	self.addEffectCo = {}
	self.addEffectCo.path = "effect/prefabs/common/skill/fx_10001_chaoshabaoqi.prefab"
	self.addEffectCo.hagPoint = UnitConst.spineFootPointPath
	self.addEffectCo.follow = 1
end

function BuffUseUtlSkill:update(deltaTime)
	self._time = self._time + deltaTime
end

function BuffUseUtlSkill:isDone()
	return self._time >= 2
end

function BuffUseUtlSkill:getBuffId()
	return UnitCompBuffList.UseUtlSkill
end

function BuffUseUtlSkill:isCustomBuff()
	return true
end

return BuffUseUtlSkill
