-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/controller/TowerSystem.lua

TowerSystem = class("TowerSystem", legs.Actor)

TowerSystem:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
TowerSystem:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
TowerSystem:has("_towerService", {
	is = "r"
}):injectWith("TowerService")
TowerSystem:has("_towerModel", {
	is = "r"
}):injectWith("TowerModel")
TowerSystem:has("_curTowerId", {
	is = "rw"
})
TowerSystem:has("_curMasterId", {
	is = "rw"
})
TowerSystem:has("_curReward", {
	is = "rw"
})
TowerSystem:has("_heroTowerCombat", {
	is = "rw"
})

kBOOL = {
	kON = 1,
	kOFF = 0
}
kViewType = {
	towerBegin = 2,
	chooseRole = 3,
	chooseTower = 1
}
kEnterFightStatus = {
	ENTER = 2,
	END = 0,
	INIT = 1
}

function TowerSystem:initialize()
	super.initialize(self)

	self._curTowerId = ""
	self._curMasterId = ""
	self._curReward = {}
	self._heroTowerCombat = {}
	self._towerFinishData = nil
end

function TowerSystem:synchronize(data)
	self._towerModel:synchronize(data)
end

function TowerSystem:deleteTower(data)
	self._towerModel:deleteTower(data)
end

function TowerSystem:getCurTowerId(...)
	self._curTowerId = self._curTowerId or self:getTowerDataList()[1]:getTowerId()

	return self._curTowerId
end

function TowerSystem:getHeroById(id)
	local teamData = self:getTowerDataById(self._curTowerId)
	local team = teamData:getTeam()

	return team:getHeroInfoById(id)
end

function TowerSystem:getCurTowerName(...)
	self._curTowerId = self._curTowerId or self:getTowerDataList()[1]:getTowerId()

	local tower = self:getTowerDataById(self._curTowerId)

	return tower:getTowerName()
end

function TowerSystem:getTowerDataList(...)
	return self._towerModel:getTowerList()
end

function TowerSystem:getRewardPiceNum(uuid)
	if self._curReward[uuid] then
		return self._curReward[uuid]
	end

	return 0
end

function TowerSystem:getTowerDataById(towerId)
	return self._towerModel:getTowerDataByTowerId(towerId)
end

function TowerSystem:getTowerOpenState(towerId)
	local lockKeyStr = self:getTowerDataById(towerId).Unlock
	local unlock, tips = self._systemKeeper:isUnlock(lockKeyStr)

	return unlock, tips
end

function TowerSystem:checkEnabled()
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips = systemKeeper:isUnlock("BlockSp_All")

	if not unlock then
		return unlock, tips
	end

	unlock, tips = systemKeeper:isUnlock("Unlock_Tower_All")

	return unlock, tips
end

function TowerSystem:tryEnter()
	local unlock, tips = self:checkEnabled()

	if not unlock then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))

		return
	end

	self:showTowerMainView()
end

function TowerSystem:checkLeftCount(data)
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips = systemKeeper:isUnlock("Unlock_Tower_All")

	if not unlock then
		return 1, tips
	end

	local list = self:getTowerDataList()

	for k, v in pairs(list) do
		dump(k, "key")

		local towerId = v:getTowerId()
		local towerData = self:getTowerDataById(towerId)

		if towerData:getStatus() == kEnterFightStatus.ENTER then
			return 1
		end

		local leftTimes = towerData:getEnterTimes().value

		if leftTimes > 0 then
			return 1
		end
	end

	return 0, Strings:get("Tower_LeftCount_NotEnough")
end

function TowerSystem:sortHeroes(list, type)
	if type then
		if not HeroSortFuncs.TowerSortFunc[type] then
			local func = HeroSortFuncs.TowerSortFunc[9]

			table.sort(list, function(a, b)
				local aInfo = self:getHeroById(a)
				local bInfo = self:getHeroById(b)

				return func(aInfo, bInfo)
			end)
		end
	end
end

