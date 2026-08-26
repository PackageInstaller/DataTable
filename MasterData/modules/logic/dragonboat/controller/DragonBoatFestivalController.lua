-- chunkname: @modules/logic/dragonboat/controller/DragonBoatFestivalController.lua

module("modules.logic.dragonboat.controller.DragonBoatFestivalController", package.seeall)

local DragonBoatFestivalController = class("DragonBoatFestivalController", BaseController)

function DragonBoatFestivalController:onInit()
	self:reInit()
end

function DragonBoatFestivalController:reInit()
	return
end

function DragonBoatFestivalController:addConstEvents()
	return
end

function DragonBoatFestivalController:_checkActivityInfo()
	return
end

function DragonBoatFestivalController:openQuestionTipView(data)
	ViewMgr.instance:openView(ViewName.DragonBoatFestivalQuestionTipView, data)
end

function DragonBoatFestivalController:openDragonBoatFestivalView()
	ViewMgr.instance:openView(ViewName.DragonBoatFestivalView)
end

DragonBoatFestivalController.instance = DragonBoatFestivalController.New()

return DragonBoatFestivalController
