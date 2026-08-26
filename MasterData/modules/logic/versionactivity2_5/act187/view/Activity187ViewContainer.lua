-- chunkname: @modules/logic/versionactivity2_5/act187/view/Activity187ViewContainer.lua

module("modules.logic.versionactivity2_5.act187.view.Activity187ViewContainer", package.seeall)

local Activity187ViewContainer = class("Activity187ViewContainer", BaseViewContainer)

function Activity187ViewContainer:buildViews()
	local views = {}

	self._act187View = Activity187View.New()
	self._act187PaintView = Activity187PaintingView.New()

	table.insert(views, self._act187View)
	table.insert(views, self._act187PaintView)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Activity187ViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self._overrideClose, self)

		return {
			self.navigateView
		}
	end
end

function Activity187ViewContainer:_overrideClose()
	self._act187View:onBtnEsc()
end

function Activity187ViewContainer:setPaintingViewDisplay(isShow)
	self._act187View:setPaintingViewDisplay(isShow)
end

function Activity187ViewContainer:isShowPaintView()
	return self._act187View.isShowPaintView
end

return Activity187ViewContainer