function TowerSystem:getTeamPrepared(teamPetIds, ownPetIds)
	local heroSystem = self._developSystem:getHeroSystem()
	local ids = teamPetIds
	local ownHeros = ownPetIds
	local heroTemp = {}

	for i = 1, #ownHeros do
		local hero = heroSystem:getHeroById(ownHeros[i])

		table.insert(heroTemp, hero)
	end

	table.sort(heroTemp, function(a, b)
		local awakenLevelA = a:getAwakenLevel()
		local starA = a:getStar() == 5 and 1 or 0
		local awakenLevelB = b:getAwakenLevel()
		local starB = b:getStar() == 5 and 1 or 0

		if awakenLevelA == awakenLevelB then
			if starA == starB then
				if a:getRarity() == b:getRarity() then
					return a:getCombat() > b:getCombat()
				else
					return a:getRarity() > b:getRarity()
				end
			else
				return starB < starA
			end
		else
			return awakenLevelB < awakenLevelA
		end
	end)

	for i = 1, #heroTemp do
		ids[#ids + 1] = heroTemp[i]:getId()
	end

	return ids
end

function TowerSystem:showTowerMainView()
	local view = self:getInjector():getInstance("TowerMainView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil))
end

function TowerSystem:showTowerBeginView()
	local view = self:getInjector():getInstance("TowerBeginView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, nil, nil))
end

function TowerSystem:showTowerChooseRoleView()
	local view = self:getInjector():getInstance("TowerChooseRoleView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, nil))
end

function TowerSystem:showMasterDetailsView(params)
	local view = self:getInjector():getInstance("TowerMasterShowDetailsView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		towerData = params.towerData,
		master = params.master
	}))
end

function TowerSystem:showHeroDetailsView(heroId)
	local view = self:getInjector():getInstance("HeroInfoView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		heroId = heroId
	}))
end

function TowerSystem:showHeroDetailsViewWithData(heroData)
	local view = self:getInjector():getInstance("TowerHeroShowDetailsView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		hero = heroData
	}))
end

