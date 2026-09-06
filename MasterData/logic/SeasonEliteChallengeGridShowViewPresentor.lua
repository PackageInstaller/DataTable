-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonEliteChallengeGridShowViewPresentor.lua

module("logic.extensions.season.view.SeasonEliteChallengeGridShowViewPresentor", package.seeall)

local SeasonEliteChallengeGridShowViewPresentor = class("SeasonEliteChallengeGridShowViewPresentor", ViewWithGuidePresentor)

function SeasonEliteChallengeGridShowViewPresentor:ctor()
	SeasonEliteChallengeGridShowViewPresentor.super.ctor(self)
end

function SeasonEliteChallengeGridShowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonEliteChallengeGridShowViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonelitechallengegridshowview.prefab"
	}
end

function SeasonEliteChallengeGridShowViewPresentor:buildViews()
	return {
		SeasonEliteChallengeGridShowView.New()
	}
end

return SeasonEliteChallengeGridShowViewPresentor
