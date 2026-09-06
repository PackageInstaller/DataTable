-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/view/StarBattleMainViewPresentor.lua

module("logic.extensions.starbattle.view.StarBattleMainViewPresentor", package.seeall)

local StarBattleMainViewPresentor = class("StarBattleMainViewPresentor", ViewPresentor)

function StarBattleMainViewPresentor:ctor()
	StarBattleMainViewPresentor.super.ctor(self)
end

function StarBattleMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StarBattleMainViewPresentor:dependWhatResources()
	return {
		"ui/views/starbattle/starbattlemainview.prefab"
	}
end

function StarBattleMainViewPresentor:buildViews()
	return {
		StarBattleMainView.New()
	}
end

return StarBattleMainViewPresentor
