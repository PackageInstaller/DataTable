-- chunkname: @modules/logic/gift/view/GiftInsightHeroChoiceViewContainer.lua

module("modules.logic.gift.view.GiftInsightHeroChoiceViewContainer", package.seeall)

local GiftInsightHeroChoiceViewContainer = class("GiftInsightHeroChoiceViewContainer", BaseViewContainer)

function GiftInsightHeroChoiceViewContainer:buildViews()
	local views = {}

	table.insert(views, GiftInsightHeroChoiceView.New())

	return views
end

return GiftInsightHeroChoiceViewContainer
