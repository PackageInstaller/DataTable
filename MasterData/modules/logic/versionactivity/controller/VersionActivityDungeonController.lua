-- chunkname: @modules/logic/versionactivity/controller/VersionActivityDungeonController.lua

module("modules.logic.versionactivity.controller.VersionActivityDungeonController", package.seeall)

local VersionActivityDungeonController = class("VersionActivityDungeonController", BaseController)

function VersionActivityDungeonController:onInit()
	return
end

function VersionActivityDungeonController:reInit()
	return
end

function VersionActivityDungeonController:openVersionActivityDungeonMapView(chapterId, episodeId, rpcCallback, rpcCallbackObj, otherViewParam)
	self.rpcCallback = rpcCallback
	self.rpcCallbackObj = rpcCallbackObj
	self.openViewParam = {
		chapterId = chapterId,
		episodeId = episodeId
	}

	if otherViewParam then
		for key, value in pairs(otherViewParam) do
			self.openViewParam[key] = value
		end
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, self._openVersionActivityDungeonMapView, self)
end

function VersionActivityDungeonController:_openVersionActivityDungeonMapView()
	ViewMgr.instance:openView(ViewName.VersionActivityDungeonMapView, self.openViewParam)

	if self.rpcCallback then
		self.rpcCallback(self.rpcCallbackObj)
	end
end

function VersionActivityDungeonController:getEpisodeMapConfig(episodeId)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeCo.chapterId == VersionActivityEnum.DungeonChapterId.LeiMiTeBeiHard then
		local index = DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(episodeId)
		local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivityEnum.DungeonChapterId.LeiMiTeBei)

		for _, config in ipairs(episodeList) do
			if index == DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(config.id) then
				episodeCo = config

				break
			end
		end
	else
		while episodeCo.chapterId ~= VersionActivityEnum.DungeonChapterId.LeiMiTeBei do
			episodeCo = DungeonConfig.instance:getEpisodeCO(episodeCo.preEpisode)
		end
	end

	return DungeonConfig.instance:getChapterMapCfg(VersionActivityEnum.DungeonChapterId.LeiMiTeBei, episodeCo.preEpisode)
end

VersionActivityDungeonController.instance = VersionActivityDungeonController.New()

return VersionActivityDungeonController
