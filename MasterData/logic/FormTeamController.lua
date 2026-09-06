-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formteam/controller/FormTeamController.lua

module("logic.extensions.formteam.controller.FormTeamController", package.seeall)

local FormTeamController = class("FormTeamController", BaseController)

function FormTeamController:onInit()
	self:onReset()
end

function FormTeamController:onReset()
	self._curForcePipeTypeId = nil

	GlobalDispatcher:addListener("enterformteamview", self.enterFormTeamView, self)
end

function FormTeamController:getUnloadTabList()
	FormTeamAgent.instance:sendPM_FT_LoadTabInfoReq()
end

function FormTeamController:getTeamList(groupId, typeId)
	FormTeamAgent.instance:sendPM_FT_QueryTeamsReq(groupId, typeId)
end

function FormTeamController:getQuickJoinTeam(groupId, typeId)
	local quickJoinParam = FormTeamExtension_pb.PM_FT_QueryTeamsReq()

	if groupId then
		quickJoinParam.groupId = groupId
	end

	if typeId then
		quickJoinParam.typeId = typeId
	end

	FormTeamAgent.instance:sendPM_FT_QuickJoinReq(quickJoinParam)
end

function FormTeamController:getJoinTeam(teamId, groupId, teamCode)
	FormTeamAgent.instance:sendPM_FT_JoinTeamReq(teamId, groupId, teamCode)
end

function FormTeamController:getJoinTeamByChat(teamId, groupId, teamCode)
	UIStateManager.instance:popByName(ViewName.chat)

	local teamCfg = FormTeamConfig.instance:getTeamCfgByGroupId(groupId)

	if teamCfg.dealType == GameEnum.FormTeamClientDealType.LingShenChallenge then
		local handler = GameUtil.handler(self.getJoinTeam, self, teamId, groupId, teamCode)

		LingShenChallengeController.instance:handlerInviteInChat(handler)
	elseif teamCfg.dealType == GameEnum.FormTeamClientDealType.MagicSchoolPvP then
		UIStateManager.instance:popByName(ViewName.FormTeamView)

		local activityId = MagicSchoolPvPController.instance:getActivityId()

		MagicSchoolPvPController.instance:enterPvpAndjoinTeam(activityId, teamId, groupId, teamCode)
	else
		self:getJoinTeam(teamId, groupId, teamCode)
	end
end

function FormTeamController:createTeam(groupId, zdl, onlyInvite)
	FormTeamAgent.instance:sendPM_FT_CreateTeamReq(groupId, zdl, onlyInvite)
end

function FormTeamController:getOnlineFamilyList()
	FormTeamAgent.instance:sendPM_GetOnlineFamilyMembersReq()
end

function FormTeamController:getOnlineBuddiesZdl()
	local buddies = FormTeamModel.instance:getOnlineBuddiesUserIdList()

	if buddies and #buddies > 0 then
		FormTeamAgent.instance:sendPM_FT_QueryBuddiesZdlReq(buddies)
	else
		GlobalDispatcher:dispatch(GlobalNotify.FormTeamGetOnlineFamilyList)
	end
end

function FormTeamController:leaveCurTeam()
	FormTeamAgent.instance:sendPM_FT_LeaveTeamReq()
end

function FormTeamController:readyForGame()
	FormTeamAgent.instance:sendPM_FT_ReadyReq()
end

function FormTeamController:kickTeammate(beKickUserId)
	FormTeamAgent.instance:sendPM_FT_KickReq(beKickUserId)
end

function FormTeamController:chatWithSimpleId(chatId)
	FormTeamAgent.instance:sendPM_FT_ChatReq(chatId)
end

function FormTeamController:inviteJoinTeam(playerId)
	local curTeamInfo = FormTeamModel.instance:getCurTeamInfo()

	if curTeamInfo and playerId then
		FormTeamAgent.instance:sendPM_FT_InviteReq(curTeamInfo.groupId, playerId, curTeamInfo.id, curTeamInfo.code)
	end
end

function FormTeamController:getReformTime()
	local curTeamInfo = FormTeamModel.instance:getCurTeamInfo()

	if curTeamInfo then
		local teamCfg, typeCfg = curTeamInfo:getTeamCfgAndTypeCfg()

		if teamCfg and typeCfg.endHandle == 1 then
			FormTeamAgent.instance:sendPM_FT_ReformInReq(curTeamInfo.id)
		end
	end
