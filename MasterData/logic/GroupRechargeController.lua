-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/grouprecharge/controller/GroupRechargeController.lua

module("logic.extensions.grouprecharge.controller.GroupRechargeController", package.seeall)

local GroupRechargeController = class("GroupRechargeController", BaseController)

GroupRechargeController.E_InfoRes = "E_InfoRes"
GroupRechargeController.E_RequestListRes = "E_RequestListRes"
GroupRechargeController.E_InviteBuddyListRes = "E_InviteBuddyListRes"
GroupRechargeController.E_SendRequestRes = "E_SendRequestRes"
GroupRechargeController.E_HandlerRequestRes = "E_HandlerRequestRes"
GroupRechargeController.E_PersonalMatchingRes = "E_PersonalMatchingRes"
GroupRechargeController.E_TeamMatchingRes = "E_TeamMatchingRes"
GroupRechargeController.E_CancelMatchingRes = "E_CancelMatchingRes"
GroupRechargeController.E_ProgressPrizeChanged = "E_ProgressPrizeChanged"
GroupRechargeController.E_PersonalRankRes = "E_PersonalRankRes"
GroupRechargeController.E_TeamRankRes = "E_TeamRankRes"
GroupRechargeController.E_FirstTeamInfoRes = "E_FirstTeamInfoRes"
GroupRechargeController.E_NotifyReceivedRequestRes = "E_NotifyReceivedRequestRes"
GroupRechargeController.E_NotifySomeOneJoinTeamRes = "E_NotifySomeOneJoinTeamRes"
GroupRechargeController.E_NotifyJoinTeamRes = "E_NotifyJoinTeamRes"
GroupRechargeController.E_NotifyMatchingSuccessRes = "E_NotifyMatchingSuccessRes"
GroupRechargeController.E_NotifyMatchingFailRes = "E_NotifyMatchingFailRes"

function GroupRechargeController:ctor()
	return
end

function GroupRechargeController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.RoleLogined, self._resetData, self)
	GlobalDispatcher:addListener("group_recharge_open", self._add2PopupMsg, self)
	self:onReset()
end

function GroupRechargeController:onReset()
	self._cachePopMsgIds = {}
end

function GroupRechargeController:_resetData()
	local activityId = GroupRechargeModel.instance:getActivityId()
	local activityConf = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.GROUP_RECHARGE, activityId)

	if activityConf and GameUtil.checkIsInTimePeriod(activityConf.startTime, activityConf.endTime) then
		GameUtil.whenLocalDataInited(function()
			RedPointController.instance:regUserOnceRedPoint(RedPointModel.ID_GROUP_RECHARGE_ONCE)
		end)
	end
end

function GroupRechargeController:loadInfo()
	local activityId = GroupRechargeModel.instance:getActivityId()
	local activityConf = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.GROUP_RECHARGE, activityId)

	if activityConf and GameUtil.checkIsInTimePeriod(activityConf.startTime, activityConf.endTime) then
		GroupRechargeAgent.instance:sendPM_GroupRechargeInfoReq()
		GroupRechargeAgent.instance:sendPM_GroupRechargeRequestListReq()
	end
end

function GroupRechargeController:handleInfoRes(status, msg)
	if status == 0 then
		GroupRechargeModel.instance:handleInfoRes(msg)
		self:_updateInviteRedPoint()
		self:localNotify(GroupRechargeController.E_InfoRes)
	end
end

function GroupRechargeController:handleRequestListRes(status, msg)
	if status == 0 then
		GroupRechargeModel.instance:handleRequestListRes(msg)
		self:_updateInviteRedPoint()
	end
end

function GroupRechargeController:reqChooseFriend()
	GroupRechargeAgent.instance:sendPM_GroupRechargeInviteBuddyListReq()
end

