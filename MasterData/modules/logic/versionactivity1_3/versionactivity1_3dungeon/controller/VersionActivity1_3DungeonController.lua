-- chunkname: @modules/logic/versionactivity1_3/versionactivity1_3dungeon/controller/VersionActivity1_3DungeonController.lua

module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.controller.VersionActivity1_3DungeonController", package.seeall)

local VersionActivity1_3DungeonController = class("VersionActivity1_3DungeonController", BaseController)

function VersionActivity1_3DungeonController:onInit()
	return
end

function VersionActivity1_3DungeonController:reInit()
	self.directFocusDaily = false
	self.dailyFromEpisodeId = nil
end

function VersionActivity1_3DungeonController:openVersionActivityDungeonMapView(chapterId, episodeId, rpcCallback, rpcCallbackObj, otherViewParam)
	self.openViewParam = {
		chapterId = chapterId,
		episodeId = episodeId
	}

	if otherViewParam then
		for key, value in pairs(otherViewParam) do
			self.openViewParam[key] = value
		end
	end

	Activity113Rpc.instance:sendGetAct113InfoRequest(VersionActivity1_3Enum.ActivityId.Dungeon)

	local list = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityDungeon, VersionActivity1_3Enum.ActivityId.Dungeon)

	if #list > 0 and Activity126Model.instance.isInit then
		ViewMgr.instance:openView(ViewName.VersionActivity1_3DungeonMapView, self.openViewParam)

		if rpcCallback then
			rpcCallback()
		end

		return
	end

	if ActivityModel.instance:isActOnLine(VersionActivity1_3Enum.ActivityId.Act310) then
		Activity126Rpc.instance:sendGet126InfosRequest(VersionActivity1_3Enum.ActivityId.Act310)
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, function()
		ViewMgr.instance:openView(ViewName.VersionActivity1_3DungeonMapView, self.openViewParam)

		if rpcCallback then
			rpcCallback()
		end
	end)
end

function VersionActivity1_3DungeonController:getEpisodeMapConfig(episodeId)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeCo.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard then
		local index = DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(episodeId)
		local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei)

		for _, config in ipairs(episodeList) do
			if index == DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(config.id) then
				episodeCo = config

				break
			end
		end
	else
		while episodeCo.chapterId ~= VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei do
			episodeCo = DungeonConfig.instance:getEpisodeCO(episodeCo.preEpisode)
		end
	end

	return DungeonConfig.instance:getChapterMapCfg(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei, episodeCo.preEpisode)
end

function VersionActivity1_3DungeonController:isDayTime(episodeId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeConfig.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard then
		episodeId = episodeId - 10000
	end

	return episodeId < VersionActivity1_3DungeonEnum.DailyEpisodeId or episodeId == VersionActivity1_3DungeonEnum.ExtraEpisodeId
end

function VersionActivity1_3DungeonController:openDungeonChangeView(param)
	ViewMgr.instance:openView(ViewName.VersionActivity1_3DungeonChangeView, param)
end

function VersionActivity1_3DungeonController:getEpisodeIndex(episodeId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeConfig.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard then
		episodeId = episodeId - 10000
		episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	elseif episodeConfig.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei3 then
		episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeConfig.preEpisode)
	elseif episodeConfig.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei4 then
		episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeConfig.preEpisode)
		episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeConfig.preEpisode)
	end

	return DungeonConfig.instance:getChapterEpisodeIndexWithSP(episodeConfig.chapterId, episodeConfig.id)
end

VersionActivity1_3DungeonController.instance = VersionActivity1_3DungeonController.New()

return VersionActivity1_3DungeonController
