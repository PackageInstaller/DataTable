-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupregress/controller/GroupRegressController.lua

module("logic.extensions.groupregress.controller.GroupRegressController", package.seeall)

local GroupRegressController = class("GroupRegressController", BaseController)
local InviteTemplateId = 96

function GroupRegressController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.ON_CLICK_ITEM_CHAT, self._onChatItemClick, self)
	self:onReset()
end

function GroupRegressController:onReset()
	self._gainOncePrizeTeamTypeMap = {}
	self._bindInviteOpenContext = nil
end

function GroupRegressController:sendPM_GroupRegressGetInfoReq(activityId)
	GroupRegressAgent.instance:sendPM_GroupRegressGetInfoReq(activityId)
end

function GroupRegressController:handlePM_GroupRegressGetInfoRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_GroupRegressGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_GroupRegressGetInfoRes, msg.activityId)
end

function GroupRegressController:sendPM_GroupRegressBindReq(activityId, inviteCode)
	GroupRegressAgent.instance:sendPM_GroupRegressBindReq(activityId, inviteCode)
end

function GroupRegressController:handlePM_GroupRegressBindRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_GroupRegressBindRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_GroupRegressBindRes, msg.activityId)
end

function GroupRegressController:sendPM_GroupRegressGainProgressPrizeReq(activityId, prizeIds, teamType)
	GroupRegressAgent.instance:sendPM_GroupRegressGainProgressPrizeReq(activityId, prizeIds, teamType)
end

function GroupRegressController:handlePM_GroupRegressGainProgressPrizeRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_GroupRegressGainProgressPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_GroupRegressGainProgressPrizeRes, msg.activityId)
end

function GroupRegressController:sendPM_GroupRegressGainOncePrizeReq(activityId, inviteNewPlayerPrize, teamType)
	self._gainOncePrizeTeamTypeMap[activityId] = checknumber(teamType)

	GroupRegressAgent.instance:sendPM_GroupRegressGainOncePrizeReq(activityId, inviteNewPlayerPrize)
end

function GroupRegressController:handlePM_GroupRegressGainOncePrizeRes(msg)
	local mo = self:getSubMo(msg.activityId)
	local teamType = self._gainOncePrizeTeamTypeMap[msg.activityId]

	self._gainOncePrizeTeamTypeMap[msg.activityId] = nil

	mo:handlePM_GroupRegressGainOncePrizeRes(msg, teamType)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_GroupRegressGainOncePrizeRes, msg.activityId)
end

function GroupRegressController:sendPM_GroupRegressGetTeamInfoReq(activityId, teamType)
	GroupRegressAgent.instance:sendPM_GroupRegressGetTeamInfoReq(activityId, teamType)
end

function GroupRegressController:handlePM_GroupRegressGetTeamInfoRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_GroupRegressGetTeamInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_GroupRegressGetTeamInfoRes, msg.activityId)
end

function GroupRegressController:handlePM_GroupRegressNotifyNewMemberRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_GroupRegressNotifyNewMemberRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_GroupRegressNotifyNewMemberRes, msg.activityId)
end

function GroupRegressController:_onChatItemClick(tpId, chatMsgMo)
	if tpId ~= InviteTemplateId then
		return
	end

	local activityId = chatMsgMo:getParam("activityId", true)
	local inviteCode = chatMsgMo:getParam("inviteCode", false)

	self:openBindInviteView(activityId, inviteCode)
end

function GroupRegressController:openBindInviteView(activityId, inviteCode)
	activityId = checknumber(activityId)

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId)

	if not isInTime then
		FloatWordMgr.instance:show("活动已过期")

		return
	end

	local headTabId = self:_getOriginDreamTeamGroupRegressHeadTabId()

	if headTabId <= 0 then
		return
	end

	self._bindInviteOpenContext = {
		activityId = activityId,
		inviteCode = inviteCode
	}

	TabFrameWorkController.instance:setEnterContext(TabFrameWorkEnum.FrameIds_OriginDreamTeam, headTabId, 0)
	UIStateManager.instance:push(ViewName.OriginDreamTeamTabShowView)
end

function GroupRegressController:_getOriginDreamTeamGroupRegressHeadTabId()
	local frameId = TabFrameWorkEnum.FrameIds_OriginDreamTeam
	local tabCfg = TabFrameWorkConfig.instance:getFwTabCfg(frameId)

	if tabCfg == nil then
		printError(string.format("源起梦队页签配置缺失，请检查 yk-运营-页签框架 | 基础配置页 | frameId = %s", frameId))

		return 0
	end

	for _, data in pairs(tabCfg) do
		if data.viewName == ViewName.GroupRegressMainTabView then
			return checknumber(data.headTabId)
		end
	end

	printError(string.format("源起梦队页签配置缺失组队回流入口，请检查 yk-运营-页签框架 | 一级页签 | viewName = %s", ViewName.GroupRegressMainTabView))

	return 0
end

function GroupRegressController:consumeBindInviteOpenContext(activityId)
	local context = self:getBindInviteOpenContext(activityId)

	if context then
		self._bindInviteOpenContext = nil
	end

	return context
end

function GroupRegressController:getBindInviteOpenContext(activityId)
	local context = self._bindInviteOpenContext

	if context == nil then
		return nil
	end

	activityId = checknumber(activityId)

	if activityId > 0 and checknumber(context.activityId) ~= activityId then
		return nil
	end

	return context
end

function GroupRegressController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.GroupRegress)
end

function GroupRegressController:getSubMo(activityId)
	return GroupRegressModel.instance:getSubMo(activityId)
end

GroupRegressController.instance = GroupRegressController.New()

return GroupRegressController
