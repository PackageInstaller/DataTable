-- chunkname: @modules/logic/herogroup/common/HeroGroupHandler.lua

module("modules.logic.herogroup.common.HeroGroupHandler", package.seeall)

local HeroGroupHandler = class("HeroGroupHandler")

HeroGroupHandler.EpisodeTypeDict = {
	[DungeonEnum.EpisodeType.TowerPermanent] = 1,
	[DungeonEnum.EpisodeType.TowerBoss] = 1,
	[DungeonEnum.EpisodeType.TowerLimited] = 1,
	[DungeonEnum.EpisodeType.TowerBossTeach] = 1,
	[DungeonEnum.EpisodeType.TowerDeep] = 1,
	[DungeonEnum.EpisodeType.Act183] = 1,
	[DungeonEnum.EpisodeType.Survival] = 1,
	[DungeonEnum.EpisodeType.Shelter] = 1,
	[DungeonEnum.EpisodeType.Rouge2] = 1
}

function HeroGroupHandler.checkIsEpisodeType(episodeType)
	return HeroGroupHandler.EpisodeTypeDict[episodeType] ~= nil
end

function HeroGroupHandler.checkIsEpisodeTypeByEpisodeId(episodeId)
	local episdoeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local episodeType = episdoeConfig.type

	return HeroGroupHandler.checkIsEpisodeType(episodeType)
end

function HeroGroupHandler.checkIsTowerEpisodeByEpisodeId(episodeId)
	local episdoeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episdoeConfig then
		return false
	end

	local episodeType = episdoeConfig.type

	return episodeType == DungeonEnum.EpisodeType.TowerPermanent or episodeType == DungeonEnum.EpisodeType.TowerBoss or episodeType == DungeonEnum.EpisodeType.TowerLimited or episodeType == DungeonEnum.EpisodeType.TowerDeep
end

function HeroGroupHandler.checkIsTowerComposeEpisodeByEpisodeId(episodeId)
	local episdoeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episdoeConfig then
		return false
	end

	local episodeType = episdoeConfig.type

	return episodeType == DungeonEnum.EpisodeType.TowerCompose
end

function HeroGroupHandler.getTowerBossSnapShot(episodeId)
	local heroGroupSnapshotType = ModuleEnum.HeroGroupSnapshotType.TowerBoss
	local snapshotSubId = TowerConfig.instance:getBossTowerIdByEpisodeId(episodeId)

	return heroGroupSnapshotType, {
		snapshotSubId
	}
end

function HeroGroupHandler.getTowerPermanentSnapShot(episodeId)
	local heroGroupSnapshotType = ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit
	local snapshotSubIds = {
		1,
		2,
		3,
		4
	}

	return heroGroupSnapshotType, snapshotSubIds
end

function HeroGroupHandler.getTowerComposeSnapShot(episodeId)
	local recordFightParam = TowerComposeModel.instance:getRecordFightParam()
	local snapshotSubIds = {
		1,
		2,
		3,
		4
	}

	if not recordFightParam then
		return ModuleEnum.HeroGroupSnapshotType.TowerComposeNormal, snapshotSubIds
	end

	local towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(recordFightParam.themeId, recordFightParam.layerId)

	if towerEpisodeConfig.plane > 0 then
		if not ModuleEnum.HeroGroupSnapshotType.TowerComposeBoss then
			local heroGroupSnapshotType = ModuleEnum.HeroGroupSnapshotType.TowerComposeNormal

			snapshotSubIds = {
				1,
				2,
				3,
				4,
				5,
				6,
				7,
				8
			}

			return heroGroupSnapshotType, snapshotSubIds
		end
	end
end

function HeroGroupHandler.getFiveHeroSnapShot(episodeId)
	local heroGroupSnapshotType = ModuleEnum.HeroGroupSnapshotType.FiveHero
	local snapshotSubIds = {
		1,
		2,
		3,
		4,
		5
	}

	return heroGroupSnapshotType, snapshotSubIds
end

function HeroGroupHandler.getAct183SnapShot(episodeId)
	local snapshotType = Act183Helper.getEpisodeSnapShotType(episodeId)

	return snapshotType, {
		1
	}
end

function HeroGroupHandler.getShelterSnapShot()
	return ModuleEnum.HeroGroupSnapshotType.Shelter, {
		1,
		2,
		3
	}
