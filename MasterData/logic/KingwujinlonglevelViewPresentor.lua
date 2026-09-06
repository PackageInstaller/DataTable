-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingwujinlong/view/KingwujinlonglevelViewPresentor.lua

module("logic.extensions.kingwujinlong.view.KingwujinlonglevelViewPresentor", package.seeall)

local KingwujinlonglevelViewPresentor = class("KingwujinlonglevelViewPresentor", ViewPresentor)

function KingwujinlonglevelViewPresentor:ctor()
	KingwujinlonglevelViewPresentor.super.ctor(self)
end

function KingwujinlonglevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingwujinlonglevelViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/kingwujinlong/kingwujinlonglevelview.prefab"
	}
end

function KingwujinlonglevelViewPresentor:buildViews()
	return {
		KingwujinlonglevelView.New()
	}
end

return KingwujinlonglevelViewPresentor
