-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldboss/view/WorldBossRankPresentor.lua

module("logic.extensions.worldboss.view.WorldBossRankPresentor", package.seeall)

local WorldBossRankPresentor = class("WorldBossRankPresentor", ViewPresentor)

function WorldBossRankPresentor:ctor()
	WorldBossRankPresentor.super.ctor(self)
end

function WorldBossRankPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WorldBossRankPresentor:dependWhatResources()
	return {
		"ui/views/worldboss/worldbossrankview.prefab"
	}
end

function WorldBossRankPresentor:buildViews()
	return {
		WorldBossRankView.New()
	}
end

return WorldBossRankPresentor
