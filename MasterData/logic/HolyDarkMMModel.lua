-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydarkmm/model/HolyDarkMMModel.lua

module("logic.extensions.holydarkmm.model.HolyDarkMMModel", package.seeall)

local HolyDarkMMModel = class("HolyDarkMMModel", BaseModel)

function HolyDarkMMModel:onInit()
	self:onReset()
end

function HolyDarkMMModel:onReset()
	self.stages = {}
	self.monsters = {}
	self.usedFormPlanId = {}
end

function HolyDarkMMModel:setChallengeInfo(msg)
	GameUtil.pbToTable(msg.stages, self.stages)
end

function HolyDarkMMModel:getChallengeInfo()
	return self.stages or {}
end

function HolyDarkMMModel:getMonsterInfo(stageId)
	for _, v in pairs(self.stages) do
		if v.stageId == stageId then
			return v.monsters or {}
		end
	end

	return {}
end

function HolyDarkMMModel:getUsedFormPlanId(stageId)
	for _, v in pairs(self.stages) do
		if v.stageId == stageId then
			return v.usedFormPlanId
		end
	end

	return {}
end

function HolyDarkMMModel:getChallengeLevelInfo(levelId)
	return self.stages[levelId] or {}
end

function HolyDarkMMModel:getChallengeFmtMo(activityId, stageId, formPlanId, angleId, formationPosList, levelId)
	if self._holyDarkMMFmtMo == nil then
		self._holyDarkMMFmtMo = HolyDarkMMFmtMo.New()
	end

	self._holyDarkMMFmtMo:initParams(activityId, stageId, formPlanId, angleId, formationPosList, levelId)

	return self._holyDarkMMFmtMo
end

HolyDarkMMModel.instance = HolyDarkMMModel.New()

return HolyDarkMMModel