end

function HeroGroupHandler.getSurvivalSnapShot()
	return ModuleEnum.HeroGroupSnapshotType.Survival, {
		1
	}
end

function HeroGroupHandler.getAbyssSnapShot()
	return ModuleEnum.HeroGroupSnapshotType.Abyss, {
		1,
		2,
		3
	}
end

function HeroGroupHandler.getRouge2Snapshot()
	return ModuleEnum.HeroGroupSnapshotType.Rouge2, {
		1
	}
end

function HeroGroupHandler.getAtomicDungeonSnapshot()
	return ModuleEnum.HeroGroupSnapshotType.AtomicDungeon, {
		1,
		2,
		3,
		4
	}
end

function HeroGroupHandler.getBossRushActModeShot()
	return ModuleEnum.HeroGroupSnapshotType.BossRushActMode, {
		1,
		2,
		3
	}
end

HeroGroupHandler.getSnapShotHandleFunc = {
	[DungeonEnum.EpisodeType.TowerPermanent] = HeroGroupHandler.getTowerPermanentSnapShot,
	[DungeonEnum.EpisodeType.TowerBoss] = HeroGroupHandler.getTowerBossSnapShot,
	[DungeonEnum.EpisodeType.TowerLimited] = HeroGroupHandler.getTowerPermanentSnapShot,
	[DungeonEnum.EpisodeType.TowerDeep] = HeroGroupHandler.getTowerPermanentSnapShot,
	[DungeonEnum.EpisodeType.TowerCompose] = HeroGroupHandler.getTowerComposeSnapShot,
	[DungeonEnum.EpisodeType.Act183] = HeroGroupHandler.getAct183SnapShot,
	[DungeonEnum.EpisodeType.Shelter] = HeroGroupHandler.getShelterSnapShot,
	[DungeonEnum.EpisodeType.Survival] = HeroGroupHandler.getSurvivalSnapShot,
	[DungeonEnum.EpisodeType.Abyss] = HeroGroupHandler.getAbyssSnapShot,
	[DungeonEnum.EpisodeType.Rouge2] = HeroGroupHandler.getRouge2Snapshot,
	[DungeonEnum.EpisodeType.AtomicDungeon] = HeroGroupHandler.getAtomicDungeonSnapshot,
	[DungeonEnum.EpisodeType.BossRushActMode] = HeroGroupHandler.getBossRushActModeShot
}

function HeroGroupHandler.getSnapShot(episodeId)
	local episdoeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local episodeType = episdoeConfig.type
	local func = HeroGroupHandler.getSnapShotHandleFunc[episodeType]

	if func then
		return func(episodeId)
	end

	if DungeonController.checkEpisodeFiveHero(episodeId) then
		return HeroGroupHandler.getFiveHeroSnapShot(episodeId)
	end
end

function HeroGroupHandler.getTowerTrialHeros(episodeId)
	return ""
end

function HeroGroupHandler.getTowerPermanentTrialHeros(episodeId)
	return ""
end

function HeroGroupHandler.getTowerBossTrialHeros(episodeId)
	local bossHeroTrialStr = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossHeroTrialList)

	return bossHeroTrialStr or ""
end

function HeroGroupHandler.getTowerDeepTrialHeros(episodeId)
	return ""
end

function HeroGroupHandler.getTowerComposeTrialHeros(episodeId)
	HeroGroupTrialModel.instance:clear()

	local trialHeroList = {}
	local fightParam = TowerComposeModel.instance:getRecordFightParam()
	local towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(fightParam.themeId, fightParam.layerId)

	if towerEpisodeConfig.plane == 2 then
		local themeMo = TowerComposeModel.instance:getThemeMo(fightParam.themeId)
		local heroTeamConfig = lua_hero_team.configDict[ModuleEnum.HeroGroupSnapshotType.TowerComposeBoss]
		local roleNumMax = heroTeamConfig.batNum

		for index = 1, roleNumMax do
			local planeId = Mathf.Ceil(index / 4)
			local curBossMo = themeMo:getCurBossMo()
			local planeMap = curBossMo:getPlaneInfoMap()
			local planeMo = planeMap[planeId]
			local teamInfoData = planeMo:getTeamInfoData()
			local heroIndex = (index - 1) % 4 + 1
			local heroData = teamInfoData.heros[heroIndex]
			local isPlaneLock = TowerComposeModel.instance:checkPlaneLock(fightParam.themeId, planeId)

			if heroData and heroData.trialId > 0 and isPlaneLock and planeMo.hasFight then
				table.insert(trialHeroList, heroData.trialId)
			end
		end

		return table.concat(trialHeroList, "|")
	end

	return ""
