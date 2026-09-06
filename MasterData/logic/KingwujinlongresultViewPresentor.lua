-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingwujinlong/view/KingwujinlongresultViewPresentor.lua

module("logic.extensions.kingwujinlong.view.KingwujinlongresultViewPresentor", package.seeall)

local KingwujinlongresultViewPresentor = class("KingwujinlongresultViewPresentor", ViewPresentor)

function KingwujinlongresultViewPresentor:ctor()
	KingwujinlongresultViewPresentor.super.ctor(self)
end

function KingwujinlongresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingwujinlongresultViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/kingwujinlong/kingwujinlongresultview.prefab"
	}
end

function KingwujinlongresultViewPresentor:buildViews()
	return {
		KingwujinlongresultView.New()
	}
end

return KingwujinlongresultViewPresentor
