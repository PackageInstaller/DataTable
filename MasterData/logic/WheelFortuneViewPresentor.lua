-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wheelfortune/view/WheelFortuneViewPresentor.lua

module("logic.extensions.wheelfortune.view.WheelFortuneViewPresentor", package.seeall)

local WheelFortuneViewPresentor = class("WheelFortuneViewPresentor", ViewPresentor)

function WheelFortuneViewPresentor:ctor()
	WheelFortuneViewPresentor.super.ctor(self)
end

function WheelFortuneViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WheelFortuneViewPresentor:dependWhatResources()
	return {
		"ui/views/wheelfortune/wheelfortuneview.prefab"
	}
end

function WheelFortuneViewPresentor:buildViews()
	return {
		WheelFortuneView.New()
	}
end

return WheelFortuneViewPresentor
