-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/SeasonTeamMO.lua

module("logic.extensions.season.model.SeasonTeamMO", package.seeall)

local SeasonTeamMO = class("SeasonTeamMO")
local EMPTY_TABLE = {}

function SeasonTeamMO:ctor()
	self.teamId = 0
	self.teamName = nil
	self.teamStrength = 0
	self.teamStrengthCD = 0
	self._recordCampLv = -1
	self.teamStrengthCDList = {}
	self.leaderSkinId = 0
	self.sceneResPath = nil
	self.teamLv = 0
	self.clientLastGridId = nil
	self.clientLastGridId2 = nil
	self.clientCurGridId = nil
	self.serverCurGridId = nil
	self.clientRollbackFromGridId = nil
	self._longPathRouterMoveTargetId = nil
	self.petList = nil
	self.holyStripesInfoList = nil
	self.holyStripesInfoMap = nil
	self.cutePetInfoMap = nil
	self.isClientLock = false
	self._aiming = false
	self._aimingId = -1
	self._transportEndGridId = nil
	self.payTimes = 0
	self.isLock = false
	self.teamZdl = 0
	self.isOtherTeam = false
end

function SeasonTeamMO:initMapData(teamPos)
	self.raceId = teamPos.raceId
	self.leaderSkinId = teamPos.raceId

	self:setTeamId(teamPos.teamId)

	self.teamName = teamPos.teamName
	self.teamZdl = checknumber(teamPos.zdl)

	SeasonTeamsModel.instance:setTeamServerLockState(self.teamId, teamPos.isLock)

	self.clientCurGridId = teamPos.curPosition

	self:setPosition(teamPos.curPosition)
end

function SeasonTeamMO:setTeamId(teamId)
	self.teamId = teamId

	self:_checkTeamHead()
end

function SeasonTeamMO:_checkTeamHead()
	if checknumber(self.leaderSkinId) <= 0 then
		local seasonId = SeasonModel.instance:getSeasonId()
		local tgCfg = SeasonMainCampConfig.instance:getTrainingGroundConfig(seasonId)

		if tgCfg then
			local teamPlanId = tgCfg.teamPlanId
			local teamCfg = SeasonMainCampConfig.instance:getTeamConfig(teamPlanId, self.teamId)

			if teamCfg then
				self.teamName = teamCfg.teamName

				if checknumber(teamCfg.headSkinId) > 0 then
					self.leaderSkinId = teamCfg.headSkinId
				end
			end
		end
	end
end

function SeasonTeamMO:isLockAction()
	return self.isLock or self.isClientLock
end

function SeasonTeamMO:isServerLocked()
	return self.isLock
end

function SeasonTeamMO:setServerLockState(value)
	self.isLock = value
end

function SeasonTeamMO:_setAimingId(value)
	self._aimingId = value
end

function SeasonTeamMO:getAimingId()
	return self._aimingId
end

function SeasonTeamMO:isClientLocked()
	return self.isClientLock
end

function SeasonTeamMO:setClientLock(value)
	self.isClientLock = value
end

function SeasonTeamMO:setStartTransport(toGridId)
	self._transportEndGridId = toGridId
end

function SeasonTeamMO:clearTransport()
	self._transportEndGridId = nil
end

function SeasonTeamMO:getTransportGrid()
	return self._transportEndGridId
end

function SeasonTeamMO:setLongPathRouterMoveTargetId(value)
	self._longPathRouterMoveTargetId = value
end

function SeasonTeamMO:clearLongPathRouterMoveTargetId()
	self._longPathRouterMoveTargetId = nil
end

function SeasonTeamMO:getLongPathRouterMoveTargetId()
	return self._longPathRouterMoveTargetId
end

function SeasonTeamMO:updateStrength(params)
	self:setTeamId(params.teamId)

	self.teamStrength = params.totalCount
	self.teamStrengthCD = params.nextLeftTime
	self._recordCampLv = -1
end