function TowerSystem:showTowerTeamView()
	local view = self:getInjector():getInstance("TowerTeamView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, nil))
end

function TowerSystem:showTowerAwardView()
	local view = self:getInjector():getInstance("TowerAwardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, nil, nil))
end

function TowerSystem:showTowerBuffView()
	local view = self:getInjector():getInstance("TowerBuffView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, nil, nil))
end

function TowerSystem:showTowerEnemyView()
	local view = self:getInjector():getInstance("TowerEnemyView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, nil, nil))
end

function TowerSystem:showTowerStrengthAwardView(strengthPetId)
	local data = self:checkIsAwardData(strengthPetId)
	local view = self:getInjector():getInstance("TowerStrengthAwardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, nil))
end

function TowerSystem:checkIsAwardData(strengthPetId)
	local tab = {}
	local teamData = self:getTowerDataById(self._curTowerId):getTeam():getHeroInfoById(strengthPetId)

	if not teamData then
		return tab
	end

	local code = teamData:getFragId()
	local awardConfig = ConfigReader:getRecordById("TowerPointCard", teamData:getBaseId()).RewardNumShow

	for k, v in pairs(awardConfig) do
		local tabCell = {
			type = 2,
			amount = v,
			code = code
		}

		table.insert(tab, tabCell)
	end

	table.sort(tab, function(a, b)
		return a.amount > b.amount
	end)

	return tab
end

function TowerSystem:showTowerStrengthView()
	local view = self:getInjector():getInstance("TowerStrengthView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, nil))
end

function TowerSystem:showTowerTeamBattleView()
	local view = self:getInjector():getInstance("TowerTeamBattleView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, nil))
end

function TowerSystem:showTowerStrengthEndTipView(data)
	local view = self:getInjector():getInstance("TowerStrengthEndTipView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, nil))
end

function TowerSystem:showHeroBuffView(heroId)
	local view = self:getInjector():getInstance("TowerGetHeroBuffView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		heroId = heroId
	}, nil))
end

function TowerSystem:showPointBuffView(buffs)
	local view = self:getInjector():getInstance("TowerBuffChooseView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		buffs = buffs
	}))
end

function TowerSystem:showPointCardsView(cards)
	local view = self:getInjector():getInstance("TowerCardsChooseView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		cards = cards
	}))
end

function TowerSystem:enterPartnerChooseView(data)
	local view = self:getInjector():getInstance("TowerPartnerSelectView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data))
end

function TowerSystem:enterTowerFinishView(data)
	local view = self:getInjector():getInstance("TowerChallengeEndView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, data))
end

function TowerSystem:showTowerPointView(towerId)
	local view = self:getInjector():getInstance("TowerPointView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		towerId = towerId
	}))
end

function TowerSystem:checkTowerBuffChoose(isOpen)
	local tower = self:getTowerDataById(self:getCurTowerId())
	local buffs = tower:getPointBuffs() or {}
	local count = 0

	for k, v in pairs(buffs) do
		count = count + 1
	end

	if count <= 0 then
		return false
	end

	if isOpen == nil or isOpen then
		self:showPointBuffView(buffs)
	end

	return true
end

function TowerSystem:checkTowerCardsChoose(isOpen)
	local tower = self:getTowerDataById(self:getCurTowerId())
	local cards = tower:getPointCards() or {}
	local count = 0

	for k, v in pairs(cards) do
		count = count + 1
	end

	if count <= 0 then
		return false
	end

	if isOpen == nil or isOpen then
		self:showPointCardsView(cards)
	end

	return true
end

function TowerSystem:checkTowerBuffAndCards()
	if not self:checkTowerBuffChoose() and not self:checkTowerCardsChoose() then
		return false
	end

	return true
end

function TowerSystem:checkTowerBattleEnd()
	local openBuff = self:checkTowerBuffChoose()

	if openBuff then
		return
	end

	local openCard = self:checkTowerCardsChoose()

	if openCard then
		return
	end

	local towerId = self:getCurTowerId()
	local towerData = self:getTowerDataById(towerId)

	if towerData:getStatus() == kEnterFightStatus.END or towerData:getReviveTimes() <= 0 then
		local finishData = self:getTowerFinishData()

		if finishData and finishData.stageFinish then
			self:enterTowerFinishView(finishData)
		end
	elseif towerId then
		self:showTowerPointView(towerId)
	end
end

function TowerSystem:setTowerFinishData(data)
	self._towerFinishData = data
end

function TowerSystem:getTowerFinishData()
	if self._towerFinishData and self._towerFinishData.stageFinish then
		return self._towerFinishData
	end

	return nil
end

function TowerSystem:enterBattleView(towerId, data)
	local towerId = towerId or self:getCurTowerId()
	local data = data or ""
	local isReplay = false
	local outSelf, battleDelegate = self, {}
	local battleSession = TowerBattleSession:new(data)

	battleSession:buildAll()

	local battleData = battleSession:getPlayersData()
	local battleConfig = battleSession:getBattleConfig()
	local battleSimulator = battleSession:getBattleSimulator()
	local battleLogic = battleSimulator:getBattleLogic()
	local battleInterpreter = BattleInterpreter:new()

	battleInterpreter:setRecordsProvider(battleSession:getBattleRecordsProvider())

	local battleDirector = LocalBattleDirector:new()

	battleDirector:setBattleSimulator(battleSimulator)
	battleDirector:setBattleInterpreter(battleInterpreter)

	local battlePassiveSkill = battleSession:getBattlePassiveSkill()
	local isAuto, timeScale = self:getInjector():getInstance(SettingSystem):getSettingModel():getBattleSetting(SettingBattleTypes.kTower)
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local isOpenSkip = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Tower_1_SkipBattleCountdown", "content")
	local skipTime = tonumber(ConfigReader:getDataByNameIdAndKey("ConfigValue", "Tower_1_SkipWaitTime", "content"))
	local speedOpenSta = systemKeeper:getBattleSpeedOpen("tower")
	local unlockSpeed, tipsSpeed = systemKeeper:isUnlock("BattleSpeed")
	local logicInfo = {
		director = battleDirector,
		interpreter = battleInterpreter,
		teams = battleSession:genTeamAiInfo(),
		mainPlayerId = {
			data.playerData.rid
		}
	}

	function battleDelegate:onLeavingBattle()
		outSelf:requestLeaveTowerBattle(towerId, function(data)
			if battleSession then
				local realData = battleSession:getExitSummary()
				local loseData = {
					battleStatist = realData and realData.statist
				}

				if data and data.stageFinish then
					outSelf:setTowerFinishData(data)
				end

				local view = outSelf:getInjector():getInstance("TowerBattleLoseView")

				outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {}, loseData, outSelf))
			end
		end)
	end

	function battleDelegate:onPauseBattle(continueCallback, leaveCallback)
		local popupDelegate = {}

		function popupDelegate:willClose(sender, data)
			if data.opt == BattlePauseResponse.kLeave then
				leaveCallback()
			else
				continueCallback(data.hpShow, data.effectShow)
			end
		end

		local pauseView = outSelf:getInjector():getInstance("battlePauseView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, pauseView, nil, {}, popupDelegate))
	end

	function battleDelegate:onAMStateChanged(sender, isAuto)
		outSelf:getInjector():getInstance(SettingSystem):getSettingModel():setBattleSetting(SettingBattleTypes.kTower, isAuto)
	end

	function battleDelegate:tryLeaving(callback)
		callback(true)
	end

	function battleDelegate:onSkipBattle()
		local realData = {
			randomSeed = 123321,
			opData = "dev",
			result = kBattleSideAWin,
			winners = {
				data.playerData.rid
			},
			pointId = data.blockPointId,
			statist = {
				totalTime = 10000,
				roundCount = 4,
				players = {
					[data.playerData.rid] = {
						unitsDeath = 0,
						hpRatio = 0.99999,
						unitsTotal = 3,
						unitSummary = {}
					},
					[data.blockPointId] = {
						unitsDeath = 20,
						hpRatio = 0,
						unitsTotal = 20,
						unitSummary = {}
					}
				}
			}
		}

		local function callback(battleReport)
			if battleReport and battleReport.stageFinish then
				outSelf:setTowerFinishData(battleReport)
			end

			if battleReport.pass then
				local var_54_0 = {
					battleStatist = battleReport.statist
				}

				var_54_0.reward = battleReport.reward or {}

				local winData = var_54_0
				local view = outSelf:getInjector():getInstance("TowerBattleWinView")

				outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {}, winData, outSelf))
			else
				local loseData = {
					battleStatist = battleReport.statist
				}
				local view = outSelf:getInjector():getInstance("TowerBattleLoseView")

				outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {}, loseData, outSelf))
			end
		end

		outSelf:requestAfterTowerBattle(towerId, realData, callback)
	end

	function battleDelegate:onBattleFinish(result)
		local realData = battleSession:getResultSummary()

		local function callback(battleReport)
			if battleReport and battleReport.stageFinish then
				outSelf:setTowerFinishData(battleReport)
			end

			if battleReport.pass then
				local var_56_0 = {
					battleStatist = battleReport.statist
				}

				var_56_0.reward = battleReport.reward or {}

				local winData = var_56_0
				local view = outSelf:getInjector():getInstance("TowerBattleWinView")

				outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {}, winData, outSelf))
			else
				local loseData = {
					battleStatist = battleReport.statist
				}
				local view = outSelf:getInjector():getInstance("TowerBattleLoseView")

				outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {}, loseData, outSelf))
			end
		end

		outSelf:requestAfterTowerBattle(towerId, realData, callback)
	end

	function battleDelegate:onDevWin()
		self:onSkipBattle()
	end

	function battleDelegate:onTimeScaleChanged(timeScale)
		outSelf:getInjector():getInstance(SettingSystem):getSettingModel():setBattleSetting(SettingBattleTypes.kTower, nil, timeScale)
	end

	function battleDelegate:showBossCome(pauseFunc, resumeCallback, paseSta)
		local popupDelegate = {}

		function popupDelegate:willClose(sender, data)
			if resumeCallback then
				resumeCallback()
			end
		end

		local bossView = outSelf:getInjector():getInstance("battleBossComeView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, bossView, nil, {
			paseSta = paseSta
		}, popupDelegate))

		if pauseFunc then
			pauseFunc()
		end
	end

	function battleDelegate:onShowRestraint(continueCallback)
		local popupDelegate = {}

		function popupDelegate:willClose(sender)
			continueCallback()
		end

		local view = outSelf:getInjector():getInstance("battlerofessionalRestraintView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {}, popupDelegate))
	end

	local bgRes = ConfigReader:getDataByNameIdAndKey("TowerEnemy", data.blockPointId, "Background") or "battle_scene_1"
	local BGM = ConfigReader:getDataByNameIdAndKey("TowerEnemy", data.blockPointId, "BGM")
	local battleSpeed_Display = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Display", "content")
	local battleSpeed_Actual = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Actual", "content")
	local bossRound = ConfigReader:getDataByNameIdAndKey("TowerEnemy", data.blockPointId, "BossRound") or 1
	local var_46_0 = {
		battleType = battleSession:getBattleType(),
		battleData = battleData,
		battleConfig = battleConfig,
		isReplay = isReplay,
		logicInfo = logicInfo,
		delegate = battleDelegate
	}
	local var_46_1 = {
		mainView = "battlePlayer",
		opPanelRes = "asset/ui/BattleUILayer.csb",
		canChangeSpeedLevel = true,
		opPanelClazz = "BattleUIMediator",
		battleSettingType = SettingBattleTypes.kTower,
		bulletTimeEnabled = BattleLoader:getBulletSetting("BulletTime_PVE_Main"),
		bgm = BGM,
		background = bgRes,
		refreshCost = ConfigReader:getRecordById("ConfigValue", "TacticsCard_Reload").content,
		battleSuppress = BattleDataHelper:getBattleSuppress()
	}

	var_46_1.hpShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getHpShowSetting()
	var_46_1.effectShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getEffectShowSetting()
	var_46_1.passiveSkill = battlePassiveSkill
	var_46_1.unlockMasterSkill = self:getInjector():getInstance(SystemKeeper):isUnlock("Master_BattleSkill")
	var_46_1.finishWaitTime = BattleDataHelper:getBattleFinishWaitTime("tower")
	var_46_1.changeMaxNum = bossRound

	local var_46_2 = {}
	local var_46_3 = {}

	var_46_3.visible = speedOpenSta and self:getInjector():getInstance(SystemKeeper):canShow("BattleSpeed")
	var_46_3.lock = not unlockSpeed
	var_46_3.tip = tipsSpeed
	var_46_3.speedConfig = battleSpeed_Actual
	var_46_3.speedShowConfig = battleSpeed_Display
	var_46_3.timeScale = timeScale
	var_46_2.speed = var_46_3
	var_46_2.skip = {
		enable = true,
		waitTips = "ARENA_SKIP_TIP",
		visible = (isOpenSkip == kBOOL.kON or nil) and true,
		skipTime = skipTime
	}

	local var_46_4 = {
		canChangeAuto = true,
		lock = false
	}

	var_46_4.visible = self:getInjector():getInstance(SystemKeeper):canShow("AutoFight")
	var_46_4.state = isAuto
	var_46_2.auto = var_46_4
	var_46_2.pause = {
		enable = true,
		visible = true
	}

	local var_46_5 = {}

	var_46_5.visible = self:getInjector():getInstance(SystemKeeper):canShow("Button_CombateDominating")
	var_46_5.lock = not self:getInjector():getInstance(SystemKeeper):isUnlock("Button_CombateDominating")
	var_46_2.restraint = var_46_5
	var_46_1.btnsShow = var_46_2
	var_46_0.viewConfig = var_46_1
	var_46_0.loadingType = self:getTowerDataById(towerId):getTowerLoadingType()

	local data = var_46_0

	BattleLoader:pushBattleView(self, data, nil, true)
end

function TowerSystem:requestEnterTower(towerId, callback)
	local params = {
		towerId = towerId
	}

	self._towerService:requestEnterTower(params, true, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback(response.data)
		end
	end)
end

function TowerSystem:requestEnterTowerRolesCombat(data, callback)
	local heroSystem = self:getDevelopSystem():getHeroSystem()
	local allPet = heroSystem:getAllHeroIds()
	local params = {
		towerId = self:getCurTowerId(),
		heroIds = allPet
	}

	self._towerService:requestEnterTowerRolesCombat(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self._heroTowerCombat = response.data

			self:showTowerTeamView()
		end
	end)
end

function TowerSystem:requestInitTowerTeam(towerId, masterId, heroIds, callback)
	local params = {
		towerId = towerId,
		masterId = masterId,
		heroIds = heroIds
	}

	self._towerService:requestInitTowerTeam(params, true, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback(response.data)
		end
	end)
end

function TowerSystem:requestSelectPointBuff(towerId, buffId, callback)
	local params = {
		towerId = towerId,
		buffId = buffId
	}

	self._towerService:requestSelectPointBuff(params, true, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback(response.data)
		end
	end)
end

function TowerSystem:requestSelectPointCard(towerId, cardIds, callback)
	local params = {
		towerId = towerId,
		cardIds = cardIds
	}

	self._towerService:requestSelectPointCard(params, true, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback(response.data)
		end
	end)
end

function TowerSystem:requestUpdateTowerTeam(towerId, heroIds, callback)
	local params = {
		towerId = towerId,
		heroIds = heroIds
	}

	self._towerService:requestUpdateTowerTeam(params, true, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback(response.data)
		end
	end)
end

function TowerSystem:requestBeforeTowerBattle(towerId, callback)
	local params = {
		towerId = towerId
	}

	self._towerService:requestBeforeTowerBattle(params, true, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback(response.data)
		end
	end)
end

function TowerSystem:requestAfterTowerBattle(towerId, resultData, callback)
	local params = {
		towerId = towerId,
		resultData = resultData
	}

	self._towerService:requestAfterTowerBattle(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			if response.data.reviewFailed then
				local data = {
					title = Strings:get("Tip_Remind"),
					title1 = Strings:get("UITitle_EN_Tishi"),
					content = Strings:get("FAC_Des"),
					sureBtn = {
						text1 = "FAC_Btn"
					}
				}
				local outSelf, delegate = self, {}

				function delegate:willClose(popupMediator, data)
					if callback then
						callback(response.data)
					end
				end

				local view = self:getInjector():getInstance("AlertView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
				}, data, delegate))
			elseif callback then
				callback(response.data)
			end
		end
	end)
