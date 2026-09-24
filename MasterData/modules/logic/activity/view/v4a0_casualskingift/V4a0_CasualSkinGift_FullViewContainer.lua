-- chunkname: @modules/logic/activity/view/v4a0_casualskingift/V4a0_CasualSkinGift_FullViewContainer.lua

module("modules.logic.activity.view.v4a0_casualskingift.V4a0_CasualSkinGift_FullViewContainer", package.seeall)

local V4a0_CasualSkinGift_FullViewContainer = class("V4a0_CasualSkinGift_FullViewContainer", V4a0_CasualSkinGiftImplContainer)

function V4a0_CasualSkinGift_FullViewContainer:buildViews()
	local views = {}

	table.insert(views, V4a0_CasualSkinGift_FullView.New())

	return views
end

return V4a0_CasualSkinGift_FullViewContainer
