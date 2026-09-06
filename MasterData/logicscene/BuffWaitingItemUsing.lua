-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffWaitingItemUsing.lua

module("logicscene.scene.battle.skills.buffs.BuffWaitingItemUsing", package.seeall)

local BuffWaitingItemUsing = class("BuffWaitingItemUsing", BuffBase)

function BuffWaitingItemUsing:ctor(buffCo, unit, itemId)
	self.itemId = itemId

	BuffWaitingItemUsing.super.ctor(self, buffCo, unit)
end

function BuffWaitingItemUsing:_buildEffects()
	local item = BattleItemsModel.instance:getBattleItemById(self.itemId)

	self.sustainEffectCo = item:watingRespondEff()
end

function BuffWaitingItemUsing:onBuffBegin()
	self._unit.attrs:setWaitingItemUsing(true)
	BuffWaitingItemUsing.super.onBuffBegin(self)
end

function BuffWaitingItemUsing:onBuffEnd()
	self._unit.attrs:setWaitingItemUsing(false)
	BuffWaitingItemUsing.super.onBuffEnd(self)
end

function BuffWaitingItemUsing:_updateEffectLayer()
	local unitLayer = self._unit.go.layer

	if unitLayer == SceneLayer.SkillAnimation_Value or unitLayer == SceneLayer.SkillEffects_Value or unitLayer == SceneLayer.SkillEffects_II_Value then
		if self._effect and self._effect.effGo and self._effect.effGo.layer ~= SceneLayer.Invisible_Value then
			Framework.GameObjectUtil.SetLayerRecursively(self._effect.effGo, SceneLayer.Invisible_Value)
		end
	elseif self._effect and self._effect.effGo and self._effect.effGo.layer ~= SceneLayer.SkillAnimation_Value then
		Framework.GameObjectUtil.SetLayerRecursively(self._effect.effGo, SceneLayer.SkillAnimation_Value)
	end
end

function BuffWaitingItemUsing:_onEffectLoaded(eff)
	self._effect = eff

	if not self.isRunning then
		self:_destroyEffect()
	else
		BattleItemController.instance:updateItemSprite(self._effect.effGo, "qiu", self.itemId)
	end
end

function BuffWaitingItemUsing:getBuffId()
	return UnitCompBuffList.WaitingItemUsingId
end

function BuffWaitingItemUsing:isCustomBuff()
	return true
end

return BuffWaitingItemUsing
