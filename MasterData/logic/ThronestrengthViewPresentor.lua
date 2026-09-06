-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throne/view/ThronestrengthViewPresentor.lua

module("logic.extensions.throne.view.ThronestrengthViewPresentor", package.seeall)

local ThronestrengthViewPresentor = class("ThronestrengthViewPresentor", ViewWithGuidePresentor)

function ThronestrengthViewPresentor:ctor()
	ThronestrengthViewPresentor.super.ctor(self)
end

function ThronestrengthViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ThronestrengthViewPresentor:dependWhatResources()
	return {
		"ui/views/throne/thronestrengthview.prefab"
	}
end

function ThronestrengthViewPresentor:buildViews()
	return {
		ThronestrengthView.New()
	}
end

return ThronestrengthViewPresentor
