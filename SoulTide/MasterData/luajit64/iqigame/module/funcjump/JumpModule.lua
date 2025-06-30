-- chunkname: @IQIGame\\Module\\FuncJump\\JumpModule.lua

JumpModule = {
	jumpCid = 0
}

function JumpModule.Initialize()
	JumpModule.jumpCid = 0
	JumpModule.girlJumpData = nil

	GameEntry.LuaEvent:Subscribe(CloseUIFormCompleteEventArgs.EventId, JumpModule.OnUIClosed)
end

function JumpModule.Shutdown()
	GameEntry.LuaEvent:Unsubscribe(CloseUIFormCompleteEventArgs.EventId, JumpModule.OnUIClosed)
end

function JumpModule.Jump(cid, jumpData)
	local cfgData = CfgFunctionTable[cid]

	if cfgData == nil then
		return
	end

	if cfgData.FunctionOpen ~= nil and cfgData.FunctionOpen ~= 0 and UnlockFunctionModule.IsUnlock(cfgData.FunctionOpen) == false then
		NoticeModule.ShowNoticeByType(1, CfgFunctionTypeTable[cfgData.FunctionOpen].LockNotice)

		return
	end

	if cfgData.FunctionOpen == Constant.UnlockType.MAZE then
		local unfinishedMazeCid = PlayerModule.GetUnfinishedMazeCid(Constant.Maze.ChapterTypeNormal)

		if unfinishedMazeCid ~= nil then
			NoticeModule.ShowNoticeNoCallback(21045001)

			return
		end
	end

	if cfgData.FunctionOpen == Constant.UnlockType.ENDLESS_MAZE then
		local unfinishedMazeCid = PlayerModule.GetUnfinishedMazeCid(Constant.Maze.ChapterTypeEndless)

		if unfinishedMazeCid ~= nil then
			NoticeModule.ShowNoticeNoCallback(21045001)

			return
		end
	end

	if PlayerModule.InMaze and cfgData.SceneType ~= SceneID.Battle and cfgData.SceneType ~= SceneID.Maze and cfgData.SceneType > 0 then
		NoticeModule.ShowNoticeNoCallback(21045001)

		return
	end

	if cfgData.SceneType ~= PlayerModule.CurrSceneID and cfgData.SceneType > 0 then
		JumpModule.jumpCid = cid

		if PlayerModule.CurrSceneID == SceneID.Home then
			HomeLandLuaModule.Shutdown()
			net_home.exitHome()
		elseif PlayerModule.CurrSceneID == SceneID.Girl then
			net_girl.exitGirls()
		elseif PlayerModule.CurrSceneID == SceneID.Panda then
			ActivePandaModule.Shutdown()
		elseif PlayerModule.CurrSceneID == SceneID.CommonActivity and GuildModule.isInGuildScene then
			GuildModule.ExitGuild()
		end

		if cfgData.SceneType == SceneID.MainCity then
			if cfgData.FunctionType == Constant.Function.openTown then
				JumpModule.jumpCid = 0
				TownModule.inTown = true
			end

			SceneManager.ChangeScene(SceneID.MainCity)
		elseif cfgData.SceneType == SceneID.Home then
			HomeLandLuaModule.EnterHome()
		elseif cfgData.SceneType == SceneID.Girl then
			if jumpData ~= nil then
				JumpModule.girlJumpData = jumpData
			end

			net_girl.getGirls()
		end
	else
		JumpModule.jumpCid = 0

		local userData, uiName

		if cfgData.FunctionType == Constant.Function.openShopUI then
			uiName = Constant.UIControllerName.ShopUI
			userData = {
				cfgData.Params[1],
				cfgData.Params[2]
			}
		elseif cfgData.FunctionType == Constant.Function.openActivityUI then
			uiName = Constant.UIControllerName.ActivityUI
			userData = cfgData.Params[1]

			if userData == Constant.Activity_ID.MoonLogin or userData == Constant.Activity_ID.MoonTip then
				if not ActiveModule.CheckMoonIsOpened() then
					NoticeModule.ShowNoticeNoCallback(21045030)

					return
				end
			elseif userData == Constant.Activity_ID.NationalDay and not ActiveModule.CheckNationalDayIsOpened() then
				NoticeModule.ShowNoticeNoCallback(21045030)

				return
			end
		elseif cfgData.FunctionType == Constant.Function.openMallUI then
			uiName = Constant.UIControllerName.MallUI

			local tempData = jumpData

			if tempData == nil then
				tempData = cfgData.Params[4]
			end

			userData = {
				cfgData.Params[1],
				cfgData.Params[2],
				cfgData.Params[3],
				tempData
			}
		elseif cfgData.FunctionType == Constant.Function.openTaskUI then
			uiName = Constant.UIControllerName.MissionUI
			userData = cfgData.Params[1]
		elseif cfgData.FunctionType == Constant.Function.openLotteryUI then
			uiName = Constant.UIControllerName.LotteryUI
		elseif cfgData.FunctionType == Constant.Function.openBattleMonsterInfoUI then
			uiName = Constant.UIControllerName.BattleMonsterInfoUI
			userData = {
				monsterCid = cfgData.Params[1]
			}
		elseif cfgData.FunctionType == Constant.Function.openFurnitureLotteryUI then
			uiName = Constant.UIControllerName.FurnitureLotteryUI
		elseif cfgData.FunctionType == Constant.Function.openTownHandbookUI then
			uiName = Constant.UIControllerName.TownHandbookUI
		elseif cfgData.FunctionType == Constant.Function.openGameGuideInfoUI then
			uiName = Constant.UIControllerName.GameGuideInfoUI
		elseif cfgData.FunctionType == Constant.Function.openSoulUI then
			uiName = Constant.UIControllerName.SoulUI

			local soulCid

			if #cfgData.Params >= 2 then
				soulCid = cfgData.Params[2]
			else
				soulCid = jumpData
			end

			local soulData = SoulModule.GetUnlockSoulDataDic()[soulCid]

			if soulData == nil then
				NoticeModule.ShowNotice(21045000)

				return
			end

			userData = {
				[UIParam.soulUI.soulData] = soulData,
				[UIParam.soulUI.tabIndex] = cfgData.Params[1]
			}
		elseif cfgData.FunctionType == Constant.Function.openGirlUI then
			JumpModule.CloseUIGroup()
			EventDispatcher.Dispatch(EventID.FuncJump, cfgData.Id)

			return
		elseif cfgData.FunctionType == Constant.Function.openWorldMazeChooseUI then
			local childTabIndex = cfgData.Params[1]

			JumpModule.CloseUIGroup()
			DailyDupModule.OpenChallengeUI(1, childTabIndex)

			return
		elseif cfgData.FunctionType == Constant.Function.openMazeDetailUI then
			local chapterId = cfgData.Params[1]

			for id, v in pairsCfg(CfgChapterTable) do
				if v.Type == 2 and v.Id == chapterId and v.LockCondition ~= 0 and ConditionModule.Check(v.LockCondition) == false then
					NoticeModule.ShowNotice(21045005)

					return
				end
			end

			local instanceId = cfgData.Params[2]
			local cfgInstanceData = CfgMazeInstanceTable[instanceId]

			if ConditionModule.Check(cfgInstanceData.LockCondition) == false and ConditionModule.Check(cfgInstanceData.QuickChallengeLockCondition) == false then
				NoticeModule.ShowNotice(21045006)

				return
			end

			if PlayerModule.PlayerInfo.baseInfo.pLv < cfgInstanceData.LockLevel then
				NoticeModule.ShowNoticeNoCallback(21045028, cfgInstanceData.LockLevel)

				return
			end

			uiName = Constant.UIControllerName.MazeDetailUI
			userData = {
				mazeCid = instanceId
			}
		elseif cfgData.FunctionType == Constant.Function.openForgeTitleListUI then
			uiName = Constant.UIControllerName.ForgeTitleListUI
			userData.funcJumpParam = cfgData.Params[1]
		elseif cfgData.FunctionType == Constant.Function.openSoulListUI then
			uiName = Constant.UIControllerName.SoulListUI
		elseif cfgData.FunctionType == Constant.Function.openEquipBg then
			uiName = Constant.UIControllerName.EquipListUI
		elseif cfgData.FunctionType == Constant.Function.openActivitySignUI then
			uiName = Constant.UIControllerName.ActivitySignUI
		elseif cfgData.FunctionType == Constant.Function.openFormationUI then
			uiName = Constant.UIControllerName.FormationUI
		elseif cfgData.FunctionType == Constant.Function.openActiveWeekendUI then
			uiName = Constant.UIControllerName.ActiveWeekendUI
		elseif cfgData.FunctionType == Constant.Function.openDailyDup then
			local challengeId = cfgData.Params[1]

			JumpModule.CloseUIGroup()
			DailyDupModule.OpenChallengeUI(2, challengeId)

			return
		elseif cfgData.FunctionType == Constant.Function.openRPGMaze then
			if RpgMazeModule.IsShow() then
				JumpModule.CloseUIGroup()
				DailyDupModule.OpenChallengeUI(3)
			else
				NoticeModule.ShowNoticeNoCallback(21057005)
			end

			return
		elseif cfgData.FunctionType == Constant.Function.openNoticeUI then
			uiName = Constant.UIControllerName.NoticeUI

			if jumpData then
				userData = {
					2,
					jumpData
				}
			else
				userData = {
					2,
					cfgData.Params[1]
				}
			end
		elseif cfgData.FunctionType == Constant.Function.openTownExchangeUI then
			uiName = Constant.UIControllerName.TownExchangeUI
		elseif cfgData.FunctionType == Constant.Function.openSoulEvolutionUI then
			uiName = Constant.UIControllerName.SoulEvolutionUI
			userData = jumpData
		elseif cfgData.FunctionType == Constant.Function.openActiveRookieUI then
			uiName = Constant.UIControllerName.ActiveRookieUI

			if #cfgData.Params > 0 then
				userData = cfgData.Params[1]
			end
		elseif cfgData.FunctionType == Constant.Function.openSoulUnlockUI then
			uiName = Constant.UIControllerName.SoulUnlockUI
			userData = {}

			if #cfgData.Params > 0 then
				userData[UIParam.soulUnlockUI.soulIds] = {
					cfgData.Params[1]
				}
				userData[UIParam.soulUnlockUI.type] = cfgData.Params[2]
				userData[UIParam.soulUnlockUI.index] = nil
			end
		elseif cfgData.FunctionType == Constant.Function.openTown then
			EventDispatcher.Dispatch(EventID.ChangeTownViewEvent, true)
			GameEntry.UI:CloseUIGroup(Constant.UILayer.UI)
		elseif cfgData.SceneType == SceneID.MainCity and cfgData.FunctionType == 0 then
			EventDispatcher.Dispatch(EventID.ChangeTownViewEvent, false)
			GameEntry.UI:CloseUIGroup(Constant.UILayer.UI)
		elseif cfgData.FunctionType == Constant.Function.openActivityCreditUI then
			local result = ActiveModule.GetFirstRechargeTaskData().TaskStatus ~= TaskModule.TaskStatus.FINISH_TASK

			if not result then
				return
			end

			uiName = Constant.UIControllerName.ActivityCreditUI
		elseif cfgData.FunctionType == Constant.Function.openBuyExchangePanelUI then
			uiName = Constant.UIControllerName.BuyExchangePanelUI

			local id = cfgData.Params[1]

			userData = CfgExchangeTable[id]
		elseif cfgData.FunctionType == Constant.Function.openExploreHall then
			uiName = Constant.UIControllerName.ExploreHallUI
			userData = {
				tabIndex = cfgData.Params[1],
				childTabIndex = cfgData.Params[2]
			}
		elseif cfgData.FunctionType == Constant.Function.openMonsterAcademySelectPanelUI then
			uiName = Constant.UIControllerName.MonsterAcademySelectPanelUI
			userData = {
				AreaCid = cfgData.Params[1]
			}
		elseif cfgData.FunctionType == Constant.Function.openGiftSalesTimePanelUI then
			uiName = Constant.UIControllerName.GiftSalesTimePanelUI
		elseif cfgData.FunctionType == Constant.Function.openMiningMainUI then
			MiningModule.EnterMap()
		elseif cfgData.FunctionType == Constant.Function.openCelebrationGiftUI then
			uiName = Constant.UIControllerName.CelebrationGiftUI
		end

		if uiName ~= nil then
			if UIModule.HasUI(uiName) then
				EventDispatcher.Dispatch(EventID.JumpToOpenedFunc, {
					uiName,
					userData
				})
			else
				JumpModule.CloseUIGroup()
				UIModule.Open(uiName, Constant.UILayer.UI, userData)
			end
		else
			JumpModule.CloseUIGroup()
		end
	end