end

function FormTeamController:getCurFetterInfo()
	local curTeamInfo = FormTeamModel.instance:getCurTeamInfo()

	if curTeamInfo then
		local teamCfg, typeCfg = curTeamInfo:getTeamCfgAndTypeCfg()

		FriendAgent.instance:sendGetTeamFetterInfoReq(typeCfg.buffPlanId, curTeamInfo:getCurTeammateUserIds())
	end
end

function FormTeamController:handleNotifyJoinTeam(msg)
	FormTeamModel.instance:onJoinTeam(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FormTeamJoinTeam, msg.settings.groupId)
	UIStateManager.instance:popByName(ViewName.chat)
end

function FormTeamController:handleLeaveCurTeam(msg)
	FormTeamModel.instance:onLeaveCurTeam(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FormTeamLeaveCurTeam)
end

function FormTeamController:handleGetOnlineFailyList(msg)
	FormTeamModel.instance:onGetOnlineFailyList(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FormTeamGetOnlineFamilyList)
end

function FormTeamController:handleGetBuddiesZdl(msg)
	FormTeamModel.instance:onGetBuddiesZdl(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FormTeamGetOnlineFamilyList)
end

function FormTeamController:handleNotifyQuickJoin(msg)
	return
end

function FormTeamController:handleNotifyCreateTeam(msg)
	return
end

function FormTeamController:handleNotifyTeamChange(msg)
	FormTeamModel.instance:onTeammateChange(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FormTeamLeaveCurTeamChangeInfo)
end

function FormTeamController:handleNotifyInviteApply(msg)
	FormTeamModel.instance:onBeInvited(msg)

	local lastInfo = FormTeamModel.instance:getLastInviteInfo()

	if lastInfo then
		local teamCfg = FormTeamConfig.instance:getTeamCfgByGroupId(lastInfo.groupId)
		local typeCfg = FormTeamConfig.instance:getTabCfgByTabId(teamCfg.typeId)
		local tip = langPara("<color=#2C7C84>%s</color>邀请你组队挑战<color=#2C7C84>%s%s</color>，快去看看吧。", lastInfo.headInfo.userName, typeCfg.name, teamCfg.name)

		UIStateManager.instance:popByName(ViewName.FormTeamInviteTipView)
		UIStateManager.instance:open(ViewName.FormTeamInviteTipView, tip)
		MainUIPopupMsgController.instance:regPopMsg({
			bTimeOutReject = true,
			cd = lastInfo.timeRefuse,
			acceptFunc = self._tryAcceptInvite,
			rejectFunc = self._tryRejectInvite,
			thisArg = self,
			desc = langPara("组队邀请：%s-%s", typeCfg.name, teamCfg.name),
			headInfo = lastInfo.headInfo,
			teamInfo = lastInfo
		})
	end

	GlobalDispatcher:dispatch(GlobalNotify.FormTeamBeInvite)
end

function FormTeamController:handleNotifyTeammateReady(msg)
	FormTeamModel.instance:onTeammateReady(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FormTeamLeaveCurTeamReady)
end

function FormTeamController:handleNotifyStart(msg)
	UIStateManager.instance:popByName(ViewName.FormTeamInviteTypeView)
	UIStateManager.instance:popByName(ViewName.FormTeamInviteView)
	FormTeamController.instance:handleDealAfterEnterGame()
end

