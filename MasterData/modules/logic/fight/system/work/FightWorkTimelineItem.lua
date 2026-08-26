-- chunkname: @modules/logic/fight/system/work/FightWorkTimelineItem.lua

module("modules.logic.fight.system.work.FightWorkTimelineItem", package.seeall)

local FightWorkTimelineItem = class("FightWorkTimelineItem", FightWorkItem)

function FightWorkTimelineItem:onConstructor(entity, timelineName, fightStepData)
	self.entity = entity
	self.timelineName = timelineName
	self.fightStepData = fightStepData
	self.timelineUrl = ResUrl.getSkillTimeline(self.timelineName)
	self.skillId = self.fightStepData.actId

	FightMsgMgr.sendMsg(FightMsgId.BeforePlayTimeline, self.entity.id, self.skillId, self.fightStepData, self.timelineName)
end

function FightWorkTimelineItem:onStart()
	if self.entity then
		local entityMo = self.entity:getMO()
		local skin = entityMo and entityMo.skin
		local flow = self:com_registFlowSequence()
		local work = FightPreloadOneTimelineRefWork.New(self.timelineName, skin, self)

		flow:addWork(work)
		flow:registFinishCallback(self.onLoadTimelineDone, self)
		flow:onStart()
		self:cancelFightWorkSafeTimer()
	end
end

function FightWorkTimelineItem:onLoadTimelineDone()
	if gohelper.isNil(self.timelineAssetItem) then
		logError("timeline 资源加载失败: " .. tostring(self.timelineName))

		return self:onDone(true)
	end

	FightHelper.logForPCSkillEditor("播放timeline:" .. tostring(self.timelineName))

	local flow = self:com_registFlowSequence()
	local jsonArr = FightTLHelper.getTLJsonData(self.timelineAssetItem, self.timelineUrl)

	for i = 1, #jsonArr, 2 do
		local tlType = tonumber(jsonArr[i])
		local paramList = jsonArr[i + 1]

		if tlType == 36 then
			local param1 = paramList[1]

			if not string.nilorempty(param1) then
				local arr = string.splitToNumber(param1, ",")

				if param1 == "0,0,0" then
					local config = lua_fight_camera_player_turn_offset.configDict[FightGameMgr.sceneLevelMgr.levelId]

					if config then
						arr[1] = config.offset[1]
						arr[2] = config.offset[2]
						arr[3] = config.offset[3]
					end
				end

				local virsualCamerasGO = CameraMgr.instance:getVirtualCameraGO()

				transformhelper.setLocalPos(virsualCamerasGO.transform, arr[1], arr[2], arr[3])
				flow:registWork(FightWorkDelayTimer, 0.1)
			end
		end
	end

	flow:registWork(FightWorkFunction, self.startTimeline, self)
	flow:start()
end

function FightWorkTimelineItem:dealSpeed()
	FightHelper.setBossSkillSpeed(self.entity.id)
	FightHelper.setTimelineExclusiveSpeed(self.timelineName)
	FightModel.instance:updateRTPCSpeed()
end

function FightWorkTimelineItem:setTimelineAssetItem(assetItem)
	self.timelineAssetItem = assetItem
end

function FightWorkTimelineItem:getTimelineAssetItem()
	return self.timelineAssetItem
end

function FightWorkTimelineItem:startTimeline()
	self:dealSpeed()

	self._startTime = Time.time

	self:beforePlayTimeline()

	self.timelineItem = self.newClass(self, FightSkillTimelineItem, self)

	self.timelineItem:play()
	FightMsgMgr.sendMsg(FightMsgId.PlayTimelineSkill, self.entity, self.skillId, self.fightStepData, self.timelineName)
	FightController.instance:dispatchEvent(FightEvent.OnSkillPlayStart, self.entity, self.skillId, self.fightStepData, self.timelineName)
end

function FightWorkTimelineItem:sameSkillPlaying()
	return false
end

function FightWorkTimelineItem:setTimeScale(scale)
	if self.timelineItem then
		self.timelineItem:setTimeScale(scale)
	end
end

function FightWorkTimelineItem:getBinder()
	return self.timelineItem and self.timelineItem.binder
end

function FightWorkTimelineItem:skipSkill()
	if not self.timelineItem then
		return
	end

	self.timelineItem:skipSkill()
	self.timelineItem:onTimelineEnd()
end

function FightWorkTimelineItem:onTimelineFinish()
	if not ((self.skipAfterTimelineFunc or nil) and true) then
		self:afterPlayTimeline()
	end

	CameraMgr.instance:getCameraShake():StopShake()
	FightHelper.cancelBossSkillSpeed()
	FightHelper.cancelExclusiveSpeed()
	FightModel.instance:updateRTPCSpeed()
	FightMsgMgr.sendMsg(FightMsgId.PlayTimelineSkillFinish, self.entity, self.skillId, self.fightStepData, self.timelineName)
	FightController.instance:dispatchEvent(FightEvent.OnSkillPlayFinish, self.entity, self.skillId, self.fightStepData, self.timelineName)

	if not self.IS_DISPOSED then
		self:onDone(true)
	end
