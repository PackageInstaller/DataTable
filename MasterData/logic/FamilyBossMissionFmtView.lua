-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyBossMissionFmtView.lua

module("logic.extensions.family.view.FamilyBossMissionFmtView", package.seeall)

local FamilyBossMissionFmtView = class("FamilyBossMissionFmtView", MissionFmtView)

function FamilyBossMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()

	self._powerTxt.text = "？？？"
end

function FamilyBossMissionFmtView:_getCreepCos()
	local bossId = self:getFirstParam()
	local spPetCos = FamilyConfig.instance:getBossCreepsCfg(bossId)

	return spPetCos or {}
end

function FamilyBossMissionFmtView:getHeroSkillId(monsterCo, team)
	local list = FightingPowerFormula.instance:getHeroSkills(team)

	return (list or nil) and (list[1] or 0)
end

return FamilyBossMissionFmtView
