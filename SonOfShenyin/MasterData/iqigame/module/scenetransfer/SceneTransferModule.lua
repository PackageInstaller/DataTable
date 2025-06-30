-- chunkname: @IQIGame\\Module\\SceneTransfer\\SceneTransferModule.lua

local LoginSceneToMainCitySceneTransfer = require("IQIGame/Module/SceneTransfer/LoginSceneToMainCitySceneTransfer")
local MainCityToBattleTransfer = require("IQIGame/Module/SceneTransfer/MainCityToBattleTransfer")
local MainCityToStoryTransfer = require("IQIGame/Module/SceneTransfer/MainCityToStoryTransfer")
local StoryToMainCityTransfer = require("IQIGame/Module/SceneTransfer/StoryToMainCityTransfer")
local StoryToStoryTransfer = require("IQIGame/Module/SceneTransfer/StoryToStoryTransfer")
local BattleToMainCityTransfer = require("IQIGame/Module/SceneTransfer/BattleToMainCityTransfer")
local BattleToStoryTransfer = require("IQIGame/Module/SceneTransfer/BattleToStoryTransfer")
local BattleToMazeTransfer = require("IQIGame/Module/SceneTransfer/BattleToMazeTransfer")
local StoryToBattleTransfer = require("IQIGame/Module/SceneTransfer/StoryToBattleTransfer")
local ReturnLoginTransfer = require("IQIGame/Module/SceneTransfer/ReturnLoginTransfer")
local MainCityToHomeTransfer = require("IQIGame/Module/SceneTransfer/MainCityToHomeTransfer")
local MainCityToGhostGameTransfer = require("IQIGame/Module/SceneTransfer/MainCityToGhostGameTransfer")
local GhostGameToMainCityTransfer = require("IQIGame/Module/SceneTransfer/GhostGameToMainCityTransfer")
local HomeSceneToMazeTransfer = require("IQIGame/Module/SceneTransfer/HomeSceneToMazeTransfer")
local MazeSceneToBattleTransfer = require("IQIGame/Module/SceneTransfer/MazeSceneToBattleTransfer")
local MazeSceneToHomeTransfer = require("IQIGame/Module/SceneTransfer/MazeSceneToHomeTransfer")
local ReEnterStoryTransfer = require("IQIGame/Module/SceneTransfer/ReEnterStoryTransfer")

SceneTransferModule = {
	SceneTransferTable = {}
}
SceneTransferModule.SceneName = {
	EmptyMainCity = "EmptyMainCity",
	Story = "Story",
	GhostGame = "GhostGame",
	Login = "Login",
	MainCity = "MainCity",
	Battle = "Battle",
	Maze = "Maze",
	StoryBattle = "StoryBattle",
	Home = "Home",
	MazeBattle = "MazeBattle"
}
SceneTransferModule.TransferName = {
	StoryToBattle = "StoryToBattleTransfer",
	BattleToMaze = "BattleToMazeTransfer",
	MainCityToBattle = "MainCityToBattleTransfer",
	LoginToStory = "ReturnLoginTransfer",
	MazeToHome = "MazeSceneToHomeTransfer",
	MainCityToStory = "MainCityToStoryTransfer",
	StoryToStory = "StoryToStory",
	HomeToMaze = "HomeToMaze",
	ReEnterStory = "ReEnterStoryTransfer",
	MainCityToHome = "MainCityToHomeTransfer",
	BattleToMainCity = "BattleToMainCityTransfer",
	MazeToBattle = "MazeSceneToBattleTransfer",
	ReturnLogin = "LoginToStoryTransfer",
	LoginSceneToMainCityScene = "LoginSceneToMainCitySceneTransfer",
	BattleToStory = "BattleToStoryTransfer",
	GhostGameToMainCity = "GhostGameToMainCity",
	MainCityToGhostGame = "MainCityToGhostGame",
	StoryToMainCity = "StoryToMainCityTransfer"
}

