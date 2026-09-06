-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sharetask/controller/ShareTaskController.lua

module("logic.extensions.sharetask.controller.ShareTaskController", package.seeall)

local ShareTaskController = class("ShareTaskController", BaseController)

function ShareTaskController:onInit()
	ShareTaskAgent.instance:addHandler(ShareTaskAgent.ShareTaskInfoRes, self.SCShareTaskInfo, self)
	ShareTaskAgent.instance:addHandler(ShareTaskAgent.ShareTaskGainDiscoveryRewardRes, self.SCGainDiscoveryReward, self)
	ShareTaskAgent.instance:addHandler(ShareTaskAgent.ShareTaskChallengeMyBossRes, self.SCChallengeMyBoss, self, self.SCChallengeMyBossFail)
	ShareTaskAgent.instance:addHandler(ShareTaskAgent.NotifyTriggerShareTaskRes, self.SCNotifyTriggerBoss, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.CSShareTaskInfoReq, self)
	self:onReset()
end

function ShareTaskController:onReset()
	self.isStopTrigger = false
end

function ShareTaskController:CSShareTaskInfoReq()
	ShareTaskAgent.instance:sendShareTaskInfoReq()
end

function ShareTaskController:SCShareTaskInfo(msg, status)
	if status ~= 0 or msg == nil then
		return
	end

	ShareTaskModel.instance:InitShareTaskBaseInfo(msg)
	ShareTaskModel.instance:SetTriggerBossInfo(msg.boss)
end

function ShareTaskController:sendShareTaskStopTriggerInfoReq()
	ShareTaskAgent.instance:sendShareTaskStopTriggerInfoReq()
end

function ShareTaskController:sendGetShareTaskSetting(isStopTrigger)
	ShareTaskAgent.instance:sendShareTaskStopTriggerChangeReq(isStopTrigger)
end

function ShareTaskController:onGetShareTaskSetting(msg)
	self.isStopTrigger = msg.isStopTrigger

	GlobalDispatcher:dispatch(GlobalNotify.UpdataShareTaskBossSetting)
end

function ShareTaskController:CSGetMyBossInfoReq()
	ShareTaskAgent.instance:sendShareTaskRefreshBossInfoReq(function(msg)
		if msg == nil or msg.boss == nil then
			return
		end

		ShareTaskModel.instance:UpdataTriggerBossInfo(msg.boss.simpleInfo, msg.boss.participant)
	end)
end

function ShareTaskController:CSGainDiscoveryRewardReq()
	ShareTaskAgent.instance:sendShareTaskGainDiscoveryRewardReq()
end

function ShareTaskController:SCGainDiscoveryReward(msg, status)
	if status ~= 0 then
		return
	end

	ShareTaskModel.instance:UpdataFindRewardStage()
end

function ShareTaskController:CSChallengeMyBossReq()
	ShareTaskAgent.instance:sendShareTaskChallengeMyBossReq()
end

function ShareTaskController:SCChallengeMyBoss(msg, status)
	if status ~= 0 or msg == nil or msg.result == nil then
		if ViewMgr.instance:isOpen(ViewName.ShareMission) then
			UIStateManager.instance:clear(true)
		end

		return
	end

	ShareTaskModel.instance:SetChallengedBossInfo(msg.result)
	ShareTaskModel.instance:OnCreateAndRemoveNpc(true)
	BattleFacade.instance:startShareFightingByBtlResult(msg.result.battleResult)

	local bossInfo = ShareTaskModel.instance:GetMyShareBossInfo()
	local bossCfg = ShareTaskConfig.instance:GetBossBaseCfg(bossInfo.bossTypeId)

	BattleFacade.instance:startShareTask(bossInfo.bossId, true, bossCfg.creepsMasterId)
end

function ShareTaskController:SCChallengeMyBossFail()
	if ViewMgr.instance:isOpen(ViewName.ShareMission) then
		UIStateManager.instance:clear(true)
	end
end

function ShareTaskController:CSGetAssistListReq()
	ShareTaskAgent.instance:sendShareTaskAssistListReq(function(msg)
		if msg == nil or msg.simpleInfo == nil then
			return
		end

		ShareTaskModel.instance:UpdataBossAssistList(msg.simpleInfo)
		UIStateManager.instance:push(ViewName.ShareList)
	end, nil, function()
		return
	end)
