-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolystripestrengthViewPresentor.lua

module("logic.extensions.holystripe.view.HolystripestrengthViewPresentor", package.seeall)

local HolystripestrengthViewPresentor = class("HolystripestrengthViewPresentor", ViewPresentor)

function HolystripestrengthViewPresentor:ctor()
	HolystripestrengthViewPresentor.super.ctor(self)
end

function HolystripestrengthViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolystripestrengthViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripestrengthview.prefab"
	}
end

function HolystripestrengthViewPresentor:buildViews()
	return {
		HolystripestrengthView.New()
	}
end

return HolystripestrengthViewPresentor
