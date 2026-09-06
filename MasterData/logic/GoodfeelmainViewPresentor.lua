-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelmainViewPresentor.lua

module("logic.extensions.goodfeel.view.GoodfeelmainViewPresentor", package.seeall)

local GoodfeelmainViewPresentor = class("GoodfeelmainViewPresentor", ViewPresentor)

function GoodfeelmainViewPresentor:ctor()
	GoodfeelmainViewPresentor.super.ctor(self)
end

function GoodfeelmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoodfeelmainViewPresentor:dependWhatResources()
	return {
		"ui/views/goodfeel/goodfeelmainview.prefab"
	}
end

function GoodfeelmainViewPresentor:buildViews()
	return {
		GoodfeelmainView.New()
	}
end

return GoodfeelmainViewPresentor
