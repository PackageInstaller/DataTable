-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/HdpetskinlimitViewPresentor.lua

module("logic.extensions.activitypopup.view.HdpetskinlimitViewPresentor", package.seeall)

local HdpetskinlimitViewPresentor = class("HdpetskinlimitViewPresentor", ViewPresentor)

function HdpetskinlimitViewPresentor:ctor()
	HdpetskinlimitViewPresentor.super.ctor(self)
end

function HdpetskinlimitViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HdpetskinlimitViewPresentor:dependWhatResources()
	return {
		"ui/views/activitypopup/hdpetskinlimitview.prefab"
	}
end

function HdpetskinlimitViewPresentor:buildViews()
	return {
		HdpetskinlimitView.New()
	}
end

return HdpetskinlimitViewPresentor
