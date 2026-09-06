-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/WaterdarktowerpasstipViewPresentor.lua

module("logic.extensions.waterdraktower.view.WaterdarktowerpasstipViewPresentor", package.seeall)

local WaterdarktowerpasstipViewPresentor = class("WaterdarktowerpasstipViewPresentor", ViewPresentor)

function WaterdarktowerpasstipViewPresentor:ctor()
	WaterdarktowerpasstipViewPresentor.super.ctor(self)
end

function WaterdarktowerpasstipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function WaterdarktowerpasstipViewPresentor:dependWhatResources()
	return {
		"ui/views/waterdraktower/waterdarktowerpasstipview.prefab"
	}
end

function WaterdarktowerpasstipViewPresentor:buildViews()
	return {
		WaterdarktowerpasstipView.New()
	}
end

return WaterdarktowerpasstipViewPresentor
