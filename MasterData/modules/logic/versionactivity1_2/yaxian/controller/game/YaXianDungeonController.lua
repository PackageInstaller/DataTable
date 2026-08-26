-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/YaXianDungeonController.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.YaXianDungeonController", package.seeall)

local YaXianDungeonController = class("YaXianDungeonController", BaseController)

function YaXianDungeonController:onInit()
	return
end

function YaXianDungeonController:reInit()
	return
end

function YaXianDungeonController:enterFight(battleId)
	local episodeId = YaXianGameEnum.EpisodeId

	DungeonModel.instance.versionActivityChapterType = DungeonEnum.ChapterType.YaXian

	local config = DungeonConfig.instance:getEpisodeCO(episodeId)

	DungeonFightController.instance:enterFightByBattleId(config.chapterId, episodeId, battleId)
end

function YaXianDungeonController:openGameAfterFight()
	local mapMo = YaXianModel.instance.currentMapMo

	if not mapMo then
		logError("not playing map data")

		return
	end

	YaXianGameController.instance:initMapByMapMo(mapMo)
	ViewMgr.instance:openView(ViewName.YaXianGameView)
end

YaXianDungeonController.instance = YaXianDungeonController.New()

return YaXianDungeonController
