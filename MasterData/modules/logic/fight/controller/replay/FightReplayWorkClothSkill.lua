-- chunkname: @modules/logic/fight/controller/replay/FightReplayWorkClothSkill.lua

module("modules.logic.fight.controller.replay.FightReplayWorkClothSkill", package.seeall)

local FightReplayWorkClothSkill = class("FightReplayWorkClothSkill", BaseWork)

function FightReplayWorkClothSkill:ctor(clothSkillOp)
	self.clothSkillOp = clothSkillOp
end

function FightReplayWorkClothSkill:onStart()
	TaskDispatcher.runDelay(self._delayDone, self, 10)

	if self.clothSkillOp.type == FightEnum.ClothSkillType.HeroUpgrade then
		FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, self._failDone, self)
		FightController.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, self._onClothSkillDone, self)
		FightRpc.instance:sendUseClothSkillRequest(self.clothSkillOp.skillId, self.clothSkillOp.fromId, self.clothSkillOp.toId, FightEnum.ClothSkillType.HeroUpgrade)

		return
	elseif self.clothSkillOp.type == FightEnum.ClothSkillType.Contract then
		FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, self._failDone, self)
		FightController.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, self._onClothSkillDone, self)
		FightRpc.instance:sendUseClothSkillRequest(self.clothSkillOp.skillId, self.clothSkillOp.fromId, self.clothSkillOp.toId, FightEnum.ClothSkillType.Contract)

		return
	elseif self.clothSkillOp.type == FightEnum.ClothSkillType.EzioBigSkill then
		local playEntity = FightHelper.getEntity(self.clothSkillOp.fromId)

		if playEntity and not FightDataHelper.tempMgr.replayAiJiAoQtePreTimeline then
			FightDataHelper.tempMgr.replayAiJiAoQtePreTimeline = true
			self.aiJiAoPreTimeline = FightWorkFlowSequence.New()

			self.aiJiAoPreTimeline:registWork(FightWorkPlayTimeline, playEntity, "aijiao_312301_unique_pre", self.clothSkillOp.toId)
			self.aiJiAoPreTimeline:registFinishCallback(self._aiJiAoPreTimelineFinish, self)
			self.aiJiAoPreTimeline:start()
		else
			FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, self._failDone, self)
			FightController.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, self._onClothSkillDone, self)
			FightRpc.instance:sendUseClothSkillRequest(self.clothSkillOp.skillId, self.clothSkillOp.fromId, self.clothSkillOp.toId, FightEnum.ClothSkillType.EzioBigSkill)
		end

		return
	elseif self.clothSkillOp.type == FightEnum.ClothSkillType.AssassinBigSkill then
		FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, self._failDone, self)
		FightController.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, self._onClothSkillDone, self)
		FightRpc.instance:sendUseClothSkillRequest(self.clothSkillOp.skillId, self.clothSkillOp.fromId, self.clothSkillOp.toId, FightEnum.ClothSkillType.AssassinBigSkill)

		return
	elseif self.clothSkillOp.type == FightEnum.ClothSkillType.SelectCrystal then
		FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, self._failDone, self)
		FightController.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, self._onClothSkillDone, self)
		FightRpc.instance:sendUseClothSkillRequest(self.clothSkillOp.skillId, self.clothSkillOp.fromId, self.clothSkillOp.toId, FightEnum.ClothSkillType.SelectCrystal)

		return
	elseif self.clothSkillOp.type == FightEnum.ClothSkillType.BattleSelection then
		FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, self._failDone, self)
		FightController.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, self._onClothSkillDone, self)
		FightRpc.instance:sendUseClothSkillRequest(self.clothSkillOp.skillId, "0", "0", FightEnum.ClothSkillType.BattleSelection)

		return
	elseif self.clothSkillOp.type == FightEnum.ClothSkillType.TwinsSelect then
		FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, self._failDone, self)
		FightController.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, self._onClothSkillDone, self)
		FightRpc.instance:sendUseClothSkillRequest(self.clothSkillOp.skillId, self.clothSkillOp.fromId, self.clothSkillOp.toId, FightEnum.ClothSkillType.TwinsSelect)

		return
	elseif self.clothSkillOp.type == FightEnum.ClothSkillType.MeiLeiErExtraRound then
		FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, self._failDone, self)
		FightController.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, self._onClothSkillDone, self)
		FightRpc.instance:sendUseClothSkillRequest(0, self.clothSkillOp.fromId, "0", FightEnum.ClothSkillType.MeiLeiErExtraRound)

		return
	end

	if self.clothSkillOp.skillId == FightEnum.DeviceDiscardSkillId then
		FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, self._failDone, self)
		FightController.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, self._onClothSkillDone, self)
		FightRpc.instance:sendUseClothSkillRequest(self.clothSkillOp.skillId, nil, self.clothSkillOp.toId)

		return
	end

	local skillCO = lua_skill.configDict[self.clothSkillOp.skillId]

	if skillCO then
		local behavior = skillCO.behavior1

		if not string.nilorempty(behavior) then
			local behaviorType = string.splitToNumber(behavior, "#")[1]
			local behaviorTypeCO = behaviorType and lua_skill_behavior.configDict[behaviorType]
			local behaviorTypeStr = behaviorTypeCO and behaviorTypeCO.type

			if behaviorTypeStr then
				self:_playBehavior(behaviorTypeStr)
			else
				logError("主角技能行为类型不存在：" .. self.clothSkillOp.skillId .. " behavior=" .. behavior)
				self:onDone(true)
			end
		else
			logError("主角技能行为不存在：" .. self.clothSkillOp.skillId)
			self:onDone(true)
		end
	else
		logError("主角技能不存在：" .. self.clothSkillOp.skillId)
		self:onDone(true)
	end
