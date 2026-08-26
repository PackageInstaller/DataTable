-- chunkname: @modules/logic/store/view/decoratemultigoods/DecorateMultiGoodsTipsViewContainer.lua

module("modules.logic.store.view.decoratemultigoods.DecorateMultiGoodsTipsViewContainer", package.seeall)

local DecorateMultiGoodsTipsViewContainer = class("DecorateMultiGoodsTipsViewContainer", BaseViewContainer)

function DecorateMultiGoodsTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, DecorateMultiGoodsTipsView.New())
	table.insert(views, DecorateMultiGoodsTipsViewBanner.New())
	table.insert(views, DecorateMultiGoodsTipsViewPay.New())

	return views
end

return DecorateMultiGoodsTipsViewContainer
