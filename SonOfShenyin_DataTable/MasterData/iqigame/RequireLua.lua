-- chunkname: @IQIGame\\RequireLua.lua

local LoadList = {}
local LoadUtilList = {
	Path = "Util",
	Value = {
		"Class",
		"Math",
		"Layer",
		"Enum",
		"Tags",
		"Array"
	}
}

table.insert(LoadList, LoadUtilList)

local LoadIQIUtilList = {
	Path = "IQIGame.Util",
	Value = {
		"Queue",
		"AssetUtil",
		"UIUtil",
		"ModuleTimerUtil",
		"Stack",
		"TimeLine.TimelineUtilityByLua",
		"LuaUtility",
		"CfgUtil",
		"LuaUtility_Spine",
		"LuaUtility_Animation",
		"LuaUtility_Effect",
		"UIAnimationUtil",
		"EventUtil",
		"UIEventUtil"
	}
}

table.insert(LoadList, LoadIQIUtilList)

local LoadConstantList = {
	Path = "IQIGame.Definition",
	Value = {
		"Constant",
		"AttributeConst",
		"UIControllerName",
		"TipConst",
		"UIParam",
		"SceneID",
		"RedDotDefine",
		"BattleConstant",
		"HomeLandConstant"
	}
}

table.insert(LoadList, LoadConstantList)

local LoadRootList = {
	Path = "IQIGame",
	Value = {
		"Global",
		"RequireConfig",
		"RequireConfigCustomizer",
		"RequireCSharpBinding",
		"RequireToGlobal"
	}
}

table.insert(LoadList, LoadRootList)

local LoadGlobalFunctionList = {
	Path = "IQIGame.GlobalFunction",
	Value = {
		"CustomTableFunction",
		"CustomStringFunction"
	}
}

table.insert(LoadList, LoadGlobalFunctionList)

local LoadCoreList = {
	Path = "IQIGame.Core",
	Value = {
		"Base",
		"Initialization",
		"NetManager",
		"CSharpInterface",
		"GlobalListener"
	}
}

table.insert(LoadList, LoadCoreList)

local LoadEventList = {
	Path = "IQIGame.Events",
	Value = {
		"EventID",
		"EventDispatcher"
	}
}

table.insert(LoadList, LoadEventList)

local LoadNetList = {
	Path = "IQIGame.Net",
	Value = {
		"net",
		"NetCommController",
		"NetPlayerResponse",
		"NetUserResponse",
		"NetWarehouseResponse",
		"NetChatRoomResponse",
		"NetRoleDevelopmentResponse",
		"NetEquipResponse",
		"NetGameChapterResponse",
		"NetCombatFormationResponse",
		"NetFriendResponse",
		"NetFightResponse",
		"NetMailResponse",
		"NetTaskResponse",
		"NetItemResponse",
		"NetLotteryResponse",
		"NetShopResponse",
		"NetSignInResponse",
		"NetSkinResponse",
		"ChapterNet.NetEquipChapterResponse",
		"ChapterNet.NetResourceChapterResponse",
		"NetPlotStageResponse",
		"ChapterNet.NetBossChapterResponse",
		"ChapterNet.NetActivityDupResponse",
		"RedDotResponse",
		"NetActivityPass",
		"NetFormationResponse",
		"NetClimbTowerResponse",
		"NetMonthCardResponse",
		"NetMapResponse",
		"NetFavorable",
		"NetMazeResponse",
		"NetMazeStageResponse",
		"NetActivityResponse",
		"NetHomeResponse",
		"NetRichManResponse",
		"NetSummerActivityResponse",
		"NetGhostGameResponse",
		"NetWorldMapResponse",
		"NetFavorResponse",
		"NetWorldBossDupResponse",
		"NetCenterRankResponse",
		"NetCrusadeResponse",
		"NetCenterChatResponse",
		"NetActivityRechargeResponse"
	}
}

table.insert(LoadList, LoadNetList)

