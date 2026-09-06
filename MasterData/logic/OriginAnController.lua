-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originan/controller/OriginAnController.lua

module("logic.extensions.originan.controller.OriginAnController", package.seeall)

local OriginAnController = class("OriginAnController", BaseController)

function OriginAnController:onInit()
	return
end

function OriginAnController:onReset()
	return
end

function OriginAnController:sendPM_OriginAnInfoReq(activityId)
	OriginAnAgent.instance:sendPM_OriginAnInfoReq(activityId)
end

function OriginAnController:handlePM_OriginAnInfoRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_OriginAnInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginAnInfoRes)
end

function OriginAnController:sendPM_OriginAnResetExtremeReq(activityId, stageId)
	OriginAnAgent.instance:sendPM_OriginAnResetExtremeReq(activityId, stageId)
end

function OriginAnController:handlePM_OriginAnResetExtremeRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_OriginAnResetExtremeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginAnResetExtremeRes)
end

function OriginAnController:sendPM_OriginAnExtremeClgReq(activityId, form, stageId)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local mo = self:getSubMo(activityId)
		local msg = mo:getExtremeClgNotifyMsg()

		UIStateManager.instance:push(ViewName.OriginAnExtremeResultView, msg)

		return true
	end)
	OriginAnAgent.instance:sendPM_OriginAnExtremeClgReq(activityId, form, stageId)
end

function OriginAnController:handlePM_OriginAnExtremeClgRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginAnExtremeClgRes)
end

function OriginAnController:handlePM_OriginAnNotifyExtremeClgRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_OriginAnNotifyExtremeClgRes(msg)

	if msg:HasField("changeSetId") then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginAnNotifyExtremeClgRes)
end

function OriginAnController:sendPM_OriginAnNormalClgReq(activityId, stageId, form)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local result = false
		local mo = self:getSubMo(activityId)
		local msg = mo:getNormalClgNotifyMsg()

		if msg and msg.isWin then
			UIStateManager.instance:push(ViewName.OriginAnNormalResultView, msg)

			result = true
		end

		return result
	end)
	OriginAnAgent.instance:sendPM_OriginAnNormalClgReq(activityId, stageId, form)
end

function OriginAnController:handlePM_OriginAnNormalClgRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginAnNormalClgRes)
end

function OriginAnController:handlePM_OriginAnNotifyNormalClgRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_OriginAnNotifyNormalClgRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginAnNotifyNormalClgRes)
end

function OriginAnController:sendPM_OriginAnGainNormalProgressReq(activityId, progressId)
	OriginAnAgent.instance:sendPM_OriginAnGainNormalProgressReq(activityId, progressId)
end

function OriginAnController:handlePM_OriginAnGainNormalProgressRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_OriginAnGainNormalProgressRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginAnGainNormalProgressRes)
end

function OriginAnController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.OriginAn)
end

function OriginAnController:getSubMo(activityId)
	return OriginAnModel.instance:getSubMo(activityId)
end

function OriginAnController:getCurNormalStageGroupId(activityId)
	local activityType = ActivityDefineController.instance:getActTypeByActId(activityId)
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, activityId)
	local day = GameUtil.getDaysByTimestamp(startTime, ServerTime.now())
	local groups = OriginAnConfig.instance:getNormalStageDatass(activityId) or {}
	local length = #groups

	if length > 0 then
		return (day - 1) % length + 1
	end

	return 0
end

function OriginAnController:enterBattleNormal(activityId, groupId, stageId)
	local fmtMo = OriginAnModel.instance:getNormalFmtMo(activityId)

	fmtMo:updateCfg(activityId, groupId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function OriginAnController:enterBattleExtreme(activityId, stageId)
	local fmtMo = OriginAnModel.instance:getExtremeFmtMo(activityId)

	fmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

OriginAnController.instance = OriginAnController.New()

return OriginAnController
