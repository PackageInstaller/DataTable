-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formprediction/controller/FormPredictionController.lua

module("logic.extensions.formprediction.controller.FormPredictionController", package.seeall)

local FormPredictionController = class("FormPredictionController", BaseController)

function FormPredictionController:onInit()
	self:onReset()
end

function FormPredictionController:onReset()
	return
end

function FormPredictionController:sendGetInfo(activityId)
	FormPredictionAgent.instance:sendPM_FormPredictionGetInfoReq(activityId)
end

function FormPredictionController:onGetInfo(msg)
	FormPredictionModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FORMPREDICTION_UPDATE)
end

function FormPredictionController:sendSetForm(activityId, formId, petIdsOnForm)
	FormPredictionAgent.instance:sendPM_FormPredictionSetFormReq(activityId, formId, petIdsOnForm)
end

function FormPredictionController:onSetForm(msg)
	FormPredictionModel.instance:onSetForm(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FORMPREDICTION_UPDATE)
end

function FormPredictionController:sendGetPrize(activityId, formId)
	FormPredictionAgent.instance:sendPM_FormPredictionGainPrizeReq(activityId, formId)
end

function FormPredictionController:onGetPrize(msg)
	FormPredictionModel.instance:onGetPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FORMPREDICTION_UPDATE)
end

function FormPredictionController:sendGetRatio(activityId, formId)
	FormPredictionAgent.instance:sendPM_FormPredictionGetSelectRatioReq(activityId, formId)
end

function FormPredictionController:onGetRatio(msg)
	FormPredictionModel.instance:onGetRatio(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FORMPREDICTION_RATIO_UPDATE)
end

function FormPredictionController:sendGetRank(activityId, formId)
	FormPredictionAgent.instance:sendPM_FormPredictionRankViewReq(activityId, formId)
end

function FormPredictionController:onGetRank(msg)
	FormPredictionModel.instance:onGetRank(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FORMPREDICTION_RANK_UPDATE)
end

FormPredictionController.instance = FormPredictionController.New()

return FormPredictionController
