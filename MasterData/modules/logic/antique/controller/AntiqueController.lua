-- chunkname: @modules/logic/antique/controller/AntiqueController.lua

module("modules.logic.antique.controller.AntiqueController", package.seeall)

local AntiqueController = class("AntiqueController", BaseController)

function AntiqueController:onInit()
	return
end

function AntiqueController:reInit()
	return
end

function AntiqueController:openAntiqueView(antiqueId)
	ViewMgr.instance:openView(ViewName.AntiqueView, antiqueId)
end

AntiqueController.instance = AntiqueController.New()

return AntiqueController
