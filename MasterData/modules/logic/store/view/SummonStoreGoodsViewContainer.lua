-- chunkname: @modules/logic/store/view/SummonStoreGoodsViewContainer.lua

module("modules.logic.store.view.SummonStoreGoodsViewContainer", package.seeall)

local SummonStoreGoodsViewContainer = class("SummonStoreGoodsViewContainer", BaseViewContainer)

function SummonStoreGoodsViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_topright"))
	table.insert(views, SummonStoreGoodsView.New())

	return views
end

function SummonStoreGoodsViewContainer:buildTabViews(tabContainerId)
	self._currencyView = CurrencyView.New({})

	return {
		self._currencyView
	}
end

function SummonStoreGoodsViewContainer:setCurrencyType(currencyId, currencyType, icon)
	local currencyTypeParam

	if self._currencyView then
		self._currencyView:setCurrencyType(CurrencyEnum.CurrencyType.FreeDiamondCoupon == currencyId and {
			CurrencyEnum.CurrencyType.Diamond,
			CurrencyEnum.CurrencyType.FreeDiamondCoupon
		} or {
			{
				isCurrencySprite = true,
				id = currencyId,
				icon = icon,
				type = MaterialEnum.MaterialType.Item
			}
		})
	end
end

function SummonStoreGoodsViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return SummonStoreGoodsViewContainer
