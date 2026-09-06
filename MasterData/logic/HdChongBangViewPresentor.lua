-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/HdChongBangViewPresentor.lua

module("logic.extensions.activitypopup.view.HdChongBangViewPresentor", package.seeall)

local HdChongBangViewPresentor = class("HdChongBangViewPresentor", ViewPresentor)

function HdChongBangViewPresentor:ctor()
	HdChongBangViewPresentor.super.ctor(self)
end

function HdChongBangViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HdChongBangViewPresentor:dependWhatResources()
	return {
		"ui/views/activitypopup/hdchongbangview.prefab"
	}
end

function HdChongBangViewPresentor:buildViews()
	return {
		HdChongBangView.New()
	}
end

return HdChongBangViewPresentor
