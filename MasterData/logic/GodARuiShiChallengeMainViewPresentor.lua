-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godaruishichallenge/view/GodARuiShiChallengeMainViewPresentor.lua

module("logic.extensions.godaruishichallenge.view.GodARuiShiChallengeMainViewPresentor", package.seeall)

local GodARuiShiChallengeMainViewPresentor = class("GodARuiShiChallengeMainViewPresentor", ViewPresentor)

function GodARuiShiChallengeMainViewPresentor:ctor()
	GodARuiShiChallengeMainViewPresentor.super.ctor(self)
end

function GodARuiShiChallengeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodARuiShiChallengeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/godaruishichallenge/godaruishichallengemainview.prefab"
	}
end

function GodARuiShiChallengeMainViewPresentor:buildViews()
	return {
		GodARuiShiChallengeMainView.New()
	}
end

return GodARuiShiChallengeMainViewPresentor
