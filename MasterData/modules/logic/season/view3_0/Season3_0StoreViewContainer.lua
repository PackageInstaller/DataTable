-- chunkname: @modules/logic/season/view3_0/Season3_0StoreViewContainer.lua

module("modules.logic.season.view3_0.Season3_0StoreViewContainer", package.seeall)

local Season3_0StoreViewContainer = class("Season3_0StoreViewContainer", BaseViewContainer)

function Season3_0StoreViewContainer:buildViews()
	local views = {}

	table.insert(views, Season3_0StoreView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))
	table.insert(views, TabViewGroup.New(2, "#go_righttop"))

	return views
end

function Season3_0StoreViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end

	if tabContainerId == 2 then
		local actId = Activity104Model.instance:getCurSeasonId()
		local currencyview = CurrencyView.New({
			Activity104Enum.StoreUTTU[actId]
		})

		currencyview.foreHideBtn = true

		return {
			currencyview
		}
	end
end

function Season3_0StoreViewContainer:_closeCallback()
	self:closeThis()
end

function Season3_0StoreViewContainer:_homeCallback()
	self:closeThis()
end

return Season3_0StoreViewContainer
