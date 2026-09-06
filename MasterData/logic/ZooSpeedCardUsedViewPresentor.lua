-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooSpeedCardUsedViewPresentor.lua

module("logic.extensions.zoo.view.ZooSpeedCardUsedViewPresentor", package.seeall)

local ZooSpeedCardUsedViewPresentor = class("ZooSpeedCardUsedViewPresentor", ViewPresentor)

function ZooSpeedCardUsedViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ZooSpeedCardUsedViewPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zoospeedusedview.prefab"
	}
end

function ZooSpeedCardUsedViewPresentor:buildViews()
	return {
		ZooSpeedCardUsedView.New()
	}
end

return ZooSpeedCardUsedViewPresentor