end

function JumpModule.CloseUIGroup()
	GameEntry.UI:CloseUIGroup(Constant.UILayer.Mid)
	GameEntry.UI:CloseUIGroup(Constant.UILayer.Tooltip)
end

function JumpModule.CheckContinueJump(isAddScene)
	if isAddScene then
		return
	end

	if JumpModule.jumpCid ~= 0 then
		JumpModule.Jump(JumpModule.jumpCid)
	end
end

function JumpModule.OnUIClosed(sender, args)
	if args.UIFormAssetName == AssetPath.Get(GlobalKey.UIPrefabPath, Constant.UIControllerName.ActivitySignUI) then
		JumpModule.CheckToAutoOpenUI()
	end
end

function JumpModule.CheckToAutoOpenUI()
	if SignInModule.CheckNeedOpenSignUI() then
		UIModule.Open(Constant.UIControllerName.ActivitySignUI, Constant.UILayer.UI)

		return
	end

	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.NOTICE)

	if result and PlayerModule.PlayerInfo.currDialog == 0 and LoginModule.isOpenNotice == false and not GuideModule.HasGuide() then
		local hasNotice = false

		for i, v in pairsCfg(CfgGameEventadsTable) do
			local remainTime = 1
			local beginTime = 0

			if v.BeginTime ~= "" and v.EndTime ~= "" then
				beginTime = cfgDateTimeToTimeStamp(v.BeginTime, PlayerModule.TimeZone)
				remainTime = beginTime + tonumber(v.EndTime) - PlayerModule.GetServerTime()
			end

			local resultCondition = true

			if v.CloseCondition > 0 then
				resultCondition = not ConditionModule.Check(v.CloseCondition)
			end

			if remainTime > 0 and beginTime <= PlayerModule.GetServerTime() and resultCondition then
				hasNotice = true

				break
			end
		end

		if hasNotice and (CfgDiscreteDataTable[6520061].Data[1] == 0 or LuaCodeInterface.GetOS() ~= "IOS") then
			UIModule.Open(Constant.UIControllerName.NoticeUI, Constant.UILayer.UI, {
				2
			})
		end
	end
end
