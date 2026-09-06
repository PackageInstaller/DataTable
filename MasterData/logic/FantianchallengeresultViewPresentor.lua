-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fantian/view/FantianchallengeresultViewPresentor.lua

module("logic.extensions.fantian.view.FantianchallengeresultViewPresentor", package.seeall)

local FantianchallengeresultViewPresentor = class("FantianchallengeresultViewPresentor", ViewPresentor)

function FantianchallengeresultViewPresentor:ctor()
	FantianchallengeresultViewPresentor.super.ctor(self)
end

function FantianchallengeresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FantianchallengeresultViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/fantian/fantianchallengeresultview.prefab"
	}
end

function FantianchallengeresultViewPresentor:buildViews()
	return {
		FantianchallengeresultView.New()
	}
end

return FantianchallengeresultViewPresentor
