-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pettrial/model/PetTrialModel.lua

module("logic.extensions.pettrial.model.PetTrialModel", package.seeall)

local PetTrialModel = class("PetTrialModel", BaseModel)

function PetTrialModel:ctor()
	return
end

function PetTrialModel:onInit()
	self:onReset()
end

function PetTrialModel:onReset()
	self.isDataInit = false
end

function PetTrialModel:handleGetMyTrialInfo(msg)
	self._stageId = checknumber(msg.stageId)
	self._teamId = checknumber(msg.teamId)
	self._hasSweepTimes = checknumber(msg.leftSweepTimes)
	self.isDataInit = true
end

function PetTrialModel:handleTrialRes(msg)
	if msg.isWin then
		self._stageId = checknumber(msg.stageId)
		self._teamId = checknumber(msg.teamId)
	end
end

function PetTrialModel:getCurStageId()
	return self._stageId
end

function PetTrialModel:getCurTeamId()
	return self._teamId
end

function PetTrialModel:getHasSweepTimes()
	return self._hasSweepTimes
end

function PetTrialModel:getIsLighted(stageId)
	return self:getIsClearAll(stageId - 1)
end

function PetTrialModel:getIsOpen(stageId)
	local cfg = PetTrialConfig.instance:getStageCfgById(stageId)
	local lv = checknumber(cfg.mofangLevel)

	return lv <= MofangModel.instance:getCurLv(), lv
end

function PetTrialModel:getIsClearAll(stageId)
	if stageId <= 0 then
		return true
	end

	if stageId < self._stageId then
		return true
	elseif stageId == self._stageId then
		local t = PetTrialConfig.instance:getTeamCfgs(stageId)

		return self._teamId == #t
	end

	return false
end

function PetTrialModel:getFinishTeamId(stageId)
	local t = PetTrialConfig.instance:getTeamCfgs(stageId)

	if stageId < self._stageId then
		return #t
	elseif stageId == self._stageId then
		return self._teamId
	else
		return 0
	end
end

function PetTrialModel:getCurChallengeId()
	local t = PetTrialConfig.instance:getTeamCfgs(self._stageId)
	local t2 = PetTrialConfig.instance:getStateCfgs()

	if t == nil or self._teamId == #t then
		return math.min(self._stageId + 1, #t2)
	else
		return self._stageId
	end
end

function PetTrialModel:getNextStageAndTeam()
	return self:getCurStage() + 1
end

function PetTrialModel:setSweepTimes(val)
	self._hasSweepTimes = val
end

function PetTrialModel:setCurStage(value)
	self._curStage = value
end

function PetTrialModel:getCurStage()
	return checknumber(self._curStage)
end

PetTrialModel.instance = PetTrialModel.New()

return PetTrialModel
