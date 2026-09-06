-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/neverland/view/NeverLandTaskViewPresentor.lua

module("logic.extensions.neverland.view.NeverLandTaskViewPresentor", package.seeall)

local NeverLandTaskViewPresentor = class("NeverLandTaskViewPresentor", ViewPresentor)

function NeverLandTaskViewPresentor:ctor()
	NeverLandTaskViewPresentor.super.ctor(self)
end

function NeverLandTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NeverLandTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/neverland/neverlandtaskview.prefab"
	}
end

function NeverLandTaskViewPresentor:buildViews()
	return {
		NeverLandTaskView.New()
	}
end

return NeverLandTaskViewPresentor