end

function HeroGroupHandler.getRouge2TrialHeros(episodeId)
	local trialInfoList = Rouge2_BackpackController.instance:getActiveSkillTrialHeroList()

	if not trialInfoList or #trialInfoList <= 0 then
		return ""
	end

	local trialStrList = {}

	for _, trialInfo in ipairs(trialInfoList) do
		local trialStr = table.concat(trialInfo, "#")

		table.insert(trialStrList, trialStr)
	end

	return table.concat(trialStrList, "|")
end

function HeroGroupHandler.getRouge2BossTrialHeros(episodeId)
	return Rouge2_BossBattleController.instance:getCurSaveTrialHeroIdStr() or ""
end

HeroGroupHandler.getTrialHerosHandleFunc = {
	[DungeonEnum.EpisodeType.TowerPermanent] = HeroGroupHandler.getTowerPermanentTrialHeros,
	[DungeonEnum.EpisodeType.TowerBoss] = HeroGroupHandler.getTowerBossTrialHeros,
	[DungeonEnum.EpisodeType.TowerLimited] = HeroGroupHandler.getTowerTrialHeros,
	[DungeonEnum.EpisodeType.TowerDeep] = HeroGroupHandler.getTowerDeepTrialHeros,
	[DungeonEnum.EpisodeType.TowerCompose] = HeroGroupHandler.getTowerComposeTrialHeros,
	[DungeonEnum.EpisodeType.Rouge2] = HeroGroupHandler.getRouge2TrialHeros,
	[DungeonEnum.EpisodeType.Rouge2Boss] = HeroGroupHandler.getRouge2BossTrialHeros
}

function HeroGroupHandler.getTrialHeros(episodeId)
	local episdoeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episdoeConfig then
		return ""
	end

	local episodeType = episdoeConfig.type
	local func = HeroGroupHandler.getTrialHerosHandleFunc[episodeType]

	if func then
		return func(episodeId)
	else
		local battleId = HeroGroupModel.instance.battleId
		local battleCO = battleId and lua_battle.configDict[battleId]

		return battleCO.trialHeros
	end
end

function HeroGroupHandler.setTowerHeroListData(episodeId, groupMO)
	groupMO = groupMO or HeroGroupSnapshotModel.instance:getCurGroup()

	if groupMO then
		for index, heroId in ipairs(groupMO.heroList) do
			if tonumber(heroId) < 0 then
				local trialHeroId = -tonumber(heroId)
				local heroMO = HeroGroupTrialModel.instance:getById(heroId)

				if heroMO then
					trialHeroId = heroMO.trialCo.id
				end

				local haveTrialHero = true
				local trialHeroIds = HeroGroupHandler.getTrialHeros(episodeId)
				local trialHeroList = haveTrialHero and string.splitToNumber(trialHeroIds, "|") or {}
				local isHeroOnline = haveTrialHero and tabletool.indexOf(trialHeroList, trialHeroId) and tonumber(trialHeroId) > 0

				if isHeroOnline then
					if not lua_hero_trial.configDict[trialHeroId][0] then
						local trialCo = {}

						groupMO.heroList[index] = isHeroOnline and tostring(tonumber(trialCo.id .. "." .. trialCo.trialTemplate) - 1099511627776) or "0"

						if isHeroOnline then
							groupMO.trialDict = groupMO.trialDict or {}
							groupMO.trialDict[index] = groupMO.trialDict[index] or {}
							groupMO.trialDict[index][1] = trialCo.id
						end
					end
				end
			end
		end
	end
end

