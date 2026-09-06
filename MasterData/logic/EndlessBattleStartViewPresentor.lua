-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/EndlessBattleStartViewPresentor.lua

module("logic.extensions.battle.view.EndlessBattleStartViewPresentor", package.seeall)

local EndlessBattleStartViewPresentor = class("EndlessBattleStartViewPresentor", ViewPresentor)

function EndlessBattleStartViewPresentor:ctor()
	EndlessBattleStartViewPresentor.super.ctor(self)
end

function EndlessBattleStartViewPresentor:attachToWhichRoot()
	return ViewRootType.HudTop
end

function EndlessBattleStartViewPresentor:dependWhatResources()
	return {
		"ui/views/battle/endlessbattlestartview.prefab"
	}
end

function EndlessBattleStartViewPresentor:buildViews()
	return {
		EndlessBattleStartView.New()
	}
end

return EndlessBattleStartViewPresentor
