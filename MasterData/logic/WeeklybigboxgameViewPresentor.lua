-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weeklybigbox/view/WeeklybigboxgameViewPresentor.lua

module("logic.extensions.weeklybigbox.view.WeeklybigboxgameViewPresentor", package.seeall)

local WeeklybigboxgameViewPresentor = class("WeeklybigboxgameViewPresentor", ViewPresentor)

function WeeklybigboxgameViewPresentor:ctor()
	WeeklybigboxgameViewPresentor.super.ctor(self)
end

function WeeklybigboxgameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WeeklybigboxgameViewPresentor:dependWhatResources()
	return {
		"ui/views/weeklybigbox/weeklybigboxgameview.prefab"
	}
end

function WeeklybigboxgameViewPresentor:buildViews()
	return {
		WeeklyBigBoxGameView.New()
	}
end

return WeeklybigboxgameViewPresentor
