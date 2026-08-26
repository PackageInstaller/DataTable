-- chunkname: @modules/logic/versionactivity3_4/giftrecommend/view/V3a4GiftRecommendPanelviewContainer.lua

module("modules.logic.versionactivity3_4.giftrecommend.view.V3a4GiftRecommendPanelviewContainer", package.seeall)

local V3a4GiftRecommendPanelviewContainer = class("V3a4GiftRecommendPanelviewContainer", BaseViewContainer)

function V3a4GiftRecommendPanelviewContainer:buildViews()
	local views = {}

	table.insert(views, V3a4GiftRecommendPanelview.New())

	return views
end

return V3a4GiftRecommendPanelviewContainer
