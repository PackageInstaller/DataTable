-- chunkname: @modules/logic/gift/view/GiftMultipleHeroChoiceViewContainer.lua

module("modules.logic.gift.view.GiftMultipleHeroChoiceViewContainer", package.seeall)

local GiftMultipleHeroChoiceViewContainer = class("GiftMultipleHeroChoiceViewContainer", BaseViewContainer)

function GiftMultipleHeroChoiceViewContainer:buildViews()
	local views = {}

	table.insert(views, GiftMultipleHeroChoiceView.New())

	return views
end

return GiftMultipleHeroChoiceViewContainer
