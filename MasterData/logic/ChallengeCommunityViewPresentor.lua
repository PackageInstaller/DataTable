-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challengecommunity/view/ChallengeCommunityViewPresentor.lua

module("logic.extensions.challengecommunity.view.ChallengeCommunityViewPresentor", package.seeall)

local ChallengeCommunityViewPresentor = class("ChallengeCommunityViewPresentor", ViewWithGuidePresentor)

function ChallengeCommunityViewPresentor:ctor()
	ChallengeCommunityViewPresentor.super.ctor(self)
end

function ChallengeCommunityViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChallengeCommunityViewPresentor:dependWhatResources()
	return {
		"ui/views/challengecommunity/challengecommunity.prefab"
	}
end

function ChallengeCommunityViewPresentor:buildViews()
	return {
		ChallengeCommunityView.New()
	}
end

return ChallengeCommunityViewPresentor
