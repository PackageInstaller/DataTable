-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffItemUseSuccess.lua

module("logicscene.scene.battle.skills.buffs.BuffItemUseSuccess", package.seeall)

local BuffItemUseSuccess = class("BuffItemUseSuccess", BuffBase)

function BuffItemUseSuccess:ctor(buffCo, unit, itemId)
	self.itemId = itemId

	local itemCo = BattleConfig.instance:getBattleItem(itemId)

	self._isCatchBall = itemCo.type == GameEnum.BattleItemType.Ball

	BuffItemUseSuccess.super.ctor(self, buffCo, unit)
end

function BuffItemUseSuccess:_buildEffects()
	local item = BattleItemsModel.instance:getBattleItemById(self.itemId)

	self.addEffectCo = item:displaySuccessEff()
	self.sucessEffectCo = item:fullScreenSuccessEff()
end

function BuffItemUseSuccess:getBuffId()
	return UnitCompBuffList.ItemUseSuccessId
end

function BuffItemUseSuccess:onBuffBegin()
	BuffItemUseSuccess.super.onBuffBegin(self)

	if self._isCatchBall then
		self._unit.unitUI:setVisible(false)
	end

	self._unit.attrs:setItemUsing(true)

	if not self.addEffectCo then
		self:_onBeginEffectPlayFinish()
	end
end

function BuffItemUseSuccess:_onBeginEffectLoaded(eff)
	self._effectBegin = eff

	if not self.isRunning then
		self:_destroyBeginEffect()
	else
		BattleItemController.instance:updateItemSprite(self._effectBegin.effGo, "bao/qiu", self.itemId)
	end
end

function BuffItemUseSuccess:onBuffEnd()
	BuffItemUseSuccess.super.onBuffEnd(self)
	self:_destroySuccessEffect()

	if self._isCatchBall then
		self._unit.attrs:setDead(true)
	end

	self._unit.attrs:setItemUsing(false)
end

function BuffItemUseSuccess:_onBeginEffectPlayFinish()
	self._effectBegin = nil

	if self._isCatchBall then
		self._unit:setVisible(false)
	end

	if self.sucessEffectCo then
		self._sucessEffect = UIEffectManager.instance:playEffectInCenters(self.sucessEffectCo.path, nil, self.sucessEffectCo.duration, self._onSuccessEffectPlayFinish, self._onSuccessEffectLoaded, self)

		self._sucessEffect:setLayer(SceneLayer.SkillAnimation_Value)
	else
		self:_onSuccessEffectPlayFinish()
	end
end

function BuffItemUseSuccess:_updateEffectLayer()
	local unitLayer = self._unit.go.layer

	if unitLayer == SceneLayer.SkillAnimation_Value or unitLayer == SceneLayer.SkillEffects_Value or unitLayer == SceneLayer.SkillEffects_II_Value then
		if self._effectBegin and self._effectBegin.effGo and self._effectBegin.effGo.layer ~= SceneLayer.Invisible_Value then
			Framework.GameObjectUtil.SetLayerRecursively(self._effectBegin.effGo, SceneLayer.Invisible_Value)
		end

		if self._sucessEffect and self._sucessEffect.effGo and self._sucessEffect.effGo.layer ~= SceneLayer.Invisible_Value then
			Framework.GameObjectUtil.SetLayerRecursively(self._sucessEffect.effGo, SceneLayer.Invisible_Value)
		end
	else
		if self._effectBegin and self._effectBegin.effGo and self._effectBegin.effGo.layer ~= SceneLayer.SkillAnimation_Value then
			Framework.GameObjectUtil.SetLayerRecursively(self._effectBegin.effGo, SceneLayer.SkillAnimation_Value)
		end

		if self._sucessEffect and self._sucessEffect.effGo and self._sucessEffect.effGo.layer ~= SceneLayer.SkillAnimation_Value then
			Framework.GameObjectUtil.SetLayerRecursively(self._sucessEffect.effGo, SceneLayer.SkillAnimation_Value)
		end
	end
end

function BuffItemUseSuccess:_onSuccessEffectPlayFinish()
	self._sucessEffect = nil

	self._unit.buffList:removeBuffById(self:getBuffId())
end

function BuffItemUseSuccess:_onSuccessEffectLoaded(eff)
	self._sucessEffect = eff

	if not self.isRunning then
		self:_destroySuccessEffect()
	end
end

function BuffItemUseSuccess:_destroySuccessEffect()
	if self._sucessEffect then
		UIEffectManager.instance:stopEffect(self._sucessEffect)

		self._sucessEffect = nil
	end
end

function BuffItemUseSuccess:isCustomBuff()
	return true
end

return BuffItemUseSuccess
