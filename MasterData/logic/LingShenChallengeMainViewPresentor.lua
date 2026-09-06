-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lingshenchallenge/view/LingShenChallengeMainViewPresentor.lua

module("logic.extensions.lingshenchallenge.view.LingShenChallengeMainViewPresentor", package.seeall)

local LingShenChallengeMainViewPresentor = class("LingShenChallengeMainViewPresentor", ViewPresentor)

function LingShenChallengeMainViewPresentor:ctor()
	LingShenChallengeMainViewPresentor.super.ctor(self)
end

function LingShenChallengeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LingShenChallengeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/lingshenchallenge/lingshenchallengemainview.prefab"
	}
end

function LingShenChallengeMainViewPresentor:buildViews()
	return {
		LingShenChallengeMainView.New()
	}
end

return LingShenChallengeMainViewPresentor
