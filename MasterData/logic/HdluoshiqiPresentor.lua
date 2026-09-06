-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/actview/HdluoshiqiPresentor.lua

module("logic.extensions.activitypopup.view.actview.HdluoshiqiPresentor", package.seeall)

local HdluoshiqiPresentor = class("HdluoshiqiPresentor", ViewPresentor)

function HdluoshiqiPresentor:ctor()
	HdluoshiqiPresentor.super.ctor(self)
end

function HdluoshiqiPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HdluoshiqiPresentor:dependWhatResources()
	return {
		"ui/views/activitypopup/hdluoshiqiview.prefab"
	}
end

function HdluoshiqiPresentor:buildViews()
	return {
		HdluoshiqiView.New()
	}
end

return HdluoshiqiPresentor
