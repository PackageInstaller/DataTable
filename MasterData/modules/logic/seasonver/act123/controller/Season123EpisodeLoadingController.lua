-- chunkname: @modules/logic/seasonver/act123/controller/Season123EpisodeLoadingController.lua

module("modules.logic.seasonver.act123.controller.Season123EpisodeLoadingController", package.seeall)

local Season123EpisodeLoadingController = class("Season123EpisodeLoadingController", BaseController)

function Season123EpisodeLoadingController:onOpenView(actId, stage, layer)
	Season123EpisodeLoadingModel.instance:init(actId, stage, layer)
end

function Season123EpisodeLoadingController:onCloseView()
	Season123EpisodeLoadingModel.instance:release()
end

function Season123EpisodeLoadingController:openEpisodeDetailView()
	ViewMgr.instance:openView(Season123Controller.instance:getEpisodeMarketViewName(), {
		actId = Season123EpisodeLoadingModel.instance.activityId,
		stage = Season123EpisodeLoadingModel.instance.stage,
		layer = Season123EpisodeLoadingModel.instance.layer
	})
end

Season123EpisodeLoadingController.instance = Season123EpisodeLoadingController.New()

return Season123EpisodeLoadingController
