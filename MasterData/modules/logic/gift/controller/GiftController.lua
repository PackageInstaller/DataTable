-- chunkname: @modules/logic/gift/controller/GiftController.lua

module("modules.logic.gift.controller.GiftController", package.seeall)

local GiftController = class("GiftController", BaseController)

function GiftController:onInit()
	return
end

function GiftController:onInitFinish()
	return
end

function GiftController:addConstEvents()
	return
end

function GiftController:reInit()
	return
end

function GiftController:openGiftMultipleChoiceView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.GiftMultipleChoiceView, param, isImmediate)
end

function GiftController:openOptionalGiftMultipleChoiceView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.OptionalGiftMultipleChoiceView, param, isImmediate)
end

function GiftController:openGiftInsightHeroChoiceView(param)
	ViewMgr.instance:openView(ViewName.GiftInsightHeroChoiceView, param)
end

function GiftController:openGiftMultipleHeroChoiceView(param)
	ViewMgr.instance:openView(ViewName.GiftMultipleHeroChoiceView, param)
end

function GiftController:GiftMultipleInspirationHeroPreviewView(param)
	ViewMgr.instance:openView(ViewName.GiftMultipleInspirationHeroPreviewView, param)
end

GiftController.instance = GiftController.New()

return GiftController
