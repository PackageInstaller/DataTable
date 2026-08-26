-- chunkname: @modules/logic/seasonver/common/SeasonHeroGroupHandler.lua

module("modules.logic.seasonver.common.SeasonHeroGroupHandler", package.seeall)

local SeasonHeroGroupHandler = class("SeasonHeroGroupHandler")

SeasonHeroGroupHandler.SeasonEpisodeTypeList = {
	DungeonEnum.EpisodeType.Season,
	DungeonEnum.EpisodeType.SeasonRetail,
	DungeonEnum.EpisodeType.SeasonSpecial,
	DungeonEnum.EpisodeType.SeasonTrial,
	DungeonEnum.EpisodeType.Season123,
	DungeonEnum.EpisodeType.Season123Retail,
	DungeonEnum.EpisodeType.Season166Base,
	DungeonEnum.EpisodeType.Season166Train,
	DungeonEnum.EpisodeType.Season166Teach
}
SeasonHeroGroupHandler.SeasonTypeList = {
	ModuleEnum.HeroGroupType.Season,
	ModuleEnum.HeroGroupType.Season123,
	ModuleEnum.HeroGroupType.Season123Retail,
	ModuleEnum.HeroGroupType.Season166Base,
	ModuleEnum.HeroGroupType.Season166Train,
	ModuleEnum.HeroGroupType.Season166Teach
}

function SeasonHeroGroupHandler.checkIsSeasonEpisodeType(episodeType)
	return (tabletool.indexOf(SeasonHeroGroupHandler.SeasonEpisodeTypeList, episodeType))
end

function SeasonHeroGroupHandler.checkIsSeasonTypeByEpisodeId(episodeId)
	local episdoeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local episodeType = episdoeConfig.type

	return SeasonHeroGroupHandler.checkIsSeasonEpisodeType(episodeType)
end

function SeasonHeroGroupHandler.checkIsSeasonHeroGroupType(heroGroupType)
	return (tabletool.indexOf(SeasonHeroGroupHandler.SeasonTypeList, heroGroupType))
end

function SeasonHeroGroupHandler.setSeasonSnapShot(paramTab)
	local heroGroupSnapshotType = ModuleEnum.HeroGroupSnapshotType.Season
	local snapshotSubId = 0
	local heroGroupMO, seasonEquips

	if paramTab.extendData then
		snapshotSubId = paramTab.extendData.groupIndex
		heroGroupMO = paramTab.extendData.heroGroup
	end

	return heroGroupSnapshotType, snapshotSubId, heroGroupMO, seasonEquips
end

function SeasonHeroGroupHandler.setSeason123SnapShot(paramTab)
	local heroGroupSnapshotType = ModuleEnum.HeroGroupSnapshotType.Season123
	local snapshotSubId = 0
	local heroGroupMO, seasonEquips

	if paramTab.extendData then
		snapshotSubId = paramTab.extendData.groupIndex
		heroGroupMO = paramTab.extendData.heroGroup
	end

	return heroGroupSnapshotType, snapshotSubId, heroGroupMO, (heroGroupMO or nil) and Season123HeroGroupUtils.getAllHeroActivity123Equips(heroGroupMO)
end

function SeasonHeroGroupHandler.setSeason123RetailSnapShot(paramTab)
	local heroGroupSnapshotType = ModuleEnum.HeroGroupSnapshotType.Season123Retail
	local snapshotSubId = 1
	local heroGroupMO, seasonEquips

	return heroGroupSnapshotType, snapshotSubId, (paramTab.extendData or nil) and paramTab.extendData.heroGroup, seasonEquips
end

function SeasonHeroGroupHandler.setSeason166BaseSpotSnapShot(paramTab)
	local heroGroupSnapshotType = ModuleEnum.HeroGroupSnapshotType.Season166Base
	local snapshotSubId = 0
	local heroGroupMO, seasonEquips

	if paramTab.extendData then
		heroGroupMO = paramTab.extendData.heroGroup
		snapshotSubId = paramTab.extendData.snapshotSubId or 1
	end

	return heroGroupSnapshotType, snapshotSubId, heroGroupMO, seasonEquips
end

function SeasonHeroGroupHandler.setSeason166TrainSpotSnapShot(paramTab)
	local heroGroupSnapshotType = ModuleEnum.HeroGroupSnapshotType.Season166Train
	local snapshotSubId = 1
	local heroGroupMO, seasonEquips

	return heroGroupSnapshotType, snapshotSubId, (paramTab.extendData or nil) and paramTab.extendData.heroGroup, seasonEquips
end

SeasonHeroGroupHandler.setSeasonSnapShotHandleFunc = {
	[ModuleEnum.HeroGroupType.Season] = SeasonHeroGroupHandler.setSeasonSnapShot,
	[ModuleEnum.HeroGroupType.Season123] = SeasonHeroGroupHandler.setSeason123SnapShot,
	[ModuleEnum.HeroGroupType.Season123Retail] = SeasonHeroGroupHandler.setSeason123RetailSnapShot,
	[ModuleEnum.HeroGroupType.Season166Base] = SeasonHeroGroupHandler.setSeason166BaseSpotSnapShot,
	[ModuleEnum.HeroGroupType.Season166Train] = SeasonHeroGroupHandler.setSeason166TrainSpotSnapShot
}

function SeasonHeroGroupHandler.buildSeason(paramTab)
	Activity104Model.instance:buildHeroGroup(paramTab.isReConnect)

	return ModuleEnum.HeroGroupType.Season
end

