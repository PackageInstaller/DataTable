-- chunkname: @modules/logic/store/view/StoreSupplementMonthCardTipViewContainer.lua

module("modules.logic.store.view.StoreSupplementMonthCardTipViewContainer", package.seeall)

local StoreSupplementMonthCardTipViewContainer = class("StoreSupplementMonthCardTipViewContainer", BaseViewContainer)

function StoreSupplementMonthCardTipViewContainer:buildViews()
	local views = {}

	table.insert(views, StoreSupplementMonthCardTipView.New())

	return views
end

return StoreSupplementMonthCardTipViewContainer
