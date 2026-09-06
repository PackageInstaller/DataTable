-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/PlayerStrengrhChangeViewPresentor.lua

module("logic.extensions.mainui.view.PlayerStrengrhChangeViewPresentor", package.seeall)

local PlayerStrengrhChangeViewPresentor = class("PlayerStrengrhChangeViewPresentor", ViewPresentor)

function PlayerStrengrhChangeViewPresentor:ctor()
	PlayerStrengrhChangeViewPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.PetMaxPowerChangePriority
end

function PlayerStrengrhChangeViewPresentor:attachToWhichRoot()
	return ViewRootType.TopMost
end

function PlayerStrengrhChangeViewPresentor:dependWhatResources()
	return {
		"ui/views/mainui/player_strength_change.prefab"
	}
end

function PlayerStrengrhChangeViewPresentor:buildViews()
	local views = {}
	local playerStrengrhChangeView = PlayerStrengrhChangeView.New()

	table.insert(views, playerStrengrhChangeView)

	return views
end

return PlayerStrengrhChangeViewPresentor