function SeasonTeamMO:getStrengthCDList()
	local seasonId = SeasonModel.instance:getSeasonId()
	local mainLevel = SeasonMainCampModel.instance:getCampLv()

	if self._recordCampLv ~= mainLevel then
		self._recordCampLv = mainLevel
		self.teamStrengthCDList = {}

		local cfg = SeasonConfig.instance:getSeasonEnergyCfg(seasonId, mainLevel)
		local recoveryLimit = checknumber(cfg.recoveryLimit)

		if recoveryLimit - self.teamStrength > 0 then
			local count = 0
			local time = self.teamStrengthCD + ServerTime.now()

			for i = self.teamStrength + cfg.unit, recoveryLimit, cfg.unit do
				local tmp = time + count * cfg.recoveryEfficiency

				table.insert(self.teamStrengthCDList, tmp)

				count = count + 1
			end
		end
	end

	return self.teamStrengthCDList
end

function SeasonTeamMO:checkAddStrength()
	self:getStrengthCDList()

	if self.teamStrengthCDList and self.teamStrengthCDList[1] then
		local time = self.teamStrengthCDList[1]

		if time <= ServerTime.now() then
			table.remove(self.teamStrengthCDList, 1)

			local seasonId = SeasonModel.instance:getSeasonId()
			local mainLevel = SeasonMainCampModel.instance:getCampLv()
			local cfg = SeasonConfig.instance:getSeasonEnergyCfg(seasonId, mainLevel)

			self.teamStrength = self.teamStrength + cfg.unit

			GlobalDispatcher:dispatch(GlobalNotify.SeasonFmtTeamInfo)
		end
	end
end

function SeasonTeamMO:updateZdl(msg)
	self.teamZdl = msg.zdl
end

function SeasonTeamMO:updateHolyStripesInfoList(params)
	self.holyStripesInfoList = GameUtil.pbToTable(params) or {}
	self.holyStripesInfoMap = {}

	for i, v in ipairs(self.holyStripesInfoList) do
		self.holyStripesInfoMap[v.raceId] = v.holyStripesId
	end

	self:updateAllPetAttr()
end

function SeasonTeamMO:updateCutePetInfoList(params)
	self.cutePetInfoList = GameUtil.pbToTable(params) or {}
	self.cutePetInfoMap = {}

	for i, v in ipairs(self.cutePetInfoList) do
		if v.cutePetType and v.cutePetTalentId then
			self.cutePetInfoMap[v.raceId] = {
				cutePetType = v.cutePetType,
				cutePetTalentId = v.cutePetTalentId
			}
		end
	end

	self:updateAllPetAttr()
end

function SeasonTeamMO:updateAllPetAttr()
	if self.petList then
		for i, mo in ipairs(self.petList) do
			self.petList[i] = SeasonPetsModel.instance:calcPetAttr(mo, self)
		end
	end
end

function SeasonTeamMO:getCurrHolySpriteAttrs(mo)
	local raceId = mo.raceId

	if self.holyStripesInfoList and self.holyStripesInfoMap[raceId] then
		local holyStripesId = self.holyStripesInfoMap[raceId]
		local cfg = SeasonConfig.instance:getHolyStripeCfg(holyStripesId) or {}

		return (FightingPowerFormula.instance:parseAttrValues(cfg.propertyApp))
	end

	return {}
end

function SeasonTeamMO:getCurrHolySpriteZdlWanPercent(mo)
	local raceId = mo.raceId

	if self.holyStripesInfoList and self.holyStripesInfoMap[raceId] then
		local holyStripesId = self.holyStripesInfoMap[raceId]
		local cfg = SeasonConfig.instance:getHolyStripeCfg(holyStripesId) or {}

		return checknumber(cfg.provideZdlWanPercent)
	end

	return 0
end

function SeasonTeamMO:getHolyStripesInfoList()
	return self.holyStripesInfoList or {}
end

function SeasonTeamMO:getHolyStripesInfoMap()
	return self.holyStripesInfoMap or {}
end

function SeasonTeamMO:isInitHolyStripesInfoMap()
	return self.holyStripesInfoMap ~= nil