end

function ShareTaskController:CSGetOtherBossInfoReq(bossId, viewName, param)
	local bossInfo = ShareTaskModel.instance:GetMyShareBossInfo()

	if bossInfo and bossInfo.bossId == bossId then
		ShareTaskAgent.instance:sendShareTaskRefreshBossInfoReq(function(msg)
			if msg == nil or msg.boss == nil then
				return
			end

			ShareTaskModel.instance:UpdataTriggerBossInfo(msg.boss.simpleInfo, msg.boss.participant)
			UIStateManager.instance:push(ViewName.BossProgress, false)
		end)

		return
	end

	ShareTaskAgent.instance:sendShareTaskOtherBossInfoReq(bossId, function(msg)
		local tempInfo = msg.boss

		if tempInfo == nil or tempInfo.simpleInfo == nil then
			return
		end

		if tempInfo.simpleInfo.curHp <= 0 then
			FloatWordMgr.instance:show("该怪物已击杀!")

			return
		end

		local allTime = ShareTaskConfig.instance:GetBossShowTime()

		if math.ceil(tempInfo.simpleInfo.startTime / 1000 + allTime - checknumber(ServerTime.now())) <= 0 then
			FloatWordMgr.instance:show("该怪物已逃离!")

			return
		end

		ShareTaskModel.instance:UpdataOtherBossList(tempInfo.simpleInfo, tempInfo.participant)

		if viewName == ViewName.ShareMission then
			UIStateManager.instance:push(viewName)
		else
			UIStateManager.instance:push(viewName, true, param)
		end
	end)
end

function ShareTaskController:CSHelpChallengeOtherBossReq(bossId, isFree)
	ShareTaskAgent.instance:sendShareTaskChallengeOtherBossReq(bossId, isFree, function(msg)
		if msg == nil or msg.result == nil then
			if ViewMgr.instance:isOpen(ViewName.ShareMission) then
				UIStateManager.instance:clear(true)
			end

			return
		end

		ShareTaskModel.instance:UpdataHelpChallBossIds(bossId, isFree)
		ShareTaskModel.instance:SetChallengedOtherBossInfo(msg.result)
		BattleFacade.instance:startShareFightingByBtlResult(msg.result.battleResult)

		local bossInfo = ShareTaskModel.instance:GetOtherShareBossInfo()
		local bossCfg = ShareTaskConfig.instance:GetBossBaseCfg(bossInfo.bossTypeId)

		BattleFacade.instance:startShareTask(bossId, false, bossCfg.creepsMasterId)
	end, nil, function()
		if ViewMgr.instance:isOpen(ViewName.ShareMission) then
			UIStateManager.instance:clear(true)
		end
	end)
end

function ShareTaskController:SCNotifyTriggerBoss(msg, status)
	if status ~= 0 or msg == nil or msg.simpleInfo == nil then
		return
	end

	ShareTaskModel.instance:ResetTriggerBossBase()
	ShareTaskModel.instance:UpdataTriggerBossInfo(msg.simpleInfo, nil)
	ShareTaskModel.instance:OnCreateAndRemoveNpc()

	if ViewMgr.instance:isOpen(ViewName.PlotChapterView) or ViewMgr.instance:isOpen(ViewName.EliteChapterView) or ViewMgr.instance:isOpen(ViewName.MopupMainView) then
		self:popBossTriggerView()

		ShareTaskModel.instance.isTriggerBoss = false

		return
	end

	ShareTaskModel.instance.isTriggerBoss = true
end

function ShareTaskController:popBossTriggerView()
	local info = {}

	info.tipsStr = "暗影来袭"

	function info.callBack()
		UIStateManager.instance:clear(true)
		UIStateManager.instance:popByName(ViewName.MopupMainView)
		UIStateManager.instance:popByName(ViewName.PlotStageView)
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		UIStateManager.instance:push(ViewName.ShareTask)
	end

	UIStateManager.instance:push(ViewName.BossTrigger, info)
end

ShareTaskController.instance = ShareTaskController.New()

return ShareTaskController
