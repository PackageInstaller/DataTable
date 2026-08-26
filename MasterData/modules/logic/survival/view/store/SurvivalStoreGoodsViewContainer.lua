-- chunkname: @modules/logic/survival/view/store/SurvivalStoreGoodsViewContainer.lua

module("modules.logic.survival.view.store.SurvivalStoreGoodsViewContainer", package.seeall)

local SurvivalStoreGoodsViewContainer = class("SurvivalStoreGoodsViewContainer", BaseViewContainer)

function SurvivalStoreGoodsViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_topright"))
	table.insert(views, SurvivalStoreGoodsView.New())

	return views
end

function SurvivalStoreGoodsViewContainer:buildTabViews(tabContainerId)
	self._currencyView = CurrencyView.New({})

	return {
		self._currencyView
	}
end

function SurvivalStoreGoodsViewContainer:setCurrencyType(currencyId)
	if self._currencyView then
		self._currencyView:setCurrencyType((CurrencyEnum.CurrencyType.FreeDiamondCoupon == currencyId or nil) and {
			CurrencyEnum.CurrencyType.SurvivalCurrency
		})
	end
end

function SurvivalStoreGoodsViewContainer:setCurrencyTypes(currencyIds)
	if self._currencyView then
		self._currencyView:setCurrencyType(currencyIds)
	end
end

function SurvivalStoreGoodsViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return SurvivalStoreGoodsViewContainer
