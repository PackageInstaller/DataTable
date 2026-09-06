-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankverify/controller/RankVerifyController.lua

module("logic.extensions.rankverify.controller.RankVerifyController", package.seeall)

local RankVerifyController = class("RankVerifyController", BaseController)

function RankVerifyController:onReset()
	return
end

function RankVerifyController:getInfo(actId)
	VerificationTaskPrizeAgent.instance:sendPM_VerificationTaskPrizeGetInfoReq(actId)
end

function RankVerifyController:handleGetInfo(msg)
	RankVerifyModel.instance:updateGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.RankVerifyInfoUpdate)
end

function RankVerifyController:verifyTask(actId, taskId)
	VerificationTaskPrizeAgent.instance:sendPM_VerificationTaskPrizeVerifyTaskReq(actId, taskId)
end

function RankVerifyController:handleVerifyTask(msg)
	RankVerifyModel.instance:updateVerifyTask(msg)
	GlobalDispatcher:dispatch(GlobalNotify.RankVerifyInfoUpdate)
end

function RankVerifyController:gainPrize(actId, prizeId)
	VerificationTaskPrizeAgent.instance:sendPM_VerificationTaskPrizeGainPrizeReq(actId, prizeId)
end

function RankVerifyController:handleGainPrize(msg)
	RankVerifyModel.instance:updateGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.RankVerifyInfoUpdate)
end

RankVerifyController.instance = RankVerifyController.New()

return RankVerifyController