function FormTeamController:handleNotifyBeKick(status, msg)
	FormTeamModel.instance:onBeKick()
	GlobalDispatcher:dispatch(GlobalNotify.FormTeamBeKick)

	if status == 0 then
		local text = lang("因队长请离或挑战人数不足等原因，您离开了当前队伍")

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			if ViewMgr.instance:isOpen(ViewName.FormTeamCurTeamView) or ViewMgr.instance:isOpen(ViewName.FormTeamCurTeamView) then
				UIStateManager.instance:popByName(ViewName.FormTeamCurTeamView)
				UIStateManager.instance:popByName(ViewName.FormTeamInviteView)
				UIStateManager.instance:popByName(ViewName.FormTeamInviteTypeView)
				UIStateManager.instance:popByName(ViewName.CustomMissionView)
				UIStateManager.instance:popByName(ViewName.FormTeamFetterView)
				UIStateManager.instance:push(ViewName.FormTeamView)
			else
				UIJumper.instance:pushClearCurStack(ViewName.FormTeamView, true)
				UIStateManager.instance:popByName(ViewName.FormTeamCurTeamView)
				UIStateManager.instance:popByName(ViewName.FormTeamInviteView)
				UIStateManager.instance:popByName(ViewName.FormTeamInviteTypeView)
				UIStateManager.instance:popByName(ViewName.CustomMissionView)
				UIStateManager.instance:popByName(ViewName.FormTeamFetterView)
			end
		end)
	else
		local text = lang("因队长请离或挑战人数不足等原因，您离开了当前队伍")

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			if ViewMgr.instance:isOpen(ViewName.FormTeamCurTeamView) or ViewMgr.instance:isOpen(ViewName.FormTeamCurTeamView) then
				UIStateManager.instance:popByName(ViewName.FormTeamCurTeamView)
				UIStateManager.instance:popByName(ViewName.FormTeamInviteView)
				UIStateManager.instance:popByName(ViewName.FormTeamInviteTypeView)
				UIStateManager.instance:popByName(ViewName.CustomMissionView)
				UIStateManager.instance:popByName(ViewName.FormTeamFetterView)
				UIStateManager.instance:push(ViewName.FormTeamView)
			else
				UIJumper.instance:pushClearCurStack(ViewName.FormTeamView, true)
				UIStateManager.instance:popByName(ViewName.FormTeamCurTeamView)
				UIStateManager.instance:popByName(ViewName.FormTeamInviteView)
				UIStateManager.instance:popByName(ViewName.FormTeamInviteTypeView)
				UIStateManager.instance:popByName(ViewName.CustomMissionView)
				UIStateManager.instance:popByName(ViewName.FormTeamFetterView)
			end
		end)
	end
end

function FormTeamController:handleNotifyChat(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FormTeamChat, msg.chatPlayerId, msg.chatId)
end

function FormTeamController:handleGetUnlockTabList(msg)
	FormTeamModel.instance:onGetUnlockTabList(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FormTeamUnlockTabListUpdate)
end

function FormTeamController:handleNotifyQueryTeams(msg)
	FormTeamModel.instance:onGetTeamList(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FormTeamQueryListUpdate)
end

function FormTeamController:handleGetReformTime(msg)
	FormTeamModel.instance:onGetReformTime(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FormTeamGetReformTime)
end

function FormTeamController:handleGetCurFetter(msg)
	FormTeamModel.instance:onGetCurFetter(msg)
	UIStateManager.instance:push(ViewName.FormTeamFetterView)
end

function FormTeamController:handleDealBeforeEnterGame()
	local info = FormTeamModel.instance:getCurTeamInfo()

	if info then
		local teamCfg, typeCfg = info:getTeamCfgAndTypeCfg()

		if teamCfg.dealType == GameEnum.FormTeamClientDealType.HolyStripe then
			HolyStripeCopyController.instance:getLastForm(true)
			HolyStripeExploreController.instance:showPopup()
		elseif teamCfg.dealType == GameEnum.FormTeamClientDealType.StarGodChallenge then
			StarGodChallengeController.instance:sendTeamForm()
		elseif teamCfg.dealType == GameEnum.FormTeamClientDealType.LingShenChallenge then
			LingShenChallengeController.instance:sendPM_LingShenClgGetInfoReq()
		elseif teamCfg.dealType == GameEnum.FormTeamClientDealType.MagicSchoolPvP then
			-- block empty
		elseif teamCfg.dealType == GameEnum.FormTeamClientDealType.DrawAndGuess then
			-- block empty
		else
			printError("未定义组队玩法的前置处理：" .. teamCfg.dealType)
		end
	end
end

