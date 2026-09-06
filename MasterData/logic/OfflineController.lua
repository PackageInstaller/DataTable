-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/offline/controller/OfflineController.lua

module("logic.extensions.offline.model.OfflineController", package.seeall)

local OfflineController = class("OfflineController", BaseController)

OfflineController.ON_GET_PRIZE_INFO = "on_get_prize_info"

function OfflineController:ctor()
	OfflineController.super.ctor(self)
end

function OfflineController:onInit()
	self:onReset()
end

function OfflineController:onReset()
	RedPointController.instance:regUserOnceRedPoint(RedPointModel.ID_HUD_OFFLINE)
	RedPointController.instance:regUserOnceRedPoint(RedPointModel.ID_HUD_OFFLINE_TAB_1)
	RedPointController.instance:regUserOnceRedPoint(RedPointModel.ID_HUD_OFFLINE_TAB_2)
	RedPointController.instance:regUserOnceRedPoint(RedPointModel.ID_HUD_OFFLINE_TAB_3)
	RedPointController.instance:regUserOnceRedPoint(RedPointModel.ID_HUD_OFFLINE_TAB_4)
	RedPointController.instance:regUserOnceRedPoint(RedPointModel.ID_HUD_OFFLINE_TAB_5)
end

function OfflineController:getCurrActivityId()
	return 147001
end

function OfflineController:sendGetPrizeInfo(activityId)
	self.tmpActId = activityId

	AnniversaryPublicityAgent.instance:sendPM_AnniversaryPublicityGetInfoReq(activityId)
end

function OfflineController:setPrizeInfo(msg)
	OfflineModel.instance:setPrizeInfo(self.tmpActId, msg)
	self:localNotify(OfflineController.ON_GET_PRIZE_INFO)
end

function OfflineController:sendGetPrize(activityId, prizeId)
	self.tmpActId = activityId
	self.tmpPrizeId = prizeId

	AnniversaryPublicityAgent.instance:sendPM_AnniversaryPublicityGainPrizeReq(activityId, prizeId)
end

function OfflineController:setGetPrize()
	OfflineModel.instance:onGetPirze(self.tmpActId, self.tmpPrizeId)
	self:localNotify(OfflineController.ON_GET_PRIZE_INFO)
end

OfflineController.instance = OfflineController.New()

return OfflineController
