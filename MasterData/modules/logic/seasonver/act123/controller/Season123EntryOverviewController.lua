-- chunkname: @modules/logic/seasonver/act123/controller/Season123EntryOverviewController.lua

module("modules.logic.seasonver.act123.controller.Season123EntryOverviewController", package.seeall)

local Season123EntryOverviewController = class("Season123EntryOverviewController", BaseController)

function Season123EntryOverviewController:onOpenView(actId)
	Season123EntryOverviewModel.instance:init(actId)
end

function Season123EntryOverviewController:onCloseView()
	return
end

Season123EntryOverviewController.instance = Season123EntryOverviewController.New()

return Season123EntryOverviewController
