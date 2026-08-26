-- chunkname: @modules/logic/store/view/recommend/GiftrecommendView1.lua

module("modules.logic.store.view.recommend.GiftrecommendView1", package.seeall)

local GiftrecommendView1 = class("GiftrecommendView1", GiftrecommendViewBase)

function GiftrecommendView1:ctor(...)
	GiftrecommendView1.super.ctor(self, ...)

	self.config = StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.GiftrecommendView1)
end

return GiftrecommendView1
