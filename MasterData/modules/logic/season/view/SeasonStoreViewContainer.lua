-- chunkname: @modules/logic/season/view/SeasonStoreViewContainer.lua

module("modules.logic.season.view.SeasonStoreViewContainer", package.seeall)

local SeasonStoreViewContainer = class("SeasonStoreViewContainer", BaseViewContainer)

function SeasonStoreViewContainer:buildViews()
	local views = {}

	table.insert(views, SeasonStoreView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))
	table.insert(views, TabViewGroup.New(2, "#go_righttop"))

	return views
end

function SeasonStoreViewContainer:buildTabViews(tabContainerId)
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

		return {
			CurrencyView.New({
				Activity104Enum.StoreUTTU[actId]
			})
		}
	end
end

function SeasonStoreViewContainer:_closeCallback()
	self:closeThis()
end

function SeasonStoreViewContainer:_homeCallback()
	self:closeThis()
end

return SeasonStoreViewContainer
