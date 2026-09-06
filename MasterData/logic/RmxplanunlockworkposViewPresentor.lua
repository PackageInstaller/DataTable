-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanunlockworkposViewPresentor.lua

module("logic.extensions.richmanxplan.view.RmxplanunlockworkposViewPresentor", package.seeall)

local RmxplanunlockworkposViewPresentor = class("RmxplanunlockworkposViewPresentor", ViewPresentor)

function RmxplanunlockworkposViewPresentor:ctor()
	RmxplanunlockworkposViewPresentor.super.ctor(self)
end

function RmxplanunlockworkposViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RmxplanunlockworkposViewPresentor:dependWhatResources()
	return {
		"ui/views/richmanxplan/rmxplanunlockworkposview.prefab"
	}
end

function RmxplanunlockworkposViewPresentor:buildViews()
	return {
		RmxplanunlockworkposView.New()
	}
end

return RmxplanunlockworkposViewPresentor
