-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InflameChallengeViewPresentor.lua

module("logic.extensions.infinitefuture.view.InflameChallengeViewPresentor", package.seeall)

local InflameChallengeViewPresentor = class("InflameChallengeViewPresentor", ViewPresentor)

function InflameChallengeViewPresentor:ctor()
	InflameChallengeViewPresentor.super.ctor(self)
end

function InflameChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function InflameChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/inflamedmother/inflamedchallengeview.prefab"
	}
end

function InflameChallengeViewPresentor:buildViews()
	return {
		InflameChallengeView.New()
	}
end

return InflameChallengeViewPresentor
