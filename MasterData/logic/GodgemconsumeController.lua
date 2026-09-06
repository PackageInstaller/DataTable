-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godgemconsume/controller/GodgemconsumeController.lua

module("logic.extensions.godgemconsume.controller.GodgemconsumeController", package.seeall)

local GodgemconsumeController = class("GodgemconsumeController", BaseController)

GodgemconsumeController.PM_GGACChangeRecipientInfoRes = "GodgemconsumeController.PM_GGACChangeRecipientInfoRes"
GodgemconsumeController.PM_GGACGainProgressPrizeRes = "GodgemconsumeController.PM_GGACGainProgressPrizeRes"
GodgemconsumeController.PM_GGACGetActivityInfoRes = "GodgemconsumeController.PM_GGACGetActivityInfoRes"
GodgemconsumeController.PM_GGACGetRankInfoRes = "GodgemconsumeController.PM_GGACGetRankInfoRes"
GodgemconsumeController.PM_GGACOneKeyGainPrizeRes = "GodgemconsumeController.PM_GGACOneKeyGainPrizeRes"

function GodgemconsumeController:ctor()
	return
end

function GodgemconsumeController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(GodGemAccConsumeAgent.PM_GGACChangeRecipientInfoRes, self._PM_GGACChangeRecipientInfoRes, self)
	GlobalDispatcher:addListener(GodGemAccConsumeAgent.PM_GGACGainProgressPrizeRes, self._PM_GGACGainProgressPrizeRes, self)
	GlobalDispatcher:addListener(GodGemAccConsumeAgent.PM_GGACGetActivityInfoRes, self._PM_GGACGetActivityInfoRes, self)
	GlobalDispatcher:addListener(GodGemAccConsumeAgent.PM_GGACGetRankInfoRes, self._PM_GGACGetRankInfoRes, self)
	GlobalDispatcher:addListener(GodGemAccConsumeAgent.PM_GGACGetRankInfoRes, self._PM_GGACGetRankInfoRes, self)
end

function GodgemconsumeController:onReset()
	self._cacheRecipientInfo = nil
end

function GodgemconsumeController:_PM_GGACChangeRecipientInfoRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("保存成功")

		if self._cacheRecipientInfo then
			GodgemconsumeModel.instance:changeRecipientInfo(self._cacheRecipientInfo)

			self._cacheRecipientInfo = nil
		end
	end

	GlobalDispatcher:dispatch(GodgemconsumeController.PM_GGACChangeRecipientInfoRes, status, msg)
end

function GodgemconsumeController:_PM_GGACGainProgressPrizeRes(status, msg)
	if status == 0 then
		GodgemconsumeModel.instance:gainProgressPrizeRes(msg)
	end

	GlobalDispatcher:dispatch(GodgemconsumeController.PM_GGACGainProgressPrizeRes, status, msg)
end

function GodgemconsumeController:PM_GGACOneKeyGainPrizeRes(status, msg)
	if status == 0 then
		GodgemconsumeModel.instance:oneKeyGainProgressPrizeRes(msg)
	end

	GlobalDispatcher:dispatch(GodgemconsumeController.PM_GGACOneKeyGainPrizeRes, status, msg)
end

function GodgemconsumeController:_PM_GGACGetActivityInfoRes(status, msg)
	if status == 0 then
		GodgemconsumeModel.instance:setActInfo(msg)
	end

	GlobalDispatcher:dispatch(GodgemconsumeController.PM_GGACGetActivityInfoRes, status, msg)
end

function GodgemconsumeController:_PM_GGACGetRankInfoRes(status, msg)
	if status == 0 then
		GodgemconsumeModel.instance:setRankMo(msg)
	end

	GlobalDispatcher:dispatch(GodgemconsumeController.PM_GGACGetRankInfoRes, status, msg)
end

function GodgemconsumeController:sendPM_GGACChangeRecipientInfoReq(activityId, recipientInfo)
	self._cacheRecipientInfo = recipientInfo

	GodGemAccConsumeAgent.instance:sendPM_GGACChangeRecipientInfoReq(activityId, recipientInfo)
end

GodgemconsumeController.instance = GodgemconsumeController.New()

return GodgemconsumeController