function FormTeamController:handleDealAfterEnterGame()
	local info = FormTeamModel.instance:getCurTeamInfo()

	UIStateManager.instance:popByName(ViewName.Popupwindow)
	UIStateManager.instance:popByName(ViewName.FormTeamFetterView)

	if info then
		UIStateManager.instance:popByName(ViewName.HolyStripeExploreTipView)

		local teamCfg, typeCfg = info:getTeamCfgAndTypeCfg()

		if teamCfg.dealType == GameEnum.FormTeamClientDealType.HolyStripe then
			local mo = HolyStripeCopyModel.instance:getTeamCustomFmtMo()

			mo:initParams(true)
			CustomFmtController.instance:showMissionView(mo)
		elseif teamCfg.dealType == GameEnum.FormTeamClientDealType.StarGodChallenge then
			local mo = StarGodChallengeModel.instance:getTeamCustomFmtMo()

			mo:initParams()
			CustomFmtController.instance:showMissionView(mo)
		elseif teamCfg.dealType == GameEnum.FormTeamClientDealType.LingShenChallenge then
			LingShenChallengeController.instance:onFormTeamEnd()
		elseif teamCfg.dealType == GameEnum.FormTeamClientDealType.MagicSchoolPvP then
			-- block empty
		elseif teamCfg.dealType == GameEnum.FormTeamClientDealType.DrawAndGuess then
			-- block empty
		else
			printError("未定义组队玩法的后置处理：" .. teamCfg.dealType)
		end
	end
end

function FormTeamController:handleOnLeaveTeamShowCI()
	return
end

function FormTeamController:onFightErrorForceLeaveCurTeam()
	local text = lang("当前无法进入战斗，队伍解散")

	TipsFacade.instance:openTipWindowNoX("提示", text, function()
		self:leaveCurTeam()
		UIStateManager.instance:popByName(ViewName.CustomMissionView)
		UIStateManager.instance:push(ViewName.FormTeamView)
	end)
end

function FormTeamController:_tryAcceptInvite(data)
	local teamInfo = data.info.teamInfo

	FormTeamController.instance:getJoinTeam(teamInfo.teamId, teamInfo.groupId, teamInfo.teamCode)
	FormTeamModel.instance:removeInviteInfo(teamInfo.teamId)
end

function FormTeamController:_tryRejectInvite(data)
	local teamInfo = data.info.teamInfo

	FormTeamModel.instance:removeInviteInfo(teamInfo.teamId)
end

function FormTeamController:gotoEnterFormTeamView(params)
	self:enterFormTeamView(unpack(params))
end

function FormTeamController:enterFormTeamView(groupId)
	self:_trySetForcePipeTypeId(groupId)
	UIStateManager.instance:push(ViewName.FormTeamView, groupId)
end

function FormTeamController:_trySetForcePipeTypeId(groupId)
	groupId = checknumber(groupId)

	local forcePipeTypeId

	if groupId and groupId > 0 then
		local groupData = FormTeamConfig.instance:getTeamCfgByGroupId(groupId)

		if groupData then
			if not groupData.typeId then
				local typeId = 0
				local typeData = FormTeamConfig.instance:getTabCfgByTabId(typeId)

				if typeData then
					if not typeData.isForcePipe then
						local isForcePipe = false

						if isForcePipe then
							forcePipeTypeId = typeData.typeId
						end
					end
				end
			end
		end
	end

	self:setCurForcePipeTypeId(forcePipeTypeId)
end

function FormTeamController:setCurForcePipeTypeId(typeId)
	self._curForcePipeTypeId = typeId
end

function FormTeamController:getCurForcePipeTypeId()
	return self._curForcePipeTypeId
end

function FormTeamController:isNeedFilterTypeWithType(typeId)
	typeId = checknumber(typeId)

	local result = false

	if not result then
		local typeData = FormTeamConfig.instance:getTabCfgByTabId(typeId)

		if typeData then
			if not typeData.isForcePipe then
				local isForcePipe = false
				local forcePipeTypeId = FormTeamController.instance:getCurForcePipeTypeId() or 0

				result = forcePipeTypeId > 0 and (isForcePipe and typeId ~= forcePipeTypeId or true) or isForcePipe
			end
		end
	end

	result = result or not FormTeamModel.instance:checkFormTeamTabShow(typeId)

	return result
end

FormTeamController.instance = FormTeamController.New()

return FormTeamController
