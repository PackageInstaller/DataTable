-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starhall/view/StarHallFmtExViewPresentor.lua

module("logic.extensions.starhall.view.StarHallFmtExViewPresentor", package.seeall)

local StarHallFmtExViewPresentor = class("StarHallFmtExViewPresentor", ViewPresentor)

function StarHallFmtExViewPresentor:ctor()
	StarHallFmtExViewPresentor.super.ctor(self)
end

function StarHallFmtExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StarHallFmtExViewPresentor:dependWhatResources()
	return {
		"ui/views/starhall/starhallfmtexview.prefab"
	}
end

function StarHallFmtExViewPresentor:buildViews()
	return {
		StarHallFmtExView.New()
	}
end

return StarHallFmtExViewPresentor
