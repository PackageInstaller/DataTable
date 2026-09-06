-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/disorderpower/view/DisOrderPowerTaskChildViewPresentor.lua

module("logic.extensions.disorderpower.view.DisOrderPowerTaskChildViewPresentor", package.seeall)

local DisOrderPowerTaskChildViewPresentor = class("DisOrderPowerTaskChildViewPresentor", ViewPresentor)

function DisOrderPowerTaskChildViewPresentor:ctor()
	DisOrderPowerTaskChildViewPresentor.super.ctor(self)
end

function DisOrderPowerTaskChildViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DisOrderPowerTaskChildViewPresentor:dependWhatResources()
	return {
		"ui/views/disorderpowercard/disorderpowertaskchildview.prefab"
	}
end

function DisOrderPowerTaskChildViewPresentor:buildViews()
	return {
		DisOrderPowerTaskChildView.New()
	}
end

return DisOrderPowerTaskChildViewPresentor
