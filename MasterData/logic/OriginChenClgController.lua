-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originchenclg/controller/OriginChenClgController.lua

module("logic.extensions.originchenclg.controller.OriginChenClgController", package.seeall)

local OriginChenClgController = class("OriginChenClgController", BaseController)

function OriginChenClgController:onInit()
	self:onReset()
end

function OriginChenClgController:onReset()
	self._confirmCI = 0
end

function OriginChenClgController:sendPM_OriginChenClgGetInfoReq(activityId)
	OriginChenClgAgent.instance:sendPM_OriginChenClgGetInfoReq(activityId)
end

function OriginChenClgController:handlePM_OriginChenClgGetInfoRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_OriginChenClgGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginChenClgGetInfoRes, msg)
end

function OriginChenClgController:sendPM_OriginChenClgChallengeExtremeReq(activityId, stageId, form)
	OriginChenClgAgent.instance:sendPM_OriginChenClgChallengeExtremeReq(activityId, stageId, form)
end

function OriginChenClgController:handlePM_OriginChenClgChallengeExtremeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginChenClgChallengeExtremeRes, msg)
end

function OriginChenClgController:handlePM_Notify_OriginChenClgChallengeExtremeResultRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_Notify_OriginChenClgChallengeExtremeResultRes(msg)

	if msg.win then
		BattleFacade.instance:registerResultHandler(function()
			BattleFacade.instance:registerResultHandler(nil, nil)
			UIStateManager.instance:push(ViewName.OriginchenclgextremestageresultView, msg.activityId, msg.stageId, msg.stageInfo)

			return true
		end)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_Notify_OriginChenClgChallengeExtremeResultRes, msg)
end

function OriginChenClgController:sendPM_OriginChenClgResetExtremeReq(activityId)
	OriginChenClgAgent.instance:sendPM_OriginChenClgResetExtremeReq(activityId)
end

function OriginChenClgController:handlePM_OriginChenClgResetExtremeRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_OriginChenClgResetExtremeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginChenClgResetExtremeRes, msg)
end

function OriginChenClgController:sendPM_OriginChenClgChallengeNormalReq(activityId, stageId, form)
	OriginChenClgAgent.instance:sendPM_OriginChenClgChallengeNormalReq(activityId, stageId, form)
end

function OriginChenClgController:handlePM_OriginChenClgChallengeNormalRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginChenClgChallengeNormalRes, msg)
end

function OriginChenClgController:handlePM_Notify_OriginChenClgChallengeNormalResultRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_Notify_OriginChenClgChallengeNormalResultRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_Notify_OriginChenClgChallengeNormalResultRes, msg)
end

function OriginChenClgController:handlePM_OriginChenClgConfirmExtremeRes(msg)
	self._confirmCI = 0

	if msg.confirm and msg.changeSetId > 0 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)

		self._confirmCI = msg.changeSetId
	end

	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_OriginChenClgConfirmExtremeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_OriginChenClgConfirmExtremeRes, msg)

	if msg.confirm and msg.challengeFinish then
		OriginChenClgAgent.instance:sendPM_OriginChenClgGetInfoReq(msg.activityId)
	end
end

function OriginChenClgController:getActivityType()
	return GameEnum.ActivityType.OriginChenClg
end

function OriginChenClgController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function OriginChenClgController:getSubMo(activityId)
	return OriginChenClgModel.instance:getSubMo(activityId)
end

function OriginChenClgController:getChallengeCfg()
	return TimeLimitedConfig.instance:getCfgById(315)
end

function OriginChenClgController:checkConfirmCI()
	if self._confirmCI > 0 then
		MaterialController.instance:showChangeSetInTemp(self._confirmCI)

		self._confirmCI = 0
	end
end

OriginChenClgController.instance = OriginChenClgController.New()

return OriginChenClgController
