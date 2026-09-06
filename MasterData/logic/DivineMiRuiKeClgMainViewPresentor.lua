-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemiruikeclg/view/DivineMiRuiKeClgMainViewPresentor.lua

module("logic.extensions.divinemiruikeclg.view.DivineMiRuiKeClgMainViewPresentor", package.seeall)

local DivineMiRuiKeClgMainViewPresentor = class("DivineMiRuiKeClgMainViewPresentor", ViewPresentor)

function DivineMiRuiKeClgMainViewPresentor:ctor()
	DivineMiRuiKeClgMainViewPresentor.super.ctor(self)
end

function DivineMiRuiKeClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineMiRuiKeClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinemiruikeclg/divinemiruikeclgmainview.prefab"
	}
end

function DivineMiRuiKeClgMainViewPresentor:buildViews()
	return {
		DivineMiRuiKeClgMainView.New()
	}
end

return DivineMiRuiKeClgMainViewPresentor
