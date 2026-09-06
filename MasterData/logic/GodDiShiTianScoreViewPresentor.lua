-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddishitian/view/GodDiShiTianScoreViewPresentor.lua

module("logic.extensions.goddishitian.view.GodDiShiTianScoreViewPresentor", package.seeall)

local GodDiShiTianScoreViewPresentor = class("GodDiShiTianScoreViewPresentor", ViewPresentor)

function GodDiShiTianScoreViewPresentor:ctor()
	GodDiShiTianScoreViewPresentor.super.ctor(self)
end

function GodDiShiTianScoreViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodDiShiTianScoreViewPresentor:dependWhatResources()
	return {
		"ui/views/goddishitian/goddishitianscoreview.prefab"
	}
end

function GodDiShiTianScoreViewPresentor:buildViews()
	return {
		GodDiShiTianScoreView.New()
	}
end

return GodDiShiTianScoreViewPresentor
