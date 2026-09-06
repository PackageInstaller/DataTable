-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripecopy/view/HolyStripeCopyChallengeViewPresentor.lua

module("logic.extensions.holystripecopy.view.HolyStripeCopyChallengeViewPresentor", package.seeall)

local HolyStripeCopyChallengeViewPresentor = class("HolyStripeCopyChallengeViewPresentor", ViewPresentor)

function HolyStripeCopyChallengeViewPresentor:ctor()
	HolyStripeCopyChallengeViewPresentor.super.ctor(self)
end

function HolyStripeCopyChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyStripeCopyChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripecopy/holystripecopychallengeview.prefab"
	}
end

function HolyStripeCopyChallengeViewPresentor:buildViews()
	return {
		HolyStripeCopyChallengeView.New()
	}
end

return HolyStripeCopyChallengeViewPresentor
