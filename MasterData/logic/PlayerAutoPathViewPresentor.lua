-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/PlayerAutoPathViewPresentor.lua

module("logic.extensions.mainui.view.PlayerAutoPathViewPresentor", package.seeall)

local PlayerAutoPathViewPresentor = class("PlayerAutoPathViewPresentor", ViewPresentor)

function PlayerAutoPathViewPresentor:attachToWhichRoot()
	return ViewRootType.HudTop
end

function PlayerAutoPathViewPresentor:dependWhatResources()
	return {
		"ui/views/mainui/player_auto_path.prefab"
	}
end

function PlayerAutoPathViewPresentor:buildViews()
	local views = {}
	local playerAutoPathView = PlayerAutoPathView.New()

	table.insert(views, playerAutoPathView)

	return views
end

return PlayerAutoPathViewPresentor