local LoadModuleList = {
	Path = "IQIGame.Module",
	Value = {
		"Util.EffectUtility",
		"Util.EntityUtility",
		"Util.OpenUIUtility",
		"Util.SceneUtility",
		"Util.CustomCoroutine.CoroutineUtility",
		"Util.CustomCoroutine.CustomWait",
		"Util.CustomCoroutine.WaitAll",
		"Util.CustomCoroutine.WaitWhile",
		"Util.CustomCoroutine.WaitUntil",
		"Util.CustomCoroutine.CustomWaitForSeconds",
		"Util.CustomCoroutine.WaitForEndOfFrame",
		"Util.CustomCoroutine.YieldReturnNull",
		"Util.CustomCoroutine.WaitLoadSceneAdditively",
		"Util.CustomCoroutine.WaitLoadSceneByPrefab",
		"Util.CustomCoroutine.WaitLoadScene",
		"Util.CustomCoroutine.WaitOpenUI",
		"Util.CustomCoroutine.WaitLoadAsset",
		"Util.FSMState",
		"Util.FiniteStateMachine",
		"Util.CustomCoroutine.WaitCreateNPC",
		"Util.CustomCoroutine.WaitCreateEntity",
		"Login.ProcedureReset",
		"Login.LoginModule",
		"Login.HttpRequestParam",
		"Login.SDKLoginModule",
		"Player.PlayerModule",
		"Battle.BattleModule",
		"Battle.BattleSkillModule",
		"Battle.BattleTeamActionModule",
		"Battle.BattleScatteredResModule",
		"Battle.BattleEffectModule",
		"Battle.BattleTimelineModule",
		"Battle.BattleEntitySortingOrderManager",
		"Battle.Util.BattleEffectUtility",
		"BehaviorTree.BehaviorTreeUtility",
		"BehaviorTree.BehaviorTreeUtility_Effect",
		"BehaviorTree.BehaviorTreeUtility_Skip",
		"BehaviorTree.BehaviorTreeUtility_WoldMapRPG",
		"Story.StoryModule",
		"Story.StoryCharacter",
		"Story.StoryNPC",
		"Story.StoryPlayer",
		"Story.ConversationModule",
		"Story.StoryModule_Myth",
		"Story.FSM.StoryFSM",
		"Story.FSM.StoryIdleState",
		"Story.FSM.StoryMoveState",
		"Story.FSM.StoryInteractState",
		"Story.FSM.StoryNullState",
		"Story.FSM.StoryTimeLineState",
		"Maze.MazeStageModule",
		"Battle.BattleDamageEffect.BattleDamageEffectComponent",
		"Battle.BattleDamageEffect.BaseBattleDamageEffect",
		"Battle.BattleDamageEffect.BattleDamageEffectNormal",
		"Battle.BattleDamageEffect.BattleDamageEffectIndirect",
		"Battle.BattleDamageEffect.BattleDamageEffectCritical",
		"Battle.BattleDamageEffect.BattleDamageEffectElement",
		"Battle.BattleDamageEffect.BattleDamageEffectDot",
		"Battle.BattleDamageEffect.BattleDamageEffectTotal",
		"Battle.BattleDamageEffect.BattleDamageEffectShield",
		"Common.UIModule",
		"Common.NoticeModule",
		"Sound.SoundPackageData",
		"Sound.SoundPackagePlayer",
		"Warehouse.ItemModule",
		"Warehouse.ItemData",
		"Warehouse.WarehouseModule",
		"Warehouse.SkillData",
		"Warlock.WarlockModule",
		"Warlock.WarlockData",
		"UserInfo.UserInfoModule",
		"RoleDevelopment.RoleDevelopmentModule",
		"GameChapter.GameChapterModule",
		"GameChapter.GameChapterItemData",
		"GameChapter.GameLevelItemData",
		"CombatFormation.CombatFormationModel",
		"CombatFormation.CombatFormationData",
		"Friend.FriendModule",
		"AssistInFighting.AssistInFightingModule",
		"AssistInFighting.AssisInFightingData",
		"Mail.MailModule",
		"Mail.MailData",
		"TaskSystem.TaskSystemModule",
		"TaskSystem.TaskSystemData",
		"TaskSystem.TaskSystemModule_Maze",
		"CreateRole.CreateRoleModule",
		"FuncJump.JumpModule",
		"Lottery.LotteryModule",
		"Shop.ShopModule",
		"Shop.ShopModule_MazeShop",
		"Shop.ShopData",
		"SignIn.SignInModule",
		"Skin.SkinModule",
		"RoleExtend.RoleExtendModule",
		"RoleInfoDetails.RoleInfoDetailsModule",
		"Guide.GuideModule",
		"Guide.GuideConditionModule",
		"FormatRole.FormatRoleModule",
		"GameNotice.GameNoticeModule",
		"Condition.ConditionModule",
		"Setting.SettingModule",
		"GmOrder.GmOrderModule",
		"GMOrder2.GMOrder2Module",
		"Chat.WarnStrFunc",
		"Chapter.EquipChapter.EquipChapterModule",
		"Chapter.ResourceChapter.ResourceChapterModule",
		"Chapter.BossChapter.BossChapterModule",
		"Activity.ActivityModule",
		"ActivityPass.ActivityPassModule",
		"UnlockFunction.UnlockFunctionModule",
		"Puzzle.PuzzleModule",
		"Achievement.AchievementModule",
		"Formation.FormationModule",
		"Main.MainCityModule",
		"Main.MainCityDialogueModule",
		"SceneTransfer.SceneTransferModule",
		"Story.StoryChapterModule",
		"Lottery.LotterySceneModule",
		"RedDot.RedDotModule",
		"RedDot.RedDotTree",
		"RedDot.RedDotNode",
		"PopUp.PopUpModule",
		"Tower.TowerModule",
		"Terrain.TerrainModule",
		"MonthCard.MonthCardModule",
		"Equip.EquipModule",
		"Equip.EquipData",
		"DiySkill.DiySkillModule",
		"Map.MapModule",
		"Map.MapItemManager",
		"Transform.TransformModule",
		"Maze.MazeModule",
		"Maze.MazeBattleStepModule",
		"Maze.MazeEventModule",
		"Maze.MazeEffectModule",
		"Maze.MazeSoundModule",
		"Common.Screen.CommonScreenModule",
		"ActivityDungeon.ActivityDungeonModule",
		"ActivityList.ActivityListModule",
		"Home.HomeModule",
		"Chapter.ChapterModule",
		"CV.CVModule",
		"ActiveActivityList.ActiveActivityListModule",
		"SummerActivity.SummerActivityModule",
		"GhostGame.GhostGameModule",
		"GhostGame.GhostGameBuffManager",
		"WorldMap.WorldMapModule",
		"WorldMap.WorldMapModule_Action",
		"FSM.FSMModule",
		"Affinity.AffinityModule",
		"ChallengeWorldBoss.ChallengeWorldBossModule",
		"Common.NpcTalk.NpcActionModule",
		"CenterRankModule.CenterRankModule",
		"GlobalBuff.GlobalBuffModule",
		"CenterChat.CenterChatModule"
	}
}

