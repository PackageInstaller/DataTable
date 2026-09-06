-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschoolpvp/controller/MagicSchoolPvPController.lua

module("logic.extensions.magicschoolpvp.controller.MagicSchoolPvPController", package.seeall)

local MagicSchoolPvPController = class("MagicSchoolPvPController", BaseController)

function MagicSchoolPvPController:onInit()
	self:onReset()
end

function MagicSchoolPvPController:onReset()
	self._isApplicationPause = false

	self:_stopTickingBattle()
	GlobalDispatcher:addListener(GlobalNotify.ApplicationPause, self._onApplicationPause, self)
	GlobalDispatcher:addListener(GlobalNotify.ApplicationResume, self._onApplicationResume, self)
end

function MagicSchoolPvPController:_onApplicationPause()
	self._isApplicationPause = true
end

function MagicSchoolPvPController:_onApplicationResume()
	self._isApplicationPause = false
end

function MagicSchoolPvPController:sendPM_MSPvPInfoReq(activityId)
	MagicSchoolPvPAgent.instance:sendPM_MSPvPInfoReq(activityId)
end

function MagicSchoolPvPController:handlePM_MSPvPInfoRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_MSPvPInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MSPvPInfoRes)
end

function MagicSchoolPvPController:sendPM_MSPvPGetPresetFormationReq(activityId)
	MagicSchoolPvPAgent.instance:sendPM_MSPvPGetPresetFormationReq(activityId)
end

function MagicSchoolPvPController:handlePM_MSPvPGetPresetFormationRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_MSPvPGetPresetFormationRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MSPvPGetPresetFormationRes)
end

function MagicSchoolPvPController:sendPM_MSPvPSetPresetFormationReq(activityId, simpleForm)
	MagicSchoolPvPAgent.instance:sendPM_MSPvPSetPresetFormationReq(activityId, simpleForm)
end

function MagicSchoolPvPController:handlePM_MSPvPSetPresetFormationRes(status, msg)
	if status == 0 then
		local subMo = self:getSubMo(msg.activityId)

		subMo:handlePM_MSPvPSetPresetFormationRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MSPvPSetPresetFormationRes, status)
end

function MagicSchoolPvPController:sendPM_MSPvPAskSwitchReq(activityId, targetUserId, originBossId, askBossId)
	MagicSchoolPvPAgent.instance:sendPM_MSPvPAskSwitchReq(activityId, targetUserId, originBossId, askBossId)
end

function MagicSchoolPvPController:handlePM_MSPvPAskSwitchRes(msg)
	return
end

function MagicSchoolPvPController:sendPM_MSPvPAskHandleSwitchReq(activityId, agree)
	MagicSchoolPvPAgent.instance:sendPM_MSPvPAskHandleSwitchReq(activityId, agree)
end

function MagicSchoolPvPController:handlePM_MSPvPAskHandleSwitchRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MSPvPAskHandleSwitchRes)
end

function MagicSchoolPvPController:sendPM_MSPvPSetFormationReq(activityId, simpleForm)
	MagicSchoolPvPAgent.instance:sendPM_MSPvPSetFormationReq(activityId, simpleForm)
end

function MagicSchoolPvPController:handlePM_MSPvPSetFormationRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MSPvPSetFormationRes, status)
end

function MagicSchoolPvPController:sendPM_MSPvPSelectBuffReq(activityId, buffId)
	MagicSchoolPvPAgent.instance:sendPM_MSPvPSelectBuffReq(activityId, buffId)
end

function MagicSchoolPvPController:handlePM_MSPvPSelectBuffRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MSPvPSelectBuffRes, status)
end

function MagicSchoolPvPController:sendPM_MSPvPChatReq(activityId, chatId)
	MagicSchoolPvPAgent.instance:sendPM_MSPvPChatReq(activityId, chatId)
end

function MagicSchoolPvPController:handlePM_MSPvPChatRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MSPvPChatRes)
end

function MagicSchoolPvPController:sendPM_MSPvPRankInfoReq(activityId)
	MagicSchoolPvPAgent.instance:sendPM_MSPvPRankInfoReq(activityId)
end

function MagicSchoolPvPController:handlePM_MSPvPRankInfoRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_MSPvPRankInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MSPvPRankInfoRes, msg)
end

function MagicSchoolPvPController:handlePM_NotifyMSPvPMatchStartRes(msg)
	local activityId = self:getActivityId()
	local subMo = self:getSubMo(activityId)

	subMo:handlePM_NotifyMSPvPMatchStartRes(msg)
	self:doCurrentPeriodEvent(activityId, MagicSchoolPvPEnum.PeriodType_Match)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_NotifyMSPvPMatchStartRes)
end