function GroupRechargeController:handleInviteBuddyListRes(status, msg)
	if status == 0 then
		local friends = {}
		local buddyList = msg.buddyList
		local friendModel = FriendModel.instance

		for _, buddy in ipairs(buddyList) do
			local mo = friendModel:getFriendMo(buddy.headInfo.userId)

			if mo then
				table.insert(friends, mo)
			end
		end

		local teamInfo = GroupRechargeModel.instance:getTeamInfo()
		local readyCount, maxReadyCount = teamInfo:getLocationReadyByType(GroupRechargeConfig.LT_Friend)

		UIStateManager.instance:open(ViewName.FriendSelect, friends, math.max(0, maxReadyCount - readyCount), "仅能邀请<color=#ff0000>本服</color>在线好友")
	end
end

function GroupRechargeController:handleSendRequestRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("发送邀请成功")
		self:localNotify(GroupRechargeController.E_SendRequestRes, status, msg)
	end
end

function GroupRechargeController:reqHandlerRequest(userId, action)
	GroupRechargeModel.instance:beforeHandlerSendRequestRes(userId, action)
	GroupRechargeAgent.instance:sendPM_GroupRechargeHandlerRequestReq(userId, action)
end

function GroupRechargeController:handleHandlerRequestRes(status, msg)
	if msg and checknumber(msg.result) == -2106 then
		FloatWordMgr.instance:show("队伍已经满人了")
	end

	if status == 0 then
		GroupRechargeModel.instance:handleHandlerRequestRes(msg)
		self:_updateInviteRedPoint()

		if msg.action == GroupRechargeConfig.Agree and msg.result == 0 then
			FloatWordMgr.instance:show("成功加入队伍")

			if not ViewMgr.instance:isOpen(ViewName.GroupRechargeMainView) then
				UIStateManager.instance:push(ViewName.GroupRechargeMainView, 3)
			else
				GroupRechargeAgent.instance:sendPM_GroupRechargeInfoReq()
			end
		end

		self:localNotify(GroupRechargeController.E_HandlerRequestRes)
	end
end

function GroupRechargeController:handlePersonalMatchingRes(status, msg)
	if status == 0 then
		self:localNotify(GroupRechargeController.E_PersonalMatchingRes, status, msg)
	end
end

function GroupRechargeController:handleTeamMatchingRes(status, msg)
	if status == 0 then
		self:localNotify(GroupRechargeController.E_TeamMatchingRes, status, msg)
	end
end

function GroupRechargeController:handleCancelMatchingRes(status, msg)
	if status == 0 then
		self:localNotify(GroupRechargeController.E_CancelMatchingRes, status, msg)
	end
end

function GroupRechargeController:reqOneKeyGainPrize(type)
	GroupRechargeModel.instance:beforeGainSinglePrizeRes(type, GroupRechargeModel.instance:getCanGainPrizeIds(type))

	if type == GroupRechargeConfig.Personal then
		GroupRechargeAgent.instance:sendPM_GroupRechargeOneKeyGainPersonalPrzieReq()
	else
		GroupRechargeAgent.instance:sendPM_GroupRechargeOneKeyGainTeamPrizeReq()
	end
end

function GroupRechargeController:reqGainPrize(type, id)
	GroupRechargeModel.instance:beforeGainSinglePrizeRes(type, {
		id
	})

	if type == GroupRechargeConfig.Personal then
		GroupRechargeAgent.instance:sendPM_GroupRechargeGainPersonalPrizeReq(id)
	else
		GroupRechargeAgent.instance:sendPM_GroupRechargeGainTeamPrizeReq(id)
	end
end

function GroupRechargeController:handleGainPersonalPrizeRes(status, msg)
	if status == 0 then
		GroupRechargeModel.instance:handleGainPrizeRes(msg)
		self:localNotify(GroupRechargeController.E_ProgressPrizeChanged)
	end
end

function GroupRechargeController:handleGainTeamPrizeRes(status, msg)
	if status == 0 then
		GroupRechargeModel.instance:handleGainPrizeRes(msg)
		self:localNotify(GroupRechargeController.E_ProgressPrizeChanged)
	end
end

function GroupRechargeController:handlePersonalRankRes(status, msg)
	if status == 0 then
		self:localNotify(GroupRechargeController.E_PersonalRankRes, status, msg)
	end
end

function GroupRechargeController:handleTeamRankRes(status, msg)
	if status == 0 then
		self:localNotify(GroupRechargeController.E_TeamRankRes, status, msg)
	end
end

