-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteam/view/DreamTeamRewardViewPresentor.lua

module("logic.extensions.dreamteam.view.DreamTeamRewardViewPresentor", package.seeall)

local DreamTeamRewardViewPresentor = class("DreamTeamRewardViewPresentor", ViewPresentor)

function DreamTeamRewardViewPresentor:ctor()
	DreamTeamRewardViewPresentor.super.ctor(self)
end

function DreamTeamRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DreamTeamRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteam/dreamteamrewardview.prefab"
	}
end

function DreamTeamRewardViewPresentor:buildViews()
	return {
		DreamTeamRewardView.New()
	}
end

return DreamTeamRewardViewPresentor
