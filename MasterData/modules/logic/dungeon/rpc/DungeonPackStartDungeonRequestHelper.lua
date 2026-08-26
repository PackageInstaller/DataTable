-- chunkname: @modules/logic/dungeon/rpc/DungeonPackStartDungeonRequestHelper.lua

module("modules.logic.dungeon.rpc.DungeonPackStartDungeonRequestHelper", package.seeall)

local DungeonPackStartDungeonRequestHelper = _M

function DungeonPackStartDungeonRequestHelper.initHandle()
	if DungeonPackStartDungeonRequestHelper.handleDict then
		return
	end

	DungeonPackStartDungeonRequestHelper.handleDict = {
		[DungeonEnum.EpisodeType.Rouge] = DungeonPackStartDungeonRequestHelper.packRougeCustomParam,
		[DungeonEnum.EpisodeType.WeekWalk_2] = DungeonPackStartDungeonRequestHelper.packWeekWalkCustomParam,
		[DungeonEnum.EpisodeType.Act183] = DungeonPackStartDungeonRequestHelper.packAct183CustomParam,
		[DungeonEnum.EpisodeType.TowerCompose] = DungeonPackStartDungeonRequestHelper.packTowerComposeCustomParam,
		[DungeonEnum.EpisodeType.Rouge2] = DungeonPackStartDungeonRequestHelper.packRouge2CustomParam,
		[DungeonEnum.EpisodeType.AtomicDungeon] = DungeonPackStartDungeonRequestHelper.packAtomicDungeonCustomParam,
		[DungeonEnum.EpisodeType.BossRush] = DungeonPackStartDungeonRequestHelper.packBossRushDungeonCustomParam,
		[DungeonEnum.EpisodeType.V3_2ZongMao] = DungeonPackStartDungeonRequestHelper.packBossRushDungeonCustomParam,
		[DungeonEnum.EpisodeType.BossRushActMode] = DungeonPackStartDungeonRequestHelper.packBossRushDungeonCustomParam
	}
end

function DungeonPackStartDungeonRequestHelper.packRequestCustomParams(request, episodeConfig)
	if not episodeConfig then
		return
	end

	DungeonPackStartDungeonRequestHelper.initHandle()

	local handle = DungeonPackStartDungeonRequestHelper.handleDict[episodeConfig.type]

	if handle then
		handle(request, episodeConfig)
	end
end

function DungeonPackStartDungeonRequestHelper.packRougeCustomParam(request, episodeConfig)
	request.params = tostring(RougeConfig1.instance:season())
end

function DungeonPackStartDungeonRequestHelper.packWeekWalkCustomParam(request, episodeConfig)
	request.params = WeekWalk_2Model.instance:getFightParam()
end

function DungeonPackStartDungeonRequestHelper.packAct183CustomParam(request, episodeConfig)
	request.params = Act183Helper.generateStartDungeonParams(episodeConfig.id)
end

function DungeonPackStartDungeonRequestHelper.packTowerComposeCustomParam(request, episodeConfig)
	local recordFightParam = TowerComposeModel.instance:getRecordFightParam()
	local extraParams = {}
	local towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(recordFightParam.themeId, recordFightParam.layerId)

	extraParams.themeId = recordFightParam.themeId
	extraParams.layerId = recordFightParam.layerId
	extraParams.planeId = TowerComposeModel.instance:getCurFightPlaneId()
	extraParams.supportId = TowerComposeHeroGroupModel.instance:getThemePlaneBuffId(extraParams.themeId, extraParams.planeId, TowerComposeEnum.TeamBuffType.Support)
	extraParams.researchId = TowerComposeHeroGroupModel.instance:getThemePlaneBuffId(extraParams.themeId, extraParams.planeId, TowerComposeEnum.TeamBuffType.Research)

	local assistData = TowerComposeHeroGroupModel.instance:getThemePlaneAssistData(extraParams.themeId, extraParams.planeId)

	extraParams.supportAssistUid = tonumber(assistData.heroUid or 0)
	extraParams.supportAssistType = assistData.assistType or 0
	request.params = cjson.encode(extraParams)
end

function DungeonPackStartDungeonRequestHelper.packRouge2CustomParam(request, episodeConfig)
	if request.fightGroup.trialHeroList then
		for _, hero in pairs(request.fightGroup.trialHeroList) do
			if hero.pos and hero.pos ~= 0 then
				local pos = tonumber(hero.pos)

				table.insert(request.fightGroup.heroList, pos, "0")
			end
		end
	end
end

function DungeonPackStartDungeonRequestHelper.packAtomicDungeonCustomParam(request, episodeConfig)
	local lastElementFightParam = AtomicDungeonModel.instance:getLastElementFightParam()
	local elementId = 0

	if lastElementFightParam and lastElementFightParam.lastEpisodeId == episodeConfig.id then
		elementId = lastElementFightParam.lastElementId
	end

	local isPolygonEpisode, config = AtomicDungeonConfig.instance:checkIsPolygonEpisode(episodeConfig.id)

	if isPolygonEpisode then
		request.params = "2"
	else
		if elementId == 0 then
			logError("事件id异常，请检查")

			return
		end

		request.params = string.format("1#%d", elementId)
	end
end

function DungeonPackStartDungeonRequestHelper.packBossRushDungeonCustomParam(request, episodeConfig)
	if not episodeConfig then
		return
	end

	local _, _, actId = BossRushModel.instance:getBattleStageAndLayer()

	if not actId then
		local _, _, _actId = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(episodeConfig.id)

		actId = _actId
	end

	request.params = tostring(actId)
end

return DungeonPackStartDungeonRequestHelper
