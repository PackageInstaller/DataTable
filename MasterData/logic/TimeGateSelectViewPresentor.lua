-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timegate/view/TimeGateSelectViewPresentor.lua

module("logic.extensions.timegate.view.TimeGateSelectViewPresentor", package.seeall)

local TimeGateSelectViewPresentor = class("TimeGateSelectViewPresentor", ViewPresentor)

function TimeGateSelectViewPresentor:ctor()
	TimeGateSelectViewPresentor.super.ctor(self)
end

function TimeGateSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TimeGateSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/timegate/timegateselectview.prefab"
	}
end

function TimeGateSelectViewPresentor:buildViews()
	return {
		TimeGateSelectView.New()
	}
end

return TimeGateSelectViewPresentor
