-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\UIStateVisible.lua

local UIVisible = {}

UIVisible.Map0 = {
	noticebox = {
		1
	}
}
UIVisible.Map1 = {
	containState = {
		Const.STATE_LOGIN,
		Const.STATE_LOGIN_START,
		Const.STATE_LOGIN_CREATE
	},
	ui = {
		login = {
			nil,
			1,
			0
		},
		loginQueueBox = {
			nil,
			nil,
			0
		},
		servers = {
			nil,
			nil,
			0
		},
		loginSpinner = {
			0,
			0,
			0
		}
	}
}
UIVisible.Map2 = {
	containState = {
		Const.STATE_MAIN_STAGE,
		Const.STATE_MAIN_MAZE,
		Const.STATE_MAIN,
		Const.STATE_MAIN_REAR_HOUSE,
		Const.STATE_MAIN_HOME,
		Const.STATE_MAIN_CIRCLE,
		Const.STATE_CLIMB_TOWER,
		Const.STATE_ELIMINATE
	},
	ui = {
		mainMenu = {
			0,
			0,
			nil,
			0,
			nil,
			0
		},
		createRoleDlg = {},
		createRoleResultDlg = {},
		speakerbox = {
			1,
			nil,
			nil,
			nil,
			nil,
			0
		},
		flyiconbox = {
			1
		},
		mainStageDlg = {
			nil,
			0
		},
		mainStageAwardBox = {},
		mainStageTitleBox = {},
		drawCardMainDlg = {},
		drawCardResultDlg = {},
		drawNewbieConfirmDlg = {},
		drawCardShowDlg = {},
		drawCardOperateDlg = {},
		achieveMainDlg = {},
		newbieTaskDlg = {},
		giftExchangeDlg = {},
		mailBoxDlg = {},
		mailResultDlg = {},
		mallDlg = {},
		shopBuyBox = {},
		moneyTradeBox = {},
		rechargeDlg = {},
		friendMainDlg = {},
		friendAddDlg = {},
		friendRequestListDlg = {},
		friendBlackListDlg = {},
		playerTips = {},
		equipTowerMainDlg = {},
		equipTowerLevelDlg = {},
		onceTowerLevelDlg = {},
		onceTowerRecordDlg = {},
		onceTowerMonsterDlg = {},
		pvpMainDlg = {},
		pvpEnemyDlg = {},
		pvpRecordDlg = {},
		pvpRankAwardDlg = {},
		pvpResultCleanDlg = {},
		pvpChooseDlg = {},
		seniorPvpMainDlg = {},
		seniorPvpCheckTeamDlg = {},
		seniorPvpEnemyDlg = {},
		seniorPvpRecordDlg = {},
		seniorPvpRecordInfoDlg = {},
		worldBossMainDlg = {},
		rankingAwardDlg = {},
		worldBossAnnounceDlg = {},
		worldBossAwardDlg = {},
		worldBossRecordDlg = {},
		worldBossPointAwardGetDlg = {},
		bossChooseDlg = {},
		bossMainDlg = {},
		bossWaveAwardBox = {},
		heroMainDlg = {},
		heroStarUpDlg = {},
		heroStarUpInfoDlg = {},
		heroStarUpFinishDlg = {},
		heroStarUpFastDlg = {},
		heroCardListSetDlg = {},
		heroUpgradeResultDlg = {},
		heroStarUpMaterialDlg = {},
		heroEquipWearDlg = {},
		heroEquipUpGradeDlg = {},
		heroSellDlg = {},
		heroSellRewardDlg = {},
		heroResetDlg = {},
		heroGroupCareerInfoDlg = {},
		handBookMainDlg = {},
		handBookHeroListDlg = {},
		handBookHeroInfoDlg = {},
		handBookAwardDlg = {},
		handBookArtifactDlg = {},
		handBookRankSelectDlg = {},
		handBookRankInfoDlg = {},
		heroGrowRecommendDlg = {},
		heroGrowBecomeLeaderDlg = {},
		heroBecomeLeaderDlg = {},
		heroTips = {},
		equipTips = {},
		equipTempleteTips = {},
		artifactTips = {},
		fragItemTips = {},
		itemTips = {},
		itemSellDlg = {},
		bagGridAddDlg = {},
		stepTowerDlg = {},
		stepTowerSweepResultDlg = {},
		stepTowerLevelDlg = {},
		chatDlg = {},
		chatEmojiBox = {},
		chooseFriendDlg = {},
		mazeMainDlg = {},
		mazeHeroCheckDlg = {},
		mazeInfoLvDlg = {},
		mazeHallowChooseDlg = {},
		mazeChooseDlg = {},
		mazeFinishDlg = {},
		mainBagDlg = {},
		MazeAwardCheckDlg = {},
		MazeFirstPassDlg = {},
		MazeChangeDlg = {},
		heroAllDlg = {},
		rearHouseMainDlg = {},
		rearHouseEditDlg = {},
		rearHouseLvUpDlg = {},
		rearHouseUnlockDlg = {},
		rearHouseCrystalInfoDlg = {},
		rearHouseShopDlg = {},
		rearHouseCrystalResultDlg = {},
		rearHouseCleanDlg = {},
		rearHouseCleanAwardDlg = {},
		rearHouseVisitMainDlg = {},
		rearHouseVisitChooseDlg = {},
		dispatchDlg = {},
		dispatchInfoDlg = {},
		dispatchExtraAwardDlg = {},
		rearHouseComfortableDlg = {},
		mainSettingDlg = {},
		rankMainDlg = {},
		performStartAniDlg = {},
		sweepMainDlg = {},
		giftBuyBox = {},
		monthCardResultBox = {},
		roleInfoPersonalDlg = {},
		roleInfoOtherDlg = {},
		editNameDlg = {},
		editSexDlg = {},
		editSignDlg = {},
		roleInfoHeroDlg = {},
		editHeadDlg = {},
		bpBuyBox = {},
		bpSpeedUpBox = {},
		bPLvUpResultBox = {},
		activityPlotDlg = {},
		activityPlotInfoDlg = {},
		ActivityAchievePubDlg = {},
		activityPlotBattleDlg = {}
	}
}
UIVisible.Map3 = {
	containState = {
		Const.STATE_MAIN_STAGE,
		Const.STATE_MAIN_MAZE,
		Const.STATE_MAIN,
		Const.STATE_MAIN_REAR_HOUSE,
		Const.STATE_MAIN_HOME,
		Const.STATE_MAIN_CIRCLE,
		Const.STATE_BATTLE,
		Const.STATE_BATTLE_REPLAY,
		Const.STATE_CLIMB_TOWER,
		Const.STATE_ELIMINATE
	},
	ui = {
		talkBox = {},
		avgVideoPlayer = {},
		confirmui = {},
		cleanResultDlg = {},
		infoNotice = {},
		rookieMainDlg = {},
		beginnerBackGround = {},
		beginnerTempAnimPanel = {},
		newbieTalkDlg = {},
		siftBoxDlg = {},
		siftBoxDlgSingle = {},
		graphicListDlg = {},
		getNewHeroDlg = {},
		bulletDlg = {
			1
		},
		battleRelinkDlg = {}
	}
}
UIVisible.Map4 = {
	containState = {
		Const.STATE_BATTLE
	},
	ui = {
		battleMainDlg = {},
		battleVictoryDlg = {},
		battleBonusDlg = {},
		battleRecordDlg = {},
		battleLoseDlg = {},
		battleStepTowerVictoryDlg = {},
		bossTowerResultDlg = {},
		bossTowerResultPassDlg = {},
		zombieResultAwardDlg = {},
		pvpResultDlg = {},
		pvpResultAwardDlg = {},
		battleDragHeroTips = {},
		battleDragHeroDlg = {},
		defendDragHeroDlg = {},
		mazeDragHeroDlg = {},
		battleStartDlg = {},
		mazeBattleResultFailDlg = {},
		mazeBattleResultWinDlg = {},
		stepTowerBattleAwardDlg = {},
		BattleBossIntroDlg = {},
		battleResultSeniorPvpWinDlg = {},
		battleActivityResultWinDlg = {},
		battleTopPvpResultWinDlg = {},
		battleBeforeWearDlg = {},
		battleResultBossEliteDlg = {},
		battleStartWorldBossEliteDlg1 = {},
		battleStartWorldBossEliteDlg2 = {}
	}
}
UIVisible.Map5 = {
	containState = {
		Const.STATE_BATTLE_REPLAY
	},
	ui = {
		battleReplayMainDlg = {}
	}
}
UIVisible.Map9 = {
	containState = {
		Const.STATE_DEMO
	},
	ui = {
		demoMainDlg = {}
	}
}

local STATE_MAP = {}

for _ = 1, 9 do
	local data = UIVisible["Map" .. _]

	if data then
		for i, gameState in ipairs(data.containState) do
			local stateVisibleData = STATE_MAP[gameState] or {}

			for uiName, visibleState in pairs(data.ui) do
				local __ = stateVisibleData[uiName]

				if __ then
					-- block empty
				else
					local vState = visibleState[i]

					if vState == 1 then
						stateVisibleData[uiName] = true
					elseif vState == 0 then
						stateVisibleData[uiName] = "Hide"
					elseif vState == nil then
						stateVisibleData[uiName] = false
					end
				end
			end

			STATE_MAP[gameState] = stateVisibleData
		end
	end
end

for gameState, stateVisibleData in pairs(STATE_MAP) do
	for uiName, v in pairs(UIVisible.Map0) do
		STATE_MAP[gameState][uiName] = true
	end
end

return STATE_MAP
