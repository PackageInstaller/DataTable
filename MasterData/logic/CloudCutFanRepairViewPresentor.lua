-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cloudcutfan/view/CloudCutFanRepairViewPresentor.lua

module("logic.extensions.cloudcutfan.view.CloudCutFanRepairViewPresentor", package.seeall)

local CloudCutFanRepairViewPresentor = class("CloudCutFanRepairViewPresentor", ViewPresentor)

function CloudCutFanRepairViewPresentor:ctor()
	CloudCutFanRepairViewPresentor.super.ctor(self)
end

function CloudCutFanRepairViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CloudCutFanRepairViewPresentor:dependWhatResources()
	return {
		"ui/views/cloudcutfan/cloudcutfanrepairview.prefab"
	}
end

function CloudCutFanRepairViewPresentor:buildViews()
	return {
		CloudCutFanRepairView.New()
	}
end

return CloudCutFanRepairViewPresentor
