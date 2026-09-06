-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yuhuichallenge/model/YuHuiChallengeModel.lua

module("logic.extensions.yuhuichallenge.model.YuHuiChallengeModel", package.seeall)

local YuHuiChallengeModel = class("YuHuiChallengeModel", BaseModel)

function YuHuiChallengeModel:ctor()
	return
end

function YuHuiChallengeModel:onInit()
	self:onReset()
end

function YuHuiChallengeModel:onReset()
	self.CiList = nil
	self._customFmtMo = nil
	self._msgMap = {}
end

function YuHuiChallengeModel:onGetInfo(msg)
	self._msgMap[msg.challengeId] = GameUtil.pbToTable(msg)
end

function YuHuiChallengeModel:getInfo(challengeId)
	return self._msgMap[challengeId]
end

function YuHuiChallengeModel:getSignInBuffLv(challengeId)
	if self._msgMap[challengeId] then
		return self._msgMap[challengeId].signInBuffLv or 0
	end
end

function YuHuiChallengeModel:onSignBuff(msg)
	local info = self._msgMap[msg.challengeId]

	if info then
		info.isSignIn = true
		info.signInBuffLv = msg.signInBuffLv
	end
end

function YuHuiChallengeModel:onChallengeReset(msg)
	local info = self._msgMap[msg.challengeId]

	if info then
		info.balanceValue = 0
		info.curStageId = 1
	end
end

function YuHuiChallengeModel:onChallengeFightEnd(msg)
	self._msgMap[msg.challengeId] = GameUtil.pbToTable(msg)

	if msg:HasField("changeSetId") then
		self.CiList = msg.changeSetId

		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end
end

function YuHuiChallengeModel:getChallengeId()
	return self._challengeId
end

function YuHuiChallengeModel:getBalanceValue(challengeId)
	local info = self._msgMap[challengeId]

	if info then
		return info.balanceValue
	end

	return 0
end

function YuHuiChallengeModel:getCurStageId(challengeId)
	local info = self._msgMap[challengeId]

	if info then
		return info.curStageId
	end

	return 0
end

function YuHuiChallengeModel:getMaxStageId(challengeId)
	local info = self._msgMap[challengeId]

	if info then
		return info.maxStageId
	end

	return 0
end

function YuHuiChallengeModel:ShowCI()
	MaterialController.instance:showChangeSetInTemp(checknumber(self.CiList))

	self.CiList = nil
end

function YuHuiChallengeModel:getCustomFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = YuHuiChallengeCustomFmtMo.New()
	end

	return self._customFmtMo
end

YuHuiChallengeModel.instance = YuHuiChallengeModel.New()

return YuHuiChallengeModel
