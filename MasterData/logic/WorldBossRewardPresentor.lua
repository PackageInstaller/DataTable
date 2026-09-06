-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldboss/view/WorldBossRewardPresentor.lua

module("logic.extensions.worldboss.view.WorldBossRewardPresentor", package.seeall)

local WorldBossRewardPresentor = class("WorldBossRewardPresentor", ViewPresentor)

function WorldBossRewardPresentor:ctor()
	WorldBossRewardPresentor.super.ctor(self)
end

function WorldBossRewardPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WorldBossRewardPresentor:dependWhatResources()
	return {
		"ui/views/worldboss/worldbossrewardview.prefab"
	}
end

function WorldBossRewardPresentor:buildViews()
	return {
		WorldBossRewardView.New()
	}
end

return WorldBossRewardPresentor
