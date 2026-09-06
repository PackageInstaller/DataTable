-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/HdNvWuShenViewPresentor.lua

module("logic.extensions.activitypopup.view.HdNvWuShenViewPresentor", package.seeall)

local HdNvWuShenViewPresentor = class("HdNvWuShenViewPresentor", ViewPresentor)

function HdNvWuShenViewPresentor:ctor()
	HdNvWuShenViewPresentor.super.ctor(self)
end

function HdNvWuShenViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HdNvWuShenViewPresentor:dependWhatResources()
	return {
		"ui/views/activitypopup/hdnvwushenview.prefab"
	}
end

function HdNvWuShenViewPresentor:buildViews()
	return {
		HdNvWuShenView.New()
	}
end

return HdNvWuShenViewPresentor
