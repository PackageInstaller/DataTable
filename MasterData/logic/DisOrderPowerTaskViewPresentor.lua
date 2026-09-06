-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/disorderpower/view/DisOrderPowerTaskViewPresentor.lua

module("logic.extensions.disorderpower.view.DisOrderPowerTaskViewPresentor", package.seeall)

local DisOrderPowerTaskViewPresentor = class("DisOrderPowerTaskViewPresentor", ViewPresentor)

function DisOrderPowerTaskViewPresentor:ctor()
	DisOrderPowerTaskViewPresentor.super.ctor(self)
end

function DisOrderPowerTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DisOrderPowerTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/disorderpowercard/disorderpowertaskview.prefab"
	}
end

function DisOrderPowerTaskViewPresentor:buildViews()
	return {
		DisOrderPowerTaskView.New()
	}
end

return DisOrderPowerTaskViewPresentor
