-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lingshenchallenge/view/LingShenChallengeAddTipViewPresentor.lua

module("logic.extensions.lingshenchallenge.view.LingShenChallengeAddTipViewPresentor", package.seeall)

local LingShenChallengeAddTipViewPresentor = class("LingShenChallengeAddTipViewPresentor", ViewPresentor)

function LingShenChallengeAddTipViewPresentor:ctor()
	LingShenChallengeAddTipViewPresentor.super.ctor(self)
end

function LingShenChallengeAddTipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LingShenChallengeAddTipViewPresentor:dependWhatResources()
	return {
		"ui/views/lingshenchallenge/lingshenchallengeaddtipview.prefab"
	}
end

function LingShenChallengeAddTipViewPresentor:buildViews()
	return {
		LingShenChallengeAddTipView.New()
	}
end

return LingShenChallengeAddTipViewPresentor
