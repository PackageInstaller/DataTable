-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/view/miracledishitian/MiracleDiShiTianClgMainViewPresentor.lua

module("logic.extensions.watertianyan.view.miracledishitian.MiracleDiShiTianClgMainViewPresentor", package.seeall)

local MiracleDiShiTianClgMainViewPresentor = class("MiracleDiShiTianClgMainViewPresentor", ViewPresentor)

function MiracleDiShiTianClgMainViewPresentor:ctor()
	MiracleDiShiTianClgMainViewPresentor.super.ctor(self)
end

function MiracleDiShiTianClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiracleDiShiTianClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/watertianyan/miracledishitian/miracledishitianclgmainview.prefab"
	}
end

function MiracleDiShiTianClgMainViewPresentor:buildViews()
	return {
		MiracleDiShiTianClgMainView.New()
	}
end

return MiracleDiShiTianClgMainViewPresentor
