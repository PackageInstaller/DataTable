-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanworkViewPresentor.lua

module("logic.extensions.richmanxplan.view.RmxplanworkViewPresentor", package.seeall)

local RmxplanworkViewPresentor = class("RmxplanworkViewPresentor", ViewPresentor)

function RmxplanworkViewPresentor:ctor()
	RmxplanworkViewPresentor.super.ctor(self)
end

function RmxplanworkViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RmxplanworkViewPresentor:dependWhatResources()
	return {
		"ui/views/richmanxplan/rmxplanworkview.prefab"
	}
end

function RmxplanworkViewPresentor:buildViews()
	return {
		RmxplanworkView.New()
	}
end

return RmxplanworkViewPresentor
