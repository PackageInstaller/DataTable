-- chunkname: @modules/logic/versionactivity1_4/act134/view/Activity134ViewContainer.lua

module("modules.logic.versionactivity1_4.act134.view.Activity134ViewContainer", package.seeall)

local Activity134ViewContainer = class("Activity134ViewContainer", BaseViewContainer)
local navigatetionview = 1
local currencyview = 2

function Activity134ViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity134View.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Activity134ViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == navigatetionview then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonView
		}
	elseif tabContainerId == currencyview then
		local currencyType = CurrencyEnum.CurrencyType
		local currencyParam = currencyType.Act134Clue

		self._currencyView = CurrencyView.New({
			currencyParam
		})

		return {
			self._currencyView
		}
	end
end

return Activity134ViewContainer
