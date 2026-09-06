-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldcup/view/WorldCupAllMatchViewPresentor.lua

module("logic.extensions.worldcup.view.WorldCupAllMatchViewPresentor", package.seeall)

local WorldCupAllMatchViewPresentor = class("WorldCupAllMatchViewPresentor", ViewPresentor)

function WorldCupAllMatchViewPresentor:ctor()
	WorldCupAllMatchViewPresentor.super.ctor(self)
end

function WorldCupAllMatchViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function WorldCupAllMatchViewPresentor:dependWhatResources()
	return {
		"ui/views/worldcup/worldcupallmatchview.prefab"
	}
end

function WorldCupAllMatchViewPresentor:buildViews()
	return {
		WorldCupAllMatchView.New()
	}
end

return WorldCupAllMatchViewPresentor
