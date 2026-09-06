-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownFuncBattleResultViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownFuncBattleResultViewPresentor", package.seeall)

local ShowDownFuncBattleResultViewPresentor = class("ShowDownFuncBattleResultViewPresentor", ViewPresentor)

function ShowDownFuncBattleResultViewPresentor:ctor()
	ShowDownFuncBattleResultViewPresentor.super.ctor(self)
end

function ShowDownFuncBattleResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ShowDownFuncBattleResultViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdownfuncbattleresultview.prefab"
	}
end

function ShowDownFuncBattleResultViewPresentor:buildViews()
	return {
		ShowDownFuncBattleResultView.New()
	}
end

return ShowDownFuncBattleResultViewPresentor
