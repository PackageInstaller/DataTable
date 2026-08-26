-- chunkname: @modules/logic/versionactivity2_8/act197/view/Activity197ViewContainer.lua

module("modules.logic.versionactivity2_8.act197.view.Activity197ViewContainer", package.seeall)

local Activity197ViewContainer = class("Activity197ViewContainer", BaseViewContainer)

function Activity197ViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity197View.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "#go_topright"))

	return views
end

function Activity197ViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	elseif tabContainerId == 2 then
		local currencyParam = {
			Activity197Enum.KeyCurrency,
			Activity197Enum.BulbCurrency
		}

		self.currencyView = CurrencyView.New(currencyParam)
		self.currencyView.foreHideBtn = true

		return {
			self.currencyView
		}
	end
end

function Activity197ViewContainer:onClickCurrency()
	return
end

return Activity197ViewContainer
