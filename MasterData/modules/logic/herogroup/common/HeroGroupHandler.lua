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
	local curSeasonId = TowerModel.instance:getTrialHeroSeason()
	local trialConfig = TowerConfig.instance:getHeroTrialConfig(curSeasonId)

	return trialConfig and trialConfig.heroIds
end

function HeroGroupHandler.getTowerPermanentTrialHeros(episodeId)
	local fightParam = TowerModel.instance:getRecordFightParam()
	local permanentCo = TowerConfig.instance:getPermanentEpisodeCo(fightParam.layerId)

	if permanentCo then
		local trialHeroList = TowerConfig.instance:getStageTrialHeroList(permanentCo.stageId)

		return table.concat(trialHeroList, "|")
	end

	return ""
end

function HeroGroupHandler.getTowerBossTrialHeros(episodeId)
	local bossHeroTrialStr = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossHeroTrialList)

	return bossHeroTrialStr or ""
end

function HeroGroupHandler.getTowerDeepTrialHeros(episodeId)
	local trialHeroList = TowerDeepConfig.instance:getHeroTrialList(episodeId)

	return #trialHeroList > 0 and table.concat(trialHeroList, "|") or ""
end

function HeroGroupHandler.getTowerComposeTrialHeros(episodeId)
	local recordFightParam = TowerComposeModel.instance:getRecordFightParam()
	local towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(recordFightParam.themeId, recordFightParam.layerId)

	if towerEpisodeConfig then
		local trialHeroList = TowerComposeConfig.instance:getThemeTrialHeroList(recordFightParam.themeId)

		return #trialHeroList > 0 and table.concat(trialHeroList, "|") or ""
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

return HeroGroupHandler