function SceneTransferModule.__AddTransfer(name, class, cameraStackType)
	SceneTransferModule.SceneTransferTable[name] = class.New(class, cameraStackType)
end

function SceneTransferModule.Init()
	SceneTransferModule.MainCameraGo = GameEntry.RenderingComponent:GetMainCamera().gameObject

	if SceneTransferModule.MainCameraGo == nil then
		logError("未能正确初始化主相机【Main Camera】,检查Launch场景")
	end

	SceneTransferModule.CurScene = SceneTransferModule.SceneName.Login
	SceneTransferModule.RunningTransfer = nil
	SceneTransferModule.TransferTable = {}

	SceneTransferModule.__AddTransfer(SceneTransferModule.TransferName.LoginSceneToMainCityScene, LoginSceneToMainCitySceneTransfer, Constant.MainCameraStackType.Normal)
	SceneTransferModule.__AddTransfer(SceneTransferModule.TransferName.MainCityToBattle, MainCityToBattleTransfer, Constant.MainCameraStackType.Battle)
	SceneTransferModule.__AddTransfer(SceneTransferModule.TransferName.BattleToMainCity, BattleToMainCityTransfer, Constant.MainCameraStackType.Normal)
	SceneTransferModule.__AddTransfer(SceneTransferModule.TransferName.MainCityToStory, MainCityToStoryTransfer, Constant.MainCameraStackType.Normal)
	SceneTransferModule.__AddTransfer(SceneTransferModule.TransferName.StoryToMainCity, StoryToMainCityTransfer, Constant.MainCameraStackType.Normal)
	SceneTransferModule.__AddTransfer(SceneTransferModule.TransferName.StoryToStory, StoryToStoryTransfer, Constant.MainCameraStackType.Normal)
	SceneTransferModule.__AddTransfer(SceneTransferModule.TransferName.BattleToStory, BattleToStoryTransfer, Constant.MainCameraStackType.Normal)
	SceneTransferModule.__AddTransfer(SceneTransferModule.TransferName.BattleToMaze, BattleToMazeTransfer, Constant.MainCameraStackType.Normal)
	SceneTransferModule.__AddTransfer(SceneTransferModule.TransferName.StoryToBattle, StoryToBattleTransfer, Constant.MainCameraStackType.Battle)
	SceneTransferModule.__AddTransfer(SceneTransferModule.TransferName.ReturnLogin, ReturnLoginTransfer, Constant.MainCameraStackType.Normal)
	SceneTransferModule.__AddTransfer(SceneTransferModule.TransferName.MainCityToHome, MainCityToHomeTransfer, Constant.MainCameraStackType.Normal)
	SceneTransferModule.__AddTransfer(SceneTransferModule.TransferName.MainCityToGhostGame, MainCityToGhostGameTransfer, Constant.MainCameraStackType.Normal)
	SceneTransferModule.__AddTransfer(SceneTransferModule.TransferName.GhostGameToMainCity, GhostGameToMainCityTransfer, Constant.MainCameraStackType.Normal)
	SceneTransferModule.__AddTransfer(SceneTransferModule.TransferName.HomeToMaze, HomeSceneToMazeTransfer, Constant.MainCameraStackType.Normal)
	SceneTransferModule.__AddTransfer(SceneTransferModule.TransferName.MazeToBattle, MazeSceneToBattleTransfer, Constant.MainCameraStackType.Battle)
	SceneTransferModule.__AddTransfer(SceneTransferModule.TransferName.MazeToHome, MazeSceneToHomeTransfer, Constant.MainCameraStackType.Normal)
	SceneTransferModule.__AddTransfer(SceneTransferModule.TransferName.ReEnterStory, ReEnterStoryTransfer, Constant.MainCameraStackType.Normal)

	SceneTransferModule.updateFrameTimer = ModuleTimerUtil.NewFrameTimer(Constant.ModuleTimerName.SceneTransfer, SceneTransferModule.__OnFrameUpdate, 1, -1)

	SceneTransferModule.updateFrameTimer:Start()
