-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petsearch/view/PetsearchMissionFmtView.lua

module("logic.extensions.plotcopy.view.PetsearchMissionFmtView", package.seeall)

local PetsearchMissionFmtView = class("PetsearchMissionFmtView", MissionFmtView)

function PetsearchMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()

	self._powerTxt.text = "？？？"
	self._speed.text = "？？？"
end

function PetsearchMissionFmtView:_getCreepCos()
	local teamId = self:_getMonsterCo().creepsMasterId
	local cfgTeam = PetsearchConfig.instance:getTeamCfg(teamId)

	return (PetsearchConfig.instance:getTeamPets(teamId))
end

function PetsearchMissionFmtView:_getMonsterCo()
	local params = self:getOpenParam()

	if not params or not params[1] then
		return {}
	end

	local bossId = params[1]
	local cfgStage = PetsearchConfig.instance:getSearchPetCfg(bossId)

	return cfgStage or {}
end

function PetsearchMissionFmtView:_selectItem(index, isUp)
	if self._infoSeats[index] then
		local param = clone(self._infoSeats[index])

		param.hideZdl = true

		CommonTipsMgr.instance:showPetTips(param)
	end
end

return PetsearchMissionFmtView
