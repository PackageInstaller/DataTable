-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originhotbloodmmclg/controller/OriginHotBloodMMClgController.lua

module("logic.extensions.originhotbloodmmclg.controller.OriginHotBloodMMClgController", package.seeall)

local OriginHotBloodMMClgController = class("OriginHotBloodMMClgController", BaseController)

function OriginHotBloodMMClgController:onInit()
	self:onReset()
end

function OriginHotBloodMMClgController:onReset()
	return
end

function OriginHotBloodMMClgController:handlePM_OriginHotBloodMMClgGetInfoRes(msg)
	OriginHotBloodMMClgModel.instance:setInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginHotBloodMMClgGetInfoRes)
end

function OriginHotBloodMMClgController:handlePM_OriginHotBloodMMClgChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginHotBloodMMClgChallengeRes)
end

function OriginHotBloodMMClgController:handlePM_Notify_OriginHotBloodMMClgChallengeResultRes(msg)
	OriginHotBloodMMClgModel.instance:setStageInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_Notify_OriginHotBloodMMClgChallengeResultRes)
end

function OriginHotBloodMMClgController:sendInfoReq(activityId)
	OriginHotBloodMMClgAgent.instance:sendPM_OriginHotBloodedMMClgGetInfoReq(activityId)
end

function OriginHotBloodMMClgController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.OriginHotBloodMMClg)
end

function OriginHotBloodMMClgController:openMissionView(activityId, stageId)
	local fmtMo = OriginHotBloodMMClgModel.instance:getFmtMo()

	fmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function OriginHotBloodMMClgController:isAllStagePassed(activityId)
	local stageCfgs = OriginHotBloodMMClgConfig.instance:getStages(activityId)

	for _, v in ipairs(stageCfgs) do
		if OriginHotBloodMMClgModel.instance:getPassStage(activityId) < v.stageId then
			return false
		end
	end

	return true
end

function OriginHotBloodMMClgController:enterStageBattle(activityId, phaseId, stageId, investBudget)
	local fmtMo = OriginHotBloodMMClgModel.instance:getFmtMo(activityId)

	fmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

OriginHotBloodMMClgController.instance = OriginHotBloodMMClgController.New()

return OriginHotBloodMMClgController
