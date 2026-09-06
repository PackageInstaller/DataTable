-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/escort/controller/EscortController.lua

module("logic.extensions.escort.controller.EscortController", package.seeall)

local EscortController = class("EscortController", BaseController)

function EscortController:onInit()
	ConvoyAgent.instance:addHandler(ConvoyAgent.PM_ConvoyUpgradeBoxRes, self.SCConvoyUpgradeBox, self)
	ConvoyAgent.instance:addHandler(ConvoyAgent.PM_AcceptConvoyRes, self.SCAcceptConvoy, self)
	ConvoyAgent.instance:addHandler(ConvoyAgent.PM_ConvoyOverTimeRes, self.SCConvoyOverTime, self)
	ConvoyAgent.instance:addHandler(ConvoyAgent.PM_GetConvoyListRes, self.SCGetConvoyList, self)
	ConvoyAgent.instance:addHandler(ConvoyAgent.PM_FinishConvoyRes, self.SCFinishConvoy, self)
	ConvoyAgent.instance:addHandler(ConvoyAgent.PM_ConvoyGetChallengeRecordRes, self.SCConvoyGetChallengeRecord, self)
	ConvoyAgent.instance:addHandler(ConvoyAgent.PM_ConvoyGetChallengeVideoRes, self.SCConvoyGetChallengeVideo, self)
	ConvoyAgent.instance:addHandler(ConvoyAgent.PM_NotifyConvoyBeChallengedRes, self.SCNotifyConvoyBeChallenged, self)
	ConvoyAgent.instance:addHandler(ConvoyAgent.PM_GetOtherConvoyDetailRes, self.SCGetOtherConvoyDetail, self)
	UIStateManager.instance:addOpenedGuard(self._checkViewOpenedWhileEscorting, self)
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self._onStartEnterGame, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.TickDailyRefreshData, self)
	GlobalDispatcher:addListener(FamilyController.GetMyFamilySimpleDataRes, self._GetMyFamilySimpleInfoRes, self)
	GlobalDispatcher:addListener("escort_startfindnpc", self._onStartFindGotoNPC, self)
end

function EscortController:onReset()
	self._notifyFlag = nil
end

function EscortController:_onStartFindGotoNPC()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.CLICK_HUSONG)
	EscortModel.instance:SetMainActivityRedpoint(true)
	EscortModel.instance:StartFindGotoNPC()
end

function EscortController:_checkViewOpenedWhileEscorting(state)
	local isCanOpen, nameStr = EscortModel.instance:IsCanOpenView(state)

	if not isCanOpen then
		return isCanOpen, string.format("护送期间不能进行<color=#ff00ff>[%s]</color>", nameStr)
	end

	return true
end

function EscortController:TickDailyRefreshData()
	self:CSRequestEscortInfo()
end

function EscortController:OnSceneLoadedFinish(sceneType, sceneId)
	EscortModel.instance:InitFunctionOpenTime()
	EscortModel.instance:SetPlayerMoveSpeed()
end

function EscortController:_onStartEnterGame()
	if not Framework.OSDef.isEditor and not self._notifyFlag and FamilyController.instance:getFamilyLv() > 0 then
		local baseInfo = EscortConfig.instance:GetBaxBaseInfo()

		if baseInfo and baseInfo.openTimes then
			local info = baseInfo.openTimes[1]

			if info then
				GlobalDispatcher:dispatch(GlobalNotify.SetPushOpen, {
					6
				}, info.startHour, info.startMin)
			end

			info = baseInfo.openTimes[2]

			if baseInfo.openTimes[2] then
				GlobalDispatcher:dispatch(GlobalNotify.SetPushOpen, {
					7
				}, info.startHour, info.startMin)
			end
		end

		self._notifyFlag = true
	end
end

function EscortController:_GetMyFamilySimpleInfoRes()
	self:_onStartEnterGame()
end

function EscortController:CSRequestEscortInfo()
	ConvoyAgent.instance:sendPM_ConvoyGetInfoReq(function(msg)
		forcePrint("=====RoleDataRequestor:_loadRequestEscortInfo===back")
		EscortModel.instance:SetEscortBaseInfo(msg)
	end)
end

function EscortController:CSConvoyUpgradeBoxReq(num)
	ConvoyAgent.instance:sendPM_ConvoyUpgradeBoxReq(num)
end

function EscortController:SCConvoyUpgradeBox(msg)
	EscortModel.instance:UpdataEscortBaseBoxID(msg.curBoxId)
end

