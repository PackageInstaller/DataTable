-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffBase.lua

module("logicscene.scene.battle.skills.buffs.BuffBase", package.seeall)

local BuffBase = class("BuffBase")

function BuffBase:ctor(buffCo, unit)
	self.buffCo = buffCo
	self._unit = unit
	self.isRunning = nil
	self._effectBegin = nil
	self._effectEnd = nil
	self._effect = nil
	self._visible = true
	self.layerNum = 0

	self:_buildEffects()
end

function BuffBase:addLayerNum()
	self.layerNum = self.layerNum + 1

	self:_createBeginEffect()
	self:updateLayerNum()
end

function BuffBase:updateLayerNum()
	if self._layerEffects then
		self._layerEffects:addLayerNum()
	end
end

function BuffBase:removeLayerNum()
	self.layerNum = self.layerNum - 1

	if self._layerEffects then
		self._layerEffects:removeLayerNum()
	end
end

function BuffBase:autoRemoveOnDead()
	if not self.buffCo then
		return true
	end

	return not self.buffCo.disable_dead_rm or self.buffCo.disable_dead_rm == 0
end

function BuffBase:onBuffBegin()
	self.isRunning = true

	self:addLayerNum()
	self:_createEffect()
	self:_createBuffTexts()

	if self.buffCo then
		GlobalDispatcher:dispatch(GlobalNotify.OnBattleBuffStart, self._unit, self)
	end

	if self.buffCo and self.buffCo.frozen then
		self._unit.attrs:setFrozen(true)
		self._unit.spine:setPlaySpeed(0)
	end

	local opacity = 0

	if self.buffCo then
		opacity = self.buffCo.opacity or 0
	end

	if opacity > 0 then
		self._unit.attrs:setTransrent(true)
		self._unit:setAlpha(1 - opacity)
	end

	if self._layerEffects then
		self._layerEffects:onBuffBegin()
	end
end

function BuffBase:onBuffEnd()
	if self._layerEffects then
		self._layerEffects:onBuffEnd()

		self._layerEffects = nil
	end

	if self.buffCo and self.buffCo.frozen then
		self._unit.attrs:setFrozen(false)

		if not self._unit.attrs:isFrozen() then
			self._unit.spine:setPlaySpeed(1)
		end
	end

	if ((self.buffCo or nil) and (self.buffCo.opacity or 0)) > 0 then
		self._unit.attrs:setTransrent(false)

		if not self._unit.attrs:isTransrent() then
			self._unit:setAlpha(1)
		end
	end

	local buffCo = self.buffCo

	self.isRunning = nil
	self.addEffectCo = nil
	self.layerNum = 0
	self.sustainEffectCo = nil
	self.removeEffectCo = nil

	self:_destroyEffect()
	self:_destroyBeginEffect()
	self:_createEndEffect()

	if buffCo then
		GlobalDispatcher:dispatch(GlobalNotify.OnBattleBuffEnd, self._unit, self)
	end
end

function BuffBase:getUnit()
	return self._unit
end

function BuffBase:getBuffId()
	if self.buffCo then
		return self.buffCo.id
	end

	return 0
end

function BuffBase:isDebuff()
	if self.buffCo and self.buffCo.buffTextType then
		return self.buffCo.buffTextType == 2
	end

	return true
end

function BuffBase:getBuffText()
	if self.buffCo then
		return self.buffCo.buffText
	end
end

function BuffBase:isCustomBuff()
	return not self.buffCo
end

function BuffBase:isNeedShowOnUI()
	return
end

function BuffBase:update(deltaTime)
	self:_updateEffectLayer()
	self:_updateEffectOrder()
end

function BuffBase:setVisible(visible)
	self._visible = visible

	self:_updateEffectLayer()
end

function BuffBase:isVisible()
	return self._visible
end

function BuffBase:pause()
	if self._isPause then
		return
	end

	self._isPause = true

	if self._effect then
		self._effect:pause()
	end
end

function BuffBase:resume()
	if not self._isPause then
		return
	end

	self._isPause = nil

	if self._effect then
		self._effect:resume()
	end
end

function BuffBase:toggle()
	return
end

function BuffBase:isDone()
	return
end

function BuffBase:_onEffectPlayFinish()
	self._effect = nil
end

function BuffBase:_onEffectLoaded(eff)
	self._effect = eff

	if not self.isRunning then
		self:_destroyEffect()
	else
		self._effect.turningShow = self.sustainEffectCo.turningShow

		self._unit.buffEffects:addEffect(eff)
		self:_updateEffectLayer()

		if self._layerEffects then
			self._layerEffects:onEffectLoaded(eff)
		end

		if self._unit.attrs:isDead() and not goutil.isNil(self._effect.effGo) then
			GoUtil.SetVisible(self._effect.effGo, false)
		end
	end
end

function BuffBase:_buildEffects()
	if self.buffCo then
		self.effPlanCo = BattleConfig.instance:getBuffEffPlanCo(self.buffCo.id, self._unit.modelId) or self.buffCo

		if self.effPlanCo.addEffectId > 0 then
			self.addEffectCo = self:_buildEffectByEffId(self.effPlanCo.addEffectId)
		end

		if self.effPlanCo.sustainEffectId > 0 then
			self.sustainEffectCo = self:_buildEffectByEffId(self.effPlanCo.sustainEffectId, true)
		end

		if self.effPlanCo.removeEffectId > 0 then
			self.removeEffectCo = self:_buildEffectByEffId(self.effPlanCo.removeEffectId)
		end

		if self.buffCo.layerEffects then
			self._layerEffects = BuffLayerEffectFactory.createLayerEffect(self.buffCo.layerEffects, self)
		end
	end