end

function SceneTransferModule.__OnFrameUpdate()
	if SceneTransferModule.RunningTransfer == nil then
		return
	end

	local deltaTime = UnityEngine.Time.deltaTime

	SceneTransferModule.RunningTransfer:Update(deltaTime)
end

function SceneTransferModule.SetMainCameraType(type)
	if type == Constant.MainCameraStackType.Normal then
		GameEntry.RenderingComponent:SwitchNormalCameras()
	elseif type == Constant.MainCameraStackType.Battle then
		GameEntry.RenderingComponent:SwitchBattleCameras()
	else
		logError("场景切换逻辑错误，切换了错误的相机堆栈类型: {0}", type)
		GameEntry.RenderingComponent:SwitchNormalCameras()
	end
end

function SceneTransferModule.__Transfer(transferName, args, callback, callbackArgs)
	if SceneTransferModule.RunningTransfer ~= nil then
		logError("执行场景切换失败，当前还在执行场景切换")

		return
	end

	SceneTransferModule.RunningTransfer = SceneTransferModule.SceneTransferTable[transferName]

	if SceneTransferModule.RunningTransfer == nil then
		logError("执行场景切换失败，找不到对应的Transfer：{0}", transferName)

		return
	end

	SceneTransferModule.RunningTransfer:Execute(args, callback, callbackArgs)
end

function SceneTransferModule.__CommonTransferCallback(args)
	SceneTransferModule.CurScene = args.SceneName
	SceneTransferModule.RunningTransfer = nil

	if args.Callback ~= nil then
		args.Callback(args.CallbackArgs)
	end
end

function SceneTransferModule.LoginSceneToEmptyMainCityScene(args)
	local callbackArgs = {
		SceneName = SceneTransferModule.SceneName.EmptyMainCity
	}

	SceneTransferModule.__Transfer(SceneTransferModule.TransferName.LoginSceneToMainCityScene, args, SceneTransferModule.__OnEnterMainCitySceneComplete, callbackArgs)
end

function SceneTransferModule.__OnEnterMainCitySceneComplete(args)
	SceneTransferModule.CurScene = args.SceneName
	SceneTransferModule.RunningTransfer = nil

	if GuideModule.needRecoverGuide == nil then
		if GuideModule.TriggerGuide(Constant.GuideTriggerType.CustomTrigger, "StartStory") then
			return
		end
	elseif GuideModule.needRecoverGuide.TriggerValues == "StartStory" then
		SceneTransferModule.__RecoverGuide()

		return
	end

	local plotId = WorldMapModule.GetCurrentStory()

	if plotId and plotId ~= 0 then
		local cfgWorldMap = CfgUtil.GetCfgWorldMapItemDataWithID(plotId)
		local excludeTypeList = {
			13
		}

		if ValueInArray(excludeTypeList, cfgWorldMap.Type) then
			HomeModule.forceEnterDefaultScene = true

			SceneTransferModule.__EmptyMainCityToHome()
		else
			StoryChapterModule.EnterDup(plotId)
		end

		return
	end

	SceneTransferModule.__EmptyMainCityToHome()
end

function SceneTransferModule.__EmptyMainCityToHome()
	local callbackArgs = {
		SceneName = SceneTransferModule.SceneName.Home
	}

	SceneTransferModule.__Transfer(SceneTransferModule.TransferName.MainCityToHome, args, SceneTransferModule.__CommonTransferCallback, callbackArgs)
end

function SceneTransferModule.__RecoverGuide()
	if GuideModule.needRecoverGuide == nil then
		return
	end

	GuideModule.GuideStart(true, GuideModule.needRecoverGuide)

	GuideModule.needRecoverGuide = nil
end

