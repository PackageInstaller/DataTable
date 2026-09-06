-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lionculture/view/LionculturestartViewPresentor.lua

module("logic.extensions.lionculture.view.LionculturestartViewPresentor", package.seeall)

local LionculturestartViewPresentor = class("LionculturestartViewPresentor", ViewPresentor)

function LionculturestartViewPresentor:ctor()
	LionculturestartViewPresentor.super.ctor(self)
end

function LionculturestartViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LionculturestartViewPresentor:dependWhatResources()
	return {
		"ui/views/lionculture/lionculturestartview.prefab"
	}
end

function LionculturestartViewPresentor:buildViews()
	return {
		LionculturestartView.New()
	}
end

return LionculturestartViewPresentor
