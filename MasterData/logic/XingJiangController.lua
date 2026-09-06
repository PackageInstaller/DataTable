-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/controller/XingJiangController.lua

module("logic.extensions.xingjiang.controller.XingJiangController", package.seeall)

local XingJiangController = class("XingJiangController", BaseController)

function XingJiangController:ctor()
	return
end

function XingJiangController:onInit()
	self:onReset()
end

function XingJiangController:onReset()
	return
end

function XingJiangController:sendInfoReq(activityId)
	XingJiangFormulaAgent.instance:sendPM_XingJiangFormulaInfoReq(activityId)
end

function XingJiangController:sendChallengeReq(activityId, stageId, teamId, form)
	XingJiangFormulaAgent.instance:sendPM_XingJiangFormulaChallengeReq(activityId, stageId, teamId, form)
end

function XingJiangController:sendResetReq(activityId, stageId, teamId)
	XingJiangFormulaAgent.instance:sendPM_XingJiangFormulaResetReq(activityId, stageId, teamId)
end

function XingJiangController:sendSignInReq(activityId)
	XingJiangFormulaAgent.instance:sendPM_XingJiangFormulaSignInReq(activityId)
end

function XingJiangController:sendGetTaskReq(activityId, taskId)
	XingJiangFormulaAgent.instance:sendPM_XingJiangFormulaTaskReq(activityId, taskId)
end

function XingJiangController:sendInfo2Req(activityId)
	XingJiangFutureAgent.instance:sendPM_XingJiangFutureInfoReq(activityId)
end

function XingJiangController:sendChallenge2Req(activityId)
	XingJiangFutureAgent.instance:sendPM_XingJiangFutureChallengeReq(activityId)
end

XingJiangController.instance = XingJiangController.New()

return XingJiangController
