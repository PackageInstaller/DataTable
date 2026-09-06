-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingwujinlong/view/KingwujinlongbuffViewPresentor.lua

module("logic.extensions.kingwujinlong.view.KingwujinlongbuffViewPresentor", package.seeall)

local KingwujinlongbuffViewPresentor = class("KingwujinlongbuffViewPresentor", ViewPresentor)

function KingwujinlongbuffViewPresentor:ctor()
	KingwujinlongbuffViewPresentor.super.ctor(self)
end

function KingwujinlongbuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingwujinlongbuffViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/kingwujinlong/kingwujinlongbuffview.prefab"
	}
end

function KingwujinlongbuffViewPresentor:buildViews()
	return {
		KingwujinlongbuffView.New()
	}
end

return KingwujinlongbuffViewPresentor
