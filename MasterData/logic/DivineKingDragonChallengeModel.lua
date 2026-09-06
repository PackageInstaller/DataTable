-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingdragonchallenge/model/DivineKingDragonChallengeModel.lua

module("logic.extensions.divinekingdragonchallenge.model.DivineKingDragonChallengeModel", package.seeall)

local DivineKingDragonChallengeModel = class("DivineKingDragonChallengeModel", BaseModel)

function DivineKingDragonChallengeModel:ctor()
	return
end

function DivineKingDragonChallengeModel:onInit()
	self:onReset()
end

function DivineKingDragonChallengeModel:onReset()
	self._customFmtMo = nil
	self._divineKingDragonMoPool = self._divineKingDragonMoPool or {}

	table.clear(self._divineKingDragonMoPool)
end

function DivineKingDragonChallengeModel:handlePM_DivineKingDragonGetInfoRes(msg)
	local mo = self:_getDivineKingDragonMo(msg.actId)

	for _, v in ipairs(msg.stageList) do
		mo:setGainPrizeOfStage(v.stageId, v.gainPrize)

		for _, vv in ipairs(v.teamList) do
			mo:setPassOfTeam(v.stageId, vv.teamId, vv.isPass)
			mo:setLockPetIdsOfTeam(v.stageId, vv.teamId, vv.lockPetIds)
		end
	end
end

function DivineKingDragonChallengeModel:handlePM_DivineKingDragonChallengeRes(msg)
	return
end

function DivineKingDragonChallengeModel:handlePM_DivineKingDragonGainPrizeRes(msg)
	local mo = self:_getDivineKingDragonMo(msg.actId)

	mo:setGainPrizeOfStage(msg.stageId, true)
end

function DivineKingDragonChallengeModel:handlePM_DivineKingDragonResetRes(msg)
	local mo = self:_getDivineKingDragonMo(msg.actId)

	mo:setPassOfTeam(msg.stageId, msg.teamId, false)
	mo:setLockPetIdsOfTeam(msg.stageId, msg.teamId, {})
end

function DivineKingDragonChallengeModel:handlePM_DivineKingDragonNotifyChallengeRes(msg)
	local mo = self:_getDivineKingDragonMo(msg.actId)

	mo:setPassOfTeam(msg.stageId, msg.teamId, msg.isWin)

	if msg.team then
		mo:setPassOfTeam(msg.stageId, msg.team.teamId, msg.team.isPass)
		mo:setLockPetIdsOfTeam(msg.stageId, msg.team.teamId, msg.team.lockPetIds)
	end
end

function DivineKingDragonChallengeModel:getCustomFmtMoOfGkd()
	if self._customFmtMo == nil then
		self._customFmtMo = DivineKingDragonCustomFmtMo.New()
	end

	return self._customFmtMo
end

function DivineKingDragonChallengeModel:_getDivineKingDragonMo(activityId)
	if self._divineKingDragonMoPool[activityId] == nil then
		self._divineKingDragonMoPool[activityId] = DivineKingDragonMo.New(activityId)
	end

	return self._divineKingDragonMoPool[activityId]
end

DivineKingDragonChallengeModel.instance = DivineKingDragonChallengeModel.New()

return DivineKingDragonChallengeModel
