-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/FomationactiveViewPresentor.lua

module("logic.extensions.nineplace.view.FomationactiveViewPresentor", package.seeall)

local FomationactiveViewPresentor = class("FomationactiveViewPresentor", ViewPresentor)

function FomationactiveViewPresentor:ctor()
	FomationactiveViewPresentor.super.ctor(self)
end

function FomationactiveViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function FomationactiveViewPresentor:dependWhatResources()
	return {
		"ui/views/nineplace/fomationactiveview.prefab"
	}
end

function FomationactiveViewPresentor:buildViews()
	return {
		FomationactiveView.New()
	}
end

return FomationactiveViewPresentor
