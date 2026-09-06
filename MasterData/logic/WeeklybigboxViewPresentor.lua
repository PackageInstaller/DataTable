-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weeklybigbox/view/WeeklybigboxViewPresentor.lua

module("logic.extensions.weeklybigbox.view.WeeklybigboxViewPresentor", package.seeall)

local WeeklybigboxViewPresentor = class("WeeklybigboxViewPresentor", ViewPresentor)

function WeeklybigboxViewPresentor:ctor()
	WeeklybigboxViewPresentor.super.ctor(self)
end

function WeeklybigboxViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WeeklybigboxViewPresentor:dependWhatResources()
	return {
		"ui/views/weeklybigbox/weeklybigboxview.prefab"
	}
end

function WeeklybigboxViewPresentor:buildViews()
	return {
		WeeklyBigBoxView.New()
	}
end

return WeeklybigboxViewPresentor
