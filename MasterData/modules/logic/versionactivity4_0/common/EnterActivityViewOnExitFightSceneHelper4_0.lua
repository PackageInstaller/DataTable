-- chunkname: @modules/logic/versionactivity4_0/common/EnterActivityViewOnExitFightSceneHelper4_0.lua

module("modules.logic.versionactivity4_0.common.EnterActivityViewOnExitFightSceneHelper4_0", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = EnterActivityViewOnExitFightSceneHelper

function EnterActivityViewOnExitFightSceneHelper.activate()
	return
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity14013(forceStarting, exitFightGroup)
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local isOpenLevelView = episodeConfig.type ~= DungeonEnum.EpisodeType.TrialHero

	if isOpenLevelView then
		if not SpLilyaController.enterEpisodeLevelView then
			local openCb

			if isOpenLevelView then
				if not SpLilyaController.instance then
					local openCbObj

					DungeonModel.instance:resetSendChapterEpisodeId()
					MainController.instance:enterMainScene(forceStarting)
					SceneHelper.instance:waitSceneDone(SceneType.Main, function()
						VersionActivityMainFixedEnterController.instance:openVersionActivityEnterViewIfNotOpened(openCb, openCbObj, VersionActivity4_0Enum.ActivityId.SpLilya, true)
					end)
				end
			end
		end
	end
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity14014(forceStarting, exitFightGroup)
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local isOpenLevelView = episodeConfig.type ~= DungeonEnum.EpisodeType.TrialHero

	if isOpenLevelView then
		if not DeleikeController.enterEpisodeLevelView then
			local openCb

			if isOpenLevelView then
				if not DeleikeController.instance then
					local openCbObj

					DungeonModel.instance:resetSendChapterEpisodeId()
					MainController.instance:enterMainScene(forceStarting)
					SceneHelper.instance:waitSceneDone(SceneType.Main, function()
						VersionActivityMainFixedEnterController.instance:openVersionActivityEnterViewIfNotOpened(openCb, openCbObj, VersionActivity4_0Enum.ActivityId.Deleike, true)
					end)
				end
			end
		end
	end
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity14009(forceStarting, exitFightGroup)
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local stage, layer = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(episodeId)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V3a2_BossRush_LevelDetailView)
		VersionActivityMainFixedEnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openV3a2MainView({
				isOpenLevelDetail = true,
				stage = stage,
				layer = layer
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

return EnterActivityViewOnExitFightSceneHelper
