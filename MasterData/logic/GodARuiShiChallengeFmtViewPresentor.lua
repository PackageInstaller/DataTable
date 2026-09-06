-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godaruishichallenge/view/GodARuiShiChallengeFmtViewPresentor.lua

module("logic.extensions.godaruishichallenge.view.GodARuiShiChallengeFmtViewPresentor", package.seeall)

local GodARuiShiChallengeFmtViewPresentor = class("GodARuiShiChallengeFmtViewPresentor", ViewPresentor)

function GodARuiShiChallengeFmtViewPresentor:ctor()
	GodARuiShiChallengeFmtViewPresentor.super.ctor(self)
end

function GodARuiShiChallengeFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodARuiShiChallengeFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/godaruishichallenge/godaruishichallengefmtview.prefab"
	}
end

function GodARuiShiChallengeFmtViewPresentor:buildViews()
	return {
		GodARuiShiChallengeFmtView.New()
	}
end

return GodARuiShiChallengeFmtViewPresentor
