-- chunkname: @modules/logic/activity/view/v4a0_stonegift/VersionActivity4_0StoneGiftFullViewContainer.lua

module("modules.logic.activity.view.v4a0_stonegift.VersionActivity4_0StoneGiftFullViewContainer", package.seeall)

local VersionActivity4_0StoneGiftFullViewContainer = class("VersionActivity4_0StoneGiftFullViewContainer", BaseViewContainer)

function VersionActivity4_0StoneGiftFullViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity4_0StoneGiftFullView.New())

	return views
end

return VersionActivity4_0StoneGiftFullViewContainer