end

function FightReplayWorkClothSkill:_playBehavior(behaviorTypeStr)
	if behaviorTypeStr == "AddUniversalCard" then
		FightController.instance:registerCallback(FightEvent.OnUniversalAppear, self._onUniversalAppear, self)
	elseif behaviorTypeStr == "RedealCardKeepStar" then
		FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, self._onRedealCardDone, self)
	elseif behaviorTypeStr == "SubHeroChange" then
		FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, self._onChangeSubDone, self)
	elseif behaviorTypeStr == "ExtraMoveCard" then
		FightController.instance:registerCallback(FightEvent.OnEffectExtraMoveAct, self._onEffectExtraMoveAct, self)
	else
		FightController.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, self._onClothSkillDone, self)
	end

	FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, self._failDone, self)
	FightController.instance:dispatchEvent(FightEvent.SimulateClickClothSkillIcon, self.clothSkillOp)
end

function FightReplayWorkClothSkill:_delayDone()
	self:onDone(true)
end

function FightReplayWorkClothSkill:_onChangeSubDone()
	TaskDispatcher.runDelay(self._done, self, 0.1)
end

function FightReplayWorkClothSkill:_onRedealCardDone()
	TaskDispatcher.runDelay(self._done, self, 0.1)
end

function FightReplayWorkClothSkill:_onUniversalAppear()
	TaskDispatcher.runDelay(self._done, self, 0.1)
end

function FightReplayWorkClothSkill:_onEffectExtraMoveAct()
	TaskDispatcher.runDelay(self._done, self, 0.1)
end

function FightReplayWorkClothSkill:_onClothSkillDone()
	TaskDispatcher.runDelay(self._done, self, 0.1)
end

function FightReplayWorkClothSkill:_done()
	self:onDone(true)
end

function FightReplayWorkClothSkill:_failDone()
	self:onDone(true)
end

function FightReplayWorkClothSkill:_aiJiAoPreTimelineFinish()
	FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, self._failDone, self)
	FightController.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, self._onClothSkillDone, self)
	FightRpc.instance:sendUseClothSkillRequest(self.clothSkillOp.skillId, self.clothSkillOp.fromId, self.clothSkillOp.toId, FightEnum.ClothSkillType.EzioBigSkill)
end

function FightReplayWorkClothSkill:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnUniversalAppear, self._onUniversalAppear, self)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, self._done, self)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, self._onChangeSubDone, self)
	FightController.instance:unregisterCallback(FightEvent.OnEffectExtraMoveAct, self._onEffectExtraMoveAct, self)
	FightController.instance:unregisterCallback(FightEvent.OnClothSkillRoundSequenceFinish, self._onClothSkillDone, self)
	FightController.instance:unregisterCallback(FightEvent.RespUseClothSkillFail, self._failDone, self)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, self._onRedealCardDone, self)
	TaskDispatcher.cancelTask(self._delayDone, self)
	TaskDispatcher.cancelTask(self._done, self)

	if self.aiJiAoPreTimeline then
		self.aiJiAoPreTimeline:disposeSelf()

		self.aiJiAoPreTimeline = nil
	end
end

return FightReplayWorkClothSkill
