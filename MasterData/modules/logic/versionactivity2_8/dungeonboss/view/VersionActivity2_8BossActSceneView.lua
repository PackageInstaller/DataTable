-- chunkname: @modules/logic/versionactivity2_8/dungeonboss/view/VersionActivity2_8BossActSceneView.lua

module("modules.logic.versionactivity2_8.dungeonboss.view.VersionActivity2_8BossActSceneView", package.seeall)

local VersionActivity2_8BossActSceneView = class("VersionActivity2_8BossActSceneView", VersionActivity2_8BossStorySceneView)

function VersionActivity2_8BossActSceneView:_startChangeMap()
	local map = VersionActivity2_8BossActSceneView.getMap()

	self:_changeMap(map)
end

function VersionActivity2_8BossActSceneView.getMap()
	local mapId = 11026

	return lua_chapter_map.configDict[mapId]
end

return VersionActivity2_8BossActSceneView
