-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pingame/view/PinGameTypeThreeViewPresentor.lua

module("logic.extensions.pingame.view.PinGameTypeThreeViewPresentor", package.seeall)

local PinGameTypeThreeViewPresentor = class("PinGameTypeThreeViewPresentor", ViewPresentor)

function PinGameTypeThreeViewPresentor:ctor()
	PinGameTypeThreeViewPresentor.super.ctor(self)
end

function PinGameTypeThreeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PinGameTypeThreeViewPresentor:dependWhatResources()
	return {
		"ui/views/pingame/pingametypethreeview.prefab"
	}
end

function PinGameTypeThreeViewPresentor:buildViews()
	return {
		PinGameTypeThreeView.New()
	}
end

return PinGameTypeThreeViewPresentor