end

function TowerSystem:requestLeaveTowerBattle(towerId, callback)
	local params = {
		towerId = towerId
	}

	self._towerService:requestLeaveTowerBattle(params, true, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback(response.data)
		end
	end)
end

function TowerSystem:requestFeedUpHero(towerId, targetUUID, resIds, callback)
	local params = {
		towerId = towerId,
		targetUUID = targetUUID,
		resIds = resIds
	}

	self._towerService:requestFeedUpHero(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self._curReward = response.data.award

			if callback then
				callback(response.data)
			end
		end
	end)
end

function TowerSystem:requestExitTower(towerId, callback)
	local params = {
		towerId = towerId
	}

	self._towerService:requestExitTower(params, true, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback(response.data)
		end
	end)
end

function TowerSystem:hasHero(heroId)
	local teamData = self:getTowerDataById(self._curTowerId)
	local team = teamData:getTeam()

	for k, v in pairs(team._allHeroes) do
		local tmpId = v._baseId

		if heroId == tmpId then
			return true
		end
	end

	return false
end

function TowerSystem:sortRewards(rewards, merge)
	local temp = {}
	local list = {}

	local function add(rewards)
		for _, reward in pairs(rewards) do
			if reward.type == RewardType.kEquip then
				local code = reward.code
				local type = reward.type
				local amount = reward.amount

				for j = 1, amount do
					list[#list + 1] = {
						amount = 1,
						code = code,
						type = type
					}
				end
			else
				list[#list + 1] = reward
			end
		end
	end

	if merge then
		for _, reward in pairs(rewards) do
			local code = reward.code

			if not temp[code] then
				temp[code] = reward
			else
				temp[code].amount = temp[code].amount + reward.amount
			end
		end

		add(temp)
	else
		add(rewards)
	end

	local rewardSystem = self:getInjector():getInstance(RewardSystem)

	table.sort(list, function(a, b)
		return rewardSystem.class:getQuality(a) > rewardSystem.class:getQuality(b)
	end)

	return list
end