function SceneTransferModule.MainCityToStory(startStoryParam)
	local args = {
		StartStoryParam = startStoryParam
	}
	local callbackArgs = {
		SceneName = SceneTransferModule.SceneName.Story
	}

	SceneTransferModule.__Transfer(SceneTransferModule.TransferName.MainCityToStory, args, SceneTransferModule.__CommonTransferCallback, callbackArgs)
end

function SceneTransferModule.ReEnterStory()
	local tips = CfgTipsTable[300000].Text

	NoticeModule.ShowNoticeByType(5, tips, function()
		SceneTransferModule.__DoReEnterStory()
	end, function()
		log("Cancel Exit ReEnterStory.")
	end)
end

function SceneTransferModule.__DoReEnterStory()
	local callbackArgs = {
		SceneName = SceneTransferModule.SceneName.Story
	}

	SceneTransferModule.__Transfer(SceneTransferModule.TransferName.ReEnterStory, nil, SceneTransferModule.__CommonTransferCallback, callbackArgs)
end

function SceneTransferModule.StoryToStory(startStoryParam)
	local args = {
		StartStoryParam = startStoryParam
	}
	local callbackArgs = {
		SceneName = SceneTransferModule.SceneName.Story
	}

	SceneTransferModule.__Transfer(SceneTransferModule.TransferName.StoryToStory, args, SceneTransferModule.__CommonTransferCallback, callbackArgs)
end

function SceneTransferModule.MainCityToBattle()
	return
end

function SceneTransferModule.StoryToBattle()
	local callbackArgs = {
		SceneName = SceneTransferModule.SceneName.StoryBattle
	}

	SceneTransferModule.__Transfer(SceneTransferModule.TransferName.StoryToBattle, nil, SceneTransferModule.__CommonTransferCallback, callbackArgs)
end

function SceneTransferModule.LoginSceneToMainCityScene(args)
	local callbackArgs = {
		SceneName = SceneTransferModule.SceneName.MainCity
	}

	SceneTransferModule.__Transfer(SceneTransferModule.TransferName.LoginToMainCity, args, SceneTransferModule.__CommonTransferCallback, callbackArgs)
end

function SceneTransferModule.BattleToMainCity(args)
	local callbackArgs = {
		SceneName = SceneTransferModule.SceneName.MainCity
	}

	SceneTransferModule.__Transfer(SceneTransferModule.TransferName.BattleToMainCity, args, SceneTransferModule.__CommonTransferCallback, callbackArgs)
end

function SceneTransferModule.StoryToMainCity(fightOverPOD, arg)
	local args = {
		FightOverPOD = fightOverPOD,
		revertUI = arg.revertUI,
		callBack = arg.callBackFunc
	}
	local callbackArgs = {
		SceneName = SceneTransferModule.SceneName.MainCity
	}

	SceneTransferModule.__Transfer(SceneTransferModule.TransferName.StoryToMainCity, args, SceneTransferModule.__CommonTransferCallback, callbackArgs)
end

function SceneTransferModule.BattleToMaze(fightOverPOD)
	local args = {
		FightOverPOD = fightOverPOD
	}
	local callbackArgs = {
		SceneName = SceneTransferModule.SceneName.Maze
	}

	SceneTransferModule.__Transfer(SceneTransferModule.TransferName.BattleToMaze, args, SceneTransferModule.__CommonTransferCallback, callbackArgs)
end

function SceneTransferModule.BattleToStory(fightOverPOD)
	local args = {
		FightOverPOD = fightOverPOD
	}
	local callbackArgs = {
		SceneName = SceneTransferModule.SceneName.Story
	}

	SceneTransferModule.__Transfer(SceneTransferModule.TransferName.BattleToStory, args, SceneTransferModule.__CommonTransferCallback, callbackArgs)
end

function SceneTransferModule.GhostGameToMainCity()
	local callbackArgs = {
		SceneName = SceneTransferModule.SceneName.MainCity
	}

	SceneTransferModule.__Transfer(SceneTransferModule.TransferName.GhostGameToMainCity, nil, SceneTransferModule.__CommonTransferCallback, callbackArgs)