end

function SeasonTeamMO:getCurrCutePetAttrs(mo)
	local raceId = mo.raceId
	local mainLevel = checknumber(SeasonMainCampModel.instance:getCampLv())

	if self.cutePetInfoList and self.cutePetInfoMap[raceId] then
		local cutePetInfo = self.cutePetInfoMap[raceId]
		local typeId = checknumber(cutePetInfo.cutePetType)
		local talentId = checknumber(cutePetInfo.cutePetTalentId)
		local cfgs = SeasonMainCampConfig.instance:getCutePetLevelInfo(typeId)
		local maxLevel = 0
		local attrs = {}

		for i, v in pairs(cfgs) do
			if maxLevel < v.campLv and mainLevel >= v.campLv then
				maxLevel = v.campLv
			end
		end

		if maxLevel > 0 then
			local cfg = cfgs[maxLevel]

			attrs = FightingPowerFormula.instance:parseAttrValues(cfg.propertyApp)
		end

		local talentCfgs = SeasonMainCampConfig.instance:getCutePetTalentInfo(typeId)

		if talentCfgs then
			local talentCfgList = talentCfgs[talentId]

			maxLevel = 0

			if talentCfgList then
				for i, v in pairs(talentCfgList) do
					if maxLevel < v.campLv and mainLevel >= v.campLv then
						maxLevel = v.campLv
					end
				end
			end

			if maxLevel > 0 then
				local cfg = talentCfgList[maxLevel]
				local tempAttrs = FightingPowerFormula.instance:parseAttrValues(cfg.propertyApp)

				attrs = AttrMo.addSameAttrs(tempAttrs, attrs)
			end
		end

		return attrs
	end

	return {}
end

function SeasonTeamMO:getCurrCutePetZdlWanPercent(mo)
	local raceId = mo.raceId
	local mainLevel = checknumber(SeasonMainCampModel.instance:getCampLv())

	if self.cutePetInfoList and self.cutePetInfoMap[raceId] then
		local cutePetInfo = self.cutePetInfoMap[raceId]
		local typeId = checknumber(cutePetInfo.cutePetType)
		local cfgs = SeasonMainCampConfig.instance:getCutePetLevelInfo(typeId)
		local maxLevel = 0

		for i, v in pairs(cfgs) do
			if maxLevel < v.campLv and mainLevel >= v.campLv then
				maxLevel = v.campLv
			end
		end

		if maxLevel > 0 then
			local cfg = cfgs[maxLevel]

			return checknumber(cfg.provideZdlWanPercent)
		end

		return 0
	end

	return 0
end

function SeasonTeamMO:getCutePetInfoList()
	return self.cutePetInfoList or {}
end

function SeasonTeamMO:getCutePetInfoMap()
	return self.cutePetInfoMap or {}
end

function SeasonTeamMO:isInitCutePetInfoMap()
	return self.cutePetInfoMap ~= nil
end

function SeasonTeamMO:setPosition(curPosition, isIgnoreDispatch)
	self.serverCurGridId = curPosition

	self:clearRollbackData()

	if not isIgnoreDispatch then
		GlobalDispatcher:dispatch(GlobalNotify.SeasonTeamServerPosUpdated, self.teamId)
	end
end

function SeasonTeamMO:traceTeamClientGridPos(gridId)
	if self.clientCurGridId ~= gridId then
		self.clientLastGridId2 = self.clientLastGridId
		self.clientLastGridId = self.clientCurGridId
		self.clientCurGridId = gridId

		self:clearRollbackData()
	end
end

function SeasonTeamMO:syncTeamServerGridPos(gridId, isIgnoreDispatch)
	self.clientCurGridId = gridId
	self.clientLastGridId = nil
	self.clientLastGridId2 = nil

	self:setPosition(gridId, isIgnoreDispatch)
end

function SeasonTeamMO:backSetPosition()
	self.clientRollbackFromGridId = self.clientCurGridId

	if self.clientLastGridId then
		self.clientCurGridId = self.clientLastGridId
	end

	self.clientLastGridId = self.clientLastGridId2
	self.clientLastGridId2 = nil

	GlobalDispatcher:dispatch(GlobalNotify.SeasonTeamClientPosRollback, self.teamId)
