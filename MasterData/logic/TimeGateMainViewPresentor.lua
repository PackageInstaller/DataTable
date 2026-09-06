-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timegate/view/TimeGateMainViewPresentor.lua

module("logic.extensions.timegate.view.TimeGateMainViewPresentor", package.seeall)

local TimeGateMainViewPresentor = class("TimeGateMainViewPresentor", ViewPresentor)

function TimeGateMainViewPresentor:ctor()
	TimeGateMainViewPresentor.super.ctor(self)
end

function TimeGateMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TimeGateMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timegate/timegatemainview.prefab"
	}
end

function TimeGateMainViewPresentor:buildViews()
	return {
		TimeGateMainView.New()
	}
end

return TimeGateMainViewPresentor
