-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/controller/GoddessGloryController.lua

module("logic.extensions.goddessglory.controller.GoddessGloryController", package.seeall)

local GoddessGloryController = class("GoddessGloryController", BaseController)

function GoddessGloryController:onInit()
	self:onReset()
end

function GoddessGloryController:onReset()
	self._lastRequestGoddessGlory = 0
	self._lastRequestGoddessGloryStageId = 0
	self._lastRequestGoddessGloryTask = 0
	self._lastRequestGoddessGloryStageTaskId = 0
	self._lastRequestGoddessGloryForm = 0
	self._lastRequestGoddessGloryStageFormId = 0
	self._lastRequestGoddessGloryTaskPrizeType = 0
	self._lastRequestGoddessGloryTaskPrizeId = 0

	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._onStageStoryEnded, self)

	self._lastReqRankChallengeId = 0
	self._lastReqRankStageId = 0
	self._lastRestartChallengeId = 0
	self._lastRestartStageId = 0
	self._lastWeeklyTaskChallengeId = 0
	self._lastWeeklyTaskTypeId = 0
	self._lastWeeklyTaskTaskId = 0
	self.showStageRuleWhileOpening = false
end

function GoddessGloryController:enterStage(challengeId, stageId)
	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._onStageStoryEnded, self)

	local stageData = GoddessGloryModel.instance:getGoddessGloryStage(challengeId, stageId)

	if not stageData then
		return
	end

	self.showStageRuleWhileOpening = false

	GoddessGloryModel.instance:setCurStageId(stageData.stageId)

	local storyId = stageData.storyId

	self._playStageStoryId = 0

	if storyId == 0 or stageData.hasPlayedStory then
		self.showStageRuleWhileOpening = true

		UIStateManager.instance:push(ViewName.GoddessGloryStageView)

		return
	end

	self._playStageStoryId = storyId

	GlobalDispatcher:addListener(GlobalNotify.EndStory, self._onStageStoryEnded, self)
	GoddessGloryModel.instance:setGoddessGloryStageStoryPlayed(challengeId, stageData.stageId)
	GlobalDispatcher:dispatch(GlobalNotify.StartStory, storyId)
end

function GoddessGloryController:_onStageStoryEnded(storyId)
	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._onStageStoryEnded, self)

	local stageId = GoddessGloryModel.instance:getCurStageId()
	local challenge = GoddessGloryModel.instance:getCurGoddessGloryId()

	if challenge == 0 or stageId == 0 then
		return
	end

	local stageMo = GoddessGloryModel.instance:getGoddessGloryStage(challenge, stageId)

	if stageMo.storyId == storyId then
		self.showStageRuleWhileOpening = true

		UIStateManager.instance:push(ViewName.GoddessGloryStageView)
	end
end

function GoddessGloryController:exexuteEvent(evtData)
	local evtCo = GoddessGloryConfig.instance:getEventCo(evtData.eventId)

	if evtCo.type == GoddessGloryEvtType.Recruit then
		ViewMgr.instance:open(ViewName.GoddessGloryRecrutView, evtData)
	elseif evtCo.type == GoddessGloryEvtType.Challenge then
		UIStateManager.instance:push(ViewName.GoddesGloryMissionView, evtData)
	elseif evtCo.type == GoddessGloryEvtType.ExtFormation then
		local challengeId = GoddessGloryModel.instance:getCurGoddessGloryId()
		local stageId = GoddessGloryModel.instance:getCurStageId()
		local stageMO = GoddessGloryModel.instance:getGoddessGloryStage(challengeId, stageId)

		if stageMO:getEnergy() < evtCo.cost then
			FloatWordMgr.instance:show("当前能量不足")

			return
		end

		TipsFacade.instance:openPopupWindow(lang("tip"), string.format("是否消耗%s能量增加一个上阵位置？", evtCo.cost), function()
			self:requestGoddessGloryDoEvent(challengeId, stageId, evtData.instanceId, 0)
		end, function()
			return
		end, "确定", "取消")
	elseif evtCo.type == GoddessGloryEvtType.Refresh then
		local challengeId = GoddessGloryModel.instance:getCurGoddessGloryId()
		local stageId = GoddessGloryModel.instance:getCurStageId()
		local stageMO = GoddessGloryModel.instance:getGoddessGloryStage(challengeId, stageId)

		if stageMO:getEnergy() < evtCo.cost then
			FloatWordMgr.instance:show("当前能量不足")

			return
		end

		TipsFacade.instance:openPopupWindow(lang("tip"), string.format("是否消耗%s能量刷新事件？", evtCo.cost), function()
			self:requestGoddessGloryDoEvent(challengeId, stageId, evtData.instanceId, 0)
		end, function()
			return
		end, "确定", "取消")
	end
