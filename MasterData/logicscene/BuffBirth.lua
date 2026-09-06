-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffBirth.lua

module("logicscene.scene.battle.skills.buffs.BuffBirth", package.seeall)

local BuffBirth = class("BuffBirth", BuffBase)

function BuffBirth:onBuffBegin()
	self._time = 0

	local battleScene = SceneMgr.instance:getCurScene()

	battleScene.unitFactory:loadCharacter(self._unit)
	BuffBirth.super.onBuffBegin(self)
end

function BuffBirth:_buildEffects()
	return
end

function BuffBirth:onBuffEnd()
	if not BattleController.instance.preloadModelsOnLoadScene and not self._isEffLoaded then
		self._unit:setVisible(self._unit._isVisible)
	end

	self._isEffLoaded = nil

	BuffBirth.super.onBuffEnd(self)
end

function BuffBirth:isDone()
	return self._unit.isBorn
end

function BuffBirth:update(deltaTime)
	if self._unit.isBorn then
		self._time = self._time + deltaTime
	end
end

function BuffBirth:getBuffId()
	return UnitCompBuffList.BirthId
end

function BuffBirth:isCustomBuff()
	return true
end

function BuffBirth:_onSpineLoaded()
	local scene = SceneMgr.instance:getCurScene()

	scene:updateUnitOnBorn(self._unit)
end

function BuffBirth:_onBeginEffectLoaded()
	return
end

return BuffBirth
