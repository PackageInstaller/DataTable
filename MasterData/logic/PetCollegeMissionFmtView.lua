-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcollege/view/PetCollegeMissionFmtView.lua

module("logic.extensions.petcollege.view.PetCollegeMissionFmtView", package.seeall)

local PetCollegeMissionFmtView = class("PetCollegeMissionFmtView", MissionFmtView)

function PetCollegeMissionFmtView:onExit()
	PetCollegeMissionFmtView.super.onExit(self)
	GuideController.instance:setViewVar("college_challengeId", nil)
	GuideController.instance:setViewVar("college_stageId", nil)
end

function PetCollegeMissionFmtView:onEnter()
	local params = self:getOpenParam()

	self._challengeId, self._stageId = params[1], params[2]

	PetCollegeMissionFmtView.super.onEnter(self)
	GuideController.instance:setViewVar("college_challengeId", self._challengeId)
	GuideController.instance:setViewVar("college_stageId", self._stageId)
end

function PetCollegeMissionFmtView:_getMonsterCo()
	local cfg = PetCollegeConfig.instance:getStageCfgByStageId(self._challengeId, self._stageId)

	return PetCollegeConfig.instance:getTeamCfg(cfg.teamId)
end

function PetCollegeMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

function PetCollegeMissionFmtView:_getCreepCos()
	local params = self:getOpenParam()
	local cfgs = PetCollegeConfig.instance:getCreepsCfgByStage(self._challengeId, self._stageId)

	return cfgs or {}
end

return PetCollegeMissionFmtView