end

function GoddessGloryController:requestGoddessGlory(id)
	GoddessGloryModel.instance:setGoddessGlory(id)
end

function GoddessGloryController:requestGoddessGloryGetInfoReq(challengeId, stageId)
	if self._lastRequestGoddessGlory ~= 0 or self._lastRequestGoddessGloryStageId ~= 0 then
		return
	end

	self._lastRequestGoddessGlory = challengeId
	self._lastRequestGoddessGloryStageId = stageId

	GoddessGloryAgent.instance:sendPM_GoddessGloryGetInfoReq(challengeId, stageId)
end

function GoddessGloryController:onGoddessGloryGetInfo(status, msg)
	local challengeId = self._lastRequestGoddessGlory
	local stageId = self._lastRequestGoddessGloryStageId

	self._lastRequestGoddessGlory = 0
	self._lastRequestGoddessGloryStageId = 0

	if status ~= 0 or challengeId == 0 or stageId == 0 then
		return
	end

	GoddessGloryModel.instance:setGoddessGloryStageInfo(challengeId, stageId, msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnGoddeddGloryStageInfo, challengeId, stageId)
end

function GoddessGloryController:requestGoddessGlorySelectPet(challengeId, stageId, petIds)
	if self._lastRequestGoddessGlory ~= 0 or self._lastRequestGoddessGloryStageId ~= 0 then
		return
	end

	self._lastRequestGoddessGlory = challengeId
	self._lastRequestGoddessGloryStageId = stageId

	GoddessGloryAgent.instance:sendPM_GoddessGlorySelectPetReq(challengeId, stageId, petIds)
end

function GoddessGloryController:onGoddessGlorySelectPet(msg)
	local challengeId = self._lastRequestGoddessGlory
	local stageId = self._lastRequestGoddessGloryStageId

	self._lastRequestGoddessGlory = 0
	self._lastRequestGoddessGloryStageId = 0

	if challengeId == 0 or stageId == 0 then
		return
	end

	GoddessGloryModel.instance:setGoddessGloryStageInfo(challengeId, stageId, msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnGoddeddGlorySelPets, challengeId, stageId)
end

function GoddessGloryController:requestGoddessGloryTaskInfo(challengeId, stageId)
	if self._lastRequestGoddessGloryTask ~= 0 or self._lastRequestGoddessGloryStageTaskId ~= 0 then
		return
	end

	self._lastRequestGoddessGloryTask = challengeId
	self._lastRequestGoddessGloryStageTaskId = stageId

	GoddessGloryAgent.instance:sendPM_GoddessGloryGetTaskInfoReq(challengeId, stageId)
end

function GoddessGloryController:onGoddessGloryTaskInfo(status, msg)
	local challengeId = self._lastRequestGoddessGloryTask
	local stageId = self._lastRequestGoddessGloryStageTaskId

	self._lastRequestGoddessGloryTask = 0
	self._lastRequestGoddessGloryStageTaskId = 0

	if status ~= 0 or challengeId == 0 or stageId == 0 then
		return
	end

	GoddessGloryModel.instance:setGoddessGloryTaskInfo(challengeId, stageId, msg.taskInfos)
	GlobalDispatcher:dispatch(GlobalNotify.OnGoddeddGloryTasks, challengeId, stageId)
end

function GoddessGloryController:requestGoddessGloryGetForm(challengeId, stageId)
	if self._lastRequestGoddessGloryForm ~= 0 or self._lastRequestGoddessGloryStageFormId ~= 0 then
		return
	end

	self._lastRequestGoddessGloryForm = challengeId
	self._lastRequestGoddessGloryStageFormId = stageId

	GoddessGloryAgent.instance:sendPM_GoddessGloryGetFormReq(challengeId, stageId)
end

