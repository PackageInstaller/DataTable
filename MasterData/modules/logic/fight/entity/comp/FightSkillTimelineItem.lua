-- chunkname: @modules/logic/fight/entity/comp/FightSkillTimelineItem.lua

module("modules.logic.fight.entity.comp.FightSkillTimelineItem", package.seeall)

local FightSkillTimelineItem = class("FightSkillTimelineItem", FightBaseClass)

function FightSkillTimelineItem:onConstructor(workTimelineItem)
	self.workTimelineItem = workTimelineItem
	self.entity = workTimelineItem.entity
	self.fightStepData = workTimelineItem.fightStepData
	self.timelineName = workTimelineItem.timelineName
	self.timelineUrl = ResUrl.getSkillTimeline(self.timelineName)
	self.timelineAssetItem = workTimelineItem:getTimelineAssetItem()
	self.timelineObj = gohelper.create3d(nil, "_skill_playable")
	self.binder = ZProj.PlayableAssetBinder.Get(self.timelineObj)
	self.trackDic = {}
	self.timelineContext = {}
end

function FightSkillTimelineItem:setSameSkillParam()
	if self.entity.skill:sameSkillPlaying() then
		local sameSkillParam = self.entity.skill.sameSkillParam[self.fightStepData.stepUid]

		if not sameSkillParam then
			return
		end

		if not sameSkillParam.startParam then
			return
		end

		local param = sameSkillParam.startParam

		self.timelineStartTime = tonumber(param[1])
		self.audioStartTime = tonumber(param[2])
		self.spineStartTime = tonumber(param[3])
		self.spineDelayTime = tonumber(param[4])

		if self.timelineStartTime ~= 0 then
			self.timelineStartTime = self.timelineStartTime or nil
		end

		if self.audioStartTime ~= 0 then
			self.audioStartTime = self.audioStartTime or nil
		end

		if self.spineStartTime ~= 0 then
			self.spineStartTime = self.spineStartTime or nil
		end

		if self.spineDelayTime ~= 0 then
			self.spineDelayTime = self.spineDelayTime or nil
		end

		self.curAnimState = sameSkillParam.curAnimState
		self.audioId = sameSkillParam.audioId

		if FightWorkBFSGSkillStart.BeiFangShaoGeUniqueSkill and FightWorkBFSGSkillStart.BeiFangShaoGeUniqueSkill <= 0 then
			self.audioId = nil
		end
	end
end

function FightSkillTimelineItem:setTimeScale(timeScale)
	self.timeScale = timeScale
end

function FightSkillTimelineItem:play()
	self:setSameSkillParam()
	self:dealDamageFromLostHp()

	self._startTime = Time.time
	self.timeScale = self.entity.skill.timeScale

	self.binder:AddFrameEventCallback(self._onFrameEventCallback, self)
	self.binder:AddEndCallback(self._onTimelineEndCallback, self)

	self.endCallbackFunc = self.timelineEndNormalFunc
	self.binder.director.enabled = true

	if self.timelineStartTime then
		self.binder:SetTime(self.timelineStartTime)
	end

	if self.audioStartTime and self.audioId then
		self._lock_skill_bgm = true
		self.fightStepData.atkAudioId = self.audioId

		AudioEffectMgr.instance:playAudio(self.audioId)
		AudioEffectMgr.instance:seekMilliSeconds(self.audioId, self.audioStartTime * 1000)
	end

	self.binder:Play(self.timelineAssetItem, self.timelineUrl)
	self:com_registUpdate(self.onUpdate)
end

function FightSkillTimelineItem:onUpdate(deltaTime)
	self.binder:Evaluate(self.timeScale * deltaTime)
end

function FightSkillTimelineItem:_onFrameEventCallback(type, id, isBegin, duration, paramStr)
	if isBegin then
		self:_onFrameEventPlayCallback(type, id, duration, paramStr)
	else
		self:_onFrameEventPauseCallback(type, id)
	end

	if FightDataHelper.stateMgr.isReplay then
		FightController.instance:dispatchEvent(FightEvent.ReplayTick)
	end
end

