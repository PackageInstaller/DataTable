-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mmteampassport/controller/MMTeamPassportController.lua

module("logic.extensions.mmteampassport.controller.MMTeamPassportController", package.seeall)

local MMTeamPassportController = class("MMTeamPassportController", BaseController)

MMTeamPassportController.PASSPORT_FUNC_ID = 26
MMTeamPassportController.TEAM_INVITE_TEMPLATE_ID = 98
MMTeamPassportController.APPLY_JOIN_FAILED_STATUS_MAX = 0

function MMTeamPassportController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.ON_CLICK_ITEM_CHAT, self._onChatItemClick, self)
	self:onReset()
end

function MMTeamPassportController:onReset()
	self:_clearTeamInviteApplyJoinListen()

	self._applyJoinFailedCaptainMap = {}
	self._lastApplyJoinContext = nil
end

function MMTeamPassportController:sendPM_MMTeamPassportGetInfoReq(activityId)
	MMTeamPassportAgent.instance:sendPM_MMTeamPassportGetInfoReq(activityId)
end

function MMTeamPassportController:handlePM_MMTeamPassportGetInfoRes(msg)
	self:_syncPassportInfo(msg.passPortActInfo)

	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_MMTeamPassportGetInfoRes(msg)
	self:_updateApplyRedPoint(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.PassportStateUpdate)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MMTeamPassportGetInfoRes, msg.activityId)
end

function MMTeamPassportController:sendPM_MMTeamPassportGetTeamHallInfoReq(activityId, searchCaptainId)
	MMTeamPassportAgent.instance:sendPM_MMTeamPassportGetTeamHallInfoReq(activityId, searchCaptainId)
end

function MMTeamPassportController:handlePM_MMTeamPassportGetTeamHallInfoRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_MMTeamPassportGetTeamHallInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MMTeamPassportGetTeamHallInfoRes, msg.activityId)
end

function MMTeamPassportController:sendPM_MMTeamPassportApplyJoinTeamReq(activityId, captainId)
	MMTeamPassportAgent.instance:sendPM_MMTeamPassportApplyJoinTeamReq(activityId, captainId)
end

function MMTeamPassportController:handlePM_MMTeamPassportApplyJoinTeamRes(status, msg)
	if self:_isApplyJoinLockStatus(status) then
		self:_lockApplyJoinFailedCaptain(msg)
		FloatWordMgr.instance:show("队伍状态已变化，请刷新后再试")
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MMTeamPassportApplyJoinTeamRes, status, msg)

	self._lastApplyJoinContext = nil
end

function MMTeamPassportController:sendPM_MMTeamPassportApproveApplyReq(activityId, applyUserId, agree)
	MMTeamPassportAgent.instance:sendPM_MMTeamPassportApproveApplyReq(activityId, applyUserId, agree)
end

function MMTeamPassportController:handlePM_MMTeamPassportApproveApplyRes(status, msg)
	if status == 0 then
		local mo = self:getSubMo(msg.activityId)

		mo:handlePM_MMTeamPassportApproveApplyRes(msg)
		self:sendPM_MMTeamPassportGetInfoReq(msg.activityId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MMTeamPassportApproveApplyRes, status, msg)
end

function MMTeamPassportController:sendPM_MMTeamPassportOpenApplyListReq(activityId)
	MMTeamPassportAgent.instance:sendPM_MMTeamPassportOpenApplyListReq(activityId)
end

function MMTeamPassportController:handlePM_MMTeamPassportOpenApplyListRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_MMTeamPassportOpenApplyListRes(msg)
	self:_updateApplyRedPoint(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MMTeamPassportOpenApplyListRes, msg.activityId)
end

function MMTeamPassportController:sendPM_MMTeamPassportGainTeamPrizeReq(activityId, prizeId)
	MMTeamPassportAgent.instance:sendPM_MMTeamPassportGainTeamPrizeReq(activityId, prizeId)
end

function MMTeamPassportController:handlePM_MMTeamPassportGainTeamPrizeRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_MMTeamPassportGainTeamPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MMTeamPassportGainTeamPrizeRes, msg.activityId)
end

function MMTeamPassportController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.MMTeamPassport)
end

function MMTeamPassportController:getSubMo(activityId)
	return MMTeamPassportModel.instance:getSubMo(activityId)
end

