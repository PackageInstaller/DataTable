-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldboss/view/WorldBossMainPresentor.lua

module("logic.extensions.worldboss.view.WorldBossMainPresentor", package.seeall)

local WorldBossMainPresentor = class("WorldBossMainPresentor", ViewPresentor)

function WorldBossMainPresentor:ctor()
	WorldBossMainPresentor.super.ctor(self)
end

function WorldBossMainPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WorldBossMainPresentor:dependWhatResources()
	return {
		"ui/views/worldboss/worldbossmainview.prefab"
	}
end

function WorldBossMainPresentor:buildViews()
	return {
		WorldBossMainView.New()
	}
end

return WorldBossMainPresentor
