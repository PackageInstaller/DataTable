-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/mazeTower/controller/MazeTowerSystem.lua

require("dm.gameplay.mazeTower.model.MazeTower")

EVT_MAZE_TOWER_MOVE_END = "EVT_MAZE_TOWER_MOVE_END"
EVT_MAZE_TOWER_REFRESH = "EVT_MAZE_TOWER_REFRESH"
EVT_MAZE_TOWER_GETREWARD = "EVT_MAZE_TOWER_GETREWARD"
MazeTowerSystem = class("MazeTowerSystem", legs.Actor)

MazeTowerSystem:has("_mazeTowerService", {
	is = "r"
}):injectWith("MazeTowerService")
MazeTowerSystem:has("_mazeTower", {
	is = "r"
})
MazeTowerSystem:has("_isReset", {
	is = "rw"
})

function MazeTowerSystem:initialize()
	super.initialize(self)

	self._mazeTower = MazeTower:new()
	self._isReset = false
end

function MazeTowerSystem:synchronize(data)
	self._mazeTower:synchronize(data)
	self:dispatch(Event:new(EVT_MAZE_TOWER_REFRESH))
end

function MazeTowerSystem:tryEnter()
	local function enterView()
		local systemKeeper = self:getInjector():getInstance("SystemKeeper")
		local unlock, tips = systemKeeper:isUnlock("Stage_Maze")

		if not unlock then
			self:dispatch(ShowTipEvent({
				tip = tips
			}))

			return
		end

		local view = self:getInjector():getInstance("MazeTowerMainView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {}))
	end

	if self._mazeTower:getCurPointId() == "" then
		self:requestMainInfo(function()
			enterView()
		end)
	else
		enterView()
	end
end

function MazeTowerSystem:hasRedPoint()
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips = systemKeeper:isUnlock("Stage_Maze")

	if not unlock then
		return false
	end

	return self._mazeTower:hasRedPoint()
end

function MazeTowerSystem:getRecommendCombat(pointId)
	local pointNum = self._mazeTower:getTotalPointNum()
	local combat = 0
	local pointConfig = ConfigReader:getRecordById("MazeBlockBattle", pointId)
	local attrEffect = pointConfig.AttrEffect

	for k, v in pairs(attrEffect) do
		local effectConfig = ConfigReader:getRecordById("MazeAttrEffect", v)

		combat = combat + effectConfig.BasicCombat + pointNum * effectConfig.GrowthCombat
	end

	return combat
end

function MazeTowerSystem:isShowQuickChallenge(pointId)
	local pointConfig = ConfigReader:getRecordById("MazeBlockBattle", pointId)
	local isquick = pointConfig.QuickChallenge

	if isquick and isquick == 1 then
		return true
	end

	return false
end

function MazeTowerSystem:isCanQuickChallenge(pointId)
	local comBatRequireRadio = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "QuickChallenge_Combat", "content")

	comBatRequireRadio = comBatRequireRadio or 1

	local developSystem = self:getInjector():getInstance("DevelopSystem")
	local team = developSystem:getSpTeamByType(StageTeamType.MAZE_TOWER)
	local curCombat = team:getCombat()
	local comBatRequire = self:getRecommendCombat(pointId) * comBatRequireRadio

	return tonumber(curCombat) >= tonumber(comBatRequire)
end

function MazeTowerSystem:checkCurrPointPass()
	local pass = true
	local mapInfo = self._mazeTower:getMap()

	for i, v in pairs(mapInfo) do
		for j, gridData in pairs(v) do
			if gridData:isHasUnFinishEvent() then
				pass = false
			end
		end
	end

	return pass
end

function MazeTowerSystem:requestMainInfo(callback)
	local params = {}

	self._mazeTowerService:requestMainInfo(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:synchronize(response.data)

			if callback then
				callback()
			end
		end
	end)
end

function MazeTowerSystem:requestMove(params, callback)
	self._mazeTowerService:requestMove(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self._isReset = response.data.isReset

			self:dispatch(Event:new(EVT_MAZE_TOWER_MOVE_END, response.data))

			if callback then
				callback(response)
			end
		end
	end)
end

