-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/view/miracledishitian/MiracleDiShiTianBuffViewPresentor.lua

module("logic.extensions.watertianyan.view.miracledishitian.MiracleDiShiTianBuffViewPresentor", package.seeall)

local MiracleDiShiTianBuffViewPresentor = class("MiracleDiShiTianBuffViewPresentor", ViewPresentor)

function MiracleDiShiTianBuffViewPresentor:ctor()
	MiracleDiShiTianBuffViewPresentor.super.ctor(self)
end

function MiracleDiShiTianBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiracleDiShiTianBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/watertianyan/miracledishitian/miracledishitianbuffview.prefab"
	}
end

function MiracleDiShiTianBuffViewPresentor:buildViews()
	return {
		MiracleDiShiTianBuffView.New()
	}
end

return MiracleDiShiTianBuffViewPresentor
