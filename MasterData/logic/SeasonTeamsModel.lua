-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/SeasonTeamsModel.lua

module("logic.extensions.season.model.SeasonTeamsModel", package.seeall)

local SeasonTeamsModel = class("SeasonTeamsModel", BaseModel)
local defaultTeamSceneResPath = "scene/season/season_player_head.prefab"

SeasonTeamsModel.TeammateAddTeamId = 100

function SeasonTeamsModel:onInit()
	self._teams = {}
	self._currTeamId = 0
end

function SeasonTeamsModel:onReset()
	self._teams = {}
	self._otherTeams = {}
	self._currTeamId = 0
	self.resetTimes = 0
	self._seasonId = -1
	self._activiteBudgeIds = nil
	self._infos = nil
	self._totemPoleAttrMap = nil
	self._badgeAttr = nil

	removetimer(self.onStrengthTimer, self)
end

function SeasonTeamsModel:addTeam(teamMo)
	self._teams = self._teams or {}

	table.insert(self._teams, teamMo)
end

function SeasonTeamsModel:addOtherTeam(teamMo)
	self._otherTeams = self._otherTeams or {}

	table.insert(self._otherTeams, teamMo)
end

function SeasonTeamsModel:setTeam(team)
	self._teams = team
	self._currTeamId = 0
end

function SeasonTeamsModel:getTeams()
	return self._teams
end

function SeasonTeamsModel:getOtherTeams()
	return self._otherTeams
end

function SeasonTeamsModel:getTeam(teamId)
	if not self._teams then
		return
	end

	for i = 1, #self._teams do
		if self._teams[i].teamId == teamId then
			return self._teams[i]
		end
	end
end

function SeasonTeamsModel:getTeamSceneResPath(team)
	if not team then
		return
	end

	if string.nilorempty(team.sceneResPath) then
		return defaultTeamSceneResPath
	end

	return team.sceneResPath
end

function SeasonTeamsModel:getCurrTeamId()
	if self._currTeamId == 0 and self._teams and #self._teams > 0 then
		self._currTeamId = self._teams[1].teamId
	end

	return self._currTeamId
end

function SeasonTeamsModel:getCurrTeamMo()
	local teamId = self:getCurrTeamId()

	return (self:getTeam(teamId))
end

function SeasonTeamsModel:setCurrTeamId(currTeamId)
	if currTeamId > 0 then
		self._currTeamId = currTeamId
	end
end

function SeasonTeamsModel:onSetAllTeamMapInfo(msg)
	local teamPos = msg.teamPos

	for i, teamPo in ipairs(teamPos) do
		local teamMo = self:getTeam(teamPo.teamId)

		if teamMo == nil then
			teamMo = SeasonTeamMO.New()
			teamMo.teamId = teamPo.teamId

			self:addTeam(teamMo)
		end

		teamMo:initMapData(teamPo)
	end
end

function SeasonTeamsModel:onServerAddTeams(msg)
	if not msg.infos then
		for i, teamPo in ipairs(msg.infos) do
			local teamMo = self:getTeam(teamPo.teamId)

			if teamMo == nil then
				teamMo = SeasonTeamMO.New()
				teamMo.teamId = teamPo.teamId

				self:addTeam(teamMo)
			end

			teamMo:initMapData(teamPo)
		end
	end
end

function SeasonTeamsModel:onServerAllTeammateTeamMapInfo(msg)
	for i, v in ipairs(msg.teamList or {}) do
		self:onServerTeammateTeamMapInfo(v)
	end
end

function SeasonTeamsModel:onServerTeammateTeamMapInfo(teammateInfo)
	local teamMo = self:getTeam(teammateInfo.teamId + SeasonTeamsModel.TeammateAddTeamId)

	if teamMo == nil then
		teamMo = SeasonTeamMO.New()
		teamMo.teamId = teammateInfo.teamId + SeasonTeamsModel.TeammateAddTeamId

		self:addOtherTeam(teamMo)
	end

	local teamPo = {}

	teamPo.curPosition = teammateInfo.pointId
	teamPo.raceId = teammateInfo.raceId
	teamPo.teamName = ""
	teamPo.zdl = 0
	teamPo.isLock = false
	teamPo.teamId = teammateInfo.teamId + SeasonTeamsModel.TeammateAddTeamId

	teamMo:initMapData(teamPo)
