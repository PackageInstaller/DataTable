-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/NinePlaceMissionFmtView.lua

module("logic.extensions.nineplace.view.NinePlaceMissionFmtView", package.seeall)

local NinePlaceMissionFmtView = class("NinePlaceMissionFmtView", MissionFmtView)

function NinePlaceMissionFmtView:onExit()
	NinePlaceMissionFmtView.super.onExit(self)
end

function NinePlaceMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

function NinePlaceMissionFmtView:_getCreepCos()
	local params = self:getOpenParam()
	local creepsMasterId = params[2]
	local cfgs = NinePlaceConfig.instance:getPetsCfg(creepsMasterId)

	return cfgs or {}
end

function NinePlaceMissionFmtView:getheroSkillId(monsterCo, teams)
	local skillIds = FightingPowerFormula.instance:getHeroSkillsByPetIds(teams)

	if skillIds then
		if not skillIds[1] then
			return 0
		end
	end
end

return NinePlaceMissionFmtView
