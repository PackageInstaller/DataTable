-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownBattleResutlViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownBattleResutlViewPresentor", package.seeall)

local ShowDownBattleResutlViewPresentor = class("ShowDownBattleResutlViewPresentor", ViewPresentor)

function ShowDownBattleResutlViewPresentor:ctor()
	ShowDownBattleResutlViewPresentor.super.ctor(self)
end

function ShowDownBattleResutlViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowDownBattleResutlViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdownbattleresutlview.prefab"
	}
end

function ShowDownBattleResutlViewPresentor:buildViews()
	return {
		ShowDownBattleResutlView.New()
	}
end

return ShowDownBattleResutlViewPresentor
