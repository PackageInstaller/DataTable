-- chunkname: @modules/logic/rouge/view/RougeCollectionInitialViewContainer.lua

module("modules.logic.rouge.view.RougeCollectionInitialViewContainer", package.seeall)

local RougeCollectionInitialViewContainer = class("RougeCollectionInitialViewContainer", BaseViewContainer)

function RougeCollectionInitialViewContainer:buildViews()
	self._collectionInitialView = RougeCollectionInitialView.New()

	return {
		TabViewGroup.New(1, "#go_topleft"),
		TabViewGroup.New(2, "#go_rougemapdetailcontainer"),
		self._collectionInitialView
	}
end

function RougeCollectionInitialViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self._navigateButtonView
		}
	elseif tabContainerId == 2 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

function RougeCollectionInitialViewContainer:setActiveBlock(isActive)
	self._collectionInitialView:setActiveBlock(isActive)
end

function RougeCollectionInitialViewContainer:getScrollViewGo()
	return self._collectionInitialView:getScrollViewGo()
end

return RougeCollectionInitialViewContainer
