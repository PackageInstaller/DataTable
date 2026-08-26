-- chunkname: @modules/logic/versionactivity3_4/giftrecommend/view/V3a4GiftRecommendFullviewContainer.lua

module("modules.logic.versionactivity3_4.giftrecommend.view.V3a4GiftRecommendFullviewContainer", package.seeall)

local V3a4GiftRecommendFullviewContainer = class("V3a4GiftRecommendFullviewContainer", BaseViewContainer)

function V3a4GiftRecommendFullviewContainer:buildViews()
	local views = {}

	table.insert(views, V3a4GiftRecommendFullview.New())

	return views
end

return V3a4GiftRecommendFullviewContainer
