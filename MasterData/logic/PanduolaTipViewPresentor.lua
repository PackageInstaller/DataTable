-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tlctip/PanduolaTipViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.tcpanduola.PanduolaTipViewPresentor", package.seeall)

local PanduolaTipViewPresentor = class("PanduolaTipViewPresentor", ViewPresentor)

function PanduolaTipViewPresentor:ctor()
	PanduolaTipViewPresentor.super.ctor(self)
end

function PanduolaTipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PanduolaTipViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/panduolaviptipview.prefab"
	}
end

function PanduolaTipViewPresentor:buildViews()
	return {
		PanduolaTipView.New()
	}
end

return PanduolaTipViewPresentor
