-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotNormalStoreGoodsViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotNormalStoreGoodsViewContainer", package.seeall)

local V1a6_CachotNormalStoreGoodsViewContainer = class("V1a6_CachotNormalStoreGoodsViewContainer", BaseViewContainer)

function V1a6_CachotNormalStoreGoodsViewContainer:buildViews()
	return {
		V1a6_CachotNormalStoreGoodsView.New(),
		V1a6_CachotCurrencyView.New("top")
	}
end

return V1a6_CachotNormalStoreGoodsViewContainer
