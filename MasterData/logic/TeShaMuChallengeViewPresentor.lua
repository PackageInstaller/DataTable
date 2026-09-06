-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teshamu/view/TeShaMuChallengeViewPresentor.lua

module("logic.extensions.teshamu.view.TeShaMuChallengeViewPresentor", package.seeall)

local TeShaMuChallengeViewPresentor = class("TeShaMuChallengeViewPresentor", ViewPresentor)

function TeShaMuChallengeViewPresentor:ctor()
	TeShaMuChallengeViewPresentor.super.ctor(self)
end

function TeShaMuChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TeShaMuChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/teshamu/teshamuchallengeview.prefab"
	}
end

function TeShaMuChallengeViewPresentor:buildViews()
	return {
		TeShaMuChallengeView.New()
	}
end

return TeShaMuChallengeViewPresentor