table.insert(LoadList, LoadModuleList)

local LoadHelperList = {
	Path = "IQIGame.Helper",
	Value = {
		"UIDelayHelper"
	}
}

table.insert(LoadList, LoadHelperList)

local LoadOtherCommonList = {
	Path = "IQIGame.Common",
	Value = {
		"TapContent",
		"TapContents",
		"ObjectPoolManager",
		"ColorCfg",
		"Filter",
		"Sorter"
	}
}

table.insert(LoadList, LoadOtherCommonList)

local LoadUIApiList = {
	Path = "IQIGame.UIExternalApi",
	Value = {
		"UIGlobalApi",
		"BaseLangApi",
		"MiscApi",
		"LoginUIApi",
		"UIGlobalApi",
		"LoadingUIApi",
		"NoticeUIApi",
		"ConfirmationUIApi",
		"UserInfoApi",
		"MainUIExtendApi",
		"CommonSlotUIApi",
		"WarehouseUIApi",
		"ItemTipsApi",
		"RoleDevelopmentApi",
		"WarlockApi",
		"MainUIAPI",
		"EquipApi",
		"MailUIApi",
		"GetPanelUIApi",
		"TaskUIApi",
		"InputPlayerNameTextUIApi",
		"UseNumberUIApi",
		"FriendUIApi",
		"LotteryUIApi",
		"LotteryRewardListUIApi",
		"ShopUIApi",
		"ShowCGUIApi",
		"SignInUIApi",
		"SkinUIApi",
		"RoleExtendApi",
		"RoleInfoDetailsUIApi",
		"GuideSub",
		"CombatFormationUIApi",
		"FormatRoleUIAPI",
		"SkillStrengthUIApi",
		"LotteryRecordsUIApi",
		"SettingUIApi",
		"OtherExtendApi",
		"BattleApi",
		"GameChapterApi",
		"ChapterUIApi",
		"LoginActivationCodeUIApi",
		"ActivityPassApi",
		"FormationUIApi",
		"GameLevelEndUIApi",
		"StoryChapterPassUIApi",
		"StoryUIApi",
		"BuyEnergyUIApi",
		"ConvertUIApi",
		"NoviceActivityApi",
		"SkinApi",
		"ClimbTowerApi",
		"AchievementApi",
		"TerrainApi",
		"StrengthTipsUIApi",
		"CommonHeroScreenViewApi",
		"CfgLoopMap",
		"MainChapterUIApi",
		"StoryStageUIApi",
		"ThreadPuzzleUIApi",
		"PuzzleUIApi",
		"OpenFuncTipsUIApi",
		"BattleUIApi",
		"CommonItemTipsUIApi",
		"CommonTipsApi",
		"CommonGiftTipsUIApi",
		"CommonSkillTipsUIApi",
		"CommonEquipTipsUIApi",
		"DiySkillStrengthenUIApi",
		"ChapterStageMapUIApi",
		"UseGiftUIApi",
		"NoviceTaskUIApi",
		"NoviceSignUIApi",
		"MazeApi",
		"CommonSortingPopupListApi",
		"DupMultipleActivityUIApi",
		"HomeLandApi",
		"ActivityListUIApi",
		"GhostGameApi",
		"CommonConditionSelectionUIApi"
	}
}

