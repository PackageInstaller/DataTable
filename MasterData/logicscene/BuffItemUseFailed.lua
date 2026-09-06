-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffItemUseFailed.lua

module("logicscene.scene.battle.skills.buffs.BuffItemUseFailed", package.seeall)

local BuffItemUseFailed = class("BuffItemUseFailed", BuffBase)

function BuffItemUseFailed:ctor(buffCo, unit, itemId)
	self.itemId = itemId

	BuffItemUseFailed.super.ctor(self, buffCo, unit)
end

function BuffItemUseFailed:_buildEffects()
	local item = BattleItemsModel.instance:getBattleItemById(self.itemId)

	self.addEffectCo = item:displayFailedEff()
	self.failEffectCo = item:fullScreenFailedEff()
end

function BuffItemUseFailed:getBuffId()
	return UnitCompBuffList.ItemUseFailedId
end

function BuffItemUseFailed:onBuffBegin()
	BuffItemUseFailed.super.onBuffBegin(self)
	self._unit.attrs:setItemUsing(true)

	if not self.addEffectCo then
		self:_onBeginEffectPlayFinish()
	end
end

function BuffItemUseFailed:onBuffEnd()
	BuffItemUseFailed.super.onBuffEnd(self)
	self:_destroyFailedEffect()
	self._unit.attrs:setItemUsing(false)
end

function BuffItemUseFailed:_onBeginEffectPlayFinish()
	self._effectBegin = nil

	if self.failEffectCo then
		self._failEffect = self._unit.battleEffects:playEffect(self.failEffectCo, self._onFailedEffectPlayFinish, self._onFailedEffectLoaded, self)
	else
		self:_onFailedEffectPlayFinish()
	end
end

function BuffItemUseFailed:_onFailedEffectPlayFinish()
	self._failEffect = nil

	self._unit.buffList:removeBuffById(self:getBuffId())
end

function BuffItemUseFailed:_onFailedEffectLoaded()
	if not self.isRunning then
		self:_destroyFailedEffect()
	end
end

function BuffItemUseFailed:_destroyFailedEffect()
	if self._failEffect then
		self._unit.battleEffects:stopEffect(self._failEffect)

		self._failEffect = nil
	end
end

function BuffItemUseFailed:isCustomBuff()
	return true
end

return BuffItemUseFailed