end

function SceneTransferModule.MainCityToGhostGame(activityId)
	local args = {
		activityId = activityId
	}
	local callbackArgs = {
		SceneName = SceneTransferModule.SceneName.GhostGame
	}

	SceneTransferModule.__Transfer(SceneTransferModule.TransferName.MainCityToGhostGame, args, SceneTransferModule.__CommonTransferCallback, callbackArgs)
end

function SceneTransferModule.EnterBattleByChapterType(chapterType)
	return
end

function SceneTransferModule.EnterCurrentDupByChapterType(arg)
	if SceneTransferModule.CurScene == SceneTransferModule.SceneName.EmptyMainCity then
		return
	end

	local userData = {}

	if GameChapterModule.CurSelectChapterType == Constant.ChapterPassType.TYPE_RESOURCES or GameChapterModule.CurSelectChapterType == Constant.ChapterPassType.TYPE_EQUIP or GameChapterModule.CurSelectChapterType == Constant.ChapterPassType.TYPE_BOSS then
		if GameChapterModule.CurSelectChapterType == Constant.ChapterPassType.TYPE_RESOURCES then
			userData.tagId = Constant.DupTagID.ResourcesDup
		elseif GameChapterModule.CurSelectChapterType == Constant.ChapterPassType.TYPE_EQUIP then
			userData.tagId = Constant.DupTagID.EquipDup
		elseif GameChapterModule.CurSelectChapterType == Constant.ChapterPassType.TYPE_BOSS then
			userData.tagId = Constant.DupTagID.BossDup
		end

		EventDispatcher.Dispatch(EventID.OpenMobilePhoneEvent, true)

		userData.tagId = GameChapterModule.CurSelectPlayingMethodType
		userData.selectedTagId = GameChapterModule.lastSelectChapterTagId

		CoroutineUtility.Yield(WaitOpenUI(Constant.UIControllerName.WorldAreaUI, Constant.UILayer.UI, {
			ToggleType = GameChapterModule.ToggleType
		}))
		CoroutineUtility.Yield(WaitOpenUI(Constant.UIControllerName.ResourceStageUI, Constant.UILayer.UI, userData))
		CoroutineUtility.Yield(WaitOpenUI(Constant.UIControllerName.StageUI, Constant.UILayer.UI, GameChapterModule.CurSelectChapterUserData))
	elseif GameChapterModule.CurSelectChapterType == Constant.ChapterPassType.TYPE_CLIMB_TOWER then
		EventDispatcher.Dispatch(EventID.OpenMobilePhoneEvent, true)
		CoroutineUtility.Yield(WaitOpenUI(Constant.UIControllerName.WorldAreaUI, Constant.UILayer.UI, {
			ToggleType = GameChapterModule.ToggleType
		}))
		CoroutineUtility.Yield(WaitOpenUI(Constant.UIControllerName.LoopTowerDungeonUI, Constant.UILayer.UI))
	elseif GameChapterModule.CurSelectChapterType == Constant.ChapterPassType.TYPE_Favor then
		CoroutineUtility.Yield(WaitOpenUI(Constant.UIControllerName.WarlockChoosePanel, Constant.UILayer.UI, {
			AutoSelectFavorStage = true,
			AutoSelectHeroId = GameChapterModule.currentFavorDupCfg and GameChapterModule.currentFavorDupCfg.HeroID or nil
		}))

		GameChapterModule.currentFavorDupCfg = nil
	elseif GameChapterModule.CurSelectChapterType == Constant.ChapterPassType.TYPE_Maze then
		EventDispatcher.Dispatch(EventID.OpenMobilePhoneEvent, true)
		CoroutineUtility.Yield(WaitOpenUI(Constant.UIControllerName.WorldAreaUI, Constant.UILayer.UI, {
			ToggleType = GameChapterModule.ToggleType
		}))
		CoroutineUtility.Yield(WaitOpenUI(Constant.UIControllerName.MazeUI, Constant.UILayer.UI, {
			isOpenMazeDetails = true
		}))
	elseif GameChapterModule.CurSelectChapterType == Constant.ChapterPassType.TYPE_StoryReview then
		CoroutineUtility.Yield(WaitOpenUI(Constant.UIControllerName.ArchivesUI, Constant.UILayer.UI))
	elseif GameChapterModule.CurSelectChapterType == Constant.ChapterPassType.TYPE_StoryGuide then
		-- block empty
	elseif GameChapterModule.CurSelectChapterType == Constant.ChapterPassType.TYPE_BattleActivity then
		CoroutineUtility.Yield(WaitOpenUI(Constant.UIControllerName.BattleActivityDungeonUI, Constant.UILayer.UI))

		if GameChapterModule.CurSelectChapterCfg and GameChapterModule.CurSelectChapterCfg.ChapterId then
			local activityDup = PlayerModule.GetActivityDup()

			for _, v in pairs(activityDup) do
				if v.chapterId == GameChapterModule.CurSelectChapterCfg.ChapterId then
					UIModule.Open(Constant.UIControllerName.ActivityStageUI, Constant.UILayer.UI, {
						ActivityChapterPOD = v
					})

					break
				end
			end
		end
	elseif GameChapterModule.CurSelectChapterType == Constant.ChapterPassType.TYPE_Challenge then
		CoroutineUtility.Yield(WaitOpenUI(Constant.UIControllerName.PlayingMethodUI, Constant.UILayer.UI))
		CoroutineUtility.Yield(WaitOpenUI(Constant.UIControllerName.ChapterStageMapUI, Constant.UILayer.UI, {
			chooseChallenge = true
		}))
	elseif GameChapterModule.CurSelectChapterType == Constant.ChapterPassType.TYPE_SummerActivity then
		local activityPod = ActivityModule.GetActivityPodByActivityType({
			Constant.ActivityType.ActivityType_Summer
		})[1]

		CoroutineUtility.Yield(WaitOpenUI(Constant.UIControllerName.SummerActivityStageUI, Constant.UILayer.UI, {
			activityPod = activityPod,
			selectChapterId = GameChapterModule.lastEnterChapterData.PassId
		}))
	elseif GameChapterModule.CurSelectChapterType == Constant.ChapterPassType.TYPE_Ghost then
		local activityPod = ActivityModule.GetActivityPodByActivityType({
			Constant.ActivityType.ActivityType_Ghost
		})[1]

		CoroutineUtility.Yield(WaitOpenUI(Constant.UIControllerName.GhostActivityStageUI, Constant.UILayer.UI, {
			activityPod = activityPod,
			selectChapterId = GameChapterModule.lastEnterChapterData.PassId
		}))
	elseif GameChapterModule.CurSelectChapterType == Constant.ChapterPassType.Type_GhostBoss then
		CoroutineUtility.Yield(WaitOpenUI(Constant.UIControllerName.ActiveActivityListUI, Constant.UILayer.UI, {
			teamID = Constant.ActivityListTeamID.SummerActivity
		}))

		local activityPod = ActivityModule.GetActivityPodByActivityType({
			Constant.ActivityType.ActivityType_GhostBoss
		})[1]

		CoroutineUtility.Yield(WaitOpenUI(Constant.UIControllerName.GhostBossChallengeUI, Constant.UILayer.UI, {
			activityPod = activityPod,
			selectChapterId = GameChapterModule.lastEnterChapterData.PassId
		}))
	elseif GameChapterModule.CurSelectChapterType == Constant.ChapterPassType.Type_ChallengeWorldBoss then
		EventDispatcher.Dispatch(EventID.OpenMobilePhoneEvent, true)
		CoroutineUtility.Yield(WaitOpenUI(Constant.UIControllerName.WorldAreaUI, Constant.UILayer.UI, {
			ToggleType = GameChapterModule.ToggleType
		}))
		CoroutineUtility.Yield(WaitOpenUI(Constant.UIControllerName.ChallengeWorldBossUI, Constant.UILayer.UI))
	end

	if arg.fightAgainUserData then
		local userData = {}

		userData.OpenType = 2
		userData.ChapterType = arg.fightAgainUserData.ChapterType
		userData.StageId = arg.fightAgainUserData.PassId

		UIModule.Open(Constant.UIControllerName.FormationUI, Constant.UILayer.UI, userData)
	end

	if arg.jumpUI then
		JumpModule.Jump(arg.jumpUI)
	end
