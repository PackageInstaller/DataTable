-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventPlayServerEffect.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventPlayServerEffect", package.seeall)

local FightTLEventPlayServerEffect = class("FightTLEventPlayServerEffect", FightTimelineTrackItem)

function FightTLEventPlayServerEffect:onTrackStart(fightStepData, duration, paramsArr)
	self._list = {}
	self.fightStepData = fightStepData

	if paramsArr[1] == "1" then
		self:_playEffect(FightEnum.EffectType.SUMMONEDDELETE)
	end

	if paramsArr[2] == "1" then
		self:_playEffect(FightEnum.EffectType.MAGICCIRCLEDELETE)
	end

	if paramsArr[3] == "1" then
		self:_playEffect(FightEnum.EffectType.MAGICCIRCLEADD)
	end

	if paramsArr[4] == "1" then
		self:_playEffect(FightEnum.EffectType.MOVE)
	end

	if paramsArr[5] == "1" then
		self:_playEffect(FightEnum.EffectType.MOVEFRONT)
	end

	if paramsArr[6] == "1" then
		self:_playEffect(FightEnum.EffectType.MOVEBACK)
	end

	if paramsArr[7] == "1" then
		self:_playEffect(FightEnum.EffectType.AVERAGELIFE)
	end

	if paramsArr[8] == "1" then
		self:_playEffect(FightEnum.EffectType.BUFFADD)
	end

	if paramsArr[9] == "1" then
		self:_playEffect(FightEnum.EffectType.BUFFDEL)
	end

	if not string.nilorempty(paramsArr[10]) then
		for i, v in ipairs(self.fightStepData.actEffect) do
			if v.effectType == FightEnum.EffectType.BUFFADD then
				local buffId = v.buff.buddId
				local buffConfig = lua_skill_buff.configDict[buffId]
				local buffTypeConfig = buffConfig and lua_skill_bufftype.configDict[buffConfig.typeId]

				if buffTypeConfig and buffTypeConfig.type == tonumber(paramsArr[10]) then
					local class = FightWork2Work.New(FightStepBuilder.ActEffectWorkCls[FightEnum.EffectType.BUFFADD], self.fightStepData, v)

					class:onStart()
					table.insert(self._list, class)
				end
			end
		end
	end

	if not string.nilorempty(paramsArr[11]) then
		for i, v in ipairs(self.fightStepData.actEffect) do
			if v.effectType == FightEnum.EffectType.BUFFDEL then
				local buffId = v.buff.buddId
				local buffConfig = lua_skill_buff.configDict[buffId]
				local buffTypeConfig = buffConfig and lua_skill_bufftype.configDict[buffConfig.typeId]

				if buffTypeConfig and buffTypeConfig.type == tonumber(paramsArr[11]) then
					local class = FightWork2Work.New(FightStepBuilder.ActEffectWorkCls[FightEnum.EffectType.BUFFDEL], self.fightStepData, v)

					class:onStart()
					table.insert(self._list, class)
				end
			end
		end
	end

	if not string.nilorempty(paramsArr[12]) then
		for i, v in ipairs(self.fightStepData.actEffect) do
			if v.configEffect == FightTLEventDefHit.nuoDiKaLostLife then
				local work = self:com_registWork(FightWorkNuoDikaLostLifeTimeline, v, self.fightStepData, paramsArr[12])

				self:addWork2TimelineFinishWork(work)
				work:start()
			end
		end
	end

	if not string.nilorempty(paramsArr[13]) then
		self.timelineItem.workTimelineItem:onDoneAndKeepPlay()
	end

	local noConditionParam = paramsArr[14]

	if not string.nilorempty(noConditionParam) then
		local arr = string.split(noConditionParam, "#")
		local work = self:com_registWork(Work2FightWork, FightWorkNormalDialog, FightViewDialog.Type.NoCondition, tonumber(arr[2]))

		if arr[4] ~= "1" then
			self:addWork2TimelineFinishWork(work)
		end

		if arr[3] == "1" then
			work:start()
		end

		if arr[4] == "1" then
			self.hideDialogWhenEnd = true
		end
	end

	local param15 = paramsArr[15]

	if not string.nilorempty(param15) and param15 == "1" then
		self.hideMySideBuffEffect = true

		for entityId, entity in pairs(FightGameMgr.entityMgr.entityDic) do
			if entity:isMySide() and entity.buff then
				entity.buff:hideBuffEffects("FightTLEventPlayServerEffect15")
			end
		end
	end

	local param16 = paramsArr[16]

	if not string.nilorempty(param16) then
		local storyId = tonumber(param16)

		if (FightDataHelper.stateMgr.isReplay or nil) and false then
			local flow = self:com_registFlowSequence()

			flow:registWork(FightWorkWaitMsg, FightMsgId.PlayStoryEndInTimeline)

			local param = {}

			param.mark = true
			param.episodeId = FightDataHelper.fieldMgr.episodeId

			StoryController.instance:playStory(storyId, param, self._afterPlayStory, self)
			self:addWork2TimelineFinishWork(flow)
			flow:start()
		end
	end
end

function FightTLEventPlayServerEffect:_afterPlayStory()
	FightMsgMgr.sendMsg(FightMsgId.PlayStoryEndInTimeline)
end

function FightTLEventPlayServerEffect:_playEffect(effectType)
	for i, v in ipairs(self.fightStepData.actEffect) do
		if v.effectType == effectType then
			local class = FightWork2Work.New(FightStepBuilder.ActEffectWorkCls[effectType], self.fightStepData, v)

			class:onStart()
			table.insert(self._list, class)
		end
	end
end

function FightTLEventPlayServerEffect:onTrackEnd()
	return
end

function FightTLEventPlayServerEffect:onDestructor()
	if self.hideMySideBuffEffect then
		for entityId, entity in pairs(FightGameMgr.entityMgr.entityDic) do
			if entity:isMySide() and entity.buff then
				entity.buff:showBuffEffects("FightTLEventPlayServerEffect15")
			end
		end
	end

	if self._list then
		for i, v in ipairs(self._list) do
			v:onStop()
		end

		self._list = nil
	end

	if self.hideDialogWhenEnd then
		FightController.instance:dispatchEvent(FightEvent.HideFightDialog)
	end
end

return FightTLEventPlayServerEffect