end

function SeasonTeamsModel:onSetAllTeamStrengthInfo(msg)
	local teamStrengthInfos = msg.teams

	for i, teamStrengthInfo in ipairs(teamStrengthInfos) do
		self:onSetSingleStrengthInfo(teamStrengthInfo)
	end
end

function SeasonTeamsModel:onSetSingleStrengthInfo(teamStrengthInfo)
	if teamStrengthInfo then
		local teamMo = self:getTeam(teamStrengthInfo.teamId)

		if teamMo == nil then
			teamMo = SeasonTeamMO.New()
			teamMo.teamId = teamStrengthInfo.teamId

			self:addTeam(teamMo)
		end

		teamMo:updateStrength(teamStrengthInfo)
	end

	removetimer(self.onStrengthTimer, self)
	settimer(5, self.onStrengthTimer, self)
end

function SeasonTeamsModel:onStrengthTimer()
	if self._teams then
		for k, teamMo in pairs(self._teams) do
			teamMo:checkAddStrength()
		end
	end
end

function SeasonTeamsModel:updaetTeamZdl(msg)
	if msg then
		local teamZdl = msg.teamZdl

		for i, zdlInfo in ipairs(teamZdl) do
			local teamMo = self:getTeam(zdlInfo.teamId)

			if teamMo == nil then
				teamMo = SeasonTeamMO.New()
				teamMo.teamId = zdlInfo.teamId

				self:addTeam(teamMo)
			end

			teamMo:updateZdl(zdlInfo)
		end
	end
end

function SeasonTeamsModel:onUpdateAllTeamHolyStripesInfo(msg)
	local teamId = msg.teamId
	local infos = msg.infos

	self:onUpdateHolyStripesInfo(teamId, infos)
end

function SeasonTeamsModel:onUpdateHolyStripesInfo(teamId, infos)
	if infos then
		local teamMo = self:getTeam(teamId)

		if teamMo == nil then
			teamMo = SeasonTeamMO.New()
			teamMo.teamId = teamId

			self:addTeam(teamMo)
		end

		teamMo:updateHolyStripesInfoList(infos)
	end
end

function SeasonTeamsModel:onUpdateAllTeamCutePetInfo(msg)
	local teamId = msg.teamId
	local infos = msg.infos

	self:onUpdateCutePetInfo(teamId, infos)
end

function SeasonTeamsModel:onUpdateCutePetInfo(teamId, infos)
	if infos then
		local teamMo = self:getTeam(teamId)

		if teamMo == nil then
			teamMo = SeasonTeamMO.New()
			teamMo.teamId = teamId

			self:addTeam(teamMo)
		end

		teamMo:updateCutePetInfoList(infos)
	end
end

function SeasonTeamsModel:onSetAllTeamFmtInfo(msg)
	self.resetTimes = msg.resetTimes

	local teamInfos = msg.teamInfos

	for i, teamInfo in ipairs(teamInfos) do
		self:onSetSingPetInfo(teamInfo)
	end
end

function SeasonTeamsModel:onSetSingPetInfo(teamInfo)
	local teamMo = self:getTeam(teamInfo.teamId)

	if teamMo == nil then
		teamMo = SeasonTeamMO.New()
		teamMo.teamId = teamInfo.teamId

		self:addTeam(teamMo)
	end

	teamMo:initFmtData(teamInfo)
end

function SeasonTeamsModel:onResetTeamForm(msg)
	local teamId = msg.teamId
	local teamMo = self:getTeam(teamId)

	if teamMo then
		teamMo:resetFormPb(msg.form)
	end
end

function SeasonTeamsModel:onResetAllFmtData()
	self.resetTimes = checknumber(self.resetTimes) + 1

	self:clearAllFmtData()
end

function SeasonTeamsModel:clearAllFmtData()
	for i, teamMo in ipairs(self._teams or {}) do
		teamMo:resetFmtData()
	end
end

function SeasonTeamsModel:onUpdateTeamSummonInfo(msg)
	local teamId = msg.teamId
	local teamMo = self:getTeam(teamId)

	if teamMo then
		teamMo:updateSummonInfo(msg.packageSummonInfos)
	end
