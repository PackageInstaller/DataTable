-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldcup/view/WorldCupRankViewPresentor.lua

module("logic.extensions.worldcup.view.WorldCupRankViewPresentor", package.seeall)

local WorldCupRankViewPresentor = class("WorldCupRankViewPresentor", ViewPresentor)

function WorldCupRankViewPresentor:ctor()
	WorldCupRankViewPresentor.super.ctor(self)
end

function WorldCupRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WorldCupRankViewPresentor:dependWhatResources()
	return {
		"ui/views/worldcup/worldcuprankview.prefab"
	}
end

function WorldCupRankViewPresentor:buildViews()
	return {
		WorldCupRankView.New()
	}
end

return WorldCupRankViewPresentor
