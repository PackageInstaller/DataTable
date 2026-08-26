-- chunkname: @modules/logic/sp01/assassin2/controller/VersionActivity2_9DungeonController.lua

module("modules.logic.sp01.assassin2.controller.VersionActivity2_9DungeonController", package.seeall)

local VersionActivity2_9DungeonController = class("VersionActivity2_9DungeonController", VersionActivityFixedDungeonController)

function VersionActivity2_9DungeonController:onInitFinish()
	return
end

function VersionActivity2_9DungeonController:getUnlockEpisodeCount(chapterId)
	local unlockEpisodeCount = 0
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(chapterId)

	for _, config in ipairs(episodeList) do
		local dungeonMo = config and DungeonModel.instance:getEpisodeInfo(config.id) or nil

		if dungeonMo then
			unlockEpisodeCount = unlockEpisodeCount + 1
		end
	end

	return unlockEpisodeCount
end

function VersionActivity2_9DungeonController:openFightSuccView(params, isImmediate)
	ViewMgr.instance:openView(ViewName.VersionActivity2_9FightSuccView, params, isImmediate)
end

function VersionActivity2_9DungeonController:openAssassinStoryDialogView(dialogId, callback, callbackObj, auto, autoplayTime, widthPercentage)
	if not dialogId then
		logError("播放对话失败 dialogId is nil")

		return
	end

	TipDialogController.instance:openTipDialogView(dialogId, callback, callbackObj, auto, autoplayTime, widthPercentage)
end

function VersionActivity2_9DungeonController:startEpisodeLittleGame(episodeId)
	local littleGameType = VersionActivity2_9DungeonHelper.getEpisdoeLittleGameType(episodeId)

	if not littleGameType then
		return
	end

	if littleGameType == VersionActivity2_9DungeonEnum.LittleGameType.Eye then
		VersionActivity2_9DungeonController.instance:startEyeGame(episodeId)
	elseif littleGameType == VersionActivity2_9DungeonEnum.LittleGameType.Line then
		VersionActivity2_9DungeonController.instance:startLineGame(episodeId)
	elseif littleGameType == VersionActivity2_9DungeonEnum.LittleGameType.Point then
		VersionActivity2_9DungeonController.instance:startPointGame(episodeId)
	else
		logError(string.format("未定义操作 episodeId = %s, littleGameType = %s", episodeId, littleGameType))
	end
end

function VersionActivity2_9DungeonController:startEyeGame(episodeId)
	local params = {
		episodeId = episodeId
	}

	ViewMgr.instance:openView(ViewName.AssassinEyeGameView, params)
end

function VersionActivity2_9DungeonController:startLineGame(episodeId)
	local params = {
		episodeId = episodeId
	}

	ViewMgr.instance:openView(ViewName.AssassinLineGameView, params)
end

function VersionActivity2_9DungeonController:startPointGame(episodeId)
	local params = {
		episodeId = episodeId
	}

	ViewMgr.instance:openView(ViewName.AssassinPointGameView, params)
end

VersionActivity2_9DungeonController.instance = VersionActivity2_9DungeonController.New()

LuaEventSystem.addEventMechanism(VersionActivity2_9DungeonController.instance)

return VersionActivity2_9DungeonController
