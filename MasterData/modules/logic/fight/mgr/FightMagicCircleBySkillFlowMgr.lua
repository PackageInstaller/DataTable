-- chunkname: @modules/logic/fight/mgr/FightMagicCircleBySkillFlowMgr.lua

module("modules.logic.fight.mgr.FightMagicCircleBySkillFlowMgr", package.seeall)

local FightMagicCircleBySkillFlowMgr = class("FightMagicCircleBySkillFlowMgr", FightBaseClass)
local FightMagicCircleBySkillFlowMgrLoopKey = "FightMagicCircleBySkillFlowMgr"

function FightMagicCircleBySkillFlowMgr:getCurKey(fightStepData)
	return FightMagicCircleBySkillFlowMgrLoopKey .. fightStepData.stepUid
end

function FightMagicCircleBySkillFlowMgr:onConstructor()
	self.effectDict = {}
	self.preMagicLoopRes = nil
	self.preMagicCo = nil

	self:com_registFightEvent(FightEvent.OnRestartStageBefore, self.onRestartStageBefore)
	self:com_registFightEvent(FightEvent.OnSwitchPlaneClearAsset, self.onSwitchPlaneClearAsset)
	self:com_registFightEvent(FightEvent.BeforeEnterStepBehaviour, self.onBeforeEnterStepBehaviour)
	self:com_registFightEvent(FightEvent.BeforeSkillEffect, self.onBeforeSkillEffect)
	self:com_registFightEvent(FightEvent.AfterSkillEffect, self.onAfterSkillEffect)
	self:com_registFightEvent(FightEvent.StartFightEnd, self.onStartFightEnd)
	self:com_registFightEvent(FightEvent.SetMagicCircleVisible, self.onSetMagicCircleVisible)
	self:com_registEvent(ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView)
	self:com_registEvent(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish)
end

function FightMagicCircleBySkillFlowMgr:getCurEntity()
	self.entity = self.entity or FightHelper.getEntity(FightEntityScene.MySideId)

	return self.entity
end

function FightMagicCircleBySkillFlowMgr:onBeforeSkillEffect(fightStepData)
	if not self.loopEffect then
		return
	end

	local skillId = fightStepData.actId

	if FightCardDataHelper.isBigSkill(skillId) then
		self.loopEffect:setActive(false, self:getCurKey(fightStepData))
	end
end

function FightMagicCircleBySkillFlowMgr:onAfterSkillEffect(fightStepData)
	local magicCo = self:getCurMagicCo()
	local curLoopRes = magicCo and magicCo.loopEffect

	if curLoopRes == self.preMagicLoopRes then
		self:tryShowLoopEffect(fightStepData)
	else
		self:tryCreateLoopEffect(magicCo)
	end

	self.preMagicCo = magicCo
	self.preMagicLoopRes = curLoopRes
end

function FightMagicCircleBySkillFlowMgr:getCurMagicCo()
	local data = FightModel.instance:getMagicCircleInfo()
	local magicCircleId = data and data.magicCircleId

	return magicCircleId and lua_magic_circle_by_skill_flow.configDict[magicCircleId]
end

function FightMagicCircleBySkillFlowMgr:tryCreateLoopEffect(magicCo)
	self:clearLoopEffect()

	if not magicCo then
		return
	end

	self:createEffect(magicCo.enterEffect, magicCo.enterTime, magicCo.enterAudio, magicCo.posArr)

	self.loopEffect = self:createEffect(magicCo.loopEffect, nil, nil, magicCo.posArr)
end

function FightMagicCircleBySkillFlowMgr:tryShowLoopEffect(fightStepData)
	if self.loopEffect then
		self.loopEffect:setActive(true, self:getCurKey(fightStepData))
	end
end

function FightMagicCircleBySkillFlowMgr:createEffect(effectRes, releaseTime, audio, posArr)
	if string.nilorempty(effectRes) then
		return
	end

	local magicData = FightModel.instance:getMagicCircleInfo()
	local targetSide = magicData and FightHelper.getMagicSide(magicData.createUid)

	targetSide = targetSide or FightEnum.EntitySide.MySide

	local entity = self:getCurEntity()
	local effectWrap = entity.effect:addGlobalEffect(effectRes, targetSide, releaseTime)
	local posX, posY, posZ = 0, 0, 0

	if posArr then
		posX = targetSide == FightEnum.EntitySide.MySide and posArr[1] or -posArr[1]
		posY = posArr[2]
		posZ = posArr[3]
	end

	effectWrap:setLocalPos(posX, posY, posZ)

	if audio and audio > 0 then
		AudioMgr.instance:trigger(audio)
	end

	return effectWrap
end

function FightMagicCircleBySkillFlowMgr:clearLoopEffect()
	if self.loopEffect then
		local entity = self:getCurEntity()

		entity.effect:removeEffect(self.loopEffect)
	end

	self.loopEffect = nil

	if self.preMagicCo then
		self:createEffect(self.preMagicCo.closeEffect, self.preMagicCo.closeTime, self.preMagicCo.closeAudio, self.preMagicCo.posArr)
	end
end

function FightMagicCircleBySkillFlowMgr:onBeforeEnterStepBehaviour()
	if FightDataHelper.stateMgr.dealingCrash then
		self:releaseAllEffect()
	end

	local magicCo = self:getCurMagicCo()

	self:tryCreateLoopEffect(magicCo)

	self.preMagicCo = magicCo
	self.preMagicLoopRes = magicCo and magicCo.loopEffect
end

local OpenFocusViewKey = "OpenFocusViewKey"

function FightMagicCircleBySkillFlowMgr:onOpenView(viewName)
	if viewName == ViewName.FightFocusView and self.loopEffect then
		self.loopEffect:setActive(false, OpenFocusViewKey)
	end
end

function FightMagicCircleBySkillFlowMgr:onCloseViewFinish(viewName)
	if viewName == ViewName.FightFocusView and self.loopEffect then
		self.loopEffect:setActive(true, OpenFocusViewKey)
	end
end

function FightMagicCircleBySkillFlowMgr:onSetMagicCircleVisible(visible, key)
	if self.loopEffect then
		self.loopEffect:setActive(visible, key)
	end
end

function FightMagicCircleBySkillFlowMgr:onRestartStageBefore()
	self:releaseAllEffect()
end

function FightMagicCircleBySkillFlowMgr:onSwitchPlaneClearAsset()
	self:releaseAllEffect()
end

function FightMagicCircleBySkillFlowMgr:onStartFightEnd()
	self:releaseAllEffect()
end

function FightMagicCircleBySkillFlowMgr:releaseAllEffect()
	if self.loopEffect then
		local entity = self:getCurEntity()

		entity.effect:removeEffect(self.loopEffect)
	end

	self.loopEffect = nil
end

function FightMagicCircleBySkillFlowMgr:onDestructor()
	self:releaseAllEffect()
end

return FightMagicCircleBySkillFlowMgr
