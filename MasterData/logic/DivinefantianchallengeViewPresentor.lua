-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalepsychic/view/copy/DivinefantianchallengeViewPresentor.lua

module("logic.extensions.femalepsychic.view.copy.DivinefantianchallengeViewPresentor", package.seeall)

local DivinefantianchallengeViewPresentor = class("DivinefantianchallengeViewPresentor", ViewPresentor)

function DivinefantianchallengeViewPresentor:ctor()
	DivinefantianchallengeViewPresentor.super.ctor(self)
end

function DivinefantianchallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinefantianchallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/femalepsychic/copy/divinefantianchallengeview.prefab"
	}
end

function DivinefantianchallengeViewPresentor:buildViews()
	return {
		DivinefantianchallengeView.New()
	}
end

return DivinefantianchallengeViewPresentor