end

function SeasonTeamMO:gmSetPosition(id)
	self.clientRollbackFromGridId = nil
	self.clientCurGridId = id
	self.serverCurGridId = id
	self.clientLastGridId = nil
	self.clientLastGridId2 = nil

	GlobalDispatcher:dispatch(GlobalNotify.SeasonTeamClientPosRollback, self.teamId)
end

function SeasonTeamMO:isRollback()
	return self.clientRollbackFromGridId ~= nil
end

function SeasonTeamMO:clearRollbackData()
	self.clientRollbackFromGridId = nil
end

function SeasonTeamMO:getServerCurGridXY()
	if self.serverCurGridId ~= nil then
		local gridX, gridY = SeasonPathFindingDataModel.instance:id2Grid(self.serverCurGridId)

		return gridX, gridY
	end
end

function SeasonTeamMO:getClientCurGridXY()
	if self.clientCurGridId ~= nil then
		local gridX, gridY = SeasonPathFindingDataModel.instance:id2Grid(self.clientCurGridId)

		return gridX, gridY
	end

	return self:getServerCurGridXY()
end

function SeasonTeamMO:getClientLastGridXY()
	if self.clientLastGridId ~= nil then
		local gridX, gridY = SeasonPathFindingDataModel.instance:id2Grid(self.clientLastGridId)

		return gridX, gridY
	end
end

function SeasonTeamMO:isClientServerPosSame()
	return self.clientCurGridId == self.serverCurGridId
end

function SeasonTeamMO:isCanTransport()
	local isFirstEnter = self.clientLastGridId == nil

	if isFirstEnter then
		return false
	end

	local seasonId = SeasonModel.instance:getSeasonId()
	local id = self.clientCurGridId

	if not isFirstEnter then
		local lastId = self.clientLastGridId
		local lastEvtConfig = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, lastId)

		if lastEvtConfig then
			if lastEvtConfig.eventType ~= SeasonGridEvtTypes.EVT_CONVEY then
				if lastEvtConfig.eventType == SeasonGridEvtTypes.EVT_RAINBOW then
					local linkObjIds = string.splitToNumber(lastEvtConfig.linkObjIds or "", ",")

					for _, elementId in ipairs(linkObjIds) do
						local gridId = SeasonPathFindingDataModel.instance:getGridIdByElementId(elementId)

						if gridId == id then
							return false
						end
					end
				end
			end
		end
	end

	local evtConfig = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, id)

	if evtConfig and (evtConfig.eventType == SeasonGridEvtTypes.EVT_CONVEY or evtConfig.eventType == SeasonGridEvtTypes.EVT_RAINBOW) then
		return true
	end

	return false
end

function SeasonTeamMO:resetFmtData()
	self.petList = nil
	self.petMap = nil
	self.form = nil
end

function SeasonTeamMO:isInitPetData()
	return self.petList ~= nil
end

function SeasonTeamMO:getPetMo(petId)
	if self.petMap then
		return self.petMap[petId]
	end

	return nil
end

function SeasonTeamMO:initFmtData(teamInfoPb)
	self:setTeamId(teamInfoPb.teamId)

	self.adjustTimes = teamInfoPb.adjustTimes
	self.payTimes = teamInfoPb.payTimes
	self.teamLv = teamInfoPb.teamLv

	self:resetPets(teamInfoPb)
	self:resetFormPb(teamInfoPb.form)
end

function SeasonTeamMO:resetPets(teamInfoPb)
	self.petIds = teamInfoPb.petIds
	self.hirePetInfos = teamInfoPb.hirePetInfos
	self.packageSummonInfos = teamInfoPb.packageSummonInfos

	self:resetPetList()
end

