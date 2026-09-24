-- chunkname: @modules/logic/activity/view/v4a0_stonegift/VersionActivity4_0StoneGiftPanelViewContainer.lua

module("modules.logic.activity.view.v4a0_stonegift.VersionActivity4_0StoneGiftPanelViewContainer", package.seeall)

local VersionActivity4_0StoneGiftPanelViewContainer = class("VersionActivity4_0StoneGiftPanelViewContainer", BaseViewContainer)

function VersionActivity4_0StoneGiftPanelViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity4_0StoneGiftPanelView.New())

	return views
end

return VersionActivity4_0StoneGiftPanelViewContainer
