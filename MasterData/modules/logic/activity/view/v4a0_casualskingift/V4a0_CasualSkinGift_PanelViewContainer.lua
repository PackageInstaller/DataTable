-- chunkname: @modules/logic/activity/view/v4a0_casualskingift/V4a0_CasualSkinGift_PanelViewContainer.lua

module("modules.logic.activity.view.v4a0_casualskingift.V4a0_CasualSkinGift_PanelViewContainer", package.seeall)

local V4a0_CasualSkinGift_PanelViewContainer = class("V4a0_CasualSkinGift_PanelViewContainer", V4a0_CasualSkinGiftImplContainer)

function V4a0_CasualSkinGift_PanelViewContainer:buildViews()
	local views = {}

	table.insert(views, V4a0_CasualSkinGift_PanelView.New())

	return views
end

return V4a0_CasualSkinGift_PanelViewContainer
