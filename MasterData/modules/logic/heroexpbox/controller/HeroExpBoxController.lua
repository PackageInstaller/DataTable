-- chunkname: @modules/logic/heroexpbox/controller/HeroExpBoxController.lua

module("modules.logic.heroexpbox.controller.HeroExpBoxController", package.seeall)

local HeroExpBoxController = class("HeroExpBoxController", BaseController)

function HeroExpBoxController:onInit()
	return
end

function HeroExpBoxController:onInitFinish()
	return
end

function HeroExpBoxController:addConstEvents()
	return
end

function HeroExpBoxController:reInit()
	return
end

function HeroExpBoxController:openHeroExpBoxView(itemId)
	local param = {
		itemId = itemId
	}

	ViewMgr.instance:openView(ViewName.HeroExpBoxView, param)
end

HeroExpBoxController.instance = HeroExpBoxController.New()

return HeroExpBoxController
