-- chunkname: @modules/logic/versionactivity/view/VersionActivityNormalStoreGoodsViewContainer.lua

module("modules.logic.versionactivity.view.VersionActivityNormalStoreGoodsViewContainer", package.seeall)

local VersionActivityNormalStoreGoodsViewContainer = class("VersionActivityNormalStoreGoodsViewContainer", BaseViewContainer)

function VersionActivityNormalStoreGoodsViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "#go_topright"),
		VersionActivityNormalStoreGoodsView.New()
	}
end

function VersionActivityNormalStoreGoodsViewContainer:buildTabViews(tabContainerId)
	local costId = CurrencyEnum.CurrencyType.LeiMiTeBei

	if self.viewParam then
		local itemParam = string.splitToNumber(self.viewParam.cost, "#")

		costId = itemParam[2]
	end

	return {
		CurrencyView.New({
			costId
		})
	}
end

function VersionActivityNormalStoreGoodsViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return VersionActivityNormalStoreGoodsViewContainer
