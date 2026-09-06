-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightrui/view/SaintKnightRuiMainViewPresentor.lua

module("logic.extensions.saintknightrui.view.SaintKnightRuiMainViewPresentor", package.seeall)

local SaintKnightRuiMainViewPresentor = class("SaintKnightRuiMainViewPresentor", ViewPresentor)

function SaintKnightRuiMainViewPresentor:ctor()
	SaintKnightRuiMainViewPresentor.super.ctor(self)
end

function SaintKnightRuiMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SaintKnightRuiMainViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknightrui/saintknightruimainview.prefab"
	}
end

function SaintKnightRuiMainViewPresentor:buildViews()
	return {
		SaintKnightRuiMainView.New()
	}
end

return SaintKnightRuiMainViewPresentor
