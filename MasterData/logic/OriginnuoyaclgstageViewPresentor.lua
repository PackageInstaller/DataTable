-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originnuoya/view/OriginnuoyaclgstageViewPresentor.lua

module("logic.extensions.originnuoya.view.OriginnuoyaclgstageViewPresentor", package.seeall)

local OriginnuoyaclgstageViewPresentor = class("OriginnuoyaclgstageViewPresentor", ViewPresentor)

function OriginnuoyaclgstageViewPresentor:ctor()
	OriginnuoyaclgstageViewPresentor.super.ctor(self)
end

function OriginnuoyaclgstageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginnuoyaclgstageViewPresentor:dependWhatResources()
	return {
		"ui/views/originnuoya/originnuoyaclgstageview.prefab"
	}
end

function OriginnuoyaclgstageViewPresentor:buildViews()
	return {
		OriginnuoyaclgstageView.New()
	}
end

return OriginnuoyaclgstageViewPresentor
