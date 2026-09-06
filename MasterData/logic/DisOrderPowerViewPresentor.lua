-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/disorderpower/view/DisOrderPowerViewPresentor.lua

module("logic.extensions.disorderpower.view.DisOrderPowerViewPresentor", package.seeall)

local DisOrderPowerViewPresentor = class("DisOrderPowerViewPresentor", ViewPresentor)

function DisOrderPowerViewPresentor:ctor()
	DisOrderPowerViewPresentor.super.ctor(self)
end

function DisOrderPowerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DisOrderPowerViewPresentor:dependWhatResources()
	return {
		"ui/views/disorderpowercard/disorderpowerview.prefab"
	}
end

function DisOrderPowerViewPresentor:buildViews()
	return {
		DisOrderPowerView.New()
	}
end

return DisOrderPowerViewPresentor
