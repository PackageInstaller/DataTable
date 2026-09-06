-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanconveytipViewPresentor.lua

module("logic.extensions.richmanxplan.view.RmxplanconveytipViewPresentor", package.seeall)

local RmxplanconveytipViewPresentor = class("RmxplanconveytipViewPresentor", ViewPresentor)

function RmxplanconveytipViewPresentor:ctor()
	RmxplanconveytipViewPresentor.super.ctor(self)
end

function RmxplanconveytipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RmxplanconveytipViewPresentor:dependWhatResources()
	return {
		"ui/views/richmanxplan/rmxplanconveytipview.prefab"
	}
end

function RmxplanconveytipViewPresentor:buildViews()
	return {
		RmxplanconveytipView.New()
	}
end

return RmxplanconveytipViewPresentor