function HeroGroupHandler.setRouge2HeroListData(episodeId)
	local groupMO = HeroGroupSnapshotModel.instance:getCurGroup()

	if not groupMO or not groupMO.heroList then
		return
	end

	for index, heroId in ipairs(groupMO.heroList) do
		if tonumber(heroId) < 0 then
			local trialHeroId = -tonumber(heroId)
			local heroMO = HeroGroupTrialModel.instance:getById(heroId)

			if heroMO then
				trialHeroId = heroMO.trialCo.id
			end

			local isHeroOnline = Rouge2_BackpackController.instance:isHasTrialHero(trialHeroId)

			if isHeroOnline then
				if not lua_hero_trial.configDict[trialHeroId][0] then
					local trialCo = {}

					groupMO.heroList[index] = isHeroOnline and HeroGroupHandler.getTrialHeroUID(trialCo.id, trialCo.trialTemplate) or "0"

					if isHeroOnline then
						groupMO.trialDict = groupMO.trialDict or {}
						groupMO.trialDict[index] = groupMO.trialDict[index] or {}
						groupMO.trialDict[index][1] = trialCo.id
					elseif groupMO.trialDict and groupMO.trialDict[index] then
						groupMO.trialDict[index] = nil
					end
				end
			end
		end
	end
end

HeroGroupHandler.getHeroListDataHandlerFunc = {
	[DungeonEnum.EpisodeType.TowerPermanent] = HeroGroupHandler.setTowerHeroListData,
	[DungeonEnum.EpisodeType.TowerBoss] = HeroGroupHandler.setTowerHeroListData,
	[DungeonEnum.EpisodeType.TowerLimited] = HeroGroupHandler.setTowerHeroListData,
	[DungeonEnum.EpisodeType.TowerDeep] = HeroGroupHandler.setTowerHeroListData,
	[DungeonEnum.EpisodeType.TowerCompose] = HeroGroupHandler.setTowerHeroListData,
	[DungeonEnum.EpisodeType.Rouge2] = HeroGroupHandler.setRouge2HeroListData,
	[DungeonEnum.EpisodeType.AtomicDungeon] = HeroGroupHandler.setTowerHeroListData
}

function HeroGroupHandler.hanldeHeroListData(episodeId)
	if not episodeId then
		return
	end

	local episdoeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local episodeType = episdoeConfig.type
	local func = HeroGroupHandler.getHeroListDataHandlerFunc[episodeType]

	if func then
		return func(episodeId)
	end
end

function HeroGroupHandler.getTowerComposeHeroTeamRoleNum(episodeId)
	local isTowerComposeEpisode = TowerComposeHeroGroupModel.instance:isTowerComposeEpisode(episodeId)

	if not isTowerComposeEpisode then
		return
	end

	local recordFightParam = TowerComposeModel.instance:getRecordFightParam()
	local towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(recordFightParam.themeId, recordFightParam.layerId)

	if towerEpisodeConfig.plane > 0 then
		if not ModuleEnum.HeroGroupSnapshotType.TowerComposeBoss then
			local heroGroupId = ModuleEnum.HeroGroupSnapshotType.TowerComposeNormal
			local heroTeamConfig = lua_hero_team.configDict[heroGroupId]

			return heroTeamConfig.batNum
		end
	end
end

HeroGroupHandler.getHeroRoleNumHandleFunc = {
	[DungeonEnum.EpisodeType.TowerCompose] = HeroGroupHandler.getTowerComposeHeroTeamRoleNum
}

function HeroGroupHandler.getHeroRoleOpenNum(episodeId)
	if not episodeId then
		return
	end

	local episdoeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local episodeType = episdoeConfig.type
	local func = HeroGroupHandler.getHeroRoleNumHandleFunc[episodeType]

	if func then
		return func(episodeId)
	end
end

function HeroGroupHandler.getTrialHeroUID(trialId, trialTemplate)
	trialId = trialId or 0
	trialTemplate = trialTemplate or 0

	return tostring(tonumber(string.format("%d.%d", trialId, trialTemplate)) - 1099511627776)
end

function HeroGroupHandler.getTowerPermanentAssistMo(episodeId, isEditor)
	local assistMO = TowerPermanentModel.instance:getAssistMo()
	local param = TowerModel.instance:getRecordFightParam()
	local canShow = not param.isHeroGroupLock

	return canShow, (isEditor or nil) and TowerPermanentModel.instance:getEditorAssistMo()
end