end

function BuffBase:_buildEffectByEffId(effId, turningShow, skinId)
	if effId > 0 then
		local effCo = BattleConfig.instance:getBuffEffCo(effId)

		if effCo then
			local eff = {}

			eff.path = GameUrl.getFuncIconUrl(effCo.path)
			eff.duration = effCo.duration
			eff.hagPoint = effCo.mountPointName
			eff.flipWithRotate = effCo.flipWithRotate
			eff.turningShow = turningShow and effCo.turningShow
			eff.showOrder = effCo.showOrder

			return eff
		end
	end
end

function BuffBase:_createEffect()
	if self.sustainEffectCo then
		self.sustainEffectCo.loop = true
		self.sustainEffectCo.isHit = true
		self.sustainEffectCo.follow = 1
		self._effect = self._unit.battleEffects:playEffect(self.sustainEffectCo, self._onEffectPlayFinish, self._onEffectLoaded, self)

		if self._effect then
			self._effect.turningShow = self.sustainEffectCo.turningShow
		end
	end
end

function BuffBase:getSustainEffect()
	return self._effect
end

function BuffBase:_createBuffTexts()
	local buffText = self:getBuffText()

	if not buffText or #buffText == 0 then
		return
	end

	local texts = string.split(buffText, ",")
	local isDebuff = self:isDebuff()

	for i = 1, #texts do
		local textId = GameEnum.BuffTextType[texts[i]]

		if textId then
			self._unit.unitUI:onBuffText(textId, isDebuff)
		end
	end
end

function BuffBase:_destroyEffect()
	if self._effect then
		self._unit.buffEffects:removeEffect(self._effect)
		self._unit.battleEffects:stopEffect(self._effect)

		self._effect = nil
	end
end

function BuffBase:_onBeginEffectPlayFinish()
	self._effectBegin = nil
end

function BuffBase:_onBeginEffectLoaded(eff)
	self._effectBegin = eff

	if not self.isRunning then
		self:_destroyBeginEffect()
	end
end

function BuffBase:_createBeginEffect()
	if self.addEffectCo then
		self.addEffectCo.isHit = true
		self.addEffectCo.follow = 1

		self._unit.battleEffects:playEffect(self.addEffectCo)
	end
end

function BuffBase:_destroyBeginEffect()
	if self._effectBegin then
		self._unit.battleEffects:stopEffect(self._effectBegin)

		self._effectBegin = nil
	end
end

function BuffBase:_onEndEffectPlayFinish()
	self._effectEnd = nil
end

function BuffBase:_onEndEffectLoaded(eff)
	self._effectEnd = eff
end

function BuffBase:_createEndEffect()
	if self.removeEffectCo then
		self.removeEffectCo.isHit = true
		self.removeEffectCo.follow = 1
		self._effectEnd = self._unit.battleEffects:playEffect(self.removeEffectCo, self._onEndEffectPlayFinish, self._onEndEffectLoaded, self)

		if self._effectEnd then
			-- block empty
		end
	end
end

function BuffBase:_destroyEndEffect()
	if self._effectEnd then
		self._unit.battleEffects:stopEffect(self._effectEnd)

		self._effectEnd = nil
	end
end

function BuffBase:_updateEffectLayer()
	if goutil.isNil(self._unit.go) then
		return
	end

	local unitLayer = self._unit.go.layer

	if self._unit.attrs:isInvisible() or not self:isVisible() or unitLayer == SceneLayer.SkillAnimation_Value or unitLayer == SceneLayer.SkillEffects_Value or unitLayer == SceneLayer.SkillEffects_II_Value then
		if self._effectEnd and self._effectEnd.effGo and self._effectEnd.effGo.layer ~= SceneLayer.Invisible_Value then
			Framework.GameObjectUtil.SetLayerRecursively(self._effectEnd.effGo, SceneLayer.Invisible_Value)
		end

		if self._effectBegin and self._effectBegin.effGo and self._effectBegin.effGo.layer ~= SceneLayer.Invisible_Value then
			Framework.GameObjectUtil.SetLayerRecursively(self._effectBegin.effGo, SceneLayer.Invisible_Value)
		end

		if self._effect and self._effect.effGo and self._effect.effGo.layer ~= SceneLayer.Invisible_Value then
			Framework.GameObjectUtil.SetLayerRecursively(self._effect.effGo, SceneLayer.Invisible_Value)
		end
	else
		if self._effectEnd and self._effectEnd.effGo then
			self._unit.battleEffects:updateEffectLayer(self._effectEnd.effGo)
		end

		if self._effectBegin and self._effectBegin.effGo then
			self._unit.battleEffects:updateEffectLayer(self._effectBegin.effGo)
		end

		if self._effect and self._effect.effGo then
			if self._unit.buffEffects:isShowing(self._effect) or not self._effect.turningShow then
				self._unit.battleEffects:updateEffectLayer(self._effect.effGo)
			elseif self._effect.effGo.layer ~= SceneLayer.Invisible_Value then
				Framework.GameObjectUtil.SetLayerRecursively(self._effect.effGo, SceneLayer.Invisible_Value)
			end
		end
	end
end

function BuffBase:_updateEffectOrder()
	if self._effectEnd and self._effectEnd.effGo then
		self._unit.battleEffects:updateEffectOrder(self._effectEnd)
	end

	if self._effectBegin and self._effectBegin.effGo then
		self._unit.battleEffects:updateEffectOrder(self._effectBegin)
	end

	if self._effect and self._effect.effGo then
		self._unit.battleEffects:updateEffectOrder(self._effect)
	end
end

return BuffBase
