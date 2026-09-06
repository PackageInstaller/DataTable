-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lingshenchallenge/view/LingShenChallengeResultViewPresentor.lua

module("logic.extensions.lingshenchallenge.view.LingShenChallengeResultViewPresentor", package.seeall)

local LingShenChallengeResultViewPresentor = class("LingShenChallengeResultViewPresentor", ViewPresentor)

function LingShenChallengeResultViewPresentor:ctor()
	LingShenChallengeResultViewPresentor.super.ctor(self)
end

function LingShenChallengeResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LingShenChallengeResultViewPresentor:dependWhatResources()
	return {
		"ui/views/battlesettlement/battlesettlementsuccess.prefab"
	}
end

function LingShenChallengeResultViewPresentor:buildViews()
	return {
		LingShenChallengeResultView.New()
	}
end

return LingShenChallengeResultViewPresentor
