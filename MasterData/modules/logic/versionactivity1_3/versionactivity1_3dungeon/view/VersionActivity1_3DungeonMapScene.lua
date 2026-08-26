-- chunkname: @modules/logic/versionactivity1_3/versionactivity1_3dungeon/view/VersionActivity1_3DungeonMapScene.lua

module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3DungeonMapScene", package.seeall)

local VersionActivity1_3DungeonMapScene = class("VersionActivity1_3DungeonMapScene", VersionActivity1_3DungeonBaseMapScene)

function VersionActivity1_3DungeonMapScene:getInteractiveItem()
	return self.viewContainer.mapView:openMapInteractiveItem()
end

function VersionActivity1_3DungeonMapScene:createInteractiveItem()
	VersionActivity1_3DungeonMapScene.super.getInteractiveItem(self)
end

function VersionActivity1_3DungeonMapScene:showInteractiveItem()
	return self.viewContainer.mapView:showInteractiveItem() or VersionActivity1_3DungeonMapScene.super.showInteractiveItem(self)
end

function VersionActivity1_3DungeonMapScene:_isSameMap(curId, lastId)
	return curId == lastId and curId ~= VersionActivity1_3DungeonEnum.DailyEpisodeId
end

function VersionActivity1_3DungeonMapScene:getMapTime()
	local curEpisodeId = self.activityDungeonMo.episodeId
	local lastEpisodeId = self._lastEpisodeId

	if not lastEpisodeId or curEpisodeId == lastEpisodeId then
		return
	end

	local lastIsSun = VersionActivity1_3DungeonController.instance:isDayTime(lastEpisodeId)
	local curIsSun = VersionActivity1_3DungeonController.instance:isDayTime(curEpisodeId)

	if lastIsSun == curIsSun then
		return
	end

	return curIsSun and "sun" or "moon"
end

function VersionActivity1_3DungeonMapScene:onOpen()
	VersionActivity1_3DungeonMapScene.super.onOpen(self)
	MainCameraMgr.instance:addView(ViewName.VersionActivity1_3DungeonMapView, self._initCamera, nil, self)
end

return VersionActivity1_3DungeonMapScene
