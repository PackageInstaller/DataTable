-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalfarm/view/EternalFarmTaskViewPresentor.lua

module("logic.extensions.eternalfarm.view.EternalFarmTaskViewPresentor", package.seeall)

local EternalFarmTaskViewPresentor = class("EternalFarmTaskViewPresentor", ViewPresentor)

function EternalFarmTaskViewPresentor:ctor()
	EternalFarmTaskViewPresentor.super.ctor(self)
end

function EternalFarmTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function EternalFarmTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/eternalfarm/eternalfarmtaskview.prefab"
	}
end

function EternalFarmTaskViewPresentor:buildViews()
	return {
		EternalFarmTaskView.New()
	}
end

return EternalFarmTaskViewPresentor
