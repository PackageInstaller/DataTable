-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tcpanduola/PanduolamainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.tcpanduola.PanduolamainViewPresentor", package.seeall)

local PanduolamainViewPresentor = class("PanduolamainViewPresentor", ViewPresentor)

function PanduolamainViewPresentor:ctor()
	PanduolamainViewPresentor.super.ctor(self)
end

function PanduolamainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PanduolamainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/panduolamainview.prefab"
	}
end

function PanduolamainViewPresentor:buildViews()
	return {
		PanduolamainView.New()
	}
end

return PanduolamainViewPresentor