end

function SeasonTeamsModel:onBuyPayTime(msg)
	local teamId = msg.teamId
	local teamMo = self:getTeam(teamId)

	if teamMo then
		teamMo.payTimes = checknumber(teamMo.payTimes) + 1
	end
end

function SeasonTeamsModel:onUndateTeamLv(msg)
	local teamId = msg.teamId
	local teamMo = self:getTeam(teamId)

	if teamMo then
		teamMo.teamLv = msg.teamLv
	end
end

function SeasonTeamsModel:setTeamServerLockState(teamId, value)
	local teamMo = self:getTeam(teamId)

	if teamMo then
		teamMo:setServerLockState(value)
	end

	GlobalDispatcher:dispatch(GlobalNotify.SeasonLockTeamStateUpdated, teamId, value)
end

function SeasonTeamsModel:setTeamAimingId(teamId, aimingId)
	local team = self:getTeam(teamId)

	if team then
		team:_setAimingId(aimingId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.SeasonTeamAimIdUpdated, teamId, aimingId)
end

function SeasonTeamsModel:getTeamAimingId(teamId)
	local team = self:getTeam(teamId)

	if team then
		return team:getAimingId()
	end

	return -1
end

function SeasonTeamsModel:traceTeamClientGridPos(teamId, gridId)
	local teamMo = self:getTeam(teamId)

	if teamMo then
		teamMo:traceTeamClientGridPos(gridId)
	end
end

function SeasonTeamsModel:syncTeamServerGridPos(teamId, gridId, isIgnoreDispatch)
	local teamMo = self:getTeam(teamId)

	if teamMo then
		teamMo:syncTeamServerGridPos(gridId, isIgnoreDispatch)
	end
end

function SeasonTeamsModel:onGetAllTeamAttrInfo(msg)
	self._seasonId = msg.seasonId
	self._activiteBudgeIds = msg.activiteBudgeIds
	self._infos = GameUtil.pbToTable(msg.infos)

	self:calcAllTotemPoleAttr()
	self:calcAllBudgeAttr()

	if not self._teams then
		return
	end

	for i, teamMo in ipairs(self._teams) do
		teamMo:updateAllPetAttr()
	end
end

function SeasonTeamsModel:getBadgeAttr(petMo)
	return self._badgeAttr or {}
end

local attrIdxMap = {
	[GameEnum.RaceType.Shui] = 1,
	[GameEnum.RaceType.Huo] = 2,
	[GameEnum.RaceType.Cao] = 3,
	[GameEnum.RaceType.Guang] = 4,
	[GameEnum.RaceType.An] = 5,
	[GameEnum.RaceType.Kong] = 6,
	[GameEnum.RaceType.Chuang] = 6
}

function SeasonTeamsModel:getRaceTypeAttr(petMo)
	local attrIdx = PetSkinConfig.instance:getFisrtEleAttrIdx(petMo.curFaceId)
	local raceTypeIndex = attrIdxMap[attrIdx]

	if self._totemPoleAttrMap then
		return self._totemPoleAttrMap[raceTypeIndex] or {}
	end

	return {}
end

function SeasonTeamsModel:getRaceZdlWanPercent(petMo)
	local attrIdx = PetSkinConfig.instance:getFisrtEleAttrIdx(petMo.curFaceId)
	local raceTypeIndex = attrIdxMap[attrIdx]

	if self._totemPoleZdlWanPercentMap then
		return checknumber(self._totemPoleZdlWanPercentMap[raceTypeIndex])
	end

	return 0
end

function SeasonTeamsModel:onUpdateAllTotemPoleInfo(msg)
	self._infos = GameUtil.pbToTable(msg.infos)

	self:calcAllTotemPoleAttr()

	if not self._teams then
		return
	end

	for i, teamMo in ipairs(self._teams) do
		teamMo:updateAllPetAttr()
	end
end

