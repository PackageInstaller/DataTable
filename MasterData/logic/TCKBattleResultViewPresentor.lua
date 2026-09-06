-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKBattleResultViewPresentor.lua

module("logic.extensions.teenchampionking.view.TCKBattleResultViewPresentor", package.seeall)

local TCKBattleResultViewPresentor = class("TCKBattleResultViewPresentor", ViewPresentor)

function TCKBattleResultViewPresentor:ctor()
	TCKBattleResultViewPresentor.super.ctor(self)
end

function TCKBattleResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TCKBattleResultViewPresentor:dependWhatResources()
	return {
		"ui/views/teenchampionking/tckbattleresultview.prefab"
	}
end

function TCKBattleResultViewPresentor:buildViews()
	return {
		TCKBattleResultView.New()
	}
end

return TCKBattleResultViewPresentor
