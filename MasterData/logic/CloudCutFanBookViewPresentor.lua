-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cloudcutfan/view/CloudCutFanBookViewPresentor.lua

module("logic.extensions.cloudcutfan.view.CloudCutFanBookViewPresentor", package.seeall)

local CloudCutFanBookViewPresentor = class("CloudCutFanBookViewPresentor", ViewPresentor)

function CloudCutFanBookViewPresentor:ctor()
	CloudCutFanBookViewPresentor.super.ctor(self)
end

function CloudCutFanBookViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CloudCutFanBookViewPresentor:dependWhatResources()
	return {
		"ui/views/cloudcutfan/cloudcutfanbookview.prefab"
	}
end

function CloudCutFanBookViewPresentor:buildViews()
	return {
		CloudCutFanBookView.New()
	}
end

return CloudCutFanBookViewPresentor
