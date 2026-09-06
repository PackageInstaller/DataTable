-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holylight/view/HolyLightMainViewPresentor.lua

module("logic.extensions.holylight.view.DoDragonChallengeMainViewPresentor", package.seeall)

local DoDragonChallengeMainViewPresentor = class("DoDragonChallengeMainViewPresentor", ViewPresentor)

function DoDragonChallengeMainViewPresentor:ctor()
	DoDragonChallengeMainViewPresentor.super.ctor(self)
end

function DoDragonChallengeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DoDragonChallengeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/holylight/holylightmainview.prefab"
	}
end

function DoDragonChallengeMainViewPresentor:buildViews()
	return {
		HolyLightMainView.New()
	}
end

return DoDragonChallengeMainViewPresentor
