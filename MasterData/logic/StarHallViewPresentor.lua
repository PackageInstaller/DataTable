-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starhall/view/StarHallViewPresentor.lua

module("logic.extensions.starhall.view.StarHallViewPresentor", package.seeall)

local StarHallViewPresentor = class("StarHallViewPresentor", ViewPresentor)

function StarHallViewPresentor:ctor()
	StarHallViewPresentor.super.ctor(self)
end

function StarHallViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StarHallViewPresentor:dependWhatResources()
	return {
		"ui/views/starhall/starhallview.prefab"
	}
end

function StarHallViewPresentor:buildViews()
	return {
		StarHallView.New()
	}
end

return StarHallViewPresentor
