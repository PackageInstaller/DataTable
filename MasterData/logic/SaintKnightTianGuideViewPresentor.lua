-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttian/view/SaintKnightTianGuideViewPresentor.lua

module("logic.extensions.saintknighttian.view.SaintKnightTianGuideViewPresentor", package.seeall)

local SaintKnightTianGuideViewPresentor = class("SaintKnightTianGuideViewPresentor", ViewPresentor)

function SaintKnightTianGuideViewPresentor:ctor()
	SaintKnightTianGuideViewPresentor.super.ctor(self)
end

function SaintKnightTianGuideViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SaintKnightTianGuideViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknighttian/saintknighttianguideview.prefab"
	}
end

function SaintKnightTianGuideViewPresentor:buildViews()
	return {
		SaintKnightTianGuideView.New()
	}
end

return SaintKnightTianGuideViewPresentor
