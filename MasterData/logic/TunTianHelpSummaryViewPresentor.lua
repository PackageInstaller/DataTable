-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tuntianhelp/view/TunTianHelpSummaryViewPresentor.lua

module("logic.extensions.tuntianhelp.view.TunTianHelpSummaryViewPresentor", package.seeall)

local TunTianHelpSummaryViewPresentor = class("TunTianHelpSummaryViewPresentor", ViewPresentor)

function TunTianHelpSummaryViewPresentor:ctor()
	TunTianHelpSummaryViewPresentor.super.ctor(self)
end

function TunTianHelpSummaryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TunTianHelpSummaryViewPresentor:dependWhatResources()
	return {
		"ui/views/tuntianhelp/tuntianhelpsummaryview.prefab"
	}
end

function TunTianHelpSummaryViewPresentor:buildViews()
	return {
		TunTianHelpSummaryView.New()
	}
end

return TunTianHelpSummaryViewPresentor
