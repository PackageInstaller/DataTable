-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/snowmancar/view/SnowManCarMainViewPresentor.lua

module("logic.extensions.snowmancar.view.SnowManCarMainViewPresentor", package.seeall)

local SnowManCarMainViewPresentor = class("SnowManCarMainViewPresentor", ViewPresentor)

function SnowManCarMainViewPresentor:ctor()
	SnowManCarMainViewPresentor.super.ctor(self)
end

function SnowManCarMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SnowManCarMainViewPresentor:dependWhatResources()
	return {
		"ui/views/snowmancar/snowmancarmainview.prefab"
	}
end

function SnowManCarMainViewPresentor:buildViews()
	return {
		SnowManCarMainView.New()
	}
end

return SnowManCarMainViewPresentor
