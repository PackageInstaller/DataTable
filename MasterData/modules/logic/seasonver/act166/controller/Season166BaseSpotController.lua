-- chunkname: @modules/logic/seasonver/act166/controller/Season166BaseSpotController.lua

module("modules.logic.seasonver.act166.controller.Season166BaseSpotController", package.seeall)

local Season166BaseSpotController = class("Season166BaseSpotController", BaseController)

function Season166BaseSpotController:onInit()
	return
end

function Season166BaseSpotController:reInit()
	return
end

function Season166BaseSpotController:enterBaseSpotFightScene(param)
	local episodeId = Season166BaseSpotModel.instance.curEpisodeId

	if episodeId then
		self:startBattle(param.actId, episodeId)
	end
end

function Season166BaseSpotController:startBattle(actId, episodeId)
	logNormal(string.format("startBattle with actId = %s, episodeId = %s", actId, episodeId))

	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local baseId = Season166BaseSpotModel.instance.curBaseSpotId
	local talentId = Season166BaseSpotModel.instance.talentId

	Season166Model.instance:setBattleContext(actId, episodeId, baseId, talentId)
	DungeonFightController.instance:enterSeasonFight(episodeCo.chapterId, episodeId)
end

Season166BaseSpotController.instance = Season166BaseSpotController.New()

return Season166BaseSpotController
