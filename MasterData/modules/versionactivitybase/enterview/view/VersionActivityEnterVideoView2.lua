-- chunkname: @modules/versionactivitybase/enterview/view/VersionActivityEnterVideoView2.lua

module("modules.versionactivitybase.enterview.view.VersionActivityEnterVideoView2", package.seeall)

local VersionActivityEnterVideoView2 = class("VersionActivityEnterVideoView2", VersionActivityEnterVideoView)

function VersionActivityEnterVideoView2:ctor(param)
	VersionActivityEnterVideoView2.super.ctor(self, param)

	param = param or {}
	self._episodeId = param.episodeId
	self._loopVideoNameList = param.loopVideoNameList or {}
	self._enterVideoNameList = param.enterVideoNameList or {}
end

function VersionActivityEnterVideoView2:addEvents()
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self.onUpdateDungeonInfo, self)
end

function VersionActivityEnterVideoView2:removeEvents()
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self.onUpdateDungeonInfo, self)
end

function VersionActivityEnterVideoView2:onUpdateDungeonInfo()
	self:refreshLoopVideo()
end

function VersionActivityEnterVideoView2:getLoopVideoName()
	local isPassEpisode = DungeonModel.instance:hasPassLevel(self._episodeId)

	return (isPassEpisode or nil) and (self._loopVideoNameList[2] or self._loopVideoNameList[1])
end

function VersionActivityEnterVideoView2:getEnterVideoName()
	local isPassEpisode = DungeonModel.instance:hasPassLevel(self._episodeId)

	return (isPassEpisode or nil) and (self._enterVideoNameList[2] or self._enterVideoNameList[1])
end

return VersionActivityEnterVideoView2
