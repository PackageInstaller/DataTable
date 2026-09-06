-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cloudcutfan/view/CloudCutFanMakeViewPresentor.lua

module("logic.extensions.cloudcutfan.view.CloudCutFanMakeViewPresentor", package.seeall)

local CloudCutFanMakeViewPresentor = class("CloudCutFanMakeViewPresentor", ViewPresentor)

function CloudCutFanMakeViewPresentor:ctor()
	CloudCutFanMakeViewPresentor.super.ctor(self)
end

function CloudCutFanMakeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CloudCutFanMakeViewPresentor:dependWhatResources()
	return {
		"ui/views/cloudcutfan/cloudcutfanmakeview.prefab"
	}
end

function CloudCutFanMakeViewPresentor:buildViews()
	return {
		CloudCutFanMakeView.New()
	}
end

return CloudCutFanMakeViewPresentor
