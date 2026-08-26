-- chunkname: @modules/logic/seasonver/act123/controller/Season123ShowHeroController.lua

module("modules.logic.seasonver.act123.controller.Season123ShowHeroController", package.seeall)

local Season123ShowHeroController = class("Season123ShowHeroController", BaseController)

function Season123ShowHeroController:onOpenView(actId, stage, layer)
	Season123ShowHeroModel.instance:init(actId, stage, layer)
end

function Season123ShowHeroController:onCloseView()
	Season123ShowHeroModel.instance:release()
end

function Season123ShowHeroController:openReset()
	Season123Controller.instance:openResetView({
		actId = Season123ShowHeroModel.instance.activityId,
		stage = Season123ShowHeroModel.instance.stage
	})
end

function Season123ShowHeroController:notifyView()
	return
end

Season123ShowHeroController.instance = Season123ShowHeroController.New()

return Season123ShowHeroController
