-- chunkname: @modules/logic/season/view1_4/Season1_4StoreViewContainer.lua

module("modules.logic.season.view1_4.Season1_4StoreViewContainer", package.seeall)

local Season1_4StoreViewContainer = class("Season1_4StoreViewContainer", BaseViewContainer)

function Season1_4StoreViewContainer:buildViews()
	local views = {}

	table.insert(views, Season1_4StoreView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))
	table.insert(views, TabViewGroup.New(2, "#go_righttop"))

	return views
end

function Season1_4StoreViewContainer:buildTabViews(tabContainerId)
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

function Season1_4StoreViewContainer:_closeCallback()
	self:closeThis()
end

function Season1_4StoreViewContainer:_homeCallback()
	self:closeThis()
end

return Season1_4StoreViewContainer
