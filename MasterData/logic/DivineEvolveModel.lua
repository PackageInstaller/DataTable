-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineevolve/model/DivineEvolveModel.lua

module("logic.extensions.divineevolve.model.DivineEvolveModel", package.seeall)

local DivineEvolveModel = class("DivineEvolveModel", BaseModel)

DivineEvolveModel.ReadFlag = "DivineEvolveModel.ReadFlag"
DivineEvolveModel.EnterPopupReadFlag = DivineEvolveModel.ReadFlag .. "#EnterPopup"

function DivineEvolveModel:ctor()
	return
end

function DivineEvolveModel:onInit()
	self:onReset()
end

function DivineEvolveModel:onReset()
	self._canEvolveRaceIds = {}
end

function DivineEvolveModel:onGetDivineEvolveInfoRes(msg)
	self._canEvolveRaceIds = GameUtil.pbToTable(msg.canEvolveRaceIds) or {}
end

function DivineEvolveModel:isFinishEvolveCondition(postDivineRaceId)
	return TableUtil.isHad(self._canEvolveRaceIds, postDivineRaceId)
end

function DivineEvolveModel:isFinishEvolveChallenge(challengeId)
	local cfg = EvolveConfig.instance:getDivineEvolveCfgByChallengeId(challengeId)

	if cfg then
		return self:isFinishEvolveCondition(cfg.newRaceId)
	else
		return false
	end
end

function DivineEvolveModel:getExtChallengeRedPoint(challengeId)
	return GameUtil.getUserData(DivineEvolveModel.ReadFlag .. "#ExtChallenge#" .. "Enter#" .. challengeId)
end

function DivineEvolveModel:saveExtChallengeRedPoint(challengeId)
	GameUtil.saveUserData(DivineEvolveModel.ReadFlag .. "#ExtChallenge#" .. "Enter#" .. challengeId, true)
end

function DivineEvolveModel:hasReadEnterPopup()
	return GameUtil.getUserData(DivineEvolveModel.EnterPopupReadFlag) == true
end

function DivineEvolveModel:saveEnterPopupReadFlag()
	GameUtil.saveUserData(DivineEvolveModel.EnterPopupReadFlag, true)
end

DivineEvolveModel.instance = DivineEvolveModel.New()

return DivineEvolveModel
