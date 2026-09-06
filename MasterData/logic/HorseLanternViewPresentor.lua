-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/horselantern/view/HorseLanternViewPresentor.lua

module("logic.extensions.horselantern.view.HorseLanternViewPresentor", package.seeall)

local HorseLanternViewPresentor = class("HorseLanternViewPresentor", ViewPresentor)

function HorseLanternViewPresentor:ctor()
	HorseLanternViewPresentor.super.ctor(self)
end

function HorseLanternViewPresentor:attachToWhichRoot()
	return ViewRootType.NotifyTop
end

function HorseLanternViewPresentor:dependWhatResources()
	return {
		"ui/views/horselantern/horselanternview.prefab"
	}
end

function HorseLanternViewPresentor:buildViews()
	return {
		HorseLanternView.New()
	}
end

return HorseLanternViewPresentor
