-- chunkname: @modules/logic/survival/controller/handbook/SurvivalHandbookController.lua

module("modules.logic.survival.controller.handbook.SurvivalHandbookController", package.seeall)

local SurvivalHandbookController = class("SurvivalHandbookController", BaseController)

function SurvivalHandbookController:onInit()
	return
end

function SurvivalHandbookController:sendOpenSurvivalHandbookView()
	ViewMgr.instance:openView(ViewName.SurvivalHandbookView)
end

function SurvivalHandbookController:markNewHandbook(type, subType)
	local ids = SurvivalHandbookModel.instance:getNewHandbook(type, subType)

	if #ids > 0 then
		SurvivalOutSideRpc.instance:sendSurvivalMarkNewHandbook(ids)
	end
end

SurvivalHandbookController.instance = SurvivalHandbookController.New()

return SurvivalHandbookController
