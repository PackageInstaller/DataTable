-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/PowerLandTaskViewPresentor.lua

module("logic.extensions.eventtasksummary.view.PowerLandTaskViewPresentor", package.seeall)

local PowerLandTaskViewPresentor = class("PowerLandTaskViewPresentor", ViewPresentor)

function PowerLandTaskViewPresentor:ctor()
	PowerLandTaskViewPresentor.super.ctor(self)
end

function PowerLandTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PowerLandTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/eventtasksummary/powerlandtaskview.prefab"
	}
end

function PowerLandTaskViewPresentor:buildViews()
	return {
		PowerLandTaskView.New()
	}
end

return PowerLandTaskViewPresentor
