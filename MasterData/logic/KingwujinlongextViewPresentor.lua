-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingwujinlong/view/KingwujinlongextViewPresentor.lua

module("logic.extensions.kingwujinlong.view.KingwujinlongextViewPresentor", package.seeall)

local KingwujinlongextViewPresentor = class("KingwujinlongextViewPresentor", ViewPresentor)

function KingwujinlongextViewPresentor:ctor()
	KingwujinlongextViewPresentor.super.ctor(self)
end

function KingwujinlongextViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingwujinlongextViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/kingwujinlong/kingwujinlongextview.prefab"
	}
end

function KingwujinlongextViewPresentor:buildViews()
	return {
		KingwujinlongextView.New()
	}
end

return KingwujinlongextViewPresentor