function MMTeamPassportController:getTeamInviteTemplateId()
	return MMTeamPassportController.TEAM_INVITE_TEMPLATE_ID
end

function MMTeamPassportController:getTeamMaxMemberCount()
	return MMTeamPassportSubMo.TEAM_MAX_MEMBER_COUNT
end

function MMTeamPassportController:hasTeamPrivilege()
	local info = PassportModel.instance:getInfo(MMTeamPassportController.PASSPORT_FUNC_ID)

	return info ~= nil and info.hasPay == true
end

function MMTeamPassportController:checkCanApplyJoinOtherTeam(activityId)
	local mo = self:getSubMo(activityId)

	if not mo:isInfoLoaded() then
		FloatWordMgr.instance:show("数据加载中，请稍后")

		return false
	end

	if not self:hasTeamPrivilege() then
		FloatWordMgr.instance:show("购买通行证后开启")

		return false
	end

	if not mo:canApplyJoinOtherTeam() then
		FloatWordMgr.instance:show("你已加入队伍，无法重复加入")

		return false
	end

	return true
end

function MMTeamPassportController:trySendPM_MMTeamPassportApplyJoinTeamReq(activityId, captainId)
	activityId = checknumber(activityId)

	local captainIdKey = self:_getApplyJoinCaptainIdKey(captainId)

	if activityId <= 0 then
		FloatWordMgr.instance:show("活动信息异常")

		return false
	end

	if string.nilorempty(captainIdKey) or captainIdKey == "0" then
		FloatWordMgr.instance:show("队伍信息已失效")

		return false
	end

	if self:_isApplyJoinCaptainFailed(activityId, captainIdKey) then
		FloatWordMgr.instance:show("队伍状态已变化，请刷新后再试")

		return false
	end

	if not self:checkCanApplyJoinOtherTeam(activityId) then
		return false
	end

	self._lastApplyJoinContext = {
		activityId = activityId,
		captainId = captainIdKey
	}

	self:sendPM_MMTeamPassportApplyJoinTeamReq(activityId, captainIdKey)

	return true
end

function MMTeamPassportController:clearApplyJoinFailedCaptains(activityId)
	activityId = checknumber(activityId)

	if activityId <= 0 then
		return
	end

	self._applyJoinFailedCaptainMap = self._applyJoinFailedCaptainMap or {}
	self._applyJoinFailedCaptainMap[activityId] = nil
end

function MMTeamPassportController:getTeamInviteDataT(activityId)
	activityId = checknumber(activityId)

	local mo = self:getSubMo(activityId)

	return {
		tpId = self:getTeamInviteTemplateId(),
		params = {
			activityId = activityId,
			captainId = tostring(RoleModel.instance:getUserId()),
			curMemberCount = mo:getTeamMemberCount(),
			maxMemberCount = self:getTeamMaxMemberCount(),
			teamScore = mo:getTeamMaxProgress()
		}
	}
end

function MMTeamPassportController:_updateApplyRedPoint(activityId)
	local mo = self:getSubMo(activityId)

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_MMTEAM_PASSPORT_APPLY, mo:hasApplyRedPoint())
end

function MMTeamPassportController:_onChatItemClick(tpId, chatMo)
	if checknumber(tpId) ~= self:getTeamInviteTemplateId() then
		return
	end

	self:openJoinTeamConfirmFromChat(chatMo)
end

function MMTeamPassportController:openJoinTeamConfirmFromChat(chatMo)
	local activityId = chatMo:getParam("activityId", true)
	local captainId = chatMo:getParam("captainId", false)
	local curMemberCount = chatMo:getParam("curMemberCount", true)
	local maxMemberCount = chatMo:getParam("maxMemberCount", true)

	if not self:_checkJoinTeamContext(activityId, captainId, curMemberCount, maxMemberCount) then
		return
	end

	activityId = checknumber(activityId)

	if self:_isApplyJoinCaptainFailed(activityId, captainId) then
		FloatWordMgr.instance:show("队伍状态已变化，请刷新后再试")

		return
	end

	if not self:checkCanApplyJoinOtherTeam(activityId) then
		return
	end

	self:_openJoinTeamConfirm({
		activityId = activityId,
		captainId = captainId,
		captainName = chatMo:Get("senderName")
	})
end

