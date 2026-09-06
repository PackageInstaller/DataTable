-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingwujinlong/view/KingwujinlongmainViewPresentor.lua

module("logic.extensions.kingwujinlong.view.KingwujinlongmainViewPresentor", package.seeall)

local KingwujinlongmainViewPresentor = class("KingwujinlongmainViewPresentor", ViewPresentor)

function KingwujinlongmainViewPresentor:ctor()
	KingwujinlongmainViewPresentor.super.ctor(self)
end

function KingwujinlongmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingwujinlongmainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/kingwujinlong/kingwujinlongmainview.prefab"
	}
end

function KingwujinlongmainViewPresentor:buildViews()
	return {
		KingwujinlongmainView.New()
	}
end

return KingwujinlongmainViewPresentor