function MagicSchoolPvPController:handlePM_NotifyMSPvPMatchOverTimeRes(msg)
	local activityId = self:getActivityId()
	local subMo = self:getSubMo(activityId)

	subMo:handlePM_NotifyMSPvPMatchOverTimeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_NotifyMSPvPMatchOverTimeRes)
end

function MagicSchoolPvPController:handlePM_NotifyMSPvPMatchFailRes(msg)
	local activityId = self:getActivityId()
	local subMo = self:getSubMo(activityId)

	subMo:handlePM_NotifyMSPvPMatchFailRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_NotifyMSPvPMatchFailRes)
end

function MagicSchoolPvPController:handlePM_NotifyMSPvPGameStartRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_NotifyMSPvPGameStartRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_NotifyMSPvPGameStartRes)
end

function MagicSchoolPvPController:handlePM_NotifyMSPvPAskSwitchPositionRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_NotifyMSPvPAskSwitchPositionRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_NotifyMSPvPAskSwitchPositionRes, msg)
end

function MagicSchoolPvPController:handlePM_NotifyMSPvPAskSwitchPositionResultRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_NotifyMSPvPAskSwitchPositionResultRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_NotifyMSPvPAskSwitchPositionResultRes, msg)
end

function MagicSchoolPvPController:handlePM_NotifyMsPvPWatchBattleResultRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_NotifyMsPvPWatchBattleResultRes(msg)
	self:doCurrentPeriodEvent(msg.activityId, MagicSchoolPvPEnum.PeriodType_Boss)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_NotifyMsPvPWatchBattleResultRes)
end

function MagicSchoolPvPController:handlePM_NotifyMsPvPStartSelectBuffRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_NotifyMsPvPStartSelectBuffRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_NotifyMsPvPStartSelectBuffRes)
end

function MagicSchoolPvPController:handlePM_NotifyMsPvPFinishSelectBuffRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_NotifyMsPvPFinishSelectBuffRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_NotifyMsPvPFinishSelectBuffRes, msg)
end

function MagicSchoolPvPController:handlePM_NotifyMsPvPGameEndRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_NotifyMsPvPGameEndRes(msg)
	self:doCurrentPeriodEvent(msg.activityId, MagicSchoolPvPEnum.PeriodType_End)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_NotifyMsPvPGameEndRes)
end

function MagicSchoolPvPController:handlePM_NotifyMsPvPErrorRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_NotifyMsPvPErrorRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_NotifyMsPvPErrorRes)
end

function MagicSchoolPvPController:handlePM_NotifyMsPvPChatRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_NotifyMsPvPChatRes, msg)
end

function MagicSchoolPvPController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.MagicSchoolPvP)
end

function MagicSchoolPvPController:isInActivityTime(activityId)
	return ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId)
end

function MagicSchoolPvPController:getSubMo(activityId)
	return MagicSchoolPvPModel.instance:getSubMo(activityId)
end

function MagicSchoolPvPController:enterPvpAndjoinTeam(activityId, teamId, groupId, teamCode)
	self:stashJoinTeamInfo(activityId, teamId, groupId, teamCode)
	UIStateManager.instance:push(ViewName.MagicSchoolPvpMainView, activityId)
end

function MagicSchoolPvPController:stashJoinTeamInfo(activityId, teamId, groupId, teamCode)
	self._joinTeamInfo = {
		activityId = activityId,
		teamId = teamId,
		groupId = groupId,
		teamCode = teamCode
	}
end

function MagicSchoolPvPController:popJoinTeamInfo()
	self._joinTeamInfo = nil

	return self._joinTeamInfo
end

function MagicSchoolPvPController:enterFormation(activityId, isBattle)
	local customFmtMo = MagicSchoolPvPModel.instance:getFormationCustomFmtMo()
	local subMo = self:getSubMo(activityId)
	local simpleForm

	if isBattle then
		simpleForm = subMo:getFormationSimpleFormBattle()

		if simpleForm == nil then
			simpleForm = subMo:getFormationSimpleForm()
		end
	else
		simpleForm = subMo:getFormationSimpleForm()
	end

	customFmtMo:updateCfg(activityId, simpleForm, isBattle)
	CustomFmtController.instance:showMissionFormationView(customFmtMo)
end

