-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fusionsoul/view/FusionSoulClueTipViewPresentor.lua

module("logic.extensions.fusionsoul.view.FusionSoulClueTipViewPresentor", package.seeall)

local FusionSoulClueTipViewPresentor = class("FusionSoulClueTipViewPresentor", ViewPresentor)

function FusionSoulClueTipViewPresentor:ctor()
	FusionSoulClueTipViewPresentor.super.ctor(self)
end

function FusionSoulClueTipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FusionSoulClueTipViewPresentor:dependWhatResources()
	return {
		"ui/views/fusionsoul/fusionsoulcluetipview.prefab"
	}
end

function FusionSoulClueTipViewPresentor:buildViews()
	return {
		FusionSoulClueTipView.New()
	}
end

return FusionSoulClueTipViewPresentor
