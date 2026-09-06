-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/snowmancar/view/SnowManCarGameViewPresentor.lua

module("logic.extensions.snowmancar.view.SnowManCarGameViewPresentor", package.seeall)

local SnowManCarGameViewPresentor = class("SnowManCarGameViewPresentor", ViewPresentor)

function SnowManCarGameViewPresentor:ctor()
	SnowManCarGameViewPresentor.super.ctor(self)
end

function SnowManCarGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SnowManCarGameViewPresentor:dependWhatResources()
	return {
		"ui/views/snowmancar/snowmancargameview.prefab"
	}
end

function SnowManCarGameViewPresentor:buildViews()
	return {
		SnowManCarGameView.New()
	}
end

return SnowManCarGameViewPresentor
