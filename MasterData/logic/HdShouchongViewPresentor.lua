-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/HdShouchongViewPresentor.lua

module("logic.extensions.activitypopup.view.HdShouchongViewPresentor", package.seeall)

local HdShouchongViewPresentor = class("HdShouchongViewPresentor", ViewPresentor)

function HdShouchongViewPresentor:ctor()
	HdShouchongViewPresentor.super.ctor(self)
end

function HdShouchongViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HdShouchongViewPresentor:dependWhatResources()
	return {
		"ui/views/activitypopup/hdshouchongview.prefab"
	}
end

function HdShouchongViewPresentor:buildViews()
	return {
		HdShouchongView.New()
	}
end

return HdShouchongViewPresentor