function SeasonTeamsModel:onUpdateTotemPoleInfo(msg)
	local info = GameUtil.pbToTable(msg)

	if self._infos then
		for i, v in ipairs(self._infos) do
			if v.raceType == info.raceType then
				self._infos[i] = info

				self:updateTotemPoleAttr(info)

				break
			end
		end

		if not self._teams then
			return
		end

		for i, teamMo in ipairs(self._teams) do
			teamMo:updateAllPetAttr()
		end
	end
end

function SeasonTeamsModel:onUpdateBadgeIds(msg)
	self._activiteBudgeIds = msg.activiteBudgeIds

	self:calcAllBudgeAttr()

	if not self._teams then
		return
	end

	for i, teamMo in ipairs(self._teams) do
		teamMo:updateAllPetAttr()
	end
end

function SeasonTeamsModel:calcAllBudgeAttr()
	if checknumber(self._seasonId) > 0 then
		local res = {}

		for i, badgeId in ipairs(self._activiteBudgeIds or {}) do
			local cfg = SeasonMainCampConfig.instance:getBadgeConfig(self._seasonId, badgeId) or {}
			local attrs = FightingPowerFormula.instance:parseAttrValues(cfg.propertyApp) or {}

			res = AttrMo.addSameAttrs(attrs, res)
		end

		local list = SeasonMainCampConfig.instance:getBadgeSuitConfig(self._seasonId)
		local len = #list

		for i = len, 1, -1 do
			local cfg = list[i]

			if #self._activiteBudgeIds >= cfg.num then
				local attrs = FightingPowerFormula.instance:parseAttrValues(cfg.propertyParam)

				res = AttrMo.addSameAttrs(attrs, res)

				break
			end
		end

		self._badgeAttr = res
	end
end

function SeasonTeamsModel:calcAllTotemPoleAttr()
	if checknumber(self._seasonId) > 0 then
		for i, info in ipairs(self._infos) do
			self:updateTotemPoleAttr(info)
		end
	end
end

function SeasonTeamsModel:updateTotemPoleAttr(info)
	if checknumber(self._seasonId) > 0 then
		local totemCfg = SeasonMainCampConfig.instance:getTotemPoleConfig(self._seasonId) or {}
		local totemPoleRaceTypePlanId = checknumber(totemCfg.totemPoleRaceTypePlanId)
		local res = {}
		local attrs = {}
		local raceTypeIndex = info.raceType
		local raceTypeConfig = SeasonMainCampConfig.instance:getTotemPoleRaceTypeConfig(totemPoleRaceTypePlanId, raceTypeIndex) or {}
		local totemItemPlanId = raceTypeConfig.totemItemPlanId

		if not info.itemInfos then
			for j, item in ipairs(info.itemInfos) do
				local itemId = item.itemId
				local itemLv = item.itemLv
				local cfg = SeasonMainCampConfig.instance:getTotemPoleItemConfig(totemItemPlanId, itemId, itemLv) or {}

				attrs = FightingPowerFormula.instance:parseAttrValues(cfg.propertyApp) or {}
				res = AttrMo.addSameAttrs(attrs, res)
			end

			local mainTotemPlanId = raceTypeConfig.mainTotemPlanId
			local mainTotemPoleLv = info.mainTotemPoleLv
			local mainCfg = SeasonMainCampConfig.instance:getMainTotemConfig(mainTotemPlanId, mainTotemPoleLv)

			if mainCfg then
				attrs = FightingPowerFormula.instance:parseAttrValues(mainCfg.propertyApp) or {}
				res = AttrMo.addSameAttrs(attrs, res)
			end

			self._totemPoleAttrMap = self._totemPoleAttrMap or {}
			self._totemPoleAttrMap[raceTypeIndex] = res
			self._totemPoleZdlWanPercentMap = self._totemPoleZdlWanPercentMap or {}

			if mainCfg then
				self._totemPoleZdlWanPercentMap[raceTypeIndex] = mainCfg.provideZdlWanPercent
			end
		end
	end
end

function SeasonTeamsModel:handleTeammateAllTeamInfo(msg)
	self._teamAllTeamInfo = GameUtil.pbToTable(msg.teamInfos)
end

function SeasonTeamsModel:getTeammateAllTeamInfo()
	return self._teamAllTeamInfo
end

SeasonTeamsModel.instance = SeasonTeamsModel.New()

return SeasonTeamsModel
