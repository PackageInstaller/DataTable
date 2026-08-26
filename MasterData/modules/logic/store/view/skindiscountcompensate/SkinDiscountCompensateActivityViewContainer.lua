-- chunkname: @modules/logic/store/view/skindiscountcompensate/SkinDiscountCompensateActivityViewContainer.lua

module("modules.logic.store.view.skindiscountcompensate.SkinDiscountCompensateActivityViewContainer", package.seeall)

local SkinDiscountCompensateActivityViewContainer = class("SkinDiscountCompensateActivityViewContainer", BaseViewContainer)

function SkinDiscountCompensateActivityViewContainer:buildViews()
	local views = {}

	table.insert(views, SkinDiscountCompensateActivityView.New())

	return views
end

return SkinDiscountCompensateActivityViewContainer