function GoddessGloryController:onGoddessGloryGetForm(status, msg)
	local challengeId = self._lastRequestGoddessGloryForm
	local stageId = self._lastRequestGoddessGloryStageFormId

	self._lastRequestGoddessGloryForm = 0
	self._lastRequestGoddessGloryStageFormId = 0

	if status ~= 0 or challengeId == 0 or stageId == 0 then
		return
	end

	GoddessGloryFmtModel.instance:setFormation(challengeId, stageId, msg.canFormCount, msg.simpleForm)
	GlobalDispatcher:dispatch(GlobalNotify.OnGoddeddGloryFormations, challengeId, stageId)
end

function GoddessGloryController:requestGoddessGlorySetForm(form, challengeId, stageId)
	if self._lastRequestGoddessGloryForm ~= 0 or self._lastRequestGoddessGloryStageFormId ~= 0 then
		return
	end

	self._lastRequestGoddessGloryForm = challengeId
	self._lastRequestGoddessGloryStageFormId = stageId

	GoddessGloryAgent.instance:sendPM_GoddessGlorySetFormReq(form, challengeId, stageId)
end

function GoddessGloryController:onGoddessGlorySetForm(status, msg)
	local challengeId = self._lastRequestGoddessGloryForm
	local stageId = self._lastRequestGoddessGloryStageFormId

	self._lastRequestGoddessGloryForm = 0
	self._lastRequestGoddessGloryStageFormId = 0

	if status ~= 0 or challengeId == 0 or stageId == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)

		return
	end

	GoddessGloryFmtModel.instance:onGoddessGlorySetForm(msg)
end

function GoddessGloryController:requestGoddessGloryDoEvent(challengeId, stageId, instanceId, selectId)
	GoddessGloryAgent.instance:sendPM_GoddessGloryDoEventReq(challengeId, stageId, instanceId, selectId)
end

function GoddessGloryController:onGoddessGloryDoEventOver(msg)
	GoddessGloryModel.instance:onGoddessGloryDoEventOver(msg)

	if checknumber(msg.newPetId) ~= 0 then
		GoddessGloryPetsModel.instance:addPet(msg.challengeId, msg.stageId, msg.newPetId)
	end

	local evt = GoddessGloryModel.instance:getEvent(msg.challengeId, msg.stageId, msg.instanceId)
	local evtCo = GoddessGloryConfig.instance:getEventCo(evt.eventId)

	if evtCo.type == GoddessGloryEvtType.ExtFormation and msg.isFinish then
		GoddessGloryFmtModel.instance:addCanFormCount(msg.challengeId, msg.stageId)
	end

	GoddessGloryModel.instance:clearTasks(msg.challengeId, msg.stageId)
	GlobalDispatcher:dispatch(GlobalNotify.OnGoddeddGloryDoEvent, msg.challengeId, msg.stageId, msg.instanceId)
end

function GoddessGloryController:requestGoddessGloryGainPrize(challengeId, stageId, type, taskId)
	if self._lastRequestGoddessGloryTask ~= 0 or self._lastRequestGoddessGloryStageTaskId ~= 0 or self._lastRequestGoddessGloryTaskPrizeType ~= 0 or self._lastRequestGoddessGloryTaskPrizeId ~= 0 then
		return
	end

	self._lastRequestGoddessGloryTask = challengeId
	self._lastRequestGoddessGloryStageTaskId = stageId
	self._lastRequestGoddessGloryTaskPrizeType = type
	self._lastRequestGoddessGloryTaskPrizeId = taskId

	GoddessGloryAgent.instance:sendPM_GoddessGloryGainPrizeReq(challengeId, stageId, type, taskId)
end

function GoddessGloryController:onGoddessGloryGainPrize(status, msg)
	local challengeId = self._lastRequestGoddessGloryTask
	local stageId = self._lastRequestGoddessGloryStageTaskId
	local typeId = self._lastRequestGoddessGloryTaskPrizeType
	local taskId = self._lastRequestGoddessGloryTaskPrizeId

	self._lastRequestGoddessGloryTask = 0
	self._lastRequestGoddessGloryStageTaskId = 0
	self._lastRequestGoddessGloryTaskPrizeType = 0
	self._lastRequestGoddessGloryTaskPrizeId = 0

	if status ~= 0 or challengeId == 0 or stageId == 0 or typeId == 0 or taskId == 0 then
		return
	end

	GoddessGloryModel.instance:gainGoddessGloryTaskPrize(challengeId, stageId, typeId, taskId)
	GlobalDispatcher:dispatch(GlobalNotify.OnGoddeddGloryGainTaskPrize, challengeId, stageId)
