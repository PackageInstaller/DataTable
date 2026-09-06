-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/upholdjustice/controller/UpholdJusticeController.lua

module("logic.extensions.upholdjustice.controller.UpholdJusticeController", package.seeall)

local UpholdJusticeController = class("UpholdJusticeController", BaseController)

function UpholdJusticeController:onInit()
	self:onReset()
end

function UpholdJusticeController:onReset()
	self._couponSelectMap = {}
	self._lastRootTab = 0
	self._lastChildTab = 0
end

function UpholdJusticeController:setRootChildTab(lastRootTab, lastChildTab)
	self._lastRootTab = lastRootTab
	self._lastChildTab = lastChildTab
end

function UpholdJusticeController:getRootChildTab()
	return self._lastRootTab, self._lastChildTab
end

function UpholdJusticeController:sendGetInfo(activityId)
	UpholdJusticeAgent.instance:sendPM_UpholdJusticeGetInfoReq(activityId)
end

function UpholdJusticeController:onGetInfo(msg)
	UpholdJusticeModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ON_UPHOLD_JUSTICE_INFO)
end

function UpholdJusticeController:sendDonateOrGain(activityId, playerType, vale)
	UpholdJusticeAgent.instance:sendPM_UpholdJusticeDonateOrGainReq(activityId, playerType, vale)
end

function UpholdJusticeController:onDonateOrGain(msg)
	if msg.playerType == 1 then
		TipsFacade.instance:openCommonTips(langPara("成功捐赠%s体力，感谢热心的老江湖！", msg.value))
	else
		TipsFacade.instance:openCommonTips(langPara("成功领取%s体力，快去行走江湖吧！", msg.value))
	end

	self:sendGetInfo(msg.activityId)
end

function UpholdJusticeController:sendGetRankInfo(activityId)
	UpholdJusticeAgent.instance:sendPM_UpholdJusticeRankViewReq(activityId)
end

function UpholdJusticeController:onGetRankInfo(msg)
	UpholdJusticeModel.instance:onGetRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ON_UPHOLD_JUSTICE_RANK_INFO)
end

UpholdJusticeController.instance = UpholdJusticeController.New()

return UpholdJusticeController
