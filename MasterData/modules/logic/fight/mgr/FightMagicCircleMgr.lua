-- chunkname: @modules/logic/fight/mgr/FightMagicCircleMgr.lua

module("modules.logic.fight.mgr.FightMagicCircleMgr", package.seeall)

local FightMagicCircleMgr = class("FightMagicCircleMgr", FightBaseClass)

function FightMagicCircleMgr:onConstructor()
	self.effectDic = {}

	self:com_registFightEvent(FightEvent.AddMagicCircile, self.onAddMagicCircile)
	self:com_registFightEvent(FightEvent.DeleteMagicCircile, self.onDeleteMagicCircile)
	self:com_registFightEvent(FightEvent.UpdateMagicCircile, self.onUpdateMagicCircile)
	self:com_registFightEvent(FightEvent.UpgradeMagicCircile, self.onUpgradeMagicCircile)
	self:com_registFightEvent(FightEvent.OnRestartStageBefore, self.onRestartStageBefore)
	self:com_registFightEvent(FightEvent.OnSwitchPlaneClearAsset, self.onSwitchPlaneClearAsset)
	self:com_registFightEvent(FightEvent.ChangeSceneVisible, self.onChangeSceneVisible)
	self:com_registFightEvent(FightEvent.BeforeEnterStepBehaviour, self.onBeforeEnterStepBehaviour)
	self:com_registFightEvent(FightEvent.OnSkillPlayStart, self.onSkillPlayStart)
	self:com_registFightEvent(FightEvent.OnSkillPlayFinish, self.onSkillPlayFinish)
	self:com_registFightEvent(FightEvent.StartFightEnd, self.onStartFightEnd)
	self:com_registFightEvent(FightEvent.SetMagicCircleVisible, self.onSetMagicCircleVisible)
	self:com_registEvent(ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView)
	self:com_registEvent(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish)
end

function FightMagicCircleMgr:createEffect(name, releaseTime)
	if not string.nilorempty(name) then
		releaseTime = releaseTime and releaseTime / 1000

		local magicData = FightModel.instance:getMagicCircleInfo()
		local posArr = self.config.posArr
		local pos = {
			x = posArr[1],
			y = posArr[2],
			z = posArr[3]
		}
		local targetSide = FightHelper.getMagicSide(magicData.createUid)
		local effectWrap = self.entity.effect:addGlobalEffect(name, targetSide, releaseTime)

		effectWrap:setLocalPos((targetSide == FightEnum.EntitySide.MySide or nil) and (pos.x or -pos.x), pos.y, pos.z)

		if not releaseTime then
			self.effectDic[effectWrap.uniqueId] = effectWrap
		end

		return effectWrap
	end
end

function FightMagicCircleMgr:onBeforeEnterStepBehaviour()
	if FightDataHelper.stateMgr.dealingCrash then
		self:releaseAllEffect()
	end

	self.entity = FightHelper.getEntity(FightEntityScene.MySideId)

	local data = FightModel.instance:getMagicCircleInfo()

	if data.magicCircleId then
		self:onAddMagicCircile(data.magicCircleId)
	end
end

function FightMagicCircleMgr:getConfig(magicCircleId)
	local data = FightModel.instance:getMagicCircleInfo()
	local entityMO = FightDataHelper.entityMgr:getById(data.createUid)
	local skinId = entityMO and entityMO.skin

	return (lua_fight_skin_replace_magic_effect.configDict[magicCircleId] or nil) and (lua_fight_skin_replace_magic_effect.configDict[magicCircleId][skinId] or lua_magic_circle.configDict[magicCircleId])
end

function FightMagicCircleMgr:onAddMagicCircile(magicCircleId)
	self:clearLastLoopEffect()

	self.config = self:getConfig(magicCircleId)

	self:createEffect(self.config.enterEffect, self.config.enterTime)

	self.loopEffect = self:createEffect(self.config.loopEffect, nil)

	self:playAudio(self.config.enterAudio)
end

function FightMagicCircleMgr:clearLastLoopEffect()
	if self.loopEffect then
		self:releaseEffect(self.loopEffect)

		self.loopEffect = nil
	end

	if self.removeEffectWrap then
		self:releaseEffect(self.removeEffectWrap)

		self.removeEffectWrap = nil
	end

	FightTimer.cancelTimer(self.singleTimer)
	FightController.instance:unregisterCallback(FightEvent.EntityEffectLoaded, self.onRemoveEffectLoaded, self)
end

function FightMagicCircleMgr:playAudio(id)
	if id ~= 0 then
		AudioMgr.instance:trigger(id)
	end