function SeasonHeroGroupHandler.buildSeason123(paramTab)
	Season123HeroGroupModel.instance:buildAidHeroGroup()

	return ModuleEnum.HeroGroupType.Season123
end

function SeasonHeroGroupHandler.buildSeason123Retail(paramTab)
	Season123HeroGroupModel.instance:buildAidHeroGroup()

	return ModuleEnum.HeroGroupType.Season123Retail
end

function SeasonHeroGroupHandler.buildSeason166BaseSpot(paramTab)
	Season166HeroGroupModel.instance:buildAidHeroGroup()

	return ModuleEnum.HeroGroupType.Season166Base
end

function SeasonHeroGroupHandler.buildSeason166Train(paramTab)
	Season166HeroGroupModel.instance:buildAidHeroGroup()

	return ModuleEnum.HeroGroupType.Season166Train
end

function SeasonHeroGroupHandler.buildSeason166Teach(paramTab)
	Season166HeroGroupModel.instance:buildAidHeroGroup()

	return ModuleEnum.HeroGroupType.Season166Teach
end

SeasonHeroGroupHandler.buildSeasonHandleFunc = {
	[DungeonEnum.EpisodeType.Season] = SeasonHeroGroupHandler.buildSeason,
	[DungeonEnum.EpisodeType.SeasonRetail] = SeasonHeroGroupHandler.buildSeason,
	[DungeonEnum.EpisodeType.SeasonSpecial] = SeasonHeroGroupHandler.buildSeason,
	[DungeonEnum.EpisodeType.SeasonTrial] = SeasonHeroGroupHandler.buildSeason,
	[DungeonEnum.EpisodeType.Season123] = SeasonHeroGroupHandler.buildSeason123,
	[DungeonEnum.EpisodeType.Season123Retail] = SeasonHeroGroupHandler.buildSeason123Retail,
	[DungeonEnum.EpisodeType.Season166Base] = SeasonHeroGroupHandler.buildSeason166BaseSpot,
	[DungeonEnum.EpisodeType.Season166Train] = SeasonHeroGroupHandler.buildSeason166Train,
	[DungeonEnum.EpisodeType.Season166Teach] = SeasonHeroGroupHandler.buildSeason166Teach
}

function SeasonHeroGroupHandler.getSeasonHeroGroupMO()
	return Activity104Model.instance:getSnapshotHeroGroupBySubId()
end

function SeasonHeroGroupHandler.getSeason123HeroGroupMO()
	return Season123HeroGroupModel.instance:getCurrentHeroGroup()
end

function SeasonHeroGroupHandler.getSeason166HeroGroupMO()
	local hasTrail = Season166HeroGroupModel.instance:isHaveTrialCo()

	if hasTrail then
		return Season166HeroGroupModel.instance:getTrailHeroGroupList()
	else
		return Season166HeroGroupModel.instance:getCurrentHeroGroup()
	end
end

SeasonHeroGroupHandler.getSeasonCurrentHeroGroupMO = {
	[ModuleEnum.HeroGroupType.Season] = SeasonHeroGroupHandler.getSeasonHeroGroupMO,
	[ModuleEnum.HeroGroupType.Season123] = SeasonHeroGroupHandler.getSeason123HeroGroupMO,
	[ModuleEnum.HeroGroupType.Season123Retail] = SeasonHeroGroupHandler.getSeason123HeroGroupMO,
	[ModuleEnum.HeroGroupType.Season166Base] = SeasonHeroGroupHandler.getSeason166HeroGroupMO,
	[ModuleEnum.HeroGroupType.Season166Train] = SeasonHeroGroupHandler.getSeason166HeroGroupMO,
	[ModuleEnum.HeroGroupType.Season166Teach] = SeasonHeroGroupHandler.getSeason166HeroGroupMO
}
SeasonHeroGroupHandler.NeedGetHeroCardSeason = {
	[ModuleEnum.HeroGroupType.Season] = true,
	[ModuleEnum.HeroGroupType.Season123] = true
}
SeasonHeroGroupHandler.NormalSeason = {
	[ModuleEnum.HeroGroupType.Season123Retail] = true
}
SeasonHeroGroupHandler.NormalSeason166 = {
	[ModuleEnum.HeroGroupType.Season166Base] = true,
	[ModuleEnum.HeroGroupType.Season166Train] = true
}

function SeasonHeroGroupHandler.setHeroGroupSnapshot(heroGroupMO, heroGroupType, episodeId, callback, callbackObj)
	local extendData = {}

	if SeasonHeroGroupHandler.NeedGetHeroCardSeason[heroGroupType] then
		extendData.groupIndex = heroGroupMO.groupId
		extendData.heroGroup = heroGroupMO

		HeroGroupModel.instance:setHeroGroupSnapshot(heroGroupType, episodeId, true, extendData, callback, callbackObj)

		return
	end

	if SeasonHeroGroupHandler.NormalSeason[heroGroupType] then
		HeroGroupModel.instance:setHeroGroupSnapshot(heroGroupType, episodeId, true, nil, callback, callbackObj)
	end

	if SeasonHeroGroupHandler.NormalSeason166[heroGroupType] then
		local battleContext = Season166Model.instance:getBattleContext()

		if not battleContext then
			return
		end

		extendData.snapshotSubId = battleContext.baseId or 1
		extendData.heroGroup = heroGroupMO

		Season166HeroGroupModel.instance:setHeroGroupSnapshot(heroGroupType, episodeId, true, extendData, callback, callbackObj)
	end
end

return SeasonHeroGroupHandler
