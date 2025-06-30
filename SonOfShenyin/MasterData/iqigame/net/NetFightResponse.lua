-- chunkname: @IQIGame\\Net\\NetFightResponse.lua

function net_fight.notifyStartFight(isLocalFight, fightPOD, userData)
	SceneTransferModule.CommonEnterBattle({
		IsLocalFight = isLocalFight,
		FightPOD = fightPOD,
		UserData = userData
	})
end

function net_fight.refreshRandomSeedResult(code, randomSeed)
	BattleModule.OnRestartBattle(randomSeed)
end

function net_fight.notifyFightOver(fightOverPOD)
	GameChapterModule.CacheFightUnits(fightOverPOD)

	if GuideModule.IsBattleResultWaitGuide then
		EventDispatcher.Dispatch(EventID.ShowBattleResultGuideEvent)
		EventDispatcher.AddSingleEventListener(EventID.BattleResultGuideEvent, function()
			if fightOverPOD.type == Constant.ChapterPassType.TYPE_STORY_FIGHT then
				EventDispatcher.Dispatch(EventID.StoryBattleNodeComplete, fightOverPOD)
			else
				local userData = {}

				userData.fightOverPOD = fightOverPOD

				function userData.closeCallBack()
					SceneTransferModule.BattleToMainCity(fightOverPOD)
				end

				UIModule.Open(Constant.UIControllerName.Settlement_BattleUI, Constant.UILayer.UI, userData)
			end

			GuideModule.IsBattleResultWaitGuide = nil
		end)

		return
	end

	if fightOverPOD.type == Constant.ChapterPassType.TYPE_STORY_FIGHT then
		EventDispatcher.Dispatch(EventID.StoryBattleNodeComplete, fightOverPOD)
		StoryModule.ItemPODShow(fightOverPOD.awards)
	elseif fightOverPOD.type == Constant.ChapterPassType.TYPE_Maze then
		local userData = {}

		userData.fightOverPOD = fightOverPOD

		function userData.closeCallBack()
			SceneTransferModule.BattleToMaze(fightOverPOD)
		end

		if fightOverPOD.fightResult == Constant.FightResult.ATTACKER_WIN then
			MazeModule.NotifyServerSelectOptionsEvent()
		end

		UIModule.Open(Constant.UIControllerName.Settlement_MazeBattleUI, Constant.UILayer.UI, userData)
	else
		local userData = {}

		userData.fightOverPOD = fightOverPOD

		function userData.closeCallBack()
			if StoryModule.IsStoring then
				EventDispatcher.Dispatch(EventID.StoryBattleNodeComplete, fightOverPOD)
			else
				SceneTransferModule.BattleToMainCity(fightOverPOD)
			end
		end

		UIModule.Open(Constant.UIControllerName.Settlement_BattleUI, Constant.UILayer.UI, userData)
	end

	if fightOverPOD.fightResult == Constant.FightResult.ATTACKER_WIN then
		EventDispatcher.Dispatch(EventID.BattleWaitResultWinGuideEvent)
	end
end

function net_plotStage.enterStaticFightResult(code)
	EventDispatcher.Dispatch(EventID.StoryStartFight)
end
