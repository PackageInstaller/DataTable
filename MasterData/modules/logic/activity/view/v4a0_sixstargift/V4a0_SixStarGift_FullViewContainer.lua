-- chunkname: @modules/logic/activity/view/v4a0_sixstargift/V4a0_SixStarGift_FullViewContainer.lua

module("modules.logic.activity.view.v4a0_sixstargift.V4a0_SixStarGift_FullViewContainer", package.seeall)

local V4a0_SixStarGift_FullViewContainer = class("V4a0_SixStarGift_FullViewContainer", V4a0_SixStarGiftImplContainer)

function V4a0_SixStarGift_FullViewContainer:buildViews()
	local views = {}

	table.insert(views, V4a0_SixStarGift_FullView.New())

	return views
end

return V4a0_SixStarGift_FullViewContainer