function HeroGroupHandler.getTowerDeepAssistMo(episodeId, isEditor)
	local assistMo = TowerPermanentDeepModel.instance:getAssistMo()

	return true, (isEditor or nil) and TowerPermanentDeepModel.instance:getEditorAssistMo()
end

function HeroGroupHandler.getTowerComposeAssistMo(episodeId, isEditor, params)
	local fightParam = TowerComposeModel.instance:getRecordFightParam()

	if not params and fightParam.plane == TowerComposeEnum.PlaneType.Twice then
		local assistMoMap = {}

		for planeId = 1, 2 do
			assistMoMap[planeId] = isEditor and TowerComposeModel.instance:getEditorAssistMo({
				planeId = planeId
			}) or TowerComposeModel.instance:getAssistMo({
				planeId = planeId
			})
		end

		local canShow = not not isEditor

		return canShow, (not assistMoMap[1] or nil) and assistMoMap[2], assistMoMap
	end

	local assistMo = TowerComposeModel.instance:getAssistMo(params)
	local canShow = fightParam.plane < TowerComposeEnum.PlaneType.Twice or isEditor

	return canShow, (isEditor or nil) and TowerComposeModel.instance:getEditorAssistMo(params)
end

function HeroGroupHandler.getAbyssAssistMo(episodeId, isEditor)
	local assistMo
	local actId = AbyssConfig.instance:getActivityId()
	local actInfo = AbyssModel.instance:getCurInfoMo()
	local haveChallengedAssist = false

	for _, stageInfo in ipairs(actInfo.stageInfoList) do
		if stageInfo:haveAssist() and stageInfo:isChallenged() then
			haveChallengedAssist = true

			break
		end
	end

	local stageId = AbyssConfig.instance:getStageIdByEpisodeId(actId, episodeId)
	local stageMo = AbyssModel.instance:getStageInfoMo(actId, stageId)

	if isEditor then
		assistMo = AbyssModel.instance:getEditorAssistMO()
	elseif stageMo and stageMo:haveAssist() then
		assistMo = AbyssModel.instance:getAssistMO()
	end

	local canShow = stageMo and not haveChallengedAssist and AbyssModel.instance:getIsAbyssAllow()

	return canShow, assistMo
end

HeroGroupHandler.getHeroAssistMoHandlerFunc = {
	[DungeonEnum.EpisodeType.TowerPermanent] = HeroGroupHandler.getTowerPermanentAssistMo,
	[DungeonEnum.EpisodeType.TowerDeep] = HeroGroupHandler.getTowerDeepAssistMo,
	[DungeonEnum.EpisodeType.TowerCompose] = HeroGroupHandler.getTowerComposeAssistMo,
	[DungeonEnum.EpisodeType.Abyss] = HeroGroupHandler.getAbyssAssistMo
}

function HeroGroupHandler.getAssistMo(episodeId, isEditor, params)
	if not episodeId then
		return
	end

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeConfig then
		return
	end

	local episodeType = episodeConfig.type
	local func = HeroGroupHandler.getHeroAssistMoHandlerFunc[episodeType]

	if func then
		return func(episodeId, isEditor, params)
	end
end

function HeroGroupHandler.setTowerPermanentAssistMo(episodeId, assistMo, index, isEditor)
	if isEditor then
		TowerPermanentModel.instance:setEditorAssistMo(assistMo)
	else
		TowerPermanentModel.instance:setAssistMo(assistMo, index)
	end
end

function HeroGroupHandler.setTowerDeepAssistMo(episodeId, assistMo, index, isEditor)
	if isEditor then
		TowerPermanentDeepModel.instance:setEditorAssistMo(assistMo)
	else
		TowerPermanentDeepModel.instance:setAssistMo(assistMo, index)
	end
end

function HeroGroupHandler.setTowerComposeAssistMo(episodeId, assistMo, index, isEditor, params)
	local fightParam = TowerComposeModel.instance:getRecordFightParam()

	if (not params or not params.planeId) and fightParam.plane == TowerComposeEnum.PlaneType.Twice then
		logError("双位面关卡设置助战必须传 params.planeId")

		return
	end

	if isEditor then
		TowerComposeModel.instance:setEditorAssistMo(assistMo, params)
	else
		TowerComposeModel.instance:setAssistMo(assistMo, index, params)
	end
end

