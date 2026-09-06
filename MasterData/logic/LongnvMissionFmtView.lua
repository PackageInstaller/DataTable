-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/longnv/mission/LongnvMissionFmtView.lua

module("logic.extensions.mission.view.LongnvMissionFmtView", package.seeall)

local LongnvMissionFmtView = class("LongnvMissionFmtView", MissionFmtView)

function LongnvMissionFmtView:_getCreepCos()
	local creepsMasterId = self:_getMonsterCo().creepsMasterId

	return (LongnvConfig.instance:getCreepsCfg(checknumber(creepsMasterId)))
end

function LongnvMissionFmtView:_getMonsterCo()
	local params = self._viewPresentor:getFirstParam()
	local cCfg

	if params then
		local type = params.type
		local stageId = params.stageId
		local planId = LongnvModel.instance:getPlanId()
		local cfg = LongnvConfig.instance:getPlanCfg(planId) or {}
		local monsterPlan = checknumber(cfg.monsterPlan)
		local monsterList = LongnvConfig.instance:getMonsterListCfg(type, monsterPlan) or {}

		return monsterList[stageId]
	end

	return {}
end

function LongnvMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

return LongnvMissionFmtView
