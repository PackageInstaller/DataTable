-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cloudcutfan/view/CloudCutFanMainViewPresentor.lua

module("logic.extensions.cloudcutfan.view.CloudCutFanMainViewPresentor", package.seeall)

local CloudCutFanMainViewPresentor = class("CloudCutFanMainViewPresentor", ViewPresentor)

function CloudCutFanMainViewPresentor:ctor()
	CloudCutFanMainViewPresentor.super.ctor(self)
end

function CloudCutFanMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CloudCutFanMainViewPresentor:dependWhatResources()
	return {
		"ui/views/cloudcutfan/cloudcutfanmainview.prefab"
	}
end

function CloudCutFanMainViewPresentor:buildViews()
	return {
		CloudCutFanMainView.New()
	}
end

return CloudCutFanMainViewPresentor
