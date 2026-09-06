-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalchallenge/model/EternalChallengeModel.lua

module("logic.extensions.eternalchallenge.model.EternalChallengeModel", package.seeall)

local EternalChallengeModel = class("EternalChallengeModel", BaseModel)

function EternalChallengeModel:ctor()
	return
end

function EternalChallengeModel:onInit()
	self:onReset()
end

function EternalChallengeModel:onReset()
	self._maxDamage = 0
	self._buffInfos = {}
	self._petInfoMgrs = {}
	self._eternalChallengeCustomFmtMo = nil
	self._fightEndResMsg = nil
end

function EternalChallengeModel:handlePM_EternalChallengeInfoRes(msg)
	self._maxDamage = msg.maxDamage

	local petInfoMgr = self:getPetInfoMgr()

	if petInfoMgr then
		for _, v in ipairs(msg.pets) do
			petInfoMgr:updatePetInfo(v.raceId, v.level)
		end
	end

	table.clear(self._buffInfos)

	for _, v in ipairs(msg.buffs) do
		self._buffInfos[v.buffId] = v
	end
end

function EternalChallengeModel:handlePM_EternalChallengeBuyPetRes(msg)
	local petInfoMgr = self:getPetInfoMgr()

	if petInfoMgr then
		petInfoMgr:updatePetInfo(msg.pet.raceId, msg.pet.level)
	end
end

function EternalChallengeModel:handlePM_EternalChallengeUpgradeBuffRes(msg)
	self._buffInfos[msg.buffs.buffId] = msg.buffs
end

function EternalChallengeModel:handlePM_EternalChallengeFightRes(msg)
	return
end

function EternalChallengeModel:handlePM_NotifyEternalChallengeFightEndRes(msg)
	self._maxDamage = Mathf.Max(self._maxDamage, msg.damage)
	self._fightEndResMsg = msg
end

function EternalChallengeModel:getMaxDamage()
	return self._maxDamage
end

function EternalChallengeModel:getPetInfoMgr(activityId)
	activityId = activityId or EternalChallengeController.instance:getActivityId()

	if activityId == 0 then
		return
	end

	local mgr = self._petInfoMgrs[activityId]

	if mgr == nil then
		mgr = EcPetInfoMgr.New(activityId)
		self._petInfoMgrs[activityId] = mgr
	end

	return mgr
end

function EternalChallengeModel:getCustomFmtMoAsternalChallenge()
	if self._eternalChallengeCustomFmtMo == nil then
		self._eternalChallengeCustomFmtMo = EternalChallengeCustomFmtMo.New()
	end

	return self._eternalChallengeCustomFmtMo
end

function EternalChallengeModel:getFightEndResMsg()
	return self._fightEndResMsg
end

function EternalChallengeModel:getCurBuffLevel(buffId)
	local info = self:getBuffInfo(buffId)

	return (info or nil) and info.level
end

function EternalChallengeModel:getBuffInfo(buffId)
	return self._buffInfos[buffId]
end

EternalChallengeModel.instance = EternalChallengeModel.New()

return EternalChallengeModel
