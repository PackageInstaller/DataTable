-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originnuoya/view/OriginnuoyaclgmainViewPresentor.lua

module("logic.extensions.originnuoya.view.OriginnuoyaclgmainViewPresentor", package.seeall)

local OriginnuoyaclgmainViewPresentor = class("OriginnuoyaclgmainViewPresentor", ViewPresentor)

function OriginnuoyaclgmainViewPresentor:ctor()
	OriginnuoyaclgmainViewPresentor.super.ctor(self)
end

function OriginnuoyaclgmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginnuoyaclgmainViewPresentor:dependWhatResources()
	return {
		"ui/views/originnuoya/originnuoyaclgmainview.prefab"
	}
end

function OriginnuoyaclgmainViewPresentor:buildViews()
	return {
		OriginnuoyaclgmainView.New()
	}
end

return OriginnuoyaclgmainViewPresentor
