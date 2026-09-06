-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonchallengegridshowViewPresentor.lua

module("logic.extensions.season.view.SeasonchallengegridshowViewPresentor", package.seeall)

local SeasonchallengegridshowViewPresentor = class("SeasonchallengegridshowViewPresentor", ViewWithGuidePresentor)

function SeasonchallengegridshowViewPresentor:ctor()
	SeasonchallengegridshowViewPresentor.super.ctor(self)
end

function SeasonchallengegridshowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonchallengegridshowViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonchallengegridshowview.prefab"
	}
end

function SeasonchallengegridshowViewPresentor:buildViews()
	return {
		SeasonChallengeGridShowView.New()
	}
end

return SeasonchallengegridshowViewPresentor
