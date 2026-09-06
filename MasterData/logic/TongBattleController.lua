-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tongbattle/controller/TongBattleController.lua

module("logic.extensions.tongbattle.controller.TongBattleController", package.seeall)

local TongBattleController = class("TongBattleController", BaseController)

function TongBattleController:ctor()
	return
end

function TongBattleController:onInit()
	self:onReset()
end

function TongBattleController:onReset()
	self._isComm = nil
end

function TongBattleController:csGetTongBaseInfoReq()
	PupilChallengeAgent.instance:sendPM_PCGetMainBoardInfoReq(TongBattleModel.instance.challengeId)
end

function TongBattleController:scSendTongBaseInfo(msg)
	TongBattleModel.instance:scSendTongBaseInfo(msg)
end

function TongBattleController:csGetTongBattleInfoReq()
	PupilChallengeAgent.instance:sendPM_PCGetChallengeBoardInfoReq(TongBattleModel.instance.challengeId)
end

function TongBattleController:scSendTongBattleInfo(msg)
	TongBattleModel.instance:scSendTongBattleInfo(msg)
	self:csGetTongBaseInfoReq()
end

function TongBattleController:csGetTongBossInfoReq(isComm)
	local num = isComm and 0 or 1

	self._isComm = isComm

	PupilChallengeAgent.instance:sendPM_PCGetChallengeBossInfoReq(TongBattleModel.instance.challengeId, num)
end

function TongBattleController:scSendTongBossInfo(msg)
	TongBattleModel.instance:scSendTongBossInfo(msg, self._isComm)

	self._isComm = nil
end

function TongBattleController:csGetTongBattleStageReq(chaType, stageId)
	PupilChallengeAgent.instance:sendPM_PCChallengeStageReq(TongBattleModel.instance.challengeId, chaType, stageId)
end

function TongBattleController:scSendTongBattleStage()
	return
end

function TongBattleController:csGetTongStageRoundsReq(isReset, rounds)
	PupilChallengeAgent.instance:sendPM_PCSetNewTurnsReq(TongBattleModel.instance.challengeId, isReset, rounds)
end

function TongBattleController:scSendTongStageRounds()
	return
end

function TongBattleController:csGetTongBuyTimesReq()
	PupilChallengeAgent.instance:sendPM_PCBuyChallengeTimesReq(TongBattleModel.instance.challengeId)
end

function TongBattleController:scSendTongBuyTimes(msg)
	TongBattleModel.instance:scSendTongBuyTimes(msg)
end

function TongBattleController:csGetTongRankInfoReq(isComm)
	if isComm then
		TimedChallengeAgent.instance:sendPM_TimedChallengeGetPetRankReq(TongBattleModel.instance.challengeId, function(msg)
			self:scSendTongRankInfoSuc(msg, true)
		end, nil, function()
			self:scSendTongRankInfoErr(true)
		end)
	else
		PupilChallengeAgent.instance:sendPM_PCGetHellRankInfoReq(TongBattleModel.instance.challengeId)
	end
end

function TongBattleController:scSendTongRankInfoSuc(msg, isComm)
	TongBattleModel.instance:scSendTongRankInfoSuc(msg, isComm)
end

function TongBattleController:scSendTongRankInfoErr(isComm)
	return
end

function TongBattleController:scSendTongNotifyBattleEnd(msg)
	TongBattleModel.instance:scSendTongNotifyBattleEnd(msg)
end

TongBattleController.instance = TongBattleController.New()

return TongBattleController
