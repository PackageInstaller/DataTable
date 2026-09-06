-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanmappreViewPresentor.lua

module("logic.extensions.richmanxplan.view.RmxplanmappreViewPresentor", package.seeall)

local RmxplanmappreViewPresentor = class("RmxplanmappreViewPresentor", ViewPresentor)

function RmxplanmappreViewPresentor:ctor()
	RmxplanmappreViewPresentor.super.ctor(self)
end

function RmxplanmappreViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RmxplanmappreViewPresentor:dependWhatResources()
	return {
		"ui/views/richmanxplan/rmxplanmappreview.prefab"
	}
end

function RmxplanmappreViewPresentor:buildViews()
	return {
		RmxplanmappreView.New()
	}
end

return RmxplanmappreViewPresentor
