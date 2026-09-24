-- chunkname: @modules/logic/decorate/view/DecoratePackageBuyViewContainer.lua

module("modules.logic.decorate.view.DecoratePackageBuyViewContainer", package.seeall)

local DecoratePackageBuyViewContainer = class("DecoratePackageBuyViewContainer", BaseViewContainer)

function DecoratePackageBuyViewContainer:buildViews()
	local views = {}

	self._bannerView = DecoratePackageBuyViewBanner.New()
	self._tipView = DecoratePackageBuyView.New()

	table.insert(views, self._tipView)
	table.insert(views, self._bannerView)
	table.insert(views, TabViewGroupFit.New(1, "extra"))
	table.insert(views, TabViewGroup.New(2, "#go_topright"))

	return views
end

function DecoratePackageBuyViewContainer:setGoodsTab(goodsId)
	self._bannerView:setGoodsTab(goodsId)
	self._tipView:setGoodsTab(goodsId)
end

function DecoratePackageBuyViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._packageLeftView = DecoratePackageLeftView.New()

		return {
			self._packageLeftView
		}
	elseif tabContainerId == 2 then
		self._currencyView = CurrencyView.New({})
		self._currencyView.foreHideBtn = true

		return {
			self._currencyView
		}
	end
end

function DecoratePackageBuyViewContainer:setCurrencyType(currencyTypeParam)
	for i, param in pairs(currencyTypeParam) do
		if param == DecorateStoreEnum.V4a0SpiritualFluid then
			local rootGo = gohelper.findChild(self.viewGO, "#go_topright")

			self._itemView = self._itemView or DecorateStoreItemView.Get(rootGo)

			local data = {}
			local item = {}

			item.materialType = MaterialEnum.MaterialType.Item
			item.materialId = DecorateStoreEnum.V4a0SpiritualFluid

			table.insert(data, item)
			self._itemView:refresh(data)
			table.remove(currencyTypeParam, i)
		end
	end

	if self._currencyView then
		self._currencyView:setCurrencyType(currencyTypeParam)
	end
end

function DecoratePackageBuyViewContainer:onContainerDestroy()
	if self._itemView then
		self._itemView:destroy()

		self._itemView = nil
	end
end

return DecoratePackageBuyViewContainer
