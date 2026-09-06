-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InfinfuchallengeViewPresentor.lua

module("logic.extensions.infinitefuture.view.InfinfuchallengeViewPresentor", package.seeall)

local InfinfuchallengeViewPresentor = class("InfinfuchallengeViewPresentor", ViewPresentor)

function InfinfuchallengeViewPresentor:ctor()
	InfinfuchallengeViewPresentor.super.ctor(self)
end

function InfinfuchallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function InfinfuchallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/infinitefuture/infinfuchallengeview.prefab"
	}
end

function InfinfuchallengeViewPresentor:buildViews()
	return {
		InfinfuchallengeView.New()
	}
end

return InfinfuchallengeViewPresentor
