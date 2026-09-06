-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/corpr/model/CorPrChallengeModel.lua

module("logic.extensions.corpr.model.CorPrChallengeModel", package.seeall)

local CorPrChallengeModel = class("CorPrChallengeModel", BaseModel)

function CorPrChallengeModel:ctor()
	return
end

function CorPrChallengeModel:onInit()
	self:onReset()
end

function CorPrChallengeModel:onReset()
	self._challengeInfoMsg = {}
	self._corPrCustomFmtMo = nil
end

function CorPrChallengeModel:handlePM_CorrectPrincipleChallengeGetInfoRes(msg)
	self._challengeInfoMsg.stageInfo = msg.stageInfo
end

function CorPrChallengeModel:handlePM_CorrectPrincipleChallengeFightRes(msg)
	return
end

function CorPrChallengeModel:handlePM_CorrectPrincipleChallengeNotifyFightEndRes(msg)
	self._challengeInfoMsg.stageInfo = msg.stageInfo
end

function CorPrChallengeModel:getCustomFmtMoAsCorPr()
	if self._corPrCustomFmtMo == nil then
		self._corPrCustomFmtMo = CorPrCustomFmtMo.New()
	end

	return self._corPrCustomFmtMo
end

function CorPrChallengeModel:getStageInfo()
	local stageInfo

	return (self._challengeInfoMsg.stageInfo or nil) and self._challengeInfoMsg.stageInfo
end

CorPrChallengeModel.instance = CorPrChallengeModel.New()

return CorPrChallengeModel
