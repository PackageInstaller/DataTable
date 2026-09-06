-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/PvEMissionFmtView.lua

module(..., package.seeall)

local PvEMissionFmtView = class("PvEMissionFmtView", MissionFmtView)

function PvEMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

function PvEMissionFmtView:_getCreepCos()
	local pveId = self._viewPresentor._openParam[1]

	return (WuShenConfig.instance:getCfgById(pveId))
end

function PvEMissionFmtView:_getMonsterCo()
	local pveId = self._viewPresentor._openParam[1]

	return (WuShenConfig.instance:getMasterCoById(pveId))
end

function PvEMissionFmtView:getTeamAndFormation(creepCfg)
	local teams = {}
	local formations = {}

	if creepCfg then
		for i, v in pairs(creepCfg) do
			if checknumber(v.posId) > 0 then
				local petMo = FightingPowerPetMo.New()

				petMo:fromTaskCreepCo(v, creepCfg)

				petMo.creepName = v.creepName

				table.insert(teams, petMo)

				formations[v.posId] = petMo
			end
		end
	end

	ArraySort.sortOn(teams, "position")

	return teams, formations
end

return PvEMissionFmtView