function FightSkillTimelineItem:_onFrameEventPlayCallback(type, id, duration, paramStr)
	if self._same_skill_after_hit then
		return
	end

	local param = cjson.decode(paramStr)
	local typeCls = FightSkillComp.FrameEventHandlerCls[type]

	if typeCls then
		if type == 3 then
			local version = FightDataHelper.fieldMgr.version

			if version < 7 then
				typeCls = FightOldClassOfTimelineDamage
			end
		end

		if type == 30 and self.entity.skill:sameSkillPlaying() then
			return
		end

		if self._lock_skill_bgm and type == 10 then
			return
		end

		if self.fightStepData.cusParam_lockTimelineTypes and self.fightStepData.cusParam_lockTimelineTypes[type] then
			return
		end

		local track = self.newClass(self, typeCls, id, type, self.binder, self)

		self.trackDic[id] = track

		if track.setContext then
			track:setContext(self.timelineContext)
		end

		local speed = FightModel.instance:getSpeed()

		duration = speed > 0 and duration / speed or duration

		track:onTrackStart(self.fightStepData, duration, param)
	else
		logError(string.format("%s 帧事件类型未实现: %s", (not self._timelineName or nil) and "nil", type))
	end
end

function FightSkillTimelineItem:skipSkill()
	for _, track in pairs(self.trackDic) do
		if track.skipSkill then
			track:skipSkill()
		end
	end
end

function FightSkillTimelineItem:_onTimelineEndCallback()
	if self.finishWork then
		self.finishWork:registFinishCallback(self.onTimelineEnd, self)
		self.finishWork:start()
	else
		self:onTimelineEnd()
	end
end

function FightSkillTimelineItem:addWork2FinishWork(work)
	self.finishWork = self.finishWork or self:com_registFlowSequence()
	work.CALLBACK_EVEN_IF_UNFINISHED = true

	self.finishWork:addWork(work)
end

function FightSkillTimelineItem:onTimelineEnd()
	self:endCallbackFunc()
end

function FightSkillTimelineItem:timelineEndNormalFunc()
	for k, track in pairs(self.trackDic) do
		if not track.signOfInvokedTrackEnd then
			track.signOfInvokedTrackEnd = true

			xpcall(track.onTrackEnd, __G__TRACKBACK__, track)
		end
	end

	self.entity.skill:clearSameSkillParam(self.fightStepData)
	self.workTimelineItem:onTimelineFinish()
end

function FightSkillTimelineItem:_sameSkillFlowOneDone()
	return
end

function FightSkillTimelineItem:_onFrameEventPauseCallback(type, id)
	local invokeTrackEnd = not self._same_skill_after_hit

	if self.entity.skill:sameSkillPlaying() then
		if type == 30 then
			invokeTrackEnd = false
		end

		if type ~= 9 or self.fightStepData.cus_Param_invokeSpineActTimelineEnd then
			-- block empty
		elseif self.entity.skill:isLastWork(self.workTimelineItem) then
			-- block empty
		else
			invokeTrackEnd = false
		end
	end

	local track = self.trackDic[id]

	if track and invokeTrackEnd and not track.signOfInvokedTrackEnd then
		track.signOfInvokedTrackEnd = true

		track:onTrackEnd()
	end
end

function FightSkillTimelineItem:stopCurTimelineWaitPlaySameSkill(same_skill_jump_type, act_ani_state)
	self._same_skill_after_hit = same_skill_jump_type == 0
	self.curAnimState = act_ani_state
	self.endCallbackFunc = self._sameSkillFlowOneDone

	if gohelper.isNil(self.entity.go) then
		return
	end

	FightSkillMgr.instance:afterTimeline(self.entity, self.fightStepData)
	FightMsgMgr.sendMsg(FightMsgId.PlayTimelineSkillFinish, self.entity, self.fightStepData.actId, self.fightStepData, self._timelineName)
	FightController.instance:dispatchEvent(FightEvent.OnSkillPlayFinish, self.entity, self.fightStepData.actId, self.fightStepData, self._timelineName)
	FightController.instance:dispatchEvent(FightEvent.ForceEndSkillStep, self.fightStepData)
end

function FightSkillTimelineItem:stopSkill()
	self:onLogicExit()
end

function FightSkillTimelineItem:GetDuration()
	return self.binder:GetDuration()
end

function FightSkillTimelineItem:onLogicExit()
	self.binder:RemoveFrameEventCallback()
	self.binder:RemoveEndCallback()
	self.binder:Stop(true)
	gohelper.destroy(self.timelineObj)
end

function FightSkillTimelineItem:dealDamageFromLostHp()
	for i, v in ipairs(self.fightStepData.actEffect) do
		if v.effectType == FightEnum.EffectType.DAMAGEFROMLOSTHP then
			self.flowForDamageFromLostHp = self.flowForDamageFromLostHp or self:com_registFlowSequence()

			self.flowForDamageFromLostHp:registWork(FightWorkDamageFromLostHp, self.fightStepData, v)
		end
	end

	if self.flowForDamageFromLostHp then
		self.flowForDamageFromLostHp:start()
	end
end

return FightSkillTimelineItem
