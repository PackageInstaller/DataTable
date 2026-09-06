-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/ExpeditionMissionFmtView.lua

module(..., package.seeall)

local ExpeditionMissionFmtView = class("ExpeditionMissionFmtView", MissionFmtView)

function ExpeditionMissionFmtView:_getCreepCos()
	local eventInfo = self._viewPresentor._openParam[1].eventInfo

	return ExpeditionFmtModel.instance:getFightingCreeps(eventInfo)
end

function ExpeditionMissionFmtView:_getMonsterCo()
	return nil
end

function ExpeditionMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

function ExpeditionMissionFmtView:_innerrefreshFromation()
	local cCfg, heroSkillId = self:_getCreepCos()
	local teams, formations, speed, zdlRadix = self:getTeamAndFormation(cCfg)

	self:_createExtParams(formations)

	local heroSkillIs = FightingPowerFormula.instance:getHeroValidSkills(teams, self:getCurElementRelationMap(), self._summonMasterPetId, self._summonedPetId)

	if heroSkillIs and #heroSkillIs > 0 and table.indexof(heroSkillIs, heroSkillId) ~= false then
		-- block empty
	else
		heroSkillId = 0
	end

	self:initFormation(formations, teams, heroSkillId)
	self:_setFmtParams(heroSkillId, speed, zdlRadix)
end

function ExpeditionMissionFmtView:getTeamAndFormation(creepCfg)
	local fightingPowerInfo = ExpeditionFmtModel.instance:getFightingMonsterMos(self._viewPresentor._openParam[1].eventInfo)
	local teams = {}
	local formations = {}
	local speed = 0
	local zdlRadix = 0
	local map = {}
	local masterPetId = -1
	local summonPos = -1

	for i, v in ipairs(fightingPowerInfo) do
		local petMo = v.petMo
		local posId = petMo.position

		table.insert(teams, petMo)

		formations[posId] = petMo

		if not petMo:isSummonedPet() then
			speed = speed + v.speed
		else
			masterPetId = petMo.summonMasterId
			summonPos = posId
		end

		map[petMo.petId] = true
		zdlRadix = zdlRadix + v.fightingPower
	end

	if masterPetId > 0 and not map[masterPetId] then
		formations[summonPos] = nil
	end

	return teams, formations, speed, zdlRadix
end

function ExpeditionMissionFmtView:getHeavenAwakenMasterAndTarget()
	local eventInfo = self._viewPresentor._openParam[1].eventInfo

	return ExpeditionFmtModel.instance:getHeavenAwakenMasterAndTarget(eventInfo)
end

return ExpeditionMissionFmtView
