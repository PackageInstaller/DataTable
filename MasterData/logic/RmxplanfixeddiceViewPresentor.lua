-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanfixeddiceViewPresentor.lua

module("logic.extensions.richmanxplan.view.RmxplanfixeddiceViewPresentor", package.seeall)

local RmxplanfixeddiceViewPresentor = class("RmxplanfixeddiceViewPresentor", ViewPresentor)

function RmxplanfixeddiceViewPresentor:ctor()
	RmxplanfixeddiceViewPresentor.super.ctor(self)
end

function RmxplanfixeddiceViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RmxplanfixeddiceViewPresentor:dependWhatResources()
	return {
		"ui/views/richmanxplan/rmxplanfixeddiceview.prefab"
	}
end

function RmxplanfixeddiceViewPresentor:buildViews()
	return {
		RmxplanfixeddiceView.New()
	}
end

return RmxplanfixeddiceViewPresentor
