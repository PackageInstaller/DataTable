-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldcup/view/WorldCupBetViewPresentor.lua

module("logic.extensions.worldcup.view.WorldCupBetViewPresentor", package.seeall)

local WorldCupBetViewPresentor = class("WorldCupBetViewPresentor", ViewPresentor)

function WorldCupBetViewPresentor:ctor()
	WorldCupBetViewPresentor.super.ctor(self)
end

function WorldCupBetViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function WorldCupBetViewPresentor:dependWhatResources()
	return {
		"ui/views/worldcup/worldcupbetview.prefab"
	}
end

function WorldCupBetViewPresentor:buildViews()
	return {
		WorldCupBetView.New()
	}
end

return WorldCupBetViewPresentor
