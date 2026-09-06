-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/view/miracledishitian/MiracleDiShiTianClgBuildViewPresentor.lua

module("logic.extensions.watertianyan.view.miracledishitian.MiracleDiShiTianClgBuildViewPresentor", package.seeall)

local MiracleDiShiTianClgBuildViewPresentor = class("MiracleDiShiTianClgBuildViewPresentor", ViewPresentor)

function MiracleDiShiTianClgBuildViewPresentor:ctor()
	MiracleDiShiTianClgBuildViewPresentor.super.ctor(self)
end

function MiracleDiShiTianClgBuildViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiracleDiShiTianClgBuildViewPresentor:dependWhatResources()
	return {
		"ui/views/watertianyan/miracledishitian/miracledishitianclgbuildview.prefab"
	}
end

function MiracleDiShiTianClgBuildViewPresentor:buildViews()
	return {
		MiracleDiShiTianClgBuildView.New()
	}
end

return MiracleDiShiTianClgBuildViewPresentor
