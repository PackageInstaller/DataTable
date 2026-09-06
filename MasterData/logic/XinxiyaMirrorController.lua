-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xinxiyamirror/controller/XinxiyaMirrorController.lua

module("logic.extensions.xinxiyamirror.controller.XinxiyaMirrorController", package.seeall)

local XinxiyaMirrorController = class("XinxiyaMirrorController", BaseController)

function XinxiyaMirrorController:ctor()
	return
end

function XinxiyaMirrorController:onInit()
	self:onReset()
end

function XinxiyaMirrorController:onReset()
	return
end

function XinxiyaMirrorController:csGetMirrorInfoReq()
	MirrorChallengeAgent.instance:sendPM_MirrorChallengeInfoReq()
end

function XinxiyaMirrorController:scSendMirrorInfo(msg)
	XinxiyaMirrorModel.instance:scSendMirrorInfo(msg)
end

function XinxiyaMirrorController:csMirrorChallengeReq(stageId)
	MirrorChallengeAgent.instance:sendPM_MirrorChallengeReq(stageId)
end

function XinxiyaMirrorController:csMirrorUseBuffReq()
	MirrorChallengeAgent.instance:sendPM_MirrorChallengeUseBuffReq()
end

function XinxiyaMirrorController:scSendMirrorUseBuff(info)
	XinxiyaMirrorModel.instance:scSendMirrorUseBuff(info)
end

function XinxiyaMirrorController:csResetMirrorStageReq()
	MirrorChallengeAgent.instance:sendPM_MirrorChallengeClearMirrorReq()
end

function XinxiyaMirrorController:scSendsResetMirrorStage()
	XinxiyaMirrorModel.instance:scSendsResetMirrorStage()
end

function XinxiyaMirrorController:csGetMirrorStagePowerReq()
	MirrorChallengeAgent.instance:sendPM_MirrorChallengeAllStageScoreReq()
end

function XinxiyaMirrorController:scSendMirrorStagePower(info)
	XinxiyaMirrorModel.instance:scSendMirrorStagePower(info)
end

function XinxiyaMirrorController:csGetMirrorRankInfoReq()
	MirrorChallengeAgent.instance:sendPM_MirrorChallengeRankReq()
end

function XinxiyaMirrorController:scSendMirrorRankInfo(msg)
	RankModel.instance:setRankData(msg, GameEnum.RankType.Mirror_Rank, 0)
	GlobalDispatcher:dispatch(GlobalNotify.RankDataGet)
end

function XinxiyaMirrorController:scSendNotifyMirrorEnd(msg)
	XinxiyaMirrorModel.instance:scSendNotifyMirrorEnd(msg)
end

function XinxiyaMirrorController:csGetMirrorDailyPrizeReq()
	MirrorChallengeAgent.instance:sendPM_MirrorChallengeGainDailyPrizeReq()
end

function XinxiyaMirrorController:scSendMirrorDailyPrize()
	XinxiyaMirrorModel.instance:scSendMirrorDailyPrize()
end

XinxiyaMirrorController.instance = XinxiyaMirrorController.New()

return XinxiyaMirrorController
