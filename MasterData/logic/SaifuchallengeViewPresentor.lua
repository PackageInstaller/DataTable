-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/SaifuchallengeViewPresentor.lua

module("logic.extensions.infinitefuture.view.SaifuchallengeViewPresentor", package.seeall)

local SaifuchallengeViewPresentor = class("SaifuchallengeViewPresentor", ViewPresentor)

function SaifuchallengeViewPresentor:ctor()
	SaifuchallengeViewPresentor.super.ctor(self)
end

function SaifuchallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SaifuchallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/infinitefuture/saifuchallengeview.prefab"
	}
end

function SaifuchallengeViewPresentor:buildViews()
	return {
		SaifuchallengeView.New()
	}
end

return SaifuchallengeViewPresentor