function HeroGroupHandler.setAbyssAssistMo(episodeId, assistMo, index, isEditor)
	if isEditor then
		AbyssModel.instance:setEditorAssistMo(assistMo)
	else
		AbyssModel.instance:setAssistMO(assistMo, index)
	end
end

HeroGroupHandler.setHeroAssistMoHandlerFunc = {
	[DungeonEnum.EpisodeType.TowerPermanent] = HeroGroupHandler.setTowerPermanentAssistMo,
	[DungeonEnum.EpisodeType.TowerDeep] = HeroGroupHandler.setTowerDeepAssistMo,
	[DungeonEnum.EpisodeType.TowerCompose] = HeroGroupHandler.setTowerComposeAssistMo,
	[DungeonEnum.EpisodeType.Abyss] = HeroGroupHandler.setAbyssAssistMo
}

function HeroGroupHandler.setAssistMo(episodeId, assistMo, index, isEditor, params)
	if not episodeId then
		return
	end

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeConfig then
		return
	end

	local episodeType = episodeConfig.type
	local func = HeroGroupHandler.setHeroAssistMoHandlerFunc[episodeType]

	if func then
		return func(episodeId, assistMo, index, isEditor, params)
	end
end

function HeroGroupHandler.clearTowerPermanentAssistMo(episodeId, isClearEditor)
	TowerPermanentModel.instance:clearAssist(isClearEditor)
end

function HeroGroupHandler.clearTowerDeepAssistMo(episodeId, isClearEditor)
	TowerPermanentDeepModel.instance:clearAssist(isClearEditor)
end

function HeroGroupHandler.clearTowerComposeAssistMo(episodeId, isClearEditor, params)
	TowerComposeModel.instance:clearAssist(isClearEditor, params)
end

function HeroGroupHandler.clearAbyssAssistMo(episodeId, isClearEditor)
	AbyssModel.instance:cleanAssistMO()
end

HeroGroupHandler.clearHeroAssistMoHandlerFunc = {
	[DungeonEnum.EpisodeType.TowerPermanent] = HeroGroupHandler.clearTowerPermanentAssistMo,
	[DungeonEnum.EpisodeType.TowerDeep] = HeroGroupHandler.clearTowerDeepAssistMo,
	[DungeonEnum.EpisodeType.TowerCompose] = HeroGroupHandler.clearTowerComposeAssistMo,
	[DungeonEnum.EpisodeType.Abyss] = HeroGroupHandler.clearAbyssAssistMo
}

function HeroGroupHandler.clearAssist(episodeId, isClearEditor, params)
	if not episodeId then
		return
	end

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeConfig then
		return
	end

	local episodeType = episodeConfig.type
	local func = HeroGroupHandler.clearHeroAssistMoHandlerFunc[episodeType]

	if func then
		return func(episodeId, isClearEditor, params)
	end
end

function HeroGroupHandler.checkTowerPermanentAssistIsBan(episodeId, heroId)
	local isHeroLocked = TowerModel.instance:isHeroLocked(heroId)
	local isHeroBan = TowerModel.instance:isHeroBan(heroId)

	return isHeroLocked or isHeroBan, ToastEnum.TowerHeroAssistBan
end

function HeroGroupHandler.checkTowerDeepAssistIsBan(episodeId, heroId)
	local isHeroBan = TowerPermanentDeepModel.instance:isHeroBan(heroId)

	return isHeroBan, ToastEnum.TowerHeroAssistBan
end

function HeroGroupHandler.checkTowerComposeAssistIsBan(episodeId, heroId, params)
	local isInSupport = TowerComposeHeroGroupModel.instance:checkEquipedSupportHero(heroId)

	if isInSupport then
		return true, ToastEnum.TrialIsJoin
	end

	local isLock = TowerComposeHeroGroupModel.instance:checkHeroIdIsInLockPlane(heroId)

	if isLock then
		return true, ToastEnum.TowerHeroAssistBan
	end

	local assistHeroList = HeroGroupModel.instance:getAssistMoList(true)

	for _, assistHero in ipairs(assistHeroList) do
		if assistHero.heroId == heroId then
			return true, ToastEnum.TrialIsJoin
		end
	end

	return false, ToastEnum.TowerHeroAssistBan
end

