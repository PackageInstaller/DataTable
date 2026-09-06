-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/view/miracledishitian/MiracleDiShiTianTipViewPresentor.lua

module("logic.extensions.watertianyan.view.miracledishitian.MiracleDiShiTianTipViewPresentor", package.seeall)

local MiracleDiShiTianTipViewPresentor = class("MiracleDiShiTianTipViewPresentor", ViewPresentor)

function MiracleDiShiTianTipViewPresentor:ctor()
	MiracleDiShiTianTipViewPresentor.super.ctor(self)
end

function MiracleDiShiTianTipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiracleDiShiTianTipViewPresentor:dependWhatResources()
	return {
		"ui/views/watertianyan/miracledishitian/miracledishitiantipview.prefab"
	}
end

function MiracleDiShiTianTipViewPresentor:buildViews()
	return {
		MiracleDiShiTianTipView.New()
	}
end

return MiracleDiShiTianTipViewPresentor
