-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanpetsViewPresentor.lua

module("logic.extensions.richmanxplan.view.RmxplanpetsViewPresentor", package.seeall)

local RmxplanpetsViewPresentor = class("RmxplanpetsViewPresentor", ViewPresentor)

function RmxplanpetsViewPresentor:ctor()
	RmxplanpetsViewPresentor.super.ctor(self)
end

function RmxplanpetsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RmxplanpetsViewPresentor:dependWhatResources()
	return {
		"ui/views/richmanxplan/rmxplanpetsview.prefab"
	}
end

function RmxplanpetsViewPresentor:buildViews()
	return {
		RmxplanpetsView.New()
	}
end

return RmxplanpetsViewPresentor