function MagicSchoolPvPController:getEnterPvpResultAndTips(isNeedTips, activityId, groupId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local subMo = self:getSubMo(activityId)

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	elseif not subMo:isInOpenTimeArrays() then
		result = GameEnum.ResultCode.Error
		tips = "不在开放时间内"
	elseif subMo:getCampId() <= 0 then
		result = GameEnum.ResultCode.Error
		tips = "尚未选择阵营，请先选择阵营"
	elseif not subMo:isEnoughDailyTimes() then
		result = GameEnum.ResultCode.Error
		tips = "今日次数已用完"
	elseif subMo:getFormationSimpleForm() == nil then
		result = GameEnum.ResultCode.Error
		tips = "预设阵容为空，需要先设置预设阵容"
	elseif subMo:isGameing() then
		result = GameEnum.ResultCode.Error
		tips = "当前正在战斗中，无法进行组队"
	elseif groupId ~= subMo:getCurGroupId() then
		result = GameEnum.ResultCode.Error
		tips = "与对方阵营身份不符，无法进入"
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result, tips
end

function MagicSchoolPvPController:openBuffTipsView(activityId, campId, buffId, targetGo)
	local buffData = MagicSchoolConfig.instance:getBuffCfgData(activityId, campId, buffId)
	local data = BufftipsView.getBuffTipSimpleData(buffData.name, buffData.desc, buffData.iconUrl)

	CommonTipsMgr.instance:openBuffTipView(data, targetGo)
end

function MagicSchoolPvPController:doCurrentPeriodEvent(activityId, periodType)
	local subMo = self:getSubMo(activityId)
	local isGameing = subMo:isGameing()

	if not isGameing or self._isApplicationPause then
		return
	end

	local subMo = self:getSubMo(activityId)
	local myCampId = subMo:getCampId()

	if myCampId <= 0 then
		printError(string.format("MagicSchoolPvPController:doCurrentPeriodEvent 缺失campId ( activityId:%s, campId:%s )", activityId, myCampId))

		return
	end

	if periodType == MagicSchoolPvPEnum.PeriodType_Match then
		UIStateManager.instance:push(ViewName.MagicSchoolPvpMatchView, activityId)
	elseif periodType == MagicSchoolPvPEnum.PeriodType_Ready then
		local groupId = subMo:getCurGroupId()
		local autoState = FormTeamModel.instance:getTeamAutoReadyState(groupId)

		if autoState == GameEnum.FormTeamAutoReadyState.Not_Play_Before then
			FormTeamModel.instance:setTeamAutoReadyState(groupId, GameEnum.FormTeamAutoReadyState.Auto)
		end

		UIStateManager.instance:push(ViewName.MagicSchoolPvpReadyView, activityId)
	elseif periodType == MagicSchoolPvPEnum.PeriodType_Boss then
		local bossId = subMo:getCurBossId()

		if bossId > 0 then
			local msg = subMo:getBattleMsg(bossId)

			if msg:HasField("battleResult") then
				self:_enterBattle(activityId, bossId, msg.battleResult)
			else
				printError(string.format("魔法组队3v3:在挑战阶段但缺失战斗结果( activityId:%s, bossId:%s )", activityId, bossId))
			end
		else
			printError(string.format("魔法组队3v3:在挑战阶段但bossId<=0( activityId:%s )", activityId))
		end
	elseif periodType == MagicSchoolPvPEnum.PeriodType_End then
		subMo:setIsGameing(false)
		subMo:setIsRuning(false)
	end
end

function MagicSchoolPvPController:_enterBattle(activityId, bossId, battleResult)
	local isBattleing = BattleController.instance:isBattling()

	if isBattleing then
		return
	end

	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local subMo = self:getSubMo(activityId)
		local bossCount = subMo:getBossCount()

		if bossCount > bossId then
			UIJumper.instance:pushOneStack(ViewName.MagicSchoolPvpBattleResultView, false, activityId, bossId)
		else
			UIJumper.instance:removeTopState(ViewName.MagicSchoolPvpReadyView)
			UIJumper.instance:pushOneStack(ViewName.MagicSchoolPvpFinishResultView, false, activityId)
		end

		BattleController.instance:endBattle()

		return true
	end)

	local viewNameList = {
		ViewName.CustomFormationView,
		ViewName.MagicSchoolPvpBuffView,
		ViewName.MagicSchoolPvpBattleResultView,
		ViewName.MagicSchoolPvpFinishResultView,
		ViewName.MagicSchoolPvpMatchView
	}

	UIJumper.instance:saveCurStack(GameUtil.unpack10(viewNameList))
	BattleController.instance:viewUserFightMonsterBtlResult(battleResult)

	local subMo = self:getSubMo(activityId)

	self._endBattleTime = subMo:getBossRoundTimeStamp(bossId, MagicSchoolPvPEnum.RoundType_Buff)

	settimer(0.5, self._onTickingBattle, self, true)
end

function MagicSchoolPvPController:_stopTickingBattle()
	self._endBattleTime = 0

	removetimer(self._onTickingBattle, self)
end

function MagicSchoolPvPController:_onTickingBattle()
	local now = ServerTime.now()

	if now >= self._endBattleTime then
		self:_stopTickingBattle()
		BattleController.instance:pass()
	elseif not BattleController.instance:isBattling() then
		self:_stopTickingBattle()
	end
end

MagicSchoolPvPController.instance = MagicSchoolPvPController.New()

return MagicSchoolPvPController
