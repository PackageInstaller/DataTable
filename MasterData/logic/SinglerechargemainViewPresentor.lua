-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/singlerecharge/view/SinglerechargemainViewPresentor.lua

module("logic.extensions.twunique.singlerecharge.view.SinglerechargemainViewPresentor", package.seeall)

local SinglerechargemainViewPresentor = class("SinglerechargemainViewPresentor", ViewPresentor)

function SinglerechargemainViewPresentor:ctor()
	SinglerechargemainViewPresentor.super.ctor(self)
end

function SinglerechargemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SinglerechargemainViewPresentor:dependWhatResources()
	return {
		"ui/views/singlerecharge/singlerechargemainview.prefab"
	}
end

function SinglerechargemainViewPresentor:buildViews()
	return {
		SinglerechargemainView.New()
	}
end

return SinglerechargemainViewPresentor