function HeroGroupHandler.checkAbyssAssistIsBan(episodeId, heroId)
	local isHeroBan = AbyssModel.instance:isCurHeroLocked(heroId)

	return isHeroBan, ToastEnum.TowerHeroAssistBan
end

HeroGroupHandler.checkAssistIsBanFunc = {
	[DungeonEnum.EpisodeType.TowerPermanent] = HeroGroupHandler.checkTowerPermanentAssistIsBan,
	[DungeonEnum.EpisodeType.TowerDeep] = HeroGroupHandler.checkTowerDeepAssistIsBan,
	[DungeonEnum.EpisodeType.TowerCompose] = HeroGroupHandler.checkTowerComposeAssistIsBan,
	[DungeonEnum.EpisodeType.Abyss] = HeroGroupHandler.checkAbyssAssistIsBan
}

function HeroGroupHandler.checkAssistIsBan(episodeId, heroId, params)
	if not episodeId then
		return false
	end

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeConfig then
		return false
	end

	local episodeType = episodeConfig.type
	local func = HeroGroupHandler.checkAssistIsBanFunc[episodeType]

	if func then
		return func(episodeId, heroId, params)
	end

	return false
end

function HeroGroupHandler.getTowerComposeAssistParams(episodeId, paramData)
	local fightParam = TowerComposeModel.instance:getRecordFightParam()

	if fightParam.plane == TowerComposeEnum.PlaneType.Twice then
		local singleGroupMOId = paramData.singleGroupMOId
		local planeId = Mathf.Ceil(singleGroupMOId / 4)

		return {
			planeId = planeId
		}
	end
end

HeroGroupHandler.getAssistParamsFunc = {
	[DungeonEnum.EpisodeType.TowerCompose] = HeroGroupHandler.getTowerComposeAssistParams
}

function HeroGroupHandler.getAssistParams(episodeId, paramData)
	if not episodeId then
		return
	end

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeConfig then
		return
	end

	local episodeType = episodeConfig.type
	local func = HeroGroupHandler.getAssistParamsFunc[episodeType]

	if func then
		return func(episodeId, paramData)
	end
end

function HeroGroupHandler.setTowerComposeAssistFightParam(episodeId, paramData)
	local recordFightParam = TowerComposeModel.instance:getRecordFightParam()

	if recordFightParam.plane == TowerComposeEnum.PlaneType.Twice then
		local curPlaneId = TowerComposeModel.instance:getCurFightPlaneId()
		local _, assistMo = HeroGroupHandler.getTowerComposeAssistMo(episodeId, false, {
			planeId = curPlaneId
		})

		if assistMo then
			for i, info in ipairs(paramData.equips) do
				local heroUid = info.heroUid
				local heroMo = HeroModel.instance:getById(heroUid)

				if heroMo and assistMo.assistMo.heroId == heroMo.heroId then
					info.heroUid = assistMo.heroUid

					break
				end
			end

			paramData.main[assistMo.id] = assistMo.assistMo.heroUid

			paramData.fightParam:setAssistHeroInfo(assistMo.assistMo.heroUid, assistMo.assistMo.userId)

			paramData.mainCount = paramData.mainCount + 1
		end

		return true, paramData
	end
end

HeroGroupHandler.setFightParamAssistFunc = {
	[DungeonEnum.EpisodeType.TowerCompose] = HeroGroupHandler.setTowerComposeAssistFightParam
}

function HeroGroupHandler.setFightParamAssist(episodeId, paramData)
	if not episodeId then
		return
	end

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeConfig then
		return
	end

	local episodeType = episodeConfig.type
	local func = HeroGroupHandler.setFightParamAssistFunc[episodeType]

	if func then
		return func(episodeId, paramData)
	end
end

HeroGroupHandler.replaceSingleGroupAssistFunc = {}

function HeroGroupHandler.replaceSingleGroup(episodeId, paramData)
	if not episodeId then
		return
	end

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeConfig then
		return
	end

	local episodeType = episodeConfig.type
	local func = HeroGroupHandler.setFightParamAssistFunc[episodeType]

	if func then
		func(episodeId, paramData)
	else
		HeroGroupModel.instance:replaceSingleGroup()
	end

	HeroGroupModel.instance:saveCurGroupData()
end

return HeroGroupHandler