end

function FightMagicCircleMgr:onDeleteMagicCircile(magicCircleId)
	self.config = self:getConfig(magicCircleId)

	if not string.nilorempty(self.config.closeAniName) then
		if self.loopEffect and self.loopEffect.effectGO then
			local ani = gohelper.onceAddComponent(self.loopEffect.effectGO, typeof(UnityEngine.Animator))

			if ani then
				ani:Play(self.config.closeAniName)
			end

			self.singleTimer = self:com_registSingleTimer(self.releaseLoopAfterCloseAni, self.config.closeTime / 1000)
		else
			self:releaseLoopEffect()
		end
	else
		self.removeEffectWrap = self:createEffect(self.config.closeEffect, self.config.closeTime)

		if self.removeEffectWrap then
			if self.removeEffectWrap.effectGO then
				self:releaseLoopEffect()
			else
				FightController.instance:registerCallback(FightEvent.EntityEffectLoaded, self.onRemoveEffectLoaded, self)
			end
		else
			self:releaseLoopEffect()
		end
	end

	self:playAudio(self.config.closeAudio)
end

function FightMagicCircleMgr:releaseLoopAfterCloseAni()
	self:releaseLoopEffect()
end

function FightMagicCircleMgr:releaseLoopEffect()
	if self.loopEffect then
		self:releaseEffect(self.loopEffect)

		self.loopEffect = nil
	end
end

function FightMagicCircleMgr:onRemoveEffectLoaded(entityId, effectWrap)
	if self.removeEffectWrap == effectWrap then
		FightController.instance:unregisterCallback(FightEvent.EntityEffectLoaded, self.onRemoveEffectLoaded, self)
		self:releaseLoopEffect()
	end
end

function FightMagicCircleMgr:onOpenView(viewName)
	if viewName == ViewName.FightFocusView and self.loopEffect then
		self.loopEffect:setActive(false, "FightMagicCircleMgrFightFocusView")
	end
end

function FightMagicCircleMgr:onCloseViewFinish(viewName)
	if viewName == ViewName.FightFocusView and self.loopEffect then
		self.loopEffect:setActive(true, "FightMagicCircleMgrFightFocusView")
	end
end

function FightMagicCircleMgr:onSkillPlayStart(entity, curSkillId, stepData)
	local entityMO = entity:getMO()

	if entityMO and FightCardDataHelper.isBigSkill(curSkillId) and self.loopEffect then
		self.loopEffect:setActive(false, "FightMagicCircleMgronSkillPlayStart" .. stepData.stepUid)
	end
end

function FightMagicCircleMgr:onSkillPlayFinish(entity, curSkillId, stepData)
	local entityMO = entity:getMO()

	if entityMO and FightCardDataHelper.isBigSkill(curSkillId) and self.loopEffect then
		self.loopEffect:setActive(true, "FightMagicCircleMgronSkillPlayStart" .. stepData.stepUid)
	end
end

function FightMagicCircleMgr:onSetMagicCircleVisible(visible, key)
	if self.loopEffect then
		self.loopEffect:setActive(visible, key)
	end
end

function FightMagicCircleMgr:onChangeSceneVisible(state)
	return
end

function FightMagicCircleMgr:onUpdateMagicCircile(magicCircleId)
	return
end

function FightMagicCircleMgr:onUpgradeMagicCircile(magicMo)
	self:clearLastLoopEffect()

	self.config = self:getConfig(magicMo.magicCircleId)

	self:createEffect(self.config.enterEffect, self.config.enterTime)

	self.loopEffect = self:createEffect(self.config.loopEffect, nil)

	self:playAudio(self.config.enterAudio)
end

function FightMagicCircleMgr:onRestartStageBefore()
	self:releaseAllEffect()
end

function FightMagicCircleMgr:onSwitchPlaneClearAsset()
	self:releaseAllEffect()
end

function FightMagicCircleMgr:releaseEffect(effectWrap)
	self.effectDic[effectWrap.uniqueId] = nil

	if self.entity then
		self.entity.effect:removeEffect(effectWrap)
	end
end

function FightMagicCircleMgr:releaseAllEffect()
	for k, effectWrap in pairs(self.effectDic) do
		self:releaseEffect(effectWrap)
	end

	self.effectDic = {}
	self.loopEffect = nil
end

function FightMagicCircleMgr:onStartFightEnd()
	self:releaseAllEffect()
end

function FightMagicCircleMgr:onDestructor()
	self:releaseAllEffect()
end

return FightMagicCircleMgr
