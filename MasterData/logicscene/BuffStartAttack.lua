-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffStartAttack.lua

module("logicscene.scene.battle.skills.buffs.BuffStartAttack", package.seeall)

local BuffStartAttack = class("BuffStartAttack", BuffBase)

function BuffStartAttack:onBuffBegin()
	BuffStartAttack.super.onBuffBegin(self)

	self._time = 0
end

function BuffStartAttack:_buildEffects()
	self.addEffectCo = {}
	self.addEffectCo.path = "effect/prefabs/ui/fx_ui_jinglinggezi/fx_ui_jinglinggezi_01.prefab"
	self.addEffectCo.hagPoint = UnitConst.spineFootPointPath
	self.addEffectCo.follow = 0
end

function BuffStartAttack:_createBeginEffect()
	if self.addEffectCo then
		self.addEffectCo.isHit = true
		self.addEffectCo.follow = 0
		self.addEffectCo.isGroundEff = true
		self._effectBegin = self._unit.battleEffects:playEffect(self.addEffectCo, self._onBeginEffectPlayFinish, self._onBeginEffectLoaded, self)

		if self._effectBegin then
			self._effectBegin:setVisible(self._visible)

			if self._isPause then
				self._effectBegin:pause()
			else
				self._effectBegin:resume()
			end
		end
	end
end

function BuffStartAttack:update(deltaTime)
	self._time = self._time + deltaTime
end

function BuffStartAttack:isDone()
	return self._time >= 1
end

function BuffStartAttack:getBuffId()
	return UnitCompBuffList.StartAttackId
end

function BuffStartAttack:isCustomBuff()
	return true
end

return BuffStartAttack
