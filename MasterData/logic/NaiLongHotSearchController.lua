-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailonghotsearch/controller/NaiLongHotSearchController.lua

module("logic.extensions.nailonghotsearch.controller.NaiLongHotSearchController", package.seeall)

local NaiLongHotSearchController = class("NaiLongHotSearchController", BaseController)

function NaiLongHotSearchController:onInit()
	return
end

function NaiLongHotSearchController:onReset()
	return
end

function NaiLongHotSearchController:sendPM_HotSearchGetInfoReq(activityId)
	NaiLongHotSearchAgent.instance:sendPM_HotSearchGetInfoReq(activityId)
end

function NaiLongHotSearchController:handlePM_HotSearchGetInfoRes(msg)
	local mo = self:getNaiLongHotSearchMo(msg.activityId)

	mo:handlePM_HotSearchGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_HotSearchGetInfoRes)
end

function NaiLongHotSearchController:sendPM_HotSearchGainPrizeReq(activityId, prizeIds)
	NaiLongHotSearchAgent.instance:sendPM_HotSearchGainPrizeReq(activityId, prizeIds)
end

function NaiLongHotSearchController:handlePM_HotSearchGainPrizeRes(msg)
	local mo = self:getNaiLongHotSearchMo(msg.activityId)

	mo:handlePM_HotSearchGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_HotSearchGainPrizeRes)
end

function NaiLongHotSearchController:sendPM_HotSearchReplyReq(activityId, replyId)
	NaiLongHotSearchAgent.instance:sendPM_HotSearchReplyReq(activityId, replyId)
end

function NaiLongHotSearchController:handlePM_HotSearchReplyRes(msg)
	local mo = self:getNaiLongHotSearchMo(msg.activityId)

	mo:handlePM_HotSearchReplyRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_HotSearchReplyRes)
end

function NaiLongHotSearchController:sendPM_HotSearchKudosReq(activityId)
	NaiLongHotSearchAgent.instance:sendPM_HotSearchKudosReq(activityId)
end

function NaiLongHotSearchController:handlePM_HotSearchKudosRes(msg)
	local mo = self:getNaiLongHotSearchMo(msg.activityId)

	mo:handlePM_HotSearchKudosRes(msg)
	MaterialController.instance:setChangeSetPopup(msg.changeSetId, MaterialController.CI_SHOW_TYPE_FLY)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_HotSearchKudosRes)
end

function NaiLongHotSearchController:sendPM_HotSearchPresentReq(activityId)
	NaiLongHotSearchAgent.instance:sendPM_HotSearchPresentReq(activityId)
end

function NaiLongHotSearchController:handlePM_HotSearchPresentRes(msg)
	local mo = self:getNaiLongHotSearchMo(msg.activityId)

	mo:handlePM_HotSearchPresentRes(msg)
	MaterialController.instance:setChangeSetPopup(msg.changeSetId, MaterialController.CI_SHOW_TYPE_FLY)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_HotSearchPresentRes)
end

function NaiLongHotSearchController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function NaiLongHotSearchController:getActivityType()
	return GameEnum.ActivityType.NaiLongHotSearch
end

function NaiLongHotSearchController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function NaiLongHotSearchController:getNaiLongHotSearchMo(activityId)
	return NaiLongHotSearchModel.instance:getNaiLongHotSearchMo(activityId)
end

function NaiLongHotSearchController:getCurInformationId(activityId)
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(self:getActivityType(), activityId)
	local day = GameUtil.getDaysByTimestamp(startTime, ServerTime.now()) - 1
	local cfg = NaiLongHotSearchConfig.instance:getInformationCfg(activityId) or {}
	local length = #cfg

	if length > 0 then
		return (day - 1) % length + 1
	else
		return 0
	end
end

function NaiLongHotSearchController:getTryOpenHotSeachMainViewResultAndTips(isNeedTips, activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

NaiLongHotSearchController.instance = NaiLongHotSearchController.New()

return NaiLongHotSearchController