end

function SceneTransferModule.GetCanBackHome()
	return SceneTransferModule.CurScene == SceneTransferModule.SceneName.MainCity
end

function SceneTransferModule.ReturnLogin()
	local callbackArgs = {
		SceneName = SceneTransferModule.SceneName.Login
	}

	SceneTransferModule.__Transfer(SceneTransferModule.TransferName.ReturnLogin, nil, SceneTransferModule.__CommonTransferCallback, callbackArgs)
end

function SceneTransferModule.LoadMainCity(revertUI, callback, args)
	local function yieldFun()
		HomeModule.EnterHomeScene()
		PopUpModule.PrepareMainUIAsyncPopupData()
		CoroutineUtility.Yield(WaitUntil(function()
			if not PopUpModule.IsMainUIAsyncPopupDataComplete() then
				return false
			end

			return HomeModule.isReady
		end))
		CoroutineUtility.Yield()
		PopUpModule.OnMainUIVisibleYieldFun(revertUI, args)
		CoroutineUtility.Yield()

		if callback ~= nil then
			callback(args.callBackArg)
		end
	end

	CoroutineUtility.StartCoroutine(yieldFun)
end

function SceneTransferModule.CommonEnterBattle(transferArgs, callback, callbackArgs)
	if SceneTransferModule.CurScene == SceneTransferModule.SceneName.Battle or SceneTransferModule.CurScene == SceneTransferModule.SceneName.StoryBattle or SceneTransferModule.CurScene == SceneTransferModule.SceneName.MazeBattle then
		BattleModule.RequestStartBattle(transferArgs.IsLocalFight, transferArgs.FightPOD, transferArgs.UserData)

		if callback ~= nil then
			callback(callbackArgs)
		end

		return
	end

	local transferName, sceneName = SceneTransferModule.__GetToBattleTransferName()
	local transferCallbackArgs = {
		SceneName = sceneName,
		Callback = callback,
		CallbackArgs = callbackArgs
	}

	SceneTransferModule.__Transfer(transferName, transferArgs, SceneTransferModule.__CommonTransferCallback, transferCallbackArgs)
end

function SceneTransferModule.__GetToBattleTransferName()
	if SceneTransferModule.CurScene == SceneTransferModule.SceneName.Story then
		return SceneTransferModule.TransferName.StoryToBattle, SceneTransferModule.SceneName.StoryBattle
	elseif SceneTransferModule.CurScene == SceneTransferModule.SceneName.Maze then
		return SceneTransferModule.TransferName.MazeToBattle, SceneTransferModule.SceneName.MazeBattle
	else
		return SceneTransferModule.TransferName.MainCityToBattle, SceneTransferModule.SceneName.Battle
	end
end

function SceneTransferModule.HomeToMaze(args)
	local callbackArgs = {
		SceneName = SceneTransferModule.SceneName.Maze
	}

	SceneTransferModule.__Transfer(SceneTransferModule.TransferName.HomeToMaze, args, SceneTransferModule.__CommonTransferCallback, callbackArgs)
end

function SceneTransferModule.MazeToHome(args)
	local callbackArgs = {
		SceneName = SceneTransferModule.SceneName.Home
	}

	SceneTransferModule.__Transfer(SceneTransferModule.TransferName.MazeToHome, args, SceneTransferModule.__CommonTransferCallback, callbackArgs)
end