end

function GoddessGloryController:requestGoddessGloryViewRank(challengeId, stageId)
	if self._lastReqRankChallengeId ~= 0 or self._lastReqRankStageId ~= 0 then
		return
	end

	self._lastReqRankChallengeId = challengeId
	self._lastReqRankStageId = stageId

	GoddessGloryAgent.instance:sendPM_GoddessGloryViewRankReq(challengeId, stageId)
end

function GoddessGloryController:onGoddessGloryViewRank(status, msg)
	local challengeId = self._lastReqRankChallengeId
	local stageId = self._lastReqRankStageId

	self._lastReqRankChallengeId = 0
	self._lastReqRankStageId = 0

	if status ~= 0 or challengeId == 0 or stageId == 0 then
		return
	end

	GoddessGloryModel.instance:onGoddessGloryViewRank(challengeId, stageId, msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnGoddeddGloryRankList, challengeId, stageId)
end

function GoddessGloryController:requestGoddessGloryReset(challengeId, stageId)
	if self._lastRestartChallengeId ~= 0 or self._lastRestartStageId ~= 0 then
		return
	end

	self._lastRestartChallengeId = challengeId
	self._lastRestartStageId = stageId

	GoddessGloryAgent.instance:sendPM_GoddessGloryResetReq(challengeId, stageId)
end

function GoddessGloryController:onGoddessGloryReset(status)
	local challengeId = self._lastRestartChallengeId
	local stageId = self._lastRestartStageId

	self._lastRestartChallengeId = 0
	self._lastRestartStageId = 0

	if status ~= 0 or challengeId == 0 or stageId == 0 then
		return
	end

	GoddessGloryModel.instance:resetGoddessGlory(challengeId, stageId)
	GoddessGloryPetsModel.instance:clearPets(challengeId, stageId)
	GoddessGloryFmtModel.instance:clearFormation(challengeId, stageId)
	GlobalDispatcher:dispatch(GlobalNotify.OnGoddeddGloryRetset, challengeId, stageId)
end

function GoddessGloryController:requestGoddessGloryGetWeeklyTasks(challengeId)
	if self._lastWeeklyTaskChallengeId ~= 0 then
		return
	end

	self._lastWeeklyTaskChallengeId = challengeId

	GoddessGloryAgent.instance:sendPM_GoddessGloryGetWeeklyTasksReq(challengeId)
end

function GoddessGloryController:onGoddessGloryGetWeeklyTasks(status, msg)
	local challengeId = self._lastWeeklyTaskChallengeId

	self._lastWeeklyTaskChallengeId = 0

	if status ~= 0 or challengeId == 0 then
		return
	end

	GoddessGloryModel.instance:setGoddessGloryGetWeeklyTasks(challengeId, msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnGoddeddGloryWeeklyTasks, challengeId)
end

function GoddessGloryController:requestGoddessGloryGainWeeklyPrize(challengeId, type, taskId)
	if self._lastWeeklyTaskChallengeId ~= 0 or self._lastWeeklyTaskTypeId ~= 0 or self._lastWeeklyTaskTaskId ~= 0 then
		return
	end

	self._lastWeeklyTaskChallengeId = challengeId
	self._lastWeeklyTaskTypeId = type
	self._lastWeeklyTaskTaskId = taskId

	GoddessGloryAgent.instance:sendPM_GoddessGloryGainWeeklyPrizeReq(challengeId, type, taskId)
end

function GoddessGloryController:onGoddessGloryGainWeeklyPrize(status, msg)
	local challengeId = self._lastWeeklyTaskChallengeId
	local typeId = self._lastWeeklyTaskTypeId
	local taskId = self._lastWeeklyTaskTaskId

	self._lastWeeklyTaskChallengeId = 0
	self._lastWeeklyTaskTypeId = 0
	self._lastWeeklyTaskTaskId = 0

	if status ~= 0 or challengeId == 0 or typeId == 0 or taskId == 0 then
		return
	end

	GoddessGloryModel.instance:gainGoddessGloryWeeklyTaskPrize(challengeId, typeId, taskId)
	GlobalDispatcher:dispatch(GlobalNotify.OnGoddeddGloryGainWeeklyTaskPrize, challengeId, typeId, taskId)
end

GoddessGloryController.instance = GoddessGloryController.New()

return GoddessGloryController
