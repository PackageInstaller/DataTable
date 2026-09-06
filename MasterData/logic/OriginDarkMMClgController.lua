-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmmclg/controller/OriginDarkMMClgController.lua

module("logic.extensions.origindarkmmclg.controller.OriginDarkMMClgController", package.seeall)

local OriginDarkMMClgController = class("OriginDarkMMClgController", BaseController)

function OriginDarkMMClgController:onInit()
	self:onReset()
end

function OriginDarkMMClgController:onReset()
	return
end

function OriginDarkMMClgController:sendInfoReq(activityId)
	OriginDarkMMClgAgent.instance:sendPM_OriginDarkMMClgGetInfoReq(activityId)
end

function OriginDarkMMClgController:handlePM_OriginDarkMMClgGetInfoRes(msg)
	OriginDarkMMClgModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginDarkMMClgGetInfoRes)
end

function OriginDarkMMClgController:openMissionView(activityId, stageId)
	local fmtMo = OriginDarkMMClgModel.instance:getFmtMo()

	fmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function OriginDarkMMClgController:petCollectionProgress(activityId)
	local data = OriginDarkMMClgConfig.instance:getActivity(activityId)

	if data then
		if not data.petRaceIds then
			local petRaceIds = {}
			local collectionNum = 0

			for _, raceId in pairs(petRaceIds) do
				if HandbookModel.instance:isHasPet(raceId) then
					collectionNum = collectionNum + 1
				end
			end

			local petNum = table.nums(petRaceIds)

			collectionNum = Mathf.Clamp(collectionNum, 0, petNum)

			return collectionNum, collectionNum / petNum
		end
	end
end

function OriginDarkMMClgController:sendResetReq(activityId, stageId)
	OriginDarkMMClgAgent.instance:sendPM_OriginDarkMMClgResetReq(activityId, stageId)
end

function OriginDarkMMClgController:handlePM_OriginDarkMMClgResetRes(activityId, stageId)
	OriginDarkMMClgModel.instance:resetStageInfo(activityId, stageId)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginDarkMMClgResetRes)
end

function OriginDarkMMClgController:handlePM_Notify_OriginDarkMMClgChallengeResultRes(msg)
	OriginDarkMMClgModel.instance:saveChallengeResult(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_Notify_OriginDarkMMClgChallengeResultRes)
end

function OriginDarkMMClgController:isAllStagePassed(activityId)
	local stageCfgs = OriginDarkMMClgConfig.instance:getStages(activityId)

	for _, v in ipairs(stageCfgs) do
		if not OriginDarkMMClgModel.instance:getStageInfo(activityId, v.stageId) then
			return false
		end
	end

	return true
end

function OriginDarkMMClgController:notifyAssignActionValue()
	GlobalDispatcher:dispatch(GlobalNotify.PM_NotifyAssignActionValue)
end

OriginDarkMMClgController.instance = OriginDarkMMClgController.New()

return OriginDarkMMClgController
