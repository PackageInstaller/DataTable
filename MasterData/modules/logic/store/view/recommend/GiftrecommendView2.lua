-- chunkname: @modules/logic/store/view/recommend/GiftrecommendView2.lua

module("modules.logic.store.view.recommend.GiftrecommendView2", package.seeall)

local GiftrecommendView2 = class("GiftrecommendView2", GiftrecommendViewBase)

function GiftrecommendView2:ctor(...)
	GiftrecommendView2.super.ctor(self, ...)

	self.config = StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.GiftrecommendView2)
end

return GiftrecommendView2
