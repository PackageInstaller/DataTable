-- chunkname: @modules/logic/store/view/StoreSkinConfirmViewContainer.lua

module("modules.logic.store.view.StoreSkinConfirmViewContainer", package.seeall)

local StoreSkinConfirmViewContainer = class("StoreSkinConfirmViewContainer", BaseViewContainer)

function StoreSkinConfirmViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_topright"))
	table.insert(views, StoreSkinConfirmView.New())

	return views
end

function StoreSkinConfirmViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._currencyView = CurrencyView.New({
			CurrencyEnum.CurrencyType.Diamond,
			CurrencyEnum.CurrencyType.SkinCard
		}, nil, nil, nil, true)

		return {
			self._currencyView
		}
	end
end

return StoreSkinConfirmViewContainer
