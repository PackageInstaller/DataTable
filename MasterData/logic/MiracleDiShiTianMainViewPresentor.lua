-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/view/miracledishitian/MiracleDiShiTianMainViewPresentor.lua

module("logic.extensions.watertianyan.view.miracledishitian.MiracleDiShiTianMainViewPresentor", package.seeall)

local MiracleDiShiTianMainViewPresentor = class("MiracleDiShiTianMainViewPresentor", ViewPresentor)

function MiracleDiShiTianMainViewPresentor:ctor()
	MiracleDiShiTianMainViewPresentor.super.ctor(self)
end

function MiracleDiShiTianMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiracleDiShiTianMainViewPresentor:dependWhatResources()
	return {
		"ui/views/watertianyan/miracledishitian/miracledishitianmainview.prefab"
	}
end

function MiracleDiShiTianMainViewPresentor:buildViews()
	return {
		MiracleDiShiTianMainView.New()
	}
end

return MiracleDiShiTianMainViewPresentor
