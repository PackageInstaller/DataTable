-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanratebuffViewPresentor.lua

module("logic.extensions.richmanxplan.view.RmxplanratebuffViewPresentor", package.seeall)

local RmxplanratebuffViewPresentor = class("RmxplanratebuffViewPresentor", ViewPresentor)

function RmxplanratebuffViewPresentor:ctor()
	RmxplanratebuffViewPresentor.super.ctor(self)
end

function RmxplanratebuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RmxplanratebuffViewPresentor:dependWhatResources()
	return {
		"ui/views/richmanxplan/rmxplanratebuffview.prefab"
	}
end

function RmxplanratebuffViewPresentor:buildViews()
	return {
		RmxplanratebuffView.New()
	}
end

return RmxplanratebuffViewPresentor
