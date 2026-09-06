-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingwujinlong/view/KingwujinlonglockViewPresentor.lua

module("logic.extensions.kingwujinlong.view.KingwujinlonglockViewPresentor", package.seeall)

local KingwujinlonglockViewPresentor = class("KingwujinlonglockViewPresentor", ViewPresentor)

function KingwujinlonglockViewPresentor:ctor()
	KingwujinlonglockViewPresentor.super.ctor(self)
end

function KingwujinlonglockViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingwujinlonglockViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/kingwujinlong/kingwujinlonglockview.prefab"
	}
end

function KingwujinlonglockViewPresentor:buildViews()
	return {
		KingwujinlonglockView.New()
	}
end

return KingwujinlonglockViewPresentor
