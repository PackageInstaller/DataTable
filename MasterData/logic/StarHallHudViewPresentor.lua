-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starhall/view/StarHallHudViewPresentor.lua

module("logic.extensions.starhall.view.StarHallHudViewPresentor", package.seeall)

local StarHallHudViewPresentor = class("StarHallHudViewPresentor", ViewPresentor)

function StarHallHudViewPresentor:ctor()
	StarHallHudViewPresentor.super.ctor(self)
end

function StarHallHudViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StarHallHudViewPresentor:dependWhatResources()
	return {
		"ui/views/starhall/starhallhudview.prefab"
	}
end

function StarHallHudViewPresentor:buildViews()
	return {
		StarHallHudView.New()
	}
end

return StarHallHudViewPresentor