function EscortController:CSAcceptConvoyReq(isJuan)
	if MountModel.instance:isTeamMountFull() then
		FloatWordMgr.instance:show("双人骑乘不能进行护送")

		return
	end

	ConvoyAgent.instance:sendPM_AcceptConvoyReq(not isJuan)
end

function EscortController:SCAcceptConvoy()
	EscortModel.instance:UpdataEscortStartTimer(ServerTime.now())
	EscortModel.instance:StartFindGotoNPC(2)
end

function EscortController:CSConvoyOverTimeReq()
	ConvoyAgent.instance:sendPM_ConvoyOverTimeReq()
end

function EscortController:SCConvoyOverTime()
	FloatWordMgr.instance:show("护送已超时失败！")

	if ViewMgr.instance:isOpen(ViewName.EscortGoods) then
		ViewMgr.instance:close(ViewName.EscortGoods)
	end

	if ViewMgr.instance:isOpen(ViewName.EscortBattle) then
		ViewMgr.instance:close(ViewName.EscortBattle)
	end

	if ViewMgr.instance:isOpen(ViewName.EscortReport) then
		ViewMgr.instance:close(ViewName.EscortReport)
	end

	EscortModel.instance:OnOverEscort()
end

function EscortController:CSConvoyTalkToNPCReq(npcId)
	ConvoyAgent.instance:sendPM_ConvoyTalkToNPCReq(npcId)
end

function EscortController:CSFinishConvoyReq()
	ConvoyAgent.instance:sendPM_FinishConvoyReq()
end

function EscortController:SCFinishConvoy(msg, status)
	if status == -4508 or status == 0 then
		SceneMgr.instance:enabledTransition()
		EscortModel.instance:OnOverEscort()
	end
end

function EscortController:CSGetConvoyListReq(isFirst)
	ConvoyAgent.instance:sendPM_GetConvoyListReq()
end

function EscortController:SCGetConvoyList(msg)
	EscortModel.instance:SetBattlePlayerList(msg.infoList)
end

function EscortController:CSConvoyChallengeReq(userId, userName, userIcon, frameId, isJuan, level)
	ConvoyAgent.instance:sendPM_ConvoyChallengeReq(userId, userName, userIcon, frameId, not isJuan, level, function(msg)
		if msg == nil or msg.btlResult == nil then
			if ViewMgr.instance:isOpen(ViewName.EscortMission) then
				UIStateManager.instance:clear(true)
			end

			return
		end

		UIJumper.instance:pushOneStack(ViewName.MainUI, true)
		UIJumper.instance:pushOneStack(ViewName.EscortBattle, true)

		if msg.daiBiNum and msg.daiBiNum > 0 then
			EscortModel.instance:SetEscortDaibiCount(false, msg.daiBiNum)
		end

		EscortModel.instance:SetSupBattleCount()
		BattleFacade.instance:startFightingByBtlResult(msg.btlResult)
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end, nil, function()
		if ViewMgr.instance:isOpen(ViewName.EscortMission) then
			UIStateManager.instance:clear(true)
		end
	end)
end

function EscortController:CSConvoyGetChallengeRecordReq()
	ConvoyAgent.instance:sendPM_ConvoyGetChallengeRecordReq()
end

function EscortController:SCConvoyGetChallengeRecord(msg)
	EscortModel.instance:SetEscortReportList(msg.recordList)
end

function EscortController:CSConvoyGetChallengeVideoReq(index)
	ConvoyAgent.instance:sendPM_ConvoyGetChallengeVideoReq(index)
end

function EscortController:SCConvoyGetChallengeVideo(msg)
	if msg == nil or msg.battleResult == nil then
		return
	end

	BattleFacade.instance:onViewUserFightMonsterBtlResult(msg.battleResult)
	UIJumper.instance:pushOneStack(ViewName.MainUI, true)
end

function EscortController:SCNotifyConvoyBeChallenged(msg)
	if msg.daiBiNum and msg.daiBiNum > 0 then
		EscortModel.instance:SetEscortDaibiCount(false, -msg.daiBiNum)
	end

	EscortModel.instance:SetEscortRedPoint("all", true)
end

function EscortController:CSGetOtherConvoyDetailReq(userId)
	ConvoyAgent.instance:sendPM_GetOtherConvoyDetailReq(userId)
end

function EscortController:SCGetOtherConvoyDetail(msg)
	local battData = EscortModel.instance:GetBattlePlayer()

	battData.msg = msg

	EscortModel.instance:SetBattlePlayer(battData, battData.isJuan)
	UIStateManager.instance:push(ViewName.EscortMission)
end

EscortController.instance = EscortController.New()

return EscortController
