-- chunkname: @modules/logic/activity/view/v4a0_sixstargift/V4a0_SixStarGift_PanelViewContainer.lua

module("modules.logic.activity.view.v4a0_sixstargift.V4a0_SixStarGift_PanelViewContainer", package.seeall)

local V4a0_SixStarGift_PanelViewContainer = class("V4a0_SixStarGift_PanelViewContainer", V4a0_SixStarGiftImplContainer)

function V4a0_SixStarGift_PanelViewContainer:buildViews()
	local views = {}

	table.insert(views, V4a0_SixStarGift_PanelView.New())

	return views
end

return V4a0_SixStarGift_PanelViewContainer
