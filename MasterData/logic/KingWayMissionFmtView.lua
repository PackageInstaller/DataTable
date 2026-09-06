-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/view/KingWayMissionFmtView.lua

module("logic.extensions.kingway.view.KingWayMissionFmtView", package.seeall)

local KingWayMissionFmtView = class("KingWayMissionFmtView", MissionFmtView)

function KingWayMissionFmtView:getHeroSkillId(co, team)
	local list = FightingPowerFormula.instance:getHeroSkills(team)

	return (list or nil) and (list[1] or 0)
end

function KingWayMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()

	self._powerTxt.text = "？？？"
end

function KingWayMissionFmtView:_getCreepCos()
	local cfgStage = self:_getMonsterCo()

	return (KingWayConfig.instance:GetWayCreepsCfg(cfgStage.creepsMasterId))
end

function KingWayMissionFmtView:_getMonsterCo()
	local batId, staId = KingWayModel.instance:GetKingBattleAndStageId()

	staId = staId + 1

	local allCfgs = KingWayConfig.instance:GetWayStageCfg(batId) or {}

	return allCfgs[staId] or {}
end

return KingWayMissionFmtView
