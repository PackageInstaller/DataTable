-- chunkname: @modules/common/activity/EnterActivityViewOnExitFightSceneHelper.lua

module("modules.common.activity.EnterActivityViewOnExitFightSceneHelper", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = class("EnterActivityViewOnExitFightSceneHelper")

function EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight()
	EnterActivityViewOnExitFightSceneHelper.recordMO = FightModel.instance:getRecordMO()

	local chapterId = DungeonModel.instance.curSendChapterId

	return EnterActivityViewOnExitFightSceneHelper.checkIsActivityFight(chapterId)
end

function EnterActivityViewOnExitFightSceneHelper.checkIsActivityFight(chapterId)
	local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)

	if chapterCo then
		if not chapterCo.actId then
			local actId = 0

			if actId ~= 0 and AbyssConfig.instance:getActivityId() == actId then
				return EnterActivityViewOnExitFightSceneHelper.enterAbyss()
			end

			return actId ~= 0 and EnterActivityViewOnExitFightSceneHelper["enterActivity" .. actId]
		end
	end
end

function EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(forceStarting, exitFightGroup)
	local chapterId = DungeonModel.instance.curSendChapterId
	local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)

	if chapterCo then
		if not chapterCo.actId then
			local actId = 0

			EnterActivityViewOnExitFightSceneHelper.enterActivity(actId, forceStarting, exitFightGroup)
		end
	end
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity(actId, forceStarting, exitFightGroup)
	local status = ActivityHelper.getActivityStatus(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		DungeonModel.instance.curSendEpisodeId = nil

		MainController.instance:enterMainScene(forceStarting)

		return
	end

	if actId == 0 then
		return
	end

	local enterFunc = EnterActivityViewOnExitFightSceneHelper["enterActivity" .. actId]

	if not exitFightGroup then
		local checkFunc = EnterActivityViewOnExitFightSceneHelper["checkFightAfterStory" .. actId]

		if checkFunc and checkFunc(enterFunc, forceStarting, exitFightGroup) then
			return
		end
	end

	if enterFunc then
		enterFunc(forceStarting, exitFightGroup)
	end
end

function EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(callBack, forceStarting, exitFightGroup)
	local chapterId = DungeonModel.instance.curSendChapterId
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local isReplay = FightController.instance:isReplayMode(episodeId)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local chapterConfig = DungeonConfig.instance:getChapterCO(chapterId)
	local actId = chapterConfig.actId
	local activityState = ActivityHelper.getActivityStatus(actId)

	if ActivityEnum.ActivityStatus.Normal ~= activityState then
		MainController.instance:enterMainScene(forceStarting)

		return
	end

	if not exitFightGroup and isReplay then
		if EnterActivityViewOnExitFightSceneHelper["enterFightAgain" .. actId] then
			if EnterActivityViewOnExitFightSceneHelper["enterFightAgain" .. actId]() then
				return
			end
		else
			EnterActivityViewOnExitFightSceneHelper.enterFightAgain()

			return
		end
	end

	DungeonModel.instance.versionActivityChapterType = nil
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)

	local param = {
		episodeId = episodeId,
		episodeCo = episodeCo,
		exitFightGroup = exitFightGroup
	}

	SceneHelper.instance:waitSceneDone(SceneType.Main, callBack, EnterActivityViewOnExitFightSceneHelper, param)
end

function EnterActivityViewOnExitFightSceneHelper.enterFightAgain()
	GameSceneMgr.instance:closeScene(nil, nil, nil, true)

	local chapterId = DungeonModel.instance.curSendChapterId
	local episodeId = DungeonModel.instance.curSendEpisodeId

	DungeonFightController.instance:enterFight(chapterId, episodeId, DungeonModel.instance.curSelectTicketId)
end

function EnterActivityViewOnExitFightSceneHelper.activeExtend()
	ActivityHelper.activateClass("EnterActivityViewOnExitFightSceneHelper%d_%d", 1, 1)

	local spVersion = 2

	while true do
		local cls = _G[string.format("EnterActivityViewOnExitFightSceneHelper_Sp%02d", spVersion)]

		if not cls then
			break
		else
			spVersion = spVersion + 1
		end
	end
end

function EnterActivityViewOnExitFightSceneHelper.enterActivityBossRush(forceStarting, exitFightGroup)
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local stage, layer = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(episodeId)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V3a2_BossRush_LevelDetailView)
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openV3a2MainView({
				isOpenLevelDetail = true,
				stage = stage,
				layer = layer
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterAbyss(forceStarting, exitFightGroup)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)

	local actId = AbyssConfig.instance:getActivityId()

	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.AbyssMainView)
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
			AbyssController.instance:openMainView(actId, true)
		end, nil, actId, true)
	end)
end

return EnterActivityViewOnExitFightSceneHelper
