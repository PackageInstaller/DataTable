-- chunkname: @modules/logic/ressplit/controller/ResSplitController.lua

module("modules.logic.ressplit.controller.ResSplitController", package.seeall)

local ResSplitController = class("ResSplitController", BaseController)

function ResSplitController:onInit()
	self._versionResSplitHandler = VersionResSplitHandler.New()

	ResSplitHelper.init()
	ResSplitSaveHelper.init()
end

function ResSplitController:onInitFinish()
	return
end

function ResSplitController:addConstEvents()
	return
end

function ResSplitController:reInit()
	return
end

function ResSplitController:generateResSplitCfg()
	self._versionResSplitHandler:generateResSplitCfg()
end

function ResSplitController.staticVersionResSplitAction()
	ResSplitController.instance:generateResSplitCfg()
end

ResSplitController.instance = ResSplitController.New()

return ResSplitController