function GroupRechargeController:handleFirstTeamInfoRes(status, msg)
	if status == 0 then
		self:localNotify(GroupRechargeController.E_FirstTeamInfoRes, status, msg)
	end
end

function GroupRechargeController:handleNotifyReceivedRequestRes(status, msg)
	if status == 0 then
		GroupRechargeModel.instance:add2RequestList(msg.request)
		self:_updateInviteRedPoint()
	end
end

function GroupRechargeController:handleNotifySomeOneJoinTeamRes(status, msg)
	GroupRechargeAgent.instance:sendPM_GroupRechargeInfoReq()
end

function GroupRechargeController:handleNotifyJoinTeamRes(status, msg)
	GroupRechargeAgent.instance:sendPM_GroupRechargeInfoReq()
end

function GroupRechargeController:handleNotifyMatchingSuccessRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("成功加入队伍")
	end

	if status == 0 and not ViewMgr.instance:isOpen(ViewName.GroupRechargeMainView) then
		UIStateManager.instance:push(ViewName.GroupRechargeMainView, 3)
	else
		GroupRechargeAgent.instance:sendPM_GroupRechargeInfoReq()
	end

	self:localNotify(GroupRechargeController.E_NotifyMatchingSuccessRes, status, msg)
end

function GroupRechargeController:handleNotifyMatchingFailRes(status, msg)
	self:localNotify(GroupRechargeController.E_NotifyMatchingFailRes, status, msg)
end

function GroupRechargeController:_updateInviteRedPoint()
	local model = GroupRechargeModel.instance

	if not model:getTeamInfo():isInTeam() and #model:getRequestList() > 0 then
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_GROUP_RECHARGE_INVITE, true)
	else
		self:_removeGRAllPopMsg()
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_GROUP_RECHARGE_INVITE, false)
	end
end

function GroupRechargeController:_add2PopupMsg()
	self:_removeGRAllPopMsg()

	local model = GroupRechargeModel.instance

	if not model:getTeamInfo():isInTeam() then
		local requestList = model:getRequestList()

		if #requestList > 0 then
			for i, request in ipairs(requestList) do
				local var_30_0 = {
					cd = -1,
					bg = 1,
					askAcceptFunc = self._askAcceptInvite,
					acceptFunc = self._tryAcceptInvite,
					rejectFunc = self._tryRejectInvite,
					thisArg = self,
					headInfo = request.headInfo,
					desc = langPara("组队邀请：<color=#ff0000>%s</color>的组队充值", request.headInfo.userName),
					request = request,
					nameReplace = langPara("队伍成员：%d", request.memberNum)
				}

				var_30_0.lvReplace = langPara("队伍总充值：%s元", request.totalRecharge or "0")

				local params = var_30_0
				local index = MainUIPopupMsgController.instance:regPopMsg(params)

				table.insert(self._cachePopMsgIds, index)
			end
		end
	end
end

function GroupRechargeController:_removeGRAllPopMsg()
	for userId, index in pairs(self._cachePopMsgIds) do
		MainUIPopupMsgController.instance:removePopMsg(index)
	end

	self._cachePopMsgIds = {}
end

function GroupRechargeController:_askAcceptInvite(data, next)
	TipsFacade.instance:openPopupWindow(lang("tip"), lang("加入组队充值队伍后无法退出或者更换队伍直至活动结束，是否确认加入？"), next, nil, lang("confirm"), lang("拒绝"))
end

function GroupRechargeController:_tryAcceptInvite(data)
	local teamInfo = GroupRechargeModel.instance:getTeamInfo()

	if teamInfo:isInTeam() then
		FloatWordMgr.instance:show("您已有队伍！")
	elseif teamInfo:isFull() then
		FloatWordMgr.instance:show("队伍人数已满！")
	else
		self:reqHandlerRequest(data.info.request.headInfo.userId, GroupRechargeConfig.Agree)
	end
end

function GroupRechargeController:_tryRejectInvite(data)
	self:reqHandlerRequest(data.info.request.headInfo.userId, GroupRechargeConfig.Disagree)
end

GroupRechargeController.instance = GroupRechargeController.New()

return GroupRechargeController
