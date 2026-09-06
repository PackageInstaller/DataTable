-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenevent/view/JieShenEventPlaceViewPresentor.lua

module("logic.extensions.jieshenevent.view.JieShenEventPlaceViewPresentor", package.seeall)

local JieShenEventPlaceViewPresentor = class("JieShenEventPlaceViewPresentor", ViewPresentor)

function JieShenEventPlaceViewPresentor:ctor()
	JieShenEventPlaceViewPresentor.super.ctor(self)
end

function JieShenEventPlaceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JieShenEventPlaceViewPresentor:dependWhatResources()
	return {
		"ui/views/jieshenevent/jiesheneventplaceview.prefab"
	}
end

function JieShenEventPlaceViewPresentor:buildViews()
	return {
		JieShenEventPlaceView.New()
	}
end

return JieShenEventPlaceViewPresentor