table.insert(LoadList, LoadUIApiList)

local LoadUIList = {
	Path = "IQIGame.UI",
	Value = {
		"Bag.ItemCell",
		"Bag.ExtendItemCell",
		"WarlockList.ExtendItemCellOne",
		"Guide.GuideUIUtil",
		"Common.CurrencyCell",
		"Common.BaseChildrenPanel",
		"Common.CommonReturnBtn",
		"LoopMapUI.LoopMapBaseCell",
		"Dialog.CommonDialogueActionUtil",
		"Common.CommonConsumeGold",
		"Common.NpcTalk.CommonNpcTalkView",
		"Common.Skill.CommonSkillImageView"
	}
}

table.insert(LoadList, LoadUIList)

local c = {
	sampleStack = {}
}

function c.beginSample(content, minLogTime)
	local stac = {}

	stac.content = content
	stac.minLogTime = minLogTime
	stac.startTime = os.clock()

	table.insert(c.sampleStack, stac)
end

function c.endSample()
	local info = table.remove(c.sampleStack)

	if info then
		local endTime = os.clock()
		local cost = endTime - info.startTime

		cost = cost * 1000
		cost = math.floor(cost)

		if cost >= info.minLogTime then
			local str = string.format("%s cost:%s", info.content, cost)

			log(str)
		end
	else
		error("not end sample")
	end
end

profile = c

function LoadScripts()
	class = require("IQIGame.Module.Util.InheritableClass")

	require("IQIGame.Global")

	for k, v in pairs(LoadList) do
		local Path = v.Path or ""

		for tm, mod in pairs(v.Value or {}) do
			profile.beginSample(Path .. "." .. mod, 5)
			require(Path .. "." .. mod)
			profile.endSample()
		end
	end
end

Log = UnityGameFramework.Runtime.Log

LoadScripts()
