-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/EndlessdchallengeViewPresentor.lua

module("logic.extensions.infinitefuture.view.EndlessdchallengeViewPresentor", package.seeall)

local EndlessdchallengeViewPresentor = class("EndlessdchallengeViewPresentor", ViewPresentor)

function EndlessdchallengeViewPresentor:ctor()
	EndlessdchallengeViewPresentor.super.ctor(self)
end

function EndlessdchallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EndlessdchallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/infinitefuture/endlessdchallengeview.prefab"
	}
end

function EndlessdchallengeViewPresentor:buildViews()
	return {
		EndlessdchallengeView.New()
	}
end

return EndlessdchallengeViewPresentor
