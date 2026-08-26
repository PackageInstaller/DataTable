-- chunkname: @modules/logic/gift/view/GiftMultipleInspirationHeroPreviewViewContainer.lua

module("modules.logic.gift.view.GiftMultipleInspirationHeroPreviewViewContainer", package.seeall)

local GiftMultipleInspirationHeroPreviewViewContainer = class("GiftMultipleInspirationHeroPreviewViewContainer", BaseViewContainer)

function GiftMultipleInspirationHeroPreviewViewContainer:buildViews()
	local views = {}

	table.insert(views, GiftMultipleInspirationHeroPreviewView.New())

	return views
end

return GiftMultipleInspirationHeroPreviewViewContainer