function SeasonTeamMO:updateSummonInfo(packageSummonInfos)
	self.packageSummonInfos = packageSummonInfos
	self.petMap = {}

	for i, mo in ipairs(self:getPetMoList()) do
		mo.summonedPetId = 0
		mo.summonMasterId = 0
		mo.contractSkillId = 0
		mo.carriedMasterId = 0
		mo.carriedPetId = 0
		mo.oracleMasterId = 0
		mo.oraclePetId = 0
		mo.oraclePetRaceId = 0
		mo.bookSpiritPetId = 0
		mo.bookSpiritRaceId = 0
		self.petMap[mo.petId] = mo
	end

	for i, summonInfo in ipairs(self.packageSummonInfos or {}) do
		local summonMasterPetId = summonInfo.summonMasterPetId
		local summonedPetId = summonInfo.summonedPetId
		local mastarMo = self.petMap[summonMasterPetId]
		local summMo = self.petMap[summonedPetId]

		if mastarMo then
			mastarMo.summonedPetId = summonedPetId
		end

		if summMo then
			summMo.summonMasterId = summonMasterPetId
			summMo.contractSkillId = SeasonConfig.instance:getCommonValue("CONTRACT_SKILL_ID", true)
		end
	end
end

function SeasonTeamMO:resetFormPb(form)
	self.form = form

	if form and form.pos then
		for i = 1, 9 do
			local petId = checknumber(form.pos[i])
			local mo = self:getPetMo(petId)

			if mo then
				self.leaderSkinId = mo.curFaceId

				break
			end
		end

		self:_checkTeamHead()
	end
end

function SeasonTeamMO:resetPetList()
	self.petList = {}
	self.petMap = {}

	for i, info in ipairs(self.hirePetInfos or {}) do
		local mo = SeasonPetsModel.instance:createHirePetMo(info.petDefineId)

		if mo then
			mo.petId = info.petId

			table.insert(self.petList, mo)

			self.petMap[mo.petId] = mo
		end
	end

	for i, petId in ipairs(self.petIds or {}) do
		local mo = SeasonPetsModel.instance:createPetMoById(petId)

		if mo then
			table.insert(self.petList, mo)

			self.petMap[mo.petId] = mo
		end
	end

	for i, summonInfo in ipairs(self.packageSummonInfos or {}) do
		local summonMasterPetId = summonInfo.summonMasterPetId
		local summonedPetId = summonInfo.summonedPetId
		local mastarMo = self.petMap[summonMasterPetId]
		local summMo = self.petMap[summonedPetId]

		if mastarMo then
			mastarMo.summonedPetId = summonedPetId
		end

		if summMo then
			summMo.summonMasterId = summonMasterPetId
			summMo.contractSkillId = SeasonConfig.instance:getCommonValue("CONTRACT_SKILL_ID", true)
		end
	end

	return self.petList
end

function SeasonTeamMO:getPetMoList()
	return self.petList or EMPTY_TABLE
end

function SeasonTeamMO:getCurrTeamTrainingAttrs()
	local attrs = {}
	local lvl = self.teamLv
	local seasonId = SeasonModel.instance:getSeasonId()
	local campLv = checknumber(SeasonMainCampModel.instance:getCampLv())
	local tgCfg = SeasonMainCampConfig.instance:getTrainingGroundConfig(seasonId)

	if tgCfg and campLv >= checknumber(tgCfg.campLv) then
		local teamPlanId = tgCfg.teamPlanId
		local teamCfg = SeasonMainCampConfig.instance:getTeamConfig(teamPlanId, self.teamId)

		if teamCfg and campLv >= checknumber(teamCfg.campLv) then
			local teamUpgradePlanId = teamCfg.teamUpgradePlanId
			local curCfg = SeasonMainCampConfig.instance:getUpgradeConfig(teamUpgradePlanId, lvl)

			if curCfg then
				attrs = FightingPowerFormula.instance:parseAttrValues(curCfg.propertyApp) or {}
			end
		end
	end

	return attrs
end

function SeasonTeamMO:getIsOtherTeam()
	return self.teamId >= SeasonTeamsModel.TeammateAddTeamId
end

return SeasonTeamMO
