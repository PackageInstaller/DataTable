-- chunkname: @modules/logic/seasonver/act166/controller/Season166TrainController.lua

module("modules.logic.seasonver.act166.controller.Season166TrainController", package.seeall)

local Season166TrainController = class("Season166TrainController", BaseController)

function Season166TrainController:onInit()
	return
end

function Season166TrainController:reInit()
	return
end

function Season166TrainController:enterTrainFightScene()
	local actId = Season166Model.instance:getCurSeasonId()
	local episodeId = Season166TrainModel.instance.curEpisodeId

	if episodeId then
		self:startBattle(actId, episodeId)
	end
end

function Season166TrainController:startBattle(actId, episodeId)
	logNormal(string.format("startBattle with actId = %s, episodeId = %s", actId, episodeId))

	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local trainId = Season166TrainModel.instance.curTrainId
	local talentId = Season166Model.getPrefsTalent()

	Season166Model.instance:setBattleContext(actId, episodeId, nil, talentId, trainId)
	DungeonFightController.instance:enterSeasonFight(episodeCo.chapterId, episodeId)
end

Season166TrainController.instance = Season166TrainController.New()

return Season166TrainController
