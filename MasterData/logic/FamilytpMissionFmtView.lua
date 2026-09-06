-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/FamilytpMissionFmtView.lua

module(..., package.seeall)

local FamilytpMissionFmtView = class("FamilytpMissionFmtView", MissionFmtView)

function FamilytpMissionFmtView:getHeroSkillId(co, team)
	local list = FightingPowerFormula.instance:getHeroSkills(team)

	return (list or nil) and (list[1] or 0)
end

function FamilytpMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()

	self._powerTxt.text = "???"
	self._speed.text = "???"
end

function FamilytpMissionFmtView:_getCreepCos()
	local params = self:getOpenParam()

	self._periodId = params[1]
	self._bossId = params[2]
	self._type = params[3]
	self._zoneId = params[4]
	self._isPractice = params[5]

	local bcfg

	if self._type == FamilyteamplayController.teamPlayType.Common then
		bcfg = FamilyteamplayConfig.instance:getBossCfg(self._periodId, self._bossId)
	elseif self._type == FamilyteamplayController.teamPlayType.Season then
		bcfg = FamilyteamplayConfig.instance:getTeamPlayBossSeason(self._periodId, self._zoneId, self._bossId)
	end

	if bcfg then
		return FamilyteamplayConfig.instance:getCreepCfgs(bcfg.creepMasterId) or {}
	end

	return {}
end

function FamilytpMissionFmtView:_selectItem(index)
	if self._infoSeats[index] then
		local param = clone(self._infoSeats[index])

		param.hideZdl = true

		CommonTipsMgr.instance:showPetTips(param)
	end
end

return FamilytpMissionFmtView
