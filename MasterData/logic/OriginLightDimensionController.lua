-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlightdimension/controller/OriginLightDimensionController.lua

module("logic.extensions.originlightdimension.controller.OriginLightDimensionController", package.seeall)

local OriginLightDimensionController = class("OriginLightDimensionController", BaseController)

function OriginLightDimensionController:ctor()
	return
end

function OriginLightDimensionController:onInit()
	self:onReset()
end

function OriginLightDimensionController:onReset()
	self._tempLockPet = {}
end

function OriginLightDimensionController:handlePM_OriginLightDimensionInfoRes(msg)
	OriginLightDimensionModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginLightDimensionGetInfoRes)
end

function OriginLightDimensionController:handlePM_OriginLightDimensionResetExtremeRes(msg)
	OriginLightDimensionModel.instance:saveResetExtremeInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginLightDimensionResetExtremeRes)
end

function OriginLightDimensionController:handlePM_OriginLightDimensionNormalClgRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginLightDimensionNormalClgRes)
end

function OriginLightDimensionController:handlePM_OriginLightDimensionNotifyNormalClgRes(msg)
	OriginLightDimensionModel.instance:saveNormalChallengeResult(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginLightDimensionNotifyNormalClgRes, msg)
end

function OriginLightDimensionController:handlePM_OriginLightDimensionExtremeClgRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginLightDimensionExtremeClgRes)
end

function OriginLightDimensionController:handlePM_OriginLightDimensionNotifyExtremeClgRes(msg)
	OriginLightDimensionModel.instance:saveExtClgResult(msg)

	if msg.isPass == true then
		OriginLightDimensionModel.instance:saveExtremeChallengeResult(msg)
	end

	BattleFacade.instance:registerResultHandler(function()
		UIStateManager.instance:push(ViewName.OriginLightDimensionExtResultView)

		return true
	end)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginLightDimensionNotifyExtremeClgRes, msg)
end

function OriginLightDimensionController:openNormalMissionView(activityId, stageId)
	local fmtMo = OriginLightDimensionModel.instance:getNormalFmtMo()

	fmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function OriginLightDimensionController:openExtremeMissionView(activityId, stageId)
	local fmtMo = OriginLightDimensionModel.instance:getExtremeFmtMo()

	fmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function OriginLightDimensionController:saveTempPrize(changeSetId)
	self._tempChangeSetId = changeSetId

	MaterialController.instance:saveChangeSetToTemp(changeSetId)
end

function OriginLightDimensionController:tryShowTempPrize()
	if self._tempChangeSetId then
		MaterialController.instance:showChangeSetInTemp(self._tempChangeSetId)

		self._tempChangeSetId = nil
	end
end

function OriginLightDimensionController:setExBuffParam(param)
	self._exBuffParam = param
end

function OriginLightDimensionController:getExBuffParam()
	return self._exBuffParam
end

OriginLightDimensionController.instance = OriginLightDimensionController.New()

return OriginLightDimensionController