end

function FightWorkTimelineItem:afterPlayTimeline()
	FightSkillMgr.instance:afterTimeline(self.entity, self.fightStepData)

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.AiJiAoQteIng) then
		return
	end

	self:_resetTargetHp()

	if self.entity.buff then
		self.entity.buff:showBuffEffects("before_skill_timeline")
	end

	if self.hide_defenders_buff_effect then
		FightHelper.revertDefenderBuffEffect(self.hide_defenders_buff_effect, "before_skill_timeline")

		self.hide_defenders_buff_effect = nil
	end

	if not FightSkillMgr.instance:isPlayingAnyTimeline() then
		FightFloatMgr.instance:resetInterval()
		self:_cancelSideRenderOrder()
		GameSceneMgr.instance:getCurScene().camera:enablePostProcessSmooth(false)

		if self.fightStepData.hasPlayTimelineCamera then
			GameSceneMgr.instance:getCurScene().camera:resetParam()
		end

		FightGameMgr.entityMgr.enableSpineRotate = true

		local entity_mo = self.entity:getMO()

		if entity_mo and entity_mo:isPassiveSkill(self.skillId) then
			-- block empty
		else
			FightGameMgr.sceneLevelMgr:setFrontVisible(true)
		end

		FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, true)
		FightController.instance:dispatchEvent(FightEvent.SetIsShowFloat, true)
		FightController.instance:dispatchEvent(FightEvent.SetIsShowNameUI, true)
	end
end

function FightWorkTimelineItem:beforePlayTimeline()
	self:setSideRenderOrder()

	if self.entity.buff then
		self.entity.buff:hideLoopEffects("before_skill_timeline")
	end

	for i, entity_id in pairs(FightHelper.hideDefenderBuffEffect(self.fightStepData, "before_skill_timeline")) do
		self.hide_defenders_buff_effect = self.hide_defenders_buff_effect or {}

		table.insert(self.hide_defenders_buff_effect, entity_id)
	end

	if not FightSkillMgr.instance:isPlayingAnyTimeline() then
		if not self.entity.skill:sameSkillPlaying() then
			FightFloatMgr.instance:removeInterval()
		end

		local entity_mo = self.entity:getMO()

		if entity_mo and entity_mo:isPassiveSkill(self.skillId) then
			-- block empty
		elseif (lua_fight_ignore_hide_front_effect.configDict[self.timelineName] or nil) and false then
			FightGameMgr.sceneLevelMgr:setFrontVisible(false)
		end
	end

	FightSkillMgr.instance:beforeTimeline(self.entity, self.fightStepData)
end

function FightWorkTimelineItem:setSideRenderOrder()
	local sideEntitys = FightHelper.getSideEntitys(self.entity:getSide(), true)
	local battleId = FightModel.instance:getFightParam().battleId

	for i, entity in ipairs(sideEntitys) do
		local ignore
		local ignoreBattle = FightEnum.AtkRenderOrderIgnore[battleId]

		if ignoreBattle then
			local ignoreSide = ignoreBattle[entity:getSide()]

			if ignoreSide and tabletool.indexOf(ignoreSide, entity:getMO().position) then
				ignore = true
			end
		end

		if not ignore then
			sideEntitys[i] = entity.id
		end
	end

	local entityId2SortId = FightRenderOrderMgr.sortOrder(FightEnum.RenderOrderType.StandPos, sideEntitys)

	for entityId, sortId in pairs(entityId2SortId) do
		FightRenderOrderMgr.instance:setOrder(entityId, FightEnum.TopOrderFactor + sortId - 1)
	end
end

function FightWorkTimelineItem:_cancelSideRenderOrder()
	local allEntitys = FightHelper.getAllEntitys(self.entity:getSide())

	for _, entity in ipairs(allEntitys) do
		FightRenderOrderMgr.instance:cancelOrder(entity.id)
	end

	FightRenderOrderMgr.instance:setSortType(FightEnum.RenderOrderType.StandPos)
end

function FightWorkTimelineItem:_resetTargetHp()
	for _, actEffectData in ipairs(self.fightStepData.actEffect) do
		local oneDefender = FightHelper.getEntity(actEffectData.targetId)

		if oneDefender and oneDefender.nameUI then
			oneDefender.nameUI:resetHp()
		end
	end
end

function FightWorkTimelineItem:clearWork()
	return
end

function FightWorkTimelineItem:onDestructor()
	FightMsgMgr.sendMsg(FightMsgId.OnTimelineWorkDestroyed, self.entity.id, self.skillId, self.fightStepData, self.timelineName)

	if FightScene.isLowMemory then
		FightHelper.clearNoUseEffect()
	end
end

return FightWorkTimelineItem