function MMTeamPassportController:_checkJoinTeamContext(activityId, captainId, curMemberCount, maxMemberCount)
	activityId = checknumber(activityId)

	if activityId <= 0 or not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		FloatWordMgr.instance:show("活动已过期")

		return false
	end

	if captainId == nil or tostring(captainId) == "" then
		FloatWordMgr.instance:show("队伍信息已失效")

		return false
	end

	if tostring(captainId) == tostring(RoleModel.instance:getUserId()) then
		FloatWordMgr.instance:show("无法加入自己的队伍")

		return false
	end

	if checknumber(maxMemberCount) > 0 and checknumber(curMemberCount) >= checknumber(maxMemberCount) then
		FloatWordMgr.instance:show("队伍成员已满，无需加入/邀请")

		return false
	end

	return true
end

function MMTeamPassportController:_openJoinTeamConfirm(context)
	local captainName = context.captainName

	if string.nilorempty(captainName) then
		captainName = "奥奇"
	end

	local content = string.format("是否加入【%s】的梦梦通行证队伍？ \n注：加入后无法自行退出，请谨慎确认无误", captainName)

	local function sureFunc()
		MMTeamPassportController.instance:_listenTeamInviteApplyJoinRes()

		if not MMTeamPassportController.instance:trySendPM_MMTeamPassportApplyJoinTeamReq(context.activityId, context.captainId) then
			MMTeamPassportController.instance:_clearTeamInviteApplyJoinListen()
		end
	end

	TipsFacade.instance:openPopupWindow("提示", content, sureFunc, nil, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)
end

function MMTeamPassportController:_listenTeamInviteApplyJoinRes()
	self:_clearTeamInviteApplyJoinListen()
	GlobalDispatcher:addListener(GlobalNotify.HandlePM_MMTeamPassportApplyJoinTeamRes, self._onTeamInviteApplyJoinRes, self)
end

function MMTeamPassportController:_clearTeamInviteApplyJoinListen()
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_MMTeamPassportApplyJoinTeamRes, self._onTeamInviteApplyJoinRes, self)
end

function MMTeamPassportController:_onTeamInviteApplyJoinRes(status, msg)
	self:_clearTeamInviteApplyJoinListen()

	if status ~= 0 then
		return
	end

	FloatWordMgr.instance:show("申请成功，请等待队长同意")
end

function MMTeamPassportController:_syncPassportInfo(passPortActInfo)
	if not passPortActInfo then
		return
	end

	PassportModel.instance:updateByActivityInfo(passPortActInfo)
end

function MMTeamPassportController:_lockApplyJoinFailedCaptain(msg)
	local context = self._lastApplyJoinContext
	local activityId = checknumber(msg and msg.activityId)
	local captainId = msg and msg.captainId

	if activityId <= 0 and context then
		activityId = checknumber(context.activityId)
	end

	local captainIdKey = self:_getApplyJoinCaptainIdKey(captainId)

	if (string.nilorempty(captainIdKey) or captainIdKey == "0") and context then
		captainIdKey = self:_getApplyJoinCaptainIdKey(context.captainId)
	end

	if activityId <= 0 or string.nilorempty(captainIdKey) or captainIdKey == "0" then
		return
	end

	self._applyJoinFailedCaptainMap = self._applyJoinFailedCaptainMap or {}
	self._applyJoinFailedCaptainMap[activityId] = self._applyJoinFailedCaptainMap[activityId] or {}
	self._applyJoinFailedCaptainMap[activityId][captainIdKey] = true
end

function MMTeamPassportController:_isApplyJoinCaptainFailed(activityId, captainId)
	self._applyJoinFailedCaptainMap = self._applyJoinFailedCaptainMap or {}

	local activityFailedMap = self._applyJoinFailedCaptainMap[checknumber(activityId)]
	local captainIdKey = self:_getApplyJoinCaptainIdKey(captainId)

	return activityFailedMap ~= nil and activityFailedMap[captainIdKey] == true
end

function MMTeamPassportController:_isApplyJoinLockStatus(status)
	return checknumber(status) < MMTeamPassportController.APPLY_JOIN_FAILED_STATUS_MAX
end

function MMTeamPassportController:_getApplyJoinCaptainIdKey(captainId)
	if captainId == nil then
		return ""
	end

	return tostring(captainId)
end

MMTeamPassportController.instance = MMTeamPassportController.New()

return MMTeamPassportController
