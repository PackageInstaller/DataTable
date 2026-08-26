-- chunkname: @modules/logic/versionactivity1_3/versionactivity1_3dungeon/view/VersionActivity1_3NormalStoreGoodsViewContainer.lua

module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3NormalStoreGoodsViewContainer", package.seeall)

local VersionActivity1_3NormalStoreGoodsViewContainer = class("VersionActivity1_3NormalStoreGoodsViewContainer", BaseViewContainer)

function VersionActivity1_3NormalStoreGoodsViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "#go_topright"),
		VersionActivity1_3NormalStoreGoodsView.New()
	}
end

function VersionActivity1_3NormalStoreGoodsViewContainer:buildTabViews(tabContainerId)
	local costId = CurrencyEnum.CurrencyType.LeiMiTeBei

	if self.viewParam then
		local itemParam = string.splitToNumber(self.viewParam.cost, "#")

		costId = itemParam[2]
	end

	self._currencyView = CurrencyView.New({
		costId
	})

	self._currencyView:setOpenCallback(self._onCurrencyOpen, self)

	return {
		self._currencyView
	}
end

function VersionActivity1_3NormalStoreGoodsViewContainer:_onCurrencyOpen()
	local item = self._currencyView:getCurrencyItem(1)

	gohelper.setActive(item.btn, false)
	gohelper.setActive(item.click, true)
	recthelper.setAnchorX(item.txt.transform, 313)
end

function VersionActivity1_3NormalStoreGoodsViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return VersionActivity1_3NormalStoreGoodsViewContainer
