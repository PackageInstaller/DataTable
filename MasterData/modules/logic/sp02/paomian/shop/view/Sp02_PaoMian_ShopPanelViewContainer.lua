-- chunkname: @modules/logic/sp02/paomian/shop/view/Sp02_PaoMian_ShopPanelViewContainer.lua

module("modules.logic.sp02.paomian.shop.view.Sp02_PaoMian_ShopPanelViewContainer", package.seeall)

local Sp02_PaoMian_ShopPanelViewContainer = class("Sp02_PaoMian_ShopPanelViewContainer", BaseViewContainer)

function Sp02_PaoMian_ShopPanelViewContainer:buildViews()
	local views = {}

	table.insert(views, Sp02_PaoMian_ShopPanelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topright"))

	return views
end

function Sp02_PaoMian_ShopPanelViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local _, secondTabId = StoreModel.instance:jumpTabIdToSelectTabId(StoreEnum.StoreId.DecorateStore)
		local storeCo = StoreConfig.instance:getTabConfig(secondTabId)

		if storeCo then
			if not storeCo.showCost then
				local showCost = ""
				local currencyTypeParam = {}
				local costInfo = string.split(showCost, "#")

				for i = #costInfo, 1, -1 do
					table.insert(currencyTypeParam, tonumber(costInfo[i]))
				end

				self.currencyView = CurrencyView.New(currencyTypeParam)

				return {
					self.currencyView
				}
			end
		end
	end
end

return Sp02_PaoMian_ShopPanelViewContainer
