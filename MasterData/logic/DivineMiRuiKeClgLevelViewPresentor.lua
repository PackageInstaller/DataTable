-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemiruikeclg/view/DivineMiRuiKeClgLevelViewPresentor.lua

module("logic.extensions.divinemiruikeclg.view.DivineMiRuiKeClgLevelViewPresentor", package.seeall)

local DivineMiRuiKeClgLevelViewPresentor = class("DivineMiRuiKeClgLevelViewPresentor", ViewPresentor)

function DivineMiRuiKeClgLevelViewPresentor:ctor()
	DivineMiRuiKeClgLevelViewPresentor.super.ctor(self)
end

function DivineMiRuiKeClgLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineMiRuiKeClgLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/divinemiruikeclg/divinemiruikeclglevelview.prefab"
	}
end

function DivineMiRuiKeClgLevelViewPresentor:buildViews()
	return {
		DivineMiRuiKeClgLevelView.New()
	}
end

return DivineMiRuiKeClgLevelViewPresentor
