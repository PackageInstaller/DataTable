-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightrui/view/SaintKnightRuiLevelViewPresentor.lua

module("logic.extensions.saintknightrui.view.SaintKnightRuiLevelViewPresentor", package.seeall)

local SaintKnightRuiLevelViewPresentor = class("SaintKnightRuiLevelViewPresentor", ViewPresentor)

function SaintKnightRuiLevelViewPresentor:ctor()
	SaintKnightRuiLevelViewPresentor.super.ctor(self)
end

function SaintKnightRuiLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SaintKnightRuiLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknightrui/saintknightruilevelview.prefab"
	}
end

function SaintKnightRuiLevelViewPresentor:buildViews()
	return {
		SaintKnightRuiLevelView.New()
	}
end

return SaintKnightRuiLevelViewPresentor
