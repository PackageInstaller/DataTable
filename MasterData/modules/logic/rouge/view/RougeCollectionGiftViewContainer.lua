-- chunkname: @modules/logic/rouge/view/RougeCollectionGiftViewContainer.lua

module("modules.logic.rouge.view.RougeCollectionGiftViewContainer", package.seeall)

local RougeCollectionGiftViewContainer = class("RougeCollectionGiftViewContainer", BaseViewContainer)
local kTabContainerId_NavigateButtonsView = 1

function RougeCollectionGiftViewContainer:buildViews()
	self._collectionGiftView = RougeCollectionGiftView.New()

	return {
		self._collectionGiftView,
		TabViewGroup.New(kTabContainerId_NavigateButtonsView, "#go_topleft")
	}
end

function RougeCollectionGiftViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == kTabContainerId_NavigateButtonsView then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

function RougeCollectionGiftViewContainer:getScrollRect()
	return self._collectionGiftView:getScrollRect()
end

function RougeCollectionGiftViewContainer:getScrollViewGo()
	return self._collectionGiftView:getScrollViewGo()
end

function RougeCollectionGiftViewContainer:setActiveBlock(isActive)
	self._collectionInitialView:setActiveBlock(isActive)
end

return RougeCollectionGiftViewContainer