function MazeTowerSystem:requestFinishBattle(params, callback)
	self._mazeTowerService:requestFinishBattle(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self._isReset = response.data.isReset

			local view = self:getInjector():getInstance("MazeTowerFinishView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {}))
		else
			BattleLoader:popBattleView(self, {
				viewName = "MazeTowerMainView"
			})
		end
	end)
end

function MazeTowerSystem:requestQuickChallenge(params, callback)
	self._mazeTowerService:requestQuickChallenge(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self._isReset = response.data.isReset
		end

		if callback then
			callback(response)
		end

		self:dispatch(Event:new(EVT_MAZE_TOWER_MOVE_END, response.data))
	end)
end

function MazeTowerSystem:requestTaskReward(params, callback)
	self._mazeTowerService:requestTaskReward(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:synchronize(response.data)

			if callback then
				callback(response)
			end

			self:dispatch(Event:new(EVT_MAZE_TOWER_GETREWARD, response.data))
		end
	end)
end

function MazeTowerSystem:enterBattle(serverData, gridIndex)
	local battleType = SettingBattleTypes.kMazeTower
	local isAuto, timeScale = self:getInjector():getInstance(SettingSystem):getSettingModel():getBattleSetting(battleType)
	local isReplay = false
	local playerData = serverData.playerData
	local pointId = serverData.blockPointId
	local outSelf = self
	local battleDelegate = {}
	local battleSession = MazeTowerBattleSession:new(serverData)

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
	local logicInfo = {
		director = battleDirector,
		interpreter = battleInterpreter,
		teams = battleSession:genTeamAiInfo(),
		mainPlayerId = {
			playerData.rid
		}
	}
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlockSpeed, tipsSpeed = systemKeeper:isUnlock("BattleSpeed")

	function battleDelegate:onAMStateChanged(sender, isAuto)
		outSelf:getInjector():getInstance(SettingSystem):getSettingModel():setBattleSetting(battleType, isAuto)
	end

	function battleDelegate:onLeavingBattle()
		local realData = battleSession:getResultSummary()
		local params = {
			battleResult = realData,
			x = gridIndex.x,
			y = gridIndex.y
		}

		outSelf:requestFinishBattle(params)
	end

	function battleDelegate:onPauseBattle(continueCallback, leaveCallback)
		local popupDelegate = {}

		function popupDelegate:willClose(sender, data)
			if data.response == AlertResponse.kOK then
				leaveCallback(true)
			else
				continueCallback(data.hpShow, data.effectShow)
			end
		end

		local data = {
			title = Strings:get("Tip_Remind"),
			content = Strings:get("Maze_Tip_3"),
			sureBtn = {},
			cancelBtn = {}
		}
		local view = outSelf:getInjector():getInstance("AlertView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data, popupDelegate))
	end

	function battleDelegate:tryLeaving(callback)
		callback(true)
	end

	function battleDelegate:onBattleFinish(result)
		local realData = battleSession:getResultSummary()
		local params = {
			battleResult = realData,
			x = gridIndex.x,
			y = gridIndex.y
		}

		outSelf:requestFinishBattle(params)
	end

	function battleDelegate:onDevWin()
		local realData = {
			randomSeed = 123321,
			opData = "dev",
			result = kBattleSideAWin,
			winners = {
				playerData.rid
			},
			statist = {
				totalTime = 10000,
				roundCount = 4,
				players = {
					[playerData.rid] = {
						unitsDeath = 0,
						hpRatio = 0.99999,
						unitsTotal = 3
					},
					[pointId] = {
						unitsDeath = 20,
						hpRatio = 0,
						unitsTotal = 20
					}
				}
			}
		}

		outSelf:battleResultCallBack(realData)
	end

	function battleDelegate:onTimeScaleChanged(timeScale)
		outSelf:getInjector():getInstance(SettingSystem):getSettingModel():setBattleSetting(battleType, nil, timeScale)
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

	local pointConfig = ConfigReader:getRecordById("MazeBlockBattle", pointId)

	if not pointConfig.Background then
		if not pointConfig.BGM then
			local BGM = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Music_BattleBGM_Maze", "content")
			local battleSpeed_Display = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Display", "content")
			local battleSpeed_Actual = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Actual", "content")
			local var_21_1 = {
				battleData = battleData,
				battleConfig = battleConfig,
				isReplay = isReplay,
				logicInfo = logicInfo,
				delegate = battleDelegate
			}
			local var_21_2 = {
				finalHitShow = true,
				mainView = "battlePlayer",
				opPanelRes = "asset/ui/BattleUILayer.csb",
				canChangeSpeedLevel = true,
				opPanelClazz = "BattleUIMediator",
				finalTaskFinishShow = true,
				battleSettingType = battleType,
				battleType = battleSession:getBattleType(),
				bulletTimeEnabled = BattleLoader:getBulletSetting("BulletTime_PVE_Tower"),
				bgm = BGM,
				background = pointConfig.Background,
				refreshCost = ConfigReader:getRecordById("ConfigValue", "TacticsCard_Reload").content,
				battleSuppress = BattleDataHelper:getBattleSuppress()
			}

			var_21_2.hpShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getHpShowSetting()
			var_21_2.effectShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getEffectShowSetting()
			var_21_2.passiveSkill = battlePassiveSkill
			var_21_2.unlockMasterSkill = self:getInjector():getInstance(SystemKeeper):isUnlock("Master_BattleSkill")
			var_21_2.finishWaitTime = BattleDataHelper:getBattleFinishWaitTime("maze_battle")

			local var_21_3 = {}
			local var_21_4 = {}

			var_21_4.visible = speedOpenSta and self:getInjector():getInstance(SystemKeeper):canShow("BattleSpeed")
			var_21_4.lock = not unlockSpeed
			var_21_4.tip = tipsSpeed
			var_21_4.speedConfig = battleSpeed_Actual
			var_21_4.speedShowConfig = battleSpeed_Display
			var_21_4.timeScale = timeScale
			var_21_3.speed = var_21_4
			var_21_3.skip = {
				visible = false
			}

			local var_21_5 = {}

			var_21_5.visible = self:getInjector():getInstance(SystemKeeper):canShow("AutoFight")
			var_21_5.state = isAuto
			var_21_5.lock = not systemKeeper:isUnlock("AutoFight")
			var_21_3.auto = var_21_5
			var_21_3.pause = {
				visible = true
			}

			local var_21_6 = {}

			var_21_6.visible = self:getInjector():getInstance(SystemKeeper):canShow("Button_CombateDominating")
			var_21_6.lock = not self:getInjector():getInstance(SystemKeeper):isUnlock("Button_CombateDominating")
			var_21_3.restraint = var_21_6
			var_21_2.btnsShow = var_21_3
			var_21_1.viewConfig = var_21_2
			var_21_1.loadingType = LoadingType.KMaze

			local data = var_21_1

			BattleLoader:pushBattleView(self, data)
		end
	end
end

function MazeTowerSystem:battleResultCallBack()
	return
end
