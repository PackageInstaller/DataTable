-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/GameFsm\\GameStateBattle.lua

local GameState = require("GameFsm/GameState")
local FrameMgr = require("Debug/Modules/Demo/DemoFrameMgr")
local TheMatrixClass = require("Common/FrameBattle/TheMatrix")
local BattleConst = require("Common/FrameBattle/BattleConst")
local BattleActorMgr = require("Logic/Battle/BattleActorMgr")
local MatrixOp = require("Common/FrameBattle/Lib/MatrixOp")
local ResHero = require("ClientData/ResHero")
local ResTower = require("ClientData/ResTower")
local ResStage = require("ClientData/ResStage")
local Monster = require("Common/Object/Monster")
local Hero = require("Common/Object/Hero")
local DragPlane = require("UI/Control/Com/DragPlane")
local PosConfig = require("ClientData/ResBattleOverPosConfig")
local BattleOVerMgr = require("Logic/Battle/BattleOVerMgr")
local VersionUtils = require("System/VersionUtils")
local ResBattleConfig = require("ClientData/ResBattleConfig")
local ResSpecialBattleAvg = require("ClientData/ResSpecialBattleAvg")
local BossIntroduceConfig = require("ClientData/ResBossIntroduceConfig")
local ResScene = require("ClientData/ResScene")
local ResMonster = require("ClientData/ResMonster")
local CustomShadowManager = require("System/CustomShadowManager")
local SceneLightManager = UnityEngine.PostProcessing.SceneLightManager
local EventConst = require("EventConst")
local ResBattleRobot = require("ClientData/ResBattleRobot")
local ResNewMazeBattle = require("ClientData/ResNewMazeBattle")
local ResOpActivityPlotStage = require("ClientData/ResOpActivityPlotStage")
local ResOpActivityPlotDetail = require("ClientData/ResOpActivityPlotDetail")
local Random = require("Common/FrameBattle/Lib/Random")
local UserData = require("Helper/UserData")
local coroutine = coroutine
local listenerFuncConfig = {
	onMatrixOver = BattleConst.MATRIX_EVENT_BATTLE_OVER
}
local GameObject = UnityEngine.GameObject
local CameraManager = Framework.CameraSystem.CameraManager
local strClassName = "GameStateBattle"
local GameStateBattle = Class(strClassName, GameState)
local StateBattleMixin = require("Logic/battle/StateBattleMixin")

if StateBattleMixin then
	MixinClass(GameStateBattle, StateBattleMixin)
end

function GameStateBattle:ctor(name)
	self:_initData()
end

function GameStateBattle:_initData()
	self.onlineMode = true
	self.mEntityDict = {}
	self.mainDlgName = "battleMainDlg"
	self.slotOnRefreshShadow = Slot(self._onRefreshShadow, self)
end

function GameStateBattle:onEnter(preStateName)
	GameStateBattle.super.onEnter(self, preStateName)

	self.preStateName = preStateName

	EventCenter.addEventListenerGroup(self, listenerFuncConfig)
end

function GameStateBattle:onExit(nextState)
	GameStateBattle.super.onExit(self, nextState)
	self:clearBattleComponents()
	CueManager.revertForceStopDof()
	CueManager.stopNoise()
	CueManager.clearEffectForceQuality()
	EventCenter.removeEventListenerGroup(self, listenerFuncConfig)

	UnityEngine.Time.timeScale = 1

	CueManager.setSfxSpeed(1)
	TouchManager.enabled(false)
	UIManager.tryHideUI("battleRelinkDlg")
end

function GameStateBattle:needRandBattleScene()
	if self.battleType == BattleConst.BATTLE_TYPE_STAGE and self.battlePreInfo.stageData then
		local season = self.battlePreInfo.stageData[1]
		local chapter = self.battlePreInfo.stageData[2]
		local level = self.battlePreInfo.stageData[3]

		if ResStage[season] and ResStage[season][chapter] and ResStage[season][chapter][level] and ResStage[season][chapter][level].scene_id == -1 then
			return true
		end
	end
end

function GameStateBattle:initPreBattleInfo(battleNo, battlePreInfo, isRetry)
	self.battleNo = battleNo
	self.battleConfig = ResBattleConfig[self.battleNo] or {}
	self.battlePreInfo = battlePreInfo
	self.battleType = battlePreInfo.type
	self.isRetry = isRetry

	self:_initBattleArgs(isRetry)
	self:onBattleRetry(isRetry)
	self:_initSceneNo()
end

function GameStateBattle:_initBattleArgs(isRetry)
	self.battleResult = nil
	self.startBattle = nil
	self.result = nil
	self.preDisconnectPause = nil
	self.inPause = false
	self.inQuickMode = false
	self.failEnhanceExit = nil
	UnityEngine.Time.timeScale = 1

	self:clearBattleComponents()

	self.bossIntroduceId = self.battleConfig.boss_introduce or 0
	self.battleEnterAvgEnable = true
	self.battleCameraCurvyEnable = true
	self.inFirstAVG = false
	self.waitCutOver = false

	if self.battleType == BattleConst.BATTLE_TYPE_STAGE then
		self.battleCameraCurvyEnable = false

		if UIManager.getUI("stageInfoDlg", nil, false) then
			self.waitCutOver = true
		end

		local stageData = self.battlePreInfo.stageData[4]

		if CurAvatar:getStageActionIndex() > stageData.idx then
			self.battleEnterAvgEnable = false
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_WORLD_BOSS then
		if UserData.loadCommonData("WorldBossAvg") == tostring(self.battleNo) then
			self.battleEnterAvgEnable = false
		else
			UserData.saveCommonData("WorldBossAvg", tostring(self.battleNo))
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_MAZE_PET then
		self.battleCameraCurvyEnable = false
	end

	self.teamLimit = nil
	self.teamNumLimit = nil
	self.multiFightIndex = 1
	self.multiTeamsIndex = nil
	self.multiPveId = nil
	self.multiResults = {}
	self.onlyUseTeam = nil
	self.fixedHeros = nil
	self.defineHeros = nil
	self.multibObjMgrs = nil
	self.outFormation = nil

	if self.battleType == BattleConst.BATTLE_TYPE_SEASON_TOWER then
		if self.battlePreInfo.seasonTowerData.onlyUseTeam and not isRetry then
			self.onlyUseTeam = self.battlePreInfo.seasonTowerData.onlyUseTeam
			self.multiTeamsIndex = {
				[2] = self.onlyUseTeam
			}
			self.teamLimit = nil
			self.teamNumLimit = nil
		else
			self.teamLimit = self.battlePreInfo.seasonTowerData.teamLimit
			self.teamNumLimit = self.battlePreInfo.seasonTowerData.teamNumLimit
			self.multiTeamsIndex = self.battlePreInfo.seasonTowerData.multiTeamsIndex
			self.battlePreInfo.seasonTowerData.monsterHps = nil
			self.battlePreInfo.seasonTowerData.onlyUseTeam = nil
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_WORLD_BOSS then
		if self.battlePreInfo.worldBossData.eliteMode then
			self.multiPveId = self.battlePreInfo.worldBossData.multiPveId
			self.multiTeamsIndex = self.battlePreInfo.worldBossData.multiTeamsIndex
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_RENT then
		if self.battlePreInfo.rentData.fixedHeros then
			self.fixedHeros = self.battlePreInfo.rentData.fixedHeros
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_CIRCLE then
		self.defineHeros = {}

		local fixedHeroDic = CurAvatar:getCircleBattleHeroDic()

		if fixedHeroDic then
			for _, hero in pairs(fixedHeroDic) do
				table.insert(self.defineHeros, hero)
			end
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_SNEAK_BATTLE then
		local actData = CurAvatar:getSneakBattleActivityData()

		if actData then
			self.defineHeros = actData:getCanDragHero(self.battlePreInfo.stage)
		end
	elseif self.battlePreInfo.fixedHeros then
		self.fixedHeros = self.battlePreInfo.fixedHeros
	end

	if self.battlePreInfo.defineHeros then
		self.defineHeros = self.battlePreInfo.defineHeros
	end

	if self.battlePreInfo.outFormation then
		self.outFormation = self.battlePreInfo.outFormation
	end

	self.formationForceEmpty = self.battlePreInfo.formationForceEmpty
	self.heroPutFilter = self.battlePreInfo.heroPutFilter
end

function GameStateBattle:_initSceneNo()
	if self.battleType == BattleConst.BATTLE_TYPE_MAZE then
		self.sceneNo = GameFsm.getState(Const.STATE_MAIN_MAZE).sceneNo
	elseif self.battleType == BattleConst.BATTLE_TYPE_CIRCLE then
		if ResBattleConfig[self.battleNo] then
			self.sceneNo = GameFsm.getState(Const.STATE_MAIN_CIRCLE).getSuitableSceneNo(ResBattleConfig[self.battleNo].sceneId)
		else
			self.sceneNo = GameFsm.getState(Const.STATE_MAIN_CIRCLE).getSuitableSceneNo()
		end
	elseif self:needRandBattleScene() then
		self.sceneNo = utils.getRandomBattleScene()
	elseif ResBattleConfig[self.battleNo] and ResBattleConfig[self.battleNo].sceneId then
		self.sceneNo = ResBattleConfig[self.battleNo].sceneId
	else
		self.sceneNo = 1
	end

	self.sceneInfo = ResScene[self.sceneNo]
	self.gridAngle = self.sceneInfo.dir or 0
	self.gridDirection = math.rad(self.gridAngle)
	self.leftDir = Vector3(-math.cos(self.gridDirection), 0, -math.sin(self.gridDirection))
	self.upDir = Vector3(-self.leftDir.z, 0, self.leftDir.x)

	local centerPoint = self.sceneInfo.origin_point

	self.centerPoint = Vector3(centerPoint[1], centerPoint[2], centerPoint[3])
end

function GameStateBattle:onBattleRetry(retryFlag)
	self.retryCanRecommend = nil

	if retryFlag then
		self.battleEnterAvgEnable = false

		if not self:isZombieBattle() then
			self.battleCameraCurvyEnable = false
		end

		if retryFlag == 1 and self.battleType == BattleConst.BATTLE_TYPE_STAGE then
			local canRecommendFormation = ConditionLimitManager.inLimitState(183)

			if canRecommendFormation and self.speData and self.speData.suppres and self.battleConfig and self.battleConfig.suppress_level and self.speData.suppres >= self.battleConfig.suppress_level then
				self.retryCanRecommend = true
			end
		end
	end

	if self.FORCE_PLAY_BATTLE_AVG then
		self.battleEnterAvgEnable = true
	end
end

function GameStateBattle:startFight(battleServerInfo)
	self:stopCoWaitResult()
	DragPlane.onBattleStart()

	self.battleServerInfo = battleServerInfo

	local battleInitInfo = utils.getBattleInitInfo(battleServerInfo)

	self.startBattle = true
	self.battleType = battleInitInfo.battleType
	self.randomSeed = battleInitInfo.seed

	if battleInitInfo.battleNo ~= self.battleNo then
		if self.battleType == BattleConst.BATTLE_TYPE_STAGE then
			CurAvatar:onPVEStartRespError("")

			return
		end

		local battlePreInfo = {}

		if self.battleType == self.battlePreInfo.type then
			battlePreInfo = self.battlePreInfo
		else
			battlePreInfo.type = self.battleType
		end

		local dataArgsName = BattleConst.BATTLETYPE_DATA_MAP[self.battleType]

		if dataArgsName then
			battlePreInfo[dataArgsName] = battleInitInfo.speData[dataArgsName]
		end

		self:initPreBattleInfo(battleInitInfo.battleNo, battlePreInfo)
	end

	self.curBattleRound = 1
	self.battleTeamResult = {}
	self.battleTeamHeros = battleInitInfo.multiTeamHeros
	self.battleTeamPets = battleInitInfo.multiTeamPets
	self.heros = battleInitInfo.heros
	self.petEntity = battleInitInfo.pets

	if self.battleTeamHeros and #self.battleTeamHeros > 1 or self.multiTeamsIndex and #self.multiTeamsIndex > 1 then
		DragPlane.stop()
	end

	self.speData = battleInitInfo.speData

	self:_initConfig()
	BeginnerManager.onTrigger(Const.BEGINNER_TRIGGER_BATTLE_START, {
		self.battleNo,
		self.battlePreInfo.stageData,
		self.battleType
	})
	self:playBattleBGM()
	self:battleHideGameObject()

	if self:isZombieBattle() then
		CameraModeManager.setToBattle(self, false, 0, 30, 0.1)
	end

	if not self.battlePreInfo.stageData then
		CurAvatar:sendNodeAnalyticsData(Const.OSS_TYPE_START_BATTLE, 0, 0)
	else
		CurAvatar:sendNodeAnalyticsData(Const.OSS_TYPE_START_BATTLE, self.battlePreInfo.stageData[2], self.battlePreInfo.stageData[3])
	end
end

function GameStateBattle:showNowTeamResult()
	local index = #self.battleTeamResult

	if index > 0 then
		local resultInfo = self.battleTeamResult[index]
		local ui

		if resultInfo[1] == BattleConst.BATTLE_RESULT_WIN then
			if self.battleType == BattleConst.BATTLE_TYPE_OPACT_PVP then
				ui = UIManager.getUI("battleOpactPvpResultWinDlg", true)
			elseif self.battleType == BattleConst.BATTLE_TYPE_TOP_PVP_GROUPMATCH then
				ui = UIManager.getUI("battleTopPvpResultWinDlg", true)
			else
				ui = UIManager.getUI("battleResultSeniorPvpWinDlg", true)
			end
		elseif self.battleType == BattleConst.BATTLE_TYPE_OPACT_PVP then
			ui = UIManager.getUI("battleOpactPvpResultFailDlg", true)
		elseif self.battleType == BattleConst.BATTLE_TYPE_TOP_PVP_GROUPMATCH then
			ui = UIManager.getUI("battleTopPvpResultFailDlg", true)
		else
			ui = UIManager.getUI("battleResultSeniorPvpFailDlg", true)
		end

		ui:setMiddleFight()
	end
end

function GameStateBattle:startFightNextTeam()
	self.curBattleRound = self.curBattleRound + 1

	UIManager.getUI("battleStartMultiDlg", true):setRound(self.curBattleRound)

	self.heros = self.battleTeamHeros[self.curBattleRound]
	self.petEntity = self.battleTeamPets[self.curBattleRound]

	self:_initConfig()
	self:playBattleBGM()
end

function GameStateBattle:startWorldBossFightNextTeam()
	self:stopCoWaitResult()

	if not self.coWaitResult then
		self.coWaitResult = coroutine.start(self.waitResult, self)
	end

	self.multiFightIndex = self.multiFightIndex + 1

	if not self.inQuickMode then
		UIManager.getUI("battleStartWorldBossEliteDlg2", true)
	end

	if self.multiPveId and self.multiPveId[self.multiFightIndex] then
		self.battleNo = self.multiPveId[self.multiFightIndex]
	end
end

function GameStateBattle:waitResult()
	local flag = true

	for waitIndex = 1, 70 do
		if self.multiResults and self.multiResults[1] then
			flag = false

			break
		end

		if waitIndex == 20 then
			UIManager.createUI("battleRelinkDlg")
		end

		coroutine.wait(0.1)
	end

	UIManager.tryHideUI("battleRelinkDlg")

	if flag then
		MsgManager.clientNotice(299)
		self:exitBattle(true)

		return
	end
end

function GameStateBattle:stopCoWaitResult()
	UIManager.tryHideUI("battleRelinkDlg")

	if self.coWaitResult then
		coroutine.stop(self.coWaitResult)

		self.coWaitResult = nil
	end
end

function GameStateBattle:onQuickEndGame()
	if self.inQuickMode then
		return
	end

	self:_onQuickEndGame()
end

function GameStateBattle:_onQuickEndGame(...)
	self.inQuickMode = true

	if self.mMatrixInstance then
		self:onRaiseMatrixInput(BattleConst.INPUT_EVENT_SET_AUTO, 0)
		self.frameMgr:pause()
		self:stopCoQuickBattle()

		self.coQuickBattle = coroutine.start(self.funcCoQuickBattle, self)
	end
end

function GameStateBattle:funcCoQuickBattle()
	local relDlg = UIManager.createUI("battleRelinkDlg")

	coroutine.step(0.1)
	relDlg:setBattleMode()

	for i = 1, BattleConst.QUICK_MODE_MAX_FRAME do
		if self.mMatrixInstance.battleOver then
			break
		elseif i % 1000 == 0 then
			coroutine.step(0.1)
		else
			self.frameMgr:nextFrameWithoutEvent()
		end
	end

	if self.mMatrixInstance.lastDeadCamp then
		self:onMatrixOver(self.mMatrixInstance.lastDeadCamp)
	else
		self:onMatrixOver(self.mMatrixInstance.lastDeadCamp, BattleConst.BATTLE_RESULT_TIME_OUT)
	end
end

function GameStateBattle:onLoadEnded()
	GameStateBattle.super.onLoadEnded(self)
	self:startBattleFormation()
end

function GameStateBattle:isInFight(...)
	return self.startBattle and not self.battleResult
end

function GameStateBattle:onLoadDynamicScene()
	if self.sceneInfo.dynamic_path then
		local nowPath = "Scenes/world/Chunk/" .. self.sceneInfo.dynamic_path

		if self.preDynamicPath and self.preDynamicPath ~= nowPath then
			DynamicSceneManager.unload(self.preDynamicPath)

			self.preDynamicPath = nil
		end

		if self.preDynamicPath ~= nowPath then
			DynamicSceneManager.load(nowPath)

			self.preDynamicPath = nowPath
		end
	elseif self.preDynamicPath then
		DynamicSceneManager.unload(self.preDynamicPath)

		self.preDynamicPath = nil
	end
end

function GameStateBattle:startBattleFormation()
	local ui = UIManager.getUI(self.mainDlgName, nil, false)

	if ui then
		ui:onBattleOver()
		ui:setVisible(false)
	end

	if self.battleConfig.battle_cue then
		CueManager.playPostProcess(self.battleConfig.battle_cue)
	end

	self:_revertCustomLight()
	self:onLoadDynamicScene()

	self.centerPointGo = GameObject("CenterPoint")
	self.centerPointGo.transform.position = self.centerPoint
	self.cameraCenterPointGo = GameObject("CameraCenterPoint")

	local cameraOffsetX = 0

	if self.battleType == BattleConst.BATTLE_TYPE_MAZE then
		cameraOffsetX = GameFsm.getState(Const.STATE_MAIN_MAZE).cameraOffsetX or 0
	end

	CameraModeManager.setBattleOffset(self, cameraOffsetX)

	if self.battleType == BattleConst.BATTLE_TYPE_STAGE and self.battleEnterAvgEnable then
		self.inFirstAVG = true

		self:stepEnterCamera()
		self:checkStageAvg("pre_enter_avg", Slot(self.firstAVGOver, self), 0.5)
	else
		self:stepEnterCamera()
	end
end

function GameStateBattle:stepEnterCamera()
	self:initDragPlaneObjects()

	if self.sceneInfo.enter_camera and self.battleCameraCurvyEnable then
		local cameraPath = "Camera/CameraCurvy/Battle/" .. self.sceneInfo.enter_camera

		if self.battleType == BattleConst.BATTLE_TYPE_STAGE then
			CameraManager.PlayCameraAnimator(cameraPath, nil, self.onCameraAnimatorOver, 0.2, 0, 0)
		else
			CameraManager.PlayCameraAnimator(cameraPath, nil, self.onCameraAnimatorOver, 0, 0, 0)
		end

		if self.battlePreInfo.type == BattleConst.BATTLE_TYPE_STAGE then
			UIManager.getUI("mainStageTitleBox", true):onShow(self.battlePreInfo.stageData)
		end

		CueManager.setUIBgmById(901)
	else
		self:onCameraAnimatorOver(true)
	end
end

function GameStateBattle:onCameraAnimatorOver(cameraNow)
	if not GameFsm.isInState(Const.STATE_BATTLE) then
		return
	end

	self = GameFsm.getCurState()

	if self.battlePreInfo.type == BattleConst.BATTLE_TYPE_STAGE then
		local mainStageTitleBox = UIManager.getUI("mainStageTitleBox", nil, false)

		if mainStageTitleBox then
			mainStageTitleBox:setVisible(false)
		end
	end

	self:initBattleCamera(cameraNow)
	self:initBossInfoPanel()
end

function GameStateBattle:initBattleCamera(cameraNow)
	self.cameraFadeDuration = BattleConst.CAMERA_DEFAULT_FADE_DURATION

	if not self:isZombieBattle() then
		local cameraOffsetX = 0

		if self.battleType == BattleConst.BATTLE_TYPE_MAZE then
			cameraOffsetX = GameFsm.getState(Const.STATE_MAIN_MAZE).cameraOffsetX or 0

			if self.preStateName == Const.STATE_MAIN then
				cameraNow = false
				self.cameraFadeDuration = BattleConst.CAMERA_MAZZ_FADE_DURATION
			end
		end

		if self.battleConfig and self.battleConfig.camera_dist then
			CameraModeManager.setToBattle(self, cameraNow, cameraOffsetX, self.battleConfig.camera_dist)
		else
			CameraModeManager.setToBattle(self, cameraNow, cameraOffsetX)
		end

		if self.battleType == BattleConst.BATTLE_TYPE_BEGINNER then
			CameraManager.SetCameraOffset(-0.4, 0.5, 0)
		end
	else
		CueManager.setEffectForceQuality(0)
	end

	CueManager.forceStopDof()
	CueManager.playBaseBGM()
end

function GameStateBattle:firstAVGOver()
	self.inFirstAVG = false

	self:initBossInfoPanel()
end

function GameStateBattle:onCutOver()
	self.waitCutOver = false

	if DragPlane.inRunning then
		self:initBossInfoPanel()
	end
end

function GameStateBattle:initBossInfoPanel()
	if self.waitCutOver then
		return
	end

	if self.inFirstAVG then
		return
	end

	local function callBack()
		self:stepCheckBattleAVG()
	end

	if self.bossIntroduceId ~= 0 then
		local bossIntroPanel = UIManager.getUI("BattleBossIntroDlg", true)
		local bossInfo = BossIntroduceConfig[self.bossIntroduceId]

		bossIntroPanel:setInfo(bossInfo, callBack)
	else
		callBack()
	end
end

function GameStateBattle:stepCheckBattleAVG()
	if self.battleEnterAvgEnable then
		self:checkStageAvg("pre_battle_avg", Slot(self.startHeroConfig, self))

		if self.battleType == BattleConst.BATTLE_TYPE_STAGE then
			local stageData = self.battlePreInfo.stageData[4]

			CurAvatar:setStageActionIndex(stageData.idx + 1)
		end
	else
		self:startHeroConfig()
	end
end

function GameStateBattle:startHeroConfig()
	DragPlane.onReady()

	if self.battleType == BattleConst.FORMATION_TYPE_ASYNC_PVP then
		UIManager.getUI("defendDragHeroDlg", true):setPutInfos(self.battlePreInfo)
	elseif self.battleType == BattleConst.BATTLE_TYPE_MAZE then
		UIManager.getUI("mazeDragHeroDlg", true):setPutInfos(self.battlePreInfo)
	elseif self.battleType == BattleConst.BATTLE_TYPE_THREE_TEAM_PVP or self.battleType == BattleConst.BATTLE_TYPE_DEFEND_THREE_TEAM then
		UIManager.getUI("multiDragHeroDlg", true):setPutInfos(self.battlePreInfo)
	elseif self.battleType == BattleConst.FORMATION_TYPE_OPACT_PVP or self.battleType == BattleConst.BATTLE_TYPE_OPACT_PVP then
		UIManager.getUI("activityPvpDragHeroDlg", true):setPutInfos(self.battlePreInfo)
	elseif self.battleType == BattleConst.FORMATION_TYPE_TOP_PVP or self.battleType == BattleConst.BATTLE_TYPE_TOP_PVP_GROUPMATCH then
		UIManager.getUI("topPvpDragHeroDlg", true):setPutInfos(self.battlePreInfo)
	elseif self.battleType == BattleConst.FORMATION_TYPE_TOP_PVP_KNOCKOUT then
		UIManager.getUI("topPvpKnockoutDragHeroDlg", true):setPutInfos(self.battlePreInfo)
	elseif self.battleType == BattleConst.FORMATION_TYPE_RENT_DEFEND then
		local rentDragHeroDlg = UIManager.getUI("rentDragHeroDlg", true)

		rentDragHeroDlg:setMaxTeamNum(CurAvatar.rentMaxUnlockTeams)
		rentDragHeroDlg:setPutInfos(self.battlePreInfo)
	elseif self.battleType == BattleConst.BATTLE_TYPE_NEW_MAZE then
		local newMazeDragHeroDlg = UIManager.getUI("newMazeDragHeroDlg", true)

		newMazeDragHeroDlg:setPutInfos(self.battlePreInfo)
		newMazeDragHeroDlg:setLosderPanel()
	elseif self.battleType == BattleConst.BATTLE_TYPE_WORLD_BOSS and self.battlePreInfo.worldBossData.eliteMode then
		UIManager.getUI("worldBossEliteDragHeroDlg", true):setPutInfos(self.battlePreInfo)
	else
		UIManager.getUI("battleDragHeroDlg", true):setPutInfos(self.battlePreInfo, self.formationIdx)
		BeginnerManager.onTrigger(Const.BEGINNER_TRIGGER_BATTLE_FORMATION, {
			self.battleNo,
			self.battlePreInfo.stageData,
			self.battleType
		})
	end

	self:_setCustomShadowActive(true)
end

function GameStateBattle:_initConfig()
	self:clear()
	self:initObjInfo()

	if self:isZombieBattle() then
		self.mainDlgName = "battleZombieMainDlg"
	elseif self.battleHeroNum and self.battleHeroNum > BattleConst.FORMATION_DEFAULT_NUM then
		self.mainDlgName = "battleMoreHeroMainDlg"
	else
		self.mainDlgName = "battleMainDlg"
	end

	local input = self:getMatrixInput()

	self.mMatrixInstance = TheMatrixClass(input, false)
	self.frameMgr = FrameMgr(self.mMatrixInstance)

	if self.inQuickMode then
		DragPlane.stop()
		self:_onQuickEndGame()
	else
		self.mActorMgr = BattleActorMgr(self, self.mMatrixInstance, self.mEntityDict)

		if not self.startTimer then
			self.startTimer = Timer.New(Slot(self.startGame, self), 1.5)
		end

		self.startTimer:Restart()

		if not self.startPanelTimer then
			self.startPanelTimer = Timer.New(Slot(self.newModelChanged, self), 1)
		end

		self.startPanelTimer:Restart()
	end
end

function GameStateBattle:startGame()
	self.frameMgr:start()

	if not self.battleConfig.enter_auto and self.battleType ~= BattleConst.BATTLE_TYPE_THREE_TEAM_PVP and not ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BATTLE_AUTO) then
		local UserData = require("Helper/UserData")

		if UserData.loadCommonData(BattleConst.MANUAL_KEY) == "1" then
			self:onRaiseMatrixInput(BattleConst.INPUT_EVENT_SET_AUTO, 1)
		end
	end

	self:initMatrixOption()
	DragPlane.stop()

	for _, actor in pairs(self.mActorMgr.actors) do
		if actor.entityModel then
			actor.entityModel:showModel(true)
		end
	end

	if self.mActorMgr then
		self.mActorMgr:actBeforeStart()
	end

	if self.inPause then
		self:onPause()
	end
end

function GameStateBattle:initMatrixOption()
	if not ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BATTLE_SKILL_SHORT) then
		local UserData = require("Helper/UserData")
		local inSkillShort = UserData.loadCommonData(BattleConst.SHORT_SKILL_KEY) == "1"

		self:onRaiseMatrixInput(BattleConst.INPUT_EVENT_SET_SHORT, inSkillShort and 1 or 0)
	end
end

function GameStateBattle:newModelChanged()
	local battleStartDlg = UIManager.getUI("battleStartDlg", nil, false)

	if battleStartDlg then
		battleStartDlg:setVisible(false)
	end

	local battleStartMultiDlg = UIManager.getUI("battleStartMultiDlg", nil, false)

	if battleStartMultiDlg then
		battleStartMultiDlg:setVisible(false)
	end

	if self.multiFightIndex then
		local battleStartMultiExDlg = UIManager.getUI("battleStartWorldBossEliteDlg" .. self.multiFightIndex, nil, false)

		if battleStartMultiExDlg then
			battleStartMultiExDlg:setVisible(false)
		end
	end
end

function GameStateBattle:clearBattleComponents()
	self:clear()
	CueManager.stopPostOutline()
	CueManager.releaseCue(nil, 10005002)

	if self.preDynamicPath then
		DynamicSceneManager.unload(self.preDynamicPath)

		self.preDynamicPath = nil
	end

	if self.preHideSceneObjects then
		for _, node in ipairs(self.preHideSceneObjects) do
			if node and not tolua.isnull(node) then
				node:SetActive(true)
			end
		end

		self.preHideSceneObjects = nil
	end

	DragPlane.stop()

	if self.mvpEffectId then
		EffectManager:releaseEffect(self.mvpEffectId)
	end

	self:stopCoFinish()

	if self.startTimer then
		self.startTimer:Stop()
	end

	if self.centerPointGo then
		UnityEngine.Object.Destroy(self.centerPointGo)

		self.centerPointGo = nil
	end

	if self.cameraCenterPointGo then
		UnityEngine.Object.Destroy(self.cameraCenterPointGo)

		self.cameraCenterPointGo = nil
	end

	if self.battleConfig and self.battleConfig.battle_cue then
		CueManager.releaseCue(nil, self.battleConfig.battle_cue)
	end

	CueManager.clearAllCue()
end

function GameStateBattle:onActorsReady()
	self.actorsReady = true
end

function GameStateBattle:onRaiseMatrixInput(matrixOpType, ...)
	local inputData = MatrixOp.packMatrixOp(matrixOpType, ...)

	if inputData and self.frameMgr then
		self.frameMgr:onReceiveMsg(matrixOpType, inputData)
	end
end

function GameStateBattle:checkStageAvg(avgKey, nextStepFunc, delayTime)
	local avgSection
	local speAvgData = ResSpecialBattleAvg[self.battleNo]

	if self.battlePreInfo and self.battlePreInfo.type == BattleConst.BATTLE_TYPE_STAGE then
		local stageInfo = self.battlePreInfo.stageData

		if stageInfo then
			local season = stageInfo[1]
			local chapter = stageInfo[2]
			local level = stageInfo[3]

			if ResStage[season] and ResStage[season][chapter] and ResStage[season][chapter][level] then
				avgSection = ResStage[season][chapter][level][avgKey]
			end
		end
	elseif speAvgData and speAvgData[avgKey] then
		avgSection = speAvgData[avgKey]
	end

	if CurAvatar:miniGameEnable() then
		avgSection = nil
	end

	if avgSection then
		UIManager.playAVG(avgSection, nil, nextStepFunc, nil, delayTime)
	elseif nextStepFunc then
		nextStepFunc()
	end
end

function GameStateBattle:playSceneBGM(...)
	if self.sceneInfo.bgm then
		self.sceneBgm = self.sceneInfo.bgm
	else
		local nowStageData = CurAvatar:getNowStageData()

		if nowStageData and nowStageData.pve_id and ResBattleConfig[nowStageData.pve_id] then
			self.sceneBgm = ResBattleConfig[nowStageData.pve_id].bgm
		end
	end

	if self.sceneBgm then
		CueManager.setBaseBGM(self.sceneBgm)
	end

	if self.sceneInfo.noise then
		CueManager.playNoise(self.sceneInfo.noise)
	else
		CueManager.stopNoise()
	end
end

function GameStateBattle:playBattleBGM(...)
	local battleBGM

	if self.relicHero then
		battleBGM = self.relicHero:getRelicBgmIdByType(Const.RELIC_BGM_TYPE_BATTLE)
	elseif ResBattleConfig[self.battleNo] and ResBattleConfig[self.battleNo].bgm then
		battleBGM = ResBattleConfig[self.battleNo].bgm
	elseif self.battleType then
		battleBGM = CueManager.getBattleBGMConfig(self.battleType, "in_battle")
	end

	if battleBGM then
		CueManager.setBaseBGM(battleBGM)
		CueManager.playBaseBGM()
	end
end

local FORMATION_EMPTY_SPECIAL_CONFIG = {
	[BattleConst.BATTLE_TYPE_THREE_TEAM_PVP] = 1,
	[BattleConst.BATTLE_TYPE_DEFEND_THREE_TEAM] = 1,
	[BattleConst.FORMATION_TYPE_OPACT_PVP] = 1,
	[BattleConst.BATTLE_TYPE_OPACT_PVP] = 1,
	[BattleConst.FORMATION_TYPE_RENT_DEFEND] = 1,
	[BattleConst.FORMATION_TYPE_TOP_PVP] = 1
}

function GameStateBattle:initDragPlaneObjects()
	self.formationIdx = nil

	DragPlane.start(self.centerPointGo, self.battleConfig.player_enter_state, self.battleConfig)

	self.centerPointGo.transform.localRotation = Quaternion.Euler(0, -self.gridAngle, 0)

	if FORMATION_EMPTY_SPECIAL_CONFIG[self.battleType] then
		self:initPetsArgs()

		return
	end

	if CurAvatar and CurAvatar.heroDic then
		local battleData = ResBattleConfig[self.battleNo] or {}
		local friends = battleData.friends or {}
		local monsterLevel = battleData.monster_level or 1

		if self.battleType == BattleConst.BATTLE_TYPE_ASYNC_PVP then
			local enemyFormation = self.battlePreInfo.asyncPVPData.asyncPVPEnemy
			local enemies = utils.getFormationHeros(enemyFormation)

			for _, hero in ipairs(enemies) do
				DragPlane.addDragObj(true, hero, -hero.pos, BattleConst.CAMP_MONSTER)
			end
		else
			local monsterHps = {}

			if self.battleType == BattleConst.BATTLE_TYPE_MAZE and self.battlePreInfo.mazeData.baseData then
				monsterLevel = math.max(1, CurAvatar.mazeData.level + (self.battlePreInfo.mazeData.baseData.level_offset or 0))

				for _, info in ipairs(CurAvatar.mazeData.monster.record) do
					monsterHps[info.id] = info.hp
				end
			end

			if self.battleType == BattleConst.BATTLE_TYPE_SEASON_TOWER and self.battlePreInfo.seasonTowerData.monsterHps then
				for _, info in ipairs(self.battlePreInfo.seasonTowerData.monsterHps) do
					monsterHps[info.id] = info.hp
				end
			end

			if self.battleType == BattleConst.BATTLE_TYPE_CIRCLE and CurAvatar.myCircle and not self.battlePreInfo.circleBattleData.isBoss then
				local data = CurAvatar.myCircle:getMonsterInfo(self.battlePreInfo.circleBattleData.serverGridPos + 1)

				if data then
					for _, info in pairs(data.monster or {}) do
						monsterHps[info.pos] = info.hp
					end
				end
			end

			if self.battleType == BattleConst.BATTLE_TYPE_NEW_MAZE then
				local actObj = CurAvatar:getNewMazeActivity()

				if actObj and actObj:isValid() then
					monsterLevel = actObj.actData.layerAwardData[1][1].monster_level

					if actObj.actData.monsterHpInfo then
						for _, info in pairs(actObj.actData.monsterHpInfo or {}) do
							monsterHps[info.pos] = info.hp
						end
					end
				end
			end

			local monsters = {}

			for pos, monsterID in ipairs(battleData.monsters or {}) do
				if ResMonster[monsterID] then
					monsters[pos] = {
						monsterID,
						monsterLevel
					}
				end
			end

			for pos, monsterInfo in pairs(monsters) do
				local monster = Monster(monsterInfo[1], monsterInfo[2])

				if monsterHps[pos] then
					monster.mazeHp = monsterHps[pos]
				end

				pos = -pos

				if monster.mazeHp ~= 0 then
					local obj = DragPlane.addDragObj(false, monster, pos, BattleConst.CAMP_MONSTER)
				end
			end

			for pos, monsterID in ipairs(friends) do
				if ResMonster[monsterID] then
					local obj = DragPlane.addDragObj(false, Monster(monsterID, monsterLevel), pos, BattleConst.CAMP_PLAYER)
				end
			end
		end

		if self.fixedHeros then
			for _, heroInfo in pairs(self.fixedHeros) do
				local pos = heroInfo[1]
				local hero = heroInfo[2]

				if hero and pos > 0 and (friends[pos] == nil or friends[pos] == 0) then
					DragPlane.addDragObj(true, hero, pos, BattleConst.CAMP_PLAYER)
				end
			end

			if self.battlePreInfo.formationIdx then
				self.formationIdx = self.battlePreInfo.formationIdx
			end
		else
			self.formationIdx = self:getFormationIndex()

			local leftInfos = CurAvatar:getNowFormation(self.formationIdx)

			if self.outFormation then
				leftInfos = self.outFormation
			end

			if self.battleType == BattleConst.BATTLE_TYPE_MAZE then
				local formNum = 0
				local camp_limit = self.battleConfig.camp_limit

				for gid, pos in pairs(leftInfos) do
					local hero = CurAvatar.heroDic[gid]

					if hero and hero.mazeHpStep <= 0 then
						leftInfos[gid] = nil
					elseif camp_limit and hero.camp ~= camp_limit then
						leftInfos[gid] = nil
					else
						formNum = formNum + 1
					end
				end

				if formNum > (self.battleConfig.num_limit or BattleConst.FORMATION_DEFAULT_NUM) then
					leftInfos = {}
				end
			end

			for gid, pos in pairs(leftInfos) do
				if self.battleType == BattleConst.BATTLE_TYPE_NEW_MAZE then
					local actObj = CurAvatar:getNewMazeActivity()

					if actObj and actObj.actData.allHeroDic[gid] then
						local hero = actObj.actData.allHeroDic[gid]
						local obj = DragPlane.addDragObj(true, hero, pos, BattleConst.CAMP_PLAYER)
					end
				elseif self.battleType == BattleConst.BATTLE_TYPE_SNEAK_BATTLE then
					local actData = CurAvatar:getSneakBattleActivityData()

					if actData and self.battlePreInfo and self.battlePreInfo.stage then
						local heros = actData:getCanDragHero(self.battlePreInfo.stage)

						if heros then
							for _, hero in ipairs(heros) do
								if hero.gid == gid then
									local obj = DragPlane.addDragObj(true, hero, pos, BattleConst.CAMP_PLAYER)

									break
								end
							end
						end
					end
				else
					local hero = CurAvatar.heroDic[gid]

					if hero and self.battleType == BattleConst.BATTLE_TYPE_CIRCLE then
						hero = utils.getCircleBattleHero(hero)
					end

					if hero and (friends[pos] == nil or friends[pos] == 0) then
						if self.teamLimit then
							for index, team in ipairs(self.teamLimit) do
								if hero.team == team then
									local obj = DragPlane.addDragObj(true, hero, pos, BattleConst.CAMP_PLAYER)
								end
							end
						else
							local obj = DragPlane.addDragObj(true, hero, pos, BattleConst.CAMP_PLAYER)
						end
					end
				end
			end
		end
	end

	self:initPetsArgs()
end

local FORMATION_PET_DISABLE_CONFIG = {
	[BattleConst.BATTLE_TYPE_STEPTOWER] = 1,
	[BattleConst.BATTLE_TYPE_NEW_MAZE] = 1
}

function GameStateBattle:initPetsArgs()
	if FORMATION_PET_DISABLE_CONFIG[self.battleType] then
		self.battlePreInfo.petDisable = true
	elseif self.battleType == BattleConst.BATTLE_TYPE_RENT and self.battlePreInfo.rentData.teamUid then
		self.battlePreInfo.pets = CurAvatar:getRentedPetByTeamId(self.battlePreInfo.rentData.teamUid, self.battlePreInfo.rentData.teamId)
		self.battlePreInfo.otherFormationInfo = CurAvatar.formationOtherInfos[self.formationIdx] or {}

		if self.battlePreInfo.pets and self.battlePreInfo.pets[1] and self.battlePreInfo.pets[1].id then
			self.battlePreInfo.otherFormationInfo.petId = self.battlePreInfo.pets[1].id
		end

		self.battlePreInfo.cannotChangePetSkill = 1
	else
		self.battlePreInfo.pets = CurAvatar:getAllSortedPets()
		self.battlePreInfo.otherFormationInfo = CurAvatar.formationOtherInfos[self.formationIdx] or {}
	end
end

function GameStateBattle:getFormationIndex()
	if self.battleType == BattleConst.FORMATION_TYPE_ASYNC_PVP then
		return Const.FORMATION_ASYNC_DEFEND
	elseif self.battleType == BattleConst.BATTLE_TYPE_MAZE then
		return Const.FORMATION_MAZE
	elseif self.battleType == BattleConst.BATTLE_TYPE_EQUIPTOWER then
		if self.battlePreInfo.equipTowerData and self.battlePreInfo.equipTowerData.type then
			return Const["FORMATION_EQUIP_TOWER_" .. self.battlePreInfo.equipTowerData.type]
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_BOSSTOWER then
		if self.battlePreInfo.bossTowerData and self.battlePreInfo.bossTowerData.type then
			return Const["FORMATION_BOSS_CHOOSE_" .. self.battlePreInfo.bossTowerData.type]
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_ACTIVITY or self.battleType == BattleConst.BATTLE_TYPE_STEPTOWER then
		return Const.FORMATION_FORCE_EMPTY
	elseif self.battleType == BattleConst.BATTLE_TYPE_SNEAK_BATTLE then
		if self.isRetry then
			return Const.FORMATION_SNEAK_BATTLE
		else
			return Const.FORMATION_FORCE_EMPTY
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_WORLD_BOSS then
		local bossId = self.battlePreInfo.worldBossData.type

		return Const.FORMATION_WORLD_BOSS[bossId]
	elseif self.battleType == BattleConst.BATTLE_TYPE_SEASON_TOWER then
		if self.battlePreInfo.seasonTowerData then
			local towerId = self.battlePreInfo.seasonTowerData.towerId

			return Const.SEASON_TOWER_FORMATION_CONFIG[towerId]
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_RENT then
		return Const.FORMATION_RENT
	elseif self.battleType == BattleConst.BATTLE_TYPE_CIRCLE then
		return Const.FORMATION_CIRCLE_BATTLE
	elseif self.battleType == BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND then
		local towerId = self.battlePreInfo.bossTowerExpandData.towerId

		return Const.FORMATION_BOSS_EXPAND[towerId]
	elseif self.battleType == BattleConst.BATTLE_TYPE_NEW_MAZE then
		return Const.FORMATION_NEW_MAZE
	elseif self.formationForceEmpty then
		return Const.FORMATION_FORCE_EMPTY
	end

	return Const.FORMATION_MAIN_STAGE
end

function GameStateBattle:onMatrixOver(loseCamp, speResultType, gmMode)
	if not self.battlePreInfo.stageData then
		CurAvatar:sendNodeAnalyticsData(Const.OSS_TYPE_FINISH_BATTLE, 0, 0)
	else
		CurAvatar:sendNodeAnalyticsData(Const.OSS_TYPE_FINISH_BATTLE, self.battlePreInfo.stageData[2], self.battlePreInfo.stageData[3])
	end

	self.win = 1

	local result = BattleConst.BATTLE_RESULT_WIN

	if speResultType then
		result = speResultType
	elseif loseCamp == BattleConst.CAMP_PLAYER then
		result = BattleConst.BATTLE_RESULT_LOSE
	end

	if result ~= BattleConst.BATTLE_RESULT_WIN then
		self.win = 0
	end

	local realEnd = true

	self.battleInvalid = false

	if speResultType == BattleConst.BATTLE_RESULT_LEAVE then
		RPC.pVEQuit(self.battleType, "kCSPVEQuitReasonTypeNormal")
	else
		if BattleConst.THREE_ROUND_BATTLE_TYPE[self.battleType] then
			self.battleTeamResult[self.curBattleRound] = {
				result,
				self.mMatrixInstance.bObjMgr,
				self:getServerReplayData()
			}

			local winNum, loseNum = self:getRoundScore()

			if winNum >= 2 then
				self.win = 1
				result = BattleConst.BATTLE_RESULT_WIN
			elseif loseNum >= 2 then
				self.win = 0
				result = BattleConst.BATTLE_RESULT_LOSE
			else
				realEnd = false
			end
		elseif self.battleType == BattleConst.BATTLE_TYPE_CIRCLE and self.battlePreInfo.circleBattleData then
			local layer = self.battlePreInfo.circleBattleData.layer
			local serverPos = self.battlePreInfo.circleBattleData.serverGridPos
			local isBoss = self.battlePreInfo.circleBattleData.isBoss

			if not isBoss and not CurAvatar:isCircleBattleFinishValid(layer, serverPos) then
				self.battleInvalid = true

				MsgManager.clientNotice(540)
			end
		end

		if realEnd and not self.battleInvalid then
			self:sendRpcFinish(result, gmMode)
		end
	end

	if self.battleType == BattleConst.BATTLE_TYPE_WORLD_BOSS and self.battlePreInfo.worldBossData.eliteMode then
		realEnd = self.multiFightIndex ~= 1

		if not realEnd then
			self:startWorldBossFightNextTeam()
		end
	end

	self:setBattleObjMgrs()
	self:startBattleOverAction(speResultType, realEnd)
end

function GameStateBattle:getRoundScore()
	local winNum = 0
	local loseNum = 0

	for teamNum, resultInfo in pairs(self.battleTeamResult) do
		if resultInfo[1] == BattleConst.BATTLE_RESULT_WIN then
			winNum = winNum + 1
		else
			loseNum = loseNum + 1
		end
	end

	local preWin

	if self.battleTeamResult[#self.battleTeamResult] then
		preWin = self.battleTeamResult[#self.battleTeamResult][1] == BattleConst.BATTLE_RESULT_WIN
	end

	return winNum, loseNum, preWin
end

function GameStateBattle:sendRpcFinish(result, gmMode)
	local common = {}

	common.seed = self.randomSeed
	common.pve_id = self.battleNo
	common.pve_data = {}

	table.insert(common.pve_data, {
		type = "kPVEDataTypeBattleFrame",
		value = self.mMatrixInstance.battleRealPassedFrame
	})
	table.insert(common.pve_data, {
		type = "kPVEDataTypeWin",
		value = self.win
	})
	table.insert(common.pve_data, {
		type = "kPVEDataTypeTime",
		value = math.floor(self.mMatrixInstance.bObjMgr:getBattleTime())
	})
	table.insert(common.pve_data, {
		type = "kPVEDataTypeAliveNum",
		value = self.mMatrixInstance.bObjMgr:getPlayerAliveNum()
	})
	table.insert(common.pve_data, {
		type = "kPVEDataTypeDieNum",
		value = self.mMatrixInstance.bObjMgr.playerDeadNum
	})

	self.totalDamage = math.floor(self.mMatrixInstance.bObjMgr:getBattleDamage())

	table.insert(common.pve_data, {
		type = "kPVEDataTypeDamage",
		value = self.totalDamage
	})

	local monsterPercent = self.mMatrixInstance.bObjMgr:getBattleDamagePercent()

	table.insert(common.pve_data, {
		type = "kPVEDataTypeDamagePercent",
		value = monsterPercent
	})

	local mvp = self:getMVPActor()

	if mvp and mvp.hero then
		table.insert(common.pve_data, {
			type = "kPVEDataTypeMvpID",
			value = mvp.hero.id
		})
	end

	if self.battleType == BattleConst.BATTLE_TYPE_MAZE then
		table.insert(common.pve_data, {
			type = "kPVEDataTypeHeroData",
			datas = {
				hero = self.mMatrixInstance.bObjMgr:playerHpInfo()
			}
		})
	end

	table.insert(common.pve_data, {
		type = "kPVEDataTypeMonsterData",
		monster_losehp = math.floor(self.mMatrixInstance.bObjMgr:getMonsterLoseHp()),
		report = {
			monster = self:getMonsterHpInfo()
		}
	})

	if BattleConst.THREE_ROUND_BATTLE_TYPE[self.battleType] then
		common.version = VersionUtils.getBattleDataVersion()
		common.op_data = {}

		for teamNum, resultInfo in pairs(self.battleTeamResult) do
			table.insert(common.op_data, resultInfo[3])
		end
	else
		common.version = VersionUtils.getBattleDataVersion()
		common.op_data = {}

		table.insert(common.op_data, self:getServerReplayData())
	end

	local spec = {}

	if self.battleType == BattleConst.BATTLE_TYPE_BOSSTOWER then
		if self:isZombieBattle() then
			spec.wave = self.mMatrixInstance.bObjMgr.beatedWave
		elseif self.battlePreInfo.battleSourceData and self.battlePreInfo.battleSourceData.wave_num then
			if gmMode then
				spec.wave = self.battlePreInfo.battleSourceData.wave_num
			else
				spec.wave = math.floor(monsterPercent * self.battlePreInfo.battleSourceData.wave_num / 10000)
			end
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_THREE_TEAM_PVP then
		local multiResults = {}

		for roundNum = 1, #self.battleTeamResult do
			table.insert(multiResults, self.battleTeamResult[roundNum][1])
		end

		spec.result_detail = multiResults
	elseif self.battleType == BattleConst.BATTLE_TYPE_OPACT_PVP then
		local opactpvpResults = {}

		for roundNum = 1, #self.battleTeamResult do
			table.insert(opactpvpResults, self.battleTeamResult[roundNum][1])
		end

		spec.result_detail = opactpvpResults
	elseif self.battleType == BattleConst.BATTLE_TYPE_TOP_PVP_GROUPMATCH then
		local topPvpResults = {}

		for roundNum = 1, #self.battleTeamResult do
			table.insert(topPvpResults, self.battleTeamResult[roundNum][1])
		end

		spec.result_detail = topPvpResults
	elseif self.battleType == BattleConst.BATTLE_TYPE_ONCETOWER and self.mMatrixInstance.bObjMgr.suppressLevel then
		spec.suppress_level = math.floor(self.mMatrixInstance.bObjMgr.suppressLevel * 10000)
	elseif self.battleType == BattleConst.BATTLE_TYPE_ACTIVITY and self.battlePreInfo.actData then
		table.insert(common.pve_data, {
			type = "kPVEDataTypeAllHero",
			all_Heros = {
				hero = self.mMatrixInstance.bObjMgr:teammateHpInfo()
			}
		})
	elseif self.battleType == BattleConst.BATTLE_TYPE_CIRCLE then
		-- block empty
	end

	if BattleConst.CHECK_REPLAY_RECORD[self.battleType] and BattleConst.CHECK_REPLAY_RECORD[self.battleType].campRecord or self.battleType == BattleConst.BATTLE_TYPE_ACTIVITY then
		spec.camp = {}
		spec.camp.team = self.mMatrixInstance.bObjMgr:getDamageResultInfo()
	end

	RPC.pVEFinish(self.battleType, result, common, spec, gmMode)
	CurAvatar:onPVEFinishRequest(self.battleType)
end

function GameStateBattle:getMonsterHpInfo()
	local hps = self.mMatrixInstance.bObjMgr:monsterHpInfo()

	if self.battleType == BattleConst.BATTLE_TYPE_MAZE or self.battleType == BattleConst.BATTLE_TYPE_SEASON_TOWER or self.battleType == BattleConst.BATTLE_TYPE_CIRCLE then
		local monsters = self:getBattleMonsters()

		for pos, monsterID in ipairs(monsters) do
			if ResMonster[monsterID] then
				local has = false

				for _, info in ipairs(hps) do
					if info.id == pos then
						has = true

						break
					end
				end

				if not has then
					local newInfo = {}

					newInfo.id = pos
					newInfo.hp = 0

					table.insert(hps, newInfo)
				end
			end
		end
	end

	return hps
end

function GameStateBattle:startBattleOverAction(speResultType, realEnd)
	self.noShowResult = nil

	self:stopCoFinish()
	self:checkRecordWatchCamera()

	if not realEnd then
		self.coFinish = coroutine.start(self.coBattleFinish, self, true)

		return
	end

	UnityEngine.Time.timeScale = 1

	if self.inQuickMode then
		self.inFinishAction = false

		return
	end

	if self.battleInvalid then
		self:exitBattle()

		return
	end

	local speAvgData = ResSpecialBattleAvg[self.battleNo]

	if not speResultType then
		self.inFinishAction = true
		self.coFinish = coroutine.start(self.coBattleFinish, self)
	elseif speAvgData and speAvgData.pre_result_avg and speResultType == BattleConst.BATTLE_RESULT_TIME_OUT then
		self.inFinishAction = true

		self:checkStageAvg("pre_result_avg", Slot(self.coShowHeros, self))
	elseif speResultType == BattleConst.BATTLE_RESULT_TIME_OUT then
		self.inFinishAction = true
		self.coFinish = coroutine.start(self.coBattleFinish, self)
	else
		self.inFinishAction = false

		if self.frameMgr then
			self.frameMgr:pause()
		end
	end
end

function GameStateBattle:onLeaveBattle(isNeedResult)
	self:onMatrixOver(nil, BattleConst.BATTLE_RESULT_LEAVE)

	if isNeedResult then
		if self.battleType ~= BattleConst.BATTLE_TYPE_ASYNC_PVP then
			self:exitBattle()
		end
	else
		self:exitBattle()
	end
end

function GameStateBattle:stopCoFinish()
	self.inFinishAction = false

	if self.coFinish then
		coroutine.stop(self.coFinish)

		self.coFinish = nil
	end
end

function GameStateBattle:stopCoQuickBattle()
	if self.coQuickBattle then
		coroutine.stop(self.coQuickBattle)

		self.coQuickBattle = nil
	end
end

function GameStateBattle:coBattleFinish(hasNext)
	local mainDlg = UIManager.getUI(self.mainDlgName, nil, false)

	if mainDlg then
		mainDlg:onBattleOver()
	end

	if self.battleType == BattleConst.BATTLE_TYPE_SEASON_TOWER and self.win ~= 1 and self.multiTeamsIndex and not self.onlyUseTeam then
		self.noShowResult = true
	end

	UIManager.getUI(self.mainDlgName):setVisible(false)

	UnityEngine.Time.timeScale = BattleConst.BATTLE_SHOW_TIME_SCALE

	coroutine.wait(BattleConst.BATTLE_SHOW_TIME)

	UnityEngine.Time.timeScale = 1

	CueManager.setSfxSpeed(1)

	if self:isZombieBattle() and self.mActorMgr and self.mActorMgr.showActor then
		if self.win == 1 then
			self.mActorMgr:playShowActorAnim("Win")
		else
			self.mActorMgr:playShowActorAnim("Lose")
		end

		coroutine.wait(BattleConst.ZOMBIE_DIE_TIME)
	end

	if hasNext then
		CameraManager.SwitchToNode(0.3, 0)

		if self.battleType == BattleConst.BATTLE_TYPE_WORLD_BOSS then
			-- block empty
		else
			self:showNowTeamResult()
		end

		self.coFinish = nil

		return
	end

	self.coFinish = nil

	if self.battleType == BattleConst.BATTLE_TYPE_SEASON_TOWER and self.win ~= 1 and self.multiTeamsIndex and not self.onlyUseTeam then
		UIManager.getUI("battleResultSeasonTowerFailDlg", true)
		coroutine.wait(1.8)

		local seasonTowerData = self.battlePreInfo.seasonTowerData

		seasonTowerData.monsterHps = self:getMonsterHpInfo()
		seasonTowerData.onlyUseTeam = seasonTowerData.multiTeamsIndex[2]

		CurAvatar:enterFormation(self.battleNo, BattleConst.BATTLE_TYPE_SEASON_TOWER, self.battlePreInfo)

		return
	end

	if self.win == 1 then
		self:checkStageAvg("pre_result_avg", Slot(self.coShowHeros, self))
	else
		self:showHeros()
	end

	self:playSceneBGM()
	CueManager.playBaseBGM()
end

function GameStateBattle:coShowHeros()
	self.coFinish = coroutine.start(self.showHeros, self)
end

function GameStateBattle:stepFinishCamera()
	local battleData = ResBattleConfig[self.battleNo] or {}

	if battleData.no_result_canvas then
		self:exitBattle(true)
	else
		self.coFinish = coroutine.start(self.coFinishCamera, self)
	end
end

local function keepNowCamera()
	return
end

function GameStateBattle:coFinishCamera()
	local cameraTime = 1.2

	if self.sceneInfo and self.sceneInfo.result_camera then
		local cameraPath = "Camera/CameraCurvy/Battle/" .. self.sceneInfo.result_camera

		CameraManager.PlayCameraAnimator(cameraPath, nil, keepNowCamera, cameraTime, 0, 0)
		CameraManager.CameraGrp:SetFov(50, cameraTime)
		coroutine.wait(cameraTime)
	end

	for _ = 1, 100 do
		coroutine.wait(0.1)

		if self.battleResult then
			break
		end
	end

	self.coFinish = nil
	self.inFinishAction = false
end

function GameStateBattle:onBattleResult(battleResult)
	if self.battleType == BattleConst.BATTLE_TYPE_WORLD_BOSS and self.battlePreInfo.worldBossData.eliteMode and battleResult[3].spec.world_boss then
		local index = battleResult[3].spec.world_boss.team or 0

		self.multiResults[index] = battleResult

		if index == 1 then
			self.multiResults.curBattleTime = math.floor(self.mMatrixInstance.bObjMgr:getBattleTime())

			return
		end
	end

	if self.noShowResult then
		return
	end

	UIManager.tryHideUI("battleRelinkDlg")

	self.battleResult = battleResult
	self.result = self.battleResult[2]

	CurAvatar:noticeBeginnerHookResult(self.result)

	if not self.inFinishAction then
		UnityEngine.Time.timeScale = 1

		CueManager.setSfxSpeed(1)

		if not self.coFinish then
			self.coFinish = coroutine.start(self.showHeros, self)
		end
	end

	CurAvatar:checkToGetaward()
end

function GameStateBattle:showHeros()
	local battleData = ResBattleConfig[self.battleNo] or {}

	if battleData.no_result_canvas then
		self:exitBattle(true)

		return
	end

	for waitIndex = 1, 70 do
		if self.battleType == BattleConst.BATTLE_TYPE_WORLD_BOSS and self.battlePreInfo.worldBossData and self.battlePreInfo.worldBossData.eliteMode then
			if #self.multiResults == 2 then
				break
			end
		elseif self.battleResult then
			break
		end

		if waitIndex == 20 then
			UIManager.createUI("battleRelinkDlg")
		end

		coroutine.wait(0.1)
	end

	UIManager.tryHideUI("battleRelinkDlg")

	if not self.battleResult then
		MsgManager.clientNotice(299)
		self:exitBattle(true)

		return
	end

	self:setMyHero()

	local ui = self:_startBattleResult()
	local traTime = CameraModeManager.setBattleOver(self)

	CueManager.clearAllCue()

	if ui and ui.playNextAni then
		ui:playNextAni()
	end

	if self:isNeedMvpShow() then
		local heroObjs = self:getMyHeroObjs()

		self:hideAllActors()
		coroutine.wait(0.5)

		local entityData = {}

		for _, data in ipairs(heroObjs) do
			table.insert(entityData, data[2])
		end

		local posInfo = {}

		for i = 1, 5 do
			local p = PosConfig[1]["pos" .. i]
			local pos = {
				position = {
					x = p[1],
					y = p[2],
					z = p[3]
				},
				rotation = {
					z = 0,
					x = 0,
					y = 0
				}
			}

			table.insert(posInfo, pos)
		end

		local isLose = false
		local result = self.battleResult[2]
		local battleType = self.battleResult[1]

		if result and result ~= BattleConst.BATTLE_RESULT_WIN then
			if battleType == BattleConst.BATTLE_TYPE_BOSSTOWER then
				local isZombie = self:isZombieBattle()
				local finish = self.battleResult[3]

				if isZombie and self.mMatrixInstance.bObjMgr.beatedWave == 0 then
					isLose = true
				elseif not isZombie and finish and finish.spec.boss_tower.award == 0 then
					isLose = true
				end
			elseif battleType == BattleConst.BATTLE_TYPE_WORLD_BOSS then
				-- block empty
			elseif battleType == BattleConst.BATTLE_TYPE_SEASON_TOWER and self.speData and self.speData.seasonTowerData and self.speData.seasonTowerData.bossConfig then
				isLose = false
			elseif battleType == BattleConst.BATTLE_TYPE_MAZE_PET then
				local finish = self.battleResult[3]
				local mazeData = finish and finish.spec and finish.spec.pet_maze or {}

				if mazeData.boss_id and mazeData.boss_id > 0 then
					isLose = false
				else
					isLose = true
				end
			else
				isLose = true
			end
		end

		self.mBattleOverMgr = BattleOVerMgr(posInfo, entityData, self:getCenterPointPos(), isLose)
	end

	CueManager.revertForceStopDof()

	self.coFinish = nil
	self.inFinishAction = false

	if self.sceneInfo and self.sceneInfo.result_light then
		self:_applyCustomLight(self.sceneInfo.result_light)
	end

	self:_setCustomShadowActive(true)
end

function GameStateBattle:_startBattleResult()
	if not self.battleResult then
		return
	end

	local ui
	local battleType = self.battleResult[1]
	local result = self.battleResult[2]
	local finish = self.battleResult[3]
	local itemBonus = self.battleResult[4]

	if battleType == BattleConst.BATTLE_TYPE_WORLD_BOSS then
		if result == BattleConst.BATTLE_RESULT_WIN then
			ui = UIManager.getUI("bossTowerResultPassDlg", true)

			ui:onShow(battleType, result, finish, itemBonus)
		elseif self.battlePreInfo.worldBossData.eliteMode and self.multiResults then
			ui = UIManager.getUI("battleResultBossEliteDlg", true)

			ui:onShow(self.multiResults)
		else
			ui = UIManager.getUI("bossTowerResultDlg", true)

			ui:onShow(battleType, result, finish, itemBonus)
		end
	elseif battleType == BattleConst.BATTLE_TYPE_ACTIVITY then
		if result == BattleConst.BATTLE_RESULT_WIN then
			local data = ResOpActivityPlotDetail[finish.spec.plot.detail]
			local info = ResOpActivityPlotStage[finish.spec.plot.detail]

			if data and info then
				local index = finish.spec.plot.index
				local stageType = info[data[index].stage].stage_type

				if stageType == Const.ACT_TYPE_PLOT_MODE_STORY then
					ui = UIManager.getUI("battleVictoryDlg", true)

					ui:onShow(battleType, finish, itemBonus)
					ui:setNoAward()
				else
					ui = UIManager.getUI("battleActivityResultWinDlg", true)

					ui:onShow(battleType, finish, result, itemBonus)
				end
			else
				ui = UIManager.getUI("battleActivityResultWinDlg", true)

				ui:onShow(battleType, finish, result, itemBonus)
			end
		else
			ui = UIManager.getUI("battleLoseDlg", true)

			ui:hidePowerPanel()
			ui:onShow(battleType, finish, result, itemBonus)
		end
	elseif battleType == BattleConst.BATTLE_TYPE_THREE_TEAM_PVP then
		if result == BattleConst.BATTLE_RESULT_WIN then
			ui = UIManager.getUI("battleResultSeniorPvpWinDlg", true)

			ui:show(battleType, self.battleTeamResult, finish, itemBonus)
		else
			ui = UIManager.getUI("battleResultSeniorPvpFailDlg", true)

			ui:show(battleType, self.battleTeamResult, finish, itemBonus)
		end
	elseif battleType == BattleConst.BATTLE_TYPE_TOP_PVP_GROUPMATCH then
		if result == BattleConst.BATTLE_RESULT_WIN then
			ui = UIManager.getUI("battleTopPvpResultWinDlg", true)

			ui:show(battleType, self.battleTeamResult, finish, itemBonus)
		else
			ui = UIManager.getUI("battleTopPvpResultFailDlg", true)

			ui:show(battleType, self.battleTeamResult, finish, itemBonus)
		end
	elseif battleType == BattleConst.BATTLE_TYPE_OPACT_PVP then
		if result == BattleConst.BATTLE_RESULT_WIN then
			ui = UIManager.getUI("battleOpactPvpResultWinDlg", true)

			ui:show(battleType, self.battleTeamResult, finish, itemBonus)
		else
			ui = UIManager.getUI("battleOpactPvpResultFailDlg", true)

			ui:show(battleType, self.battleTeamResult, finish, itemBonus)
		end
	elseif battleType == BattleConst.BATTLE_TYPE_ASYNC_PVP then
		ui = UIManager.getUI("pvpResultDlg", true)

		ui:show(battleType, result, finish, itemBonus)
	elseif battleType == BattleConst.BATTLE_TYPE_BOSSTOWER then
		if result == BattleConst.BATTLE_RESULT_WIN then
			ui = UIManager.getUI("bossTowerResultPassDlg", true)

			ui:onShow(battleType, result, finish, itemBonus)
		else
			local isZombie = self:isZombieBattle()

			if isZombie and self.mMatrixInstance.bObjMgr.beatedWave == 0 then
				ui = UIManager.getUI("battleLoseDlg", true)

				ui:onShow(battleType, result, finish, itemBonus)
			elseif not isZombie and finish.spec.boss_tower.award == 0 then
				ui = UIManager.getUI("battleLoseDlg", true)

				ui:onShow(battleType, result, finish, itemBonus)
			else
				ui = UIManager.getUI("bossTowerResultDlg", true)

				ui:onShow(battleType, result, finish, itemBonus)
			end
		end
	elseif battleType == BattleConst.BATTLE_TYPE_MAZE then
		if result == BattleConst.BATTLE_RESULT_WIN then
			ui = UIManager.getUI("mazeBattleResultWinDlg", true)

			ui:show(battleType, finish, itemBonus, self:getMyHeros())
		else
			ui = UIManager.getUI("mazeBattleResultFailDlg", true)

			ui:show(battleType, finish, itemBonus, self:getMyHeros(), result)
		end
	elseif battleType == BattleConst.BATTLE_TYPE_CIRCLE then
		if result == BattleConst.BATTLE_RESULT_WIN then
			ui = UIManager.getUI("battleVictoryDlg", true)

			ui:onShow(battleType, finish, itemBonus)
		else
			ui = UIManager.getUI("battleCircleFailDlg", true)

			ui:show(battleType, finish, result, itemBonus)
		end
	elseif battleType == BattleConst.BATTLE_TYPE_SEASON_TOWER then
		if result == BattleConst.BATTLE_RESULT_WIN or self.speData and self.speData.seasonTowerData and self.speData.seasonTowerData.bossConfig then
			ui = UIManager.getUI("battleVictoryDlg", true)

			ui:onShow(battleType, finish, itemBonus)
		else
			ui = UIManager.getUI("battleLoseDlg", true)

			ui:onShow(battleType, finish, result, itemBonus)
		end
	elseif battleType == BattleConst.BATTLE_TYPE_NEW_MAZE then
		if result == BattleConst.BATTLE_RESULT_WIN then
			ui = UIManager.getUI("battleStepTowerVictoryDlg", true)

			ui:onShow(battleType, finish, itemBonus)
			ui:hideBtnAgain()
		else
			local eventId = self.speData.newMazeData.eventId
			local eventData = ResNewMazeBattle[eventId] or {}
			local actObj = CurAvatar:getNewMazeActivity()

			if eventData.need_settle == 1 and actObj then
				ui = UIManager.getUI("battleStepTowerVictoryDlg", true)

				ui:onShow(battleType, finish, itemBonus)
				ui:hideBtnAgain()
			else
				ui = UIManager.getUI("battleLoseDlg", true)

				ui:onShow(battleType, finish, result, itemBonus)
				ui:hidePowerPanel()
			end
		end
	elseif battleType == BattleConst.BATTLE_TYPE_MAZE_PET then
		local mazeData = finish and finish.spec and finish.spec.pet_maze or {}

		if mazeData.boss_id and mazeData.boss_id > 0 and mazeData.is_pass and mazeData.is_pass > 0 then
			ui = UIManager.getUI("petMazzBattleResultPerfectDlg", true)

			ui:onShow(battleType, finish, itemBonus)
		elseif mazeData.boss_id and mazeData.boss_id > 0 then
			ui = UIManager.getUI("petMazzBattleResultBossDlg", true)

			ui:onShow(battleType, finish, itemBonus)
		elseif result == BattleConst.BATTLE_RESULT_WIN then
			ui = UIManager.getUI("battleVictoryDlg", true)

			ui:onShow(battleType, finish, itemBonus)
		else
			ui = UIManager.getUI("battleLoseDlg", true)

			ui:onShow(battleType, finish, result, itemBonus)
		end
	elseif battleType == BattleConst.BATTLE_TYPE_SNEAK_BATTLE then
		local pveData = finish and finish.spec and finish.spec.new_pve or {}

		if pveData.is_weak_pass == 1 then
			ui = UIManager.getUI("sneakBattleResultWinDlg", true)

			ui:onShow(battleType, finish, itemBonus)
			ui:hideBtnAgain()
		else
			ui = UIManager.getUI("sneakBattleResultFailDlg", true)

			ui:show(battleType, finish, itemBonus, {}, result)
		end
	elseif result == BattleConst.BATTLE_RESULT_WIN then
		if battleType == BattleConst.BATTLE_TYPE_STEPTOWER then
			local layer = finish.spec.tower.layer
			local level = finish.spec.tower.level

			if ResTower[layer] and ResTower[layer][level] and ResTower[layer][level].need_record == 1 then
				ui = UIManager.getUI("battleStepTowerVictoryDlg", true)

				ui:onShow(battleType, finish, itemBonus)
			else
				ui = UIManager.getUI("battleVictoryDlg", true)

				ui:onShow(battleType, finish, itemBonus)
			end
		elseif battleType == BattleConst.BATTLE_TYPE_RENT then
			ui = UIManager.getUI("battleVictoryDlg", true)

			ui:onShow(battleType, finish, itemBonus)

			if not self.battlePreInfo.rentData.hasAward then
				ui:setNoAward()
			end
		else
			ui = UIManager.getUI("battleVictoryDlg", true)

			ui:onShow(battleType, finish, itemBonus)
		end
	else
		ui = UIManager.getUI("battleLoseDlg", true)

		ui:onShow(battleType, finish, result, itemBonus)
	end

	if ui then
		if result == BattleConst.BATTLE_RESULT_WIN then
			ui:playCustomBgm(battleType, "result_win")
		else
			ui:playCustomBgm(battleType, "result_lose")
		end
	end

	return ui
end

function GameStateBattle:setCameraCenterPointGoPos(pos)
	if self.cameraCenterPointGo and pos then
		self.cameraCenterPointGo.transform.position = pos
	end
end

function GameStateBattle:setMyHero(...)
	local heros = {}

	if self.mActorMgr then
		for _, hero in ipairs(self.heros) do
			for id, actor in pairs(self.mActorMgr.actors) do
				if actor.heroID and hero.heroID == actor.heroID then
					local hero = {
						gid = hero.gid,
						hp = actor.hp,
						mhp = actor.mhp
					}

					table.insert(heros, hero)
				end
			end
		end
	end

	self.myHeros = heros
end

function GameStateBattle:getMyHeros(...)
	return self.myHeros
end

function GameStateBattle:getBattleObjMgr(...)
	if self.mMatrixInstance then
		return self.mMatrixInstance.bObjMgr
	end
end

function GameStateBattle:setBattleObjMgrs(...)
	if self.multibObjMgrs == nil then
		self.multibObjMgrs = {}
	end

	if self.mMatrixInstance then
		table.insert(self.multibObjMgrs, self.mMatrixInstance.bObjMgr)
	end
end

function GameStateBattle:getBattleObjMgrs(...)
	return self.multibObjMgrs or {}
end

function GameStateBattle:hideAllActors()
	if self.mActorMgr then
		self.mActorMgr:destroy()
	end
end

local RAND_RATIO = {
	60,
	20,
	10,
	5,
	5
}

function GameStateBattle:getMyHeroObjs()
	local myHeroObjs = {}

	if self.mMatrixInstance then
		local mvp
		local maxDamage = -1
		local isNeedRand = ConditionLimitManager.inLimitState(Const.CONDITION_MVP_RAND) ~= true
		local record = self.mMatrixInstance.bObjMgr.resultRecord or {}

		for aid, obj in pairs(self.mMatrixInstance.bObjMgr.objects) do
			if obj.camp == BattleConst.CAMP_PLAYER and obj.heroID then
				local dmg = 0

				if record[aid] then
					dmg = record[aid].totalDamage or 0

					if isNeedRand == true then
						dmg = dmg + (record[aid].receiveDamage or 0) * 0.5
						dmg = dmg + (record[aid].totalHeal or 0) * 0.5
					end
				end

				table.insert(myHeroObjs, {
					aid,
					obj.hero,
					dmg
				})
			end
		end

		table.sort(myHeroObjs, function(v1, v2)
			if v1[3] ~= v2[3] then
				return v1[3] > v2[3]
			else
				return self.mEntityDict[v1[1]].level > self.mEntityDict[v2[1]].level
			end
		end)

		if isNeedRand == true and #myHeroObjs >= 2 and myHeroObjs[1][3] > myHeroObjs[2][3] * 2 then
			isNeedRand = false
		end

		if isNeedRand == true then
			local randIndex = 1

			if self.randomSeed then
				local generator = Random:twister(self.randomSeed)

				randIndex = generator:random(1, 100)
			else
				randIndex = math.random(100)
			end

			local randNum = 0
			local mvpIndex

			for i, info in ipairs(myHeroObjs) do
				randNum = randNum + RAND_RATIO[i] or 0

				if randIndex <= randNum then
					mvpIndex = i

					break
				end
			end

			if mvpIndex ~= nil then
				local info = myHeroObjs[mvpIndex]

				table.remove(myHeroObjs, mvpIndex)
				table.insert(myHeroObjs, 1, info)
			end
		end

		if #myHeroObjs > 0 then
			local aid = myHeroObjs[1][1]

			self.battleMvp = self.mMatrixInstance.bObjMgr.objects[aid]
			self.cachedBattleMvp = self.battleMvp
		end
	end

	return myHeroObjs
end

function GameStateBattle:getMVPActor()
	if not self.battleMvp then
		self:getMyHeroObjs()
	end

	return self.battleMvp
end

function GameStateBattle:getCachedMvp(...)
	return self.cachedBattleMvp
end

function GameStateBattle:isBattleOverShowEnd(...)
	if self.mBattleOverMgr then
		return self.mBattleOverMgr:isBattleOverActorsAllLoaded()
	else
		return false
	end
end

function GameStateBattle:isNeedMvpShow(...)
	local battleType

	if self.battleResult then
		battleType = self.battleResult[1]
	end

	if battleType == BattleConst.BATTLE_TYPE_THREE_TEAM_PVP and self.stateName ~= Const.STATE_BATTLE_REPLAY then
		return false
	else
		return true
	end
end

function GameStateBattle:exitBattle(needCheckAVG)
	self:_revertCustomLight()
	self:clearBattleComponents()

	if needCheckAVG then
		self:checkStageAvg("after_result_avg", Slot(self.onExitBattle, self))
	else
		self:onExitBattle()
	end

	self:_setCustomShadowActive(false)

	if not utils.tableIsContainsElement(BattleConst.HIDE_WEAR_TYPE, self.battleType) and self.formationIdx ~= nil then
		UserData.saveCommonData("LastFormationIdx", self.formationIdx)
		CurAvatar:checkCanEquipInTeamHeros()
	end
end

function GameStateBattle:onExitBattle()
	GameFsm.translateState(Const.STATE_MAIN)
end

function GameStateBattle:refreshInfoLevel(infoLevel, refreshAll)
	if infoLevel == nil then
		local UserData = require("Helper/UserData")

		infoLevel = UserData.loadCommonData(BattleConst.INFO_LEVEL_KEY) or BattleConst.INFO_LEVEL_DEFAULT
	end

	if self.mActorMgr and refreshAll then
		for _, obj in pairs(self.mActorMgr.actors) do
			if obj.logo then
				obj.logo:refreshInfoLevel(infoLevel)
			end
		end
	end
end

function GameStateBattle:getCenterPointPos()
	if self.centerPointGo then
		return self.centerPointGo.transform.position
	else
		return self.centerPoint
	end
end

function GameStateBattle:onDisconnect()
	local ui = UIManager.getUI(self.mainDlgName, nil, false)

	if ui and ui:getVisible() and not ui.noExit then
		ui:onClickQuit()
	else
		if self.preDisconnectPause == nil then
			self.preDisconnectPause = self.inPause
		end

		self:onPause()
	end
end

function GameStateBattle:onReconnect(newInfo)
	local preDisconnectPause = self.preDisconnectPause

	self.preDisconnectPause = nil

	local battleType = newInfo.role_data.necessary.battle.type
	local battleCommon = newInfo.role_data.necessary.battle.battle_common

	if self.inQuickMode then
		return false
	end

	if self:isInFight() then
		if self.battleType ~= battleType or self.randomSeed ~= battleCommon.seed or self.battleNo ~= battleCommon.pve_id then
			return false
		end
	elseif UIManager.getUI("battleStartDlg", nil, false) then
		return false
	elseif UIManager.getUI("battleStartMultiDlg", nil, false) then
		return false
	elseif UIManager.getUI("battleStartWorldBossEliteDlg1", nil, false) then
		return false
	else
		UIManager.tryHideUI("confirmui")
	end

	if (self.battleType == BattleConst.BATTLE_TYPE_ASYNC_PVP or BattleConst.THREE_ROUND_BATTLE_TYPE[self.battleType]) and not self.battleResult and not self:isInFight() then
		return false
	end

	local ui = UIManager.getUI(self.mainDlgName, nil, false)

	if ui and ui:getVisible() and not ui.noExit then
		if UIManager.getUI("rookieMainDlg", nil, false) and UIManager.getUI("rookieMainDlg", nil, false):isInShow() then
			UIManager.tryHideUI("confirmui")
		end

		return true
	else
		if not preDisconnectPause then
			self:onResume()
		end

		return true
	end
end

function GameStateBattle:onPause()
	self.inPause = true

	if self.frameMgr then
		self.frameMgr:pause()
	end

	if self.mActorMgr then
		self.mActorMgr:onPause()
	end
end

function GameStateBattle:onResume()
	self.inPause = false

	if self.frameMgr then
		self.frameMgr:resume()
	end

	if self.mActorMgr then
		self.mActorMgr:onResume()
	end
end

function GameStateBattle:getPlayers(camp)
	if not self.mMatrixInstance then
		return {}
	end

	local out = {}

	for _, obj in pairs(self.mMatrixInstance.bObjMgr.objects) do
		if obj.camp == (camp or BattleConst.CAMP_PLAYER) and not obj.master and obj.playerControl then
			out[math.abs(obj.pos)] = obj
		end
	end

	return out
end

function GameStateBattle:playStateBGM(...)
	self:playSceneBGM()
end

function GameStateBattle:getReplayData()
	local data = {}

	data.battleServerInfo = self.battleServerInfo
	data.frameData = {}

	if self.frameMgr then
		data.frameData = self.frameMgr.frameQueue
		data.maxFrame = self.frameMgr.curFrame
	end

	return data
end

function GameStateBattle:getServerReplayData()
	local operaData = {}
	local replayData = {}

	if self.frameMgr then
		for frameNum, frameData in pairs(self.frameMgr.frameQueue) do
			for _, data in ipairs(frameData) do
				local newData = {}

				newData.frameid = frameNum
				newData.optype = data[1]
				newData.data = data[2]

				table.insert(replayData, newData)
			end
		end
	end

	operaData.index = self.curBattleRound
	operaData.framedata = replayData

	return operaData
end

function GameStateBattle:_setCustomShadowActive(active, registerEvent)
	if registerEvent == nil then
		registerEvent = true
	end

	if active then
		CustomShadowManager.setBattleShadowActive(true, self:_getShadowCenterAndRadius())

		if registerEvent then
			EventCenter.addEventListener(EventConst.REFRESH_SHADOW, self.slotOnRefreshShadow)
		end
	else
		if registerEvent then
			EventCenter.removeEventListener(EventConst.REFRESH_SHADOW, self.slotOnRefreshShadow)
		end

		CustomShadowManager.setBattleShadowActive(false)
	end
end

function GameStateBattle:_getShadowCenterAndRadius(isBattleFinished)
	local centerPoint = self.cameraCenterPointGo and self.cameraCenterPointGo.transform.position or self.centerPoint
	local x = centerPoint.x
	local y = centerPoint.y
	local z = centerPoint.z
	local radius, dis

	if isBattleFinished then
		radius = 3.5
		dis = 0
	elseif self:isZombieBattle() then
		dis = 3
		radius = 11
	elseif self.battleType == BattleConst.BATTLE_TYPE_BEGINNER then
		dis = 0
		radius = 10
	else
		dis = 0
		radius = 8.5
	end

	if dis ~= 0 then
		local leftDir = self.leftDir

		x = x + leftDir.x * dis
		y = y + leftDir.y * dis
		z = z + leftDir.z * dis
	end

	return x, y, z, radius
end

function GameStateBattle:_onRefreshShadow()
	self:_setCustomShadowActive(true, false)
end

function GameStateBattle:_applyCustomLight(extraLightIndex)
	SceneLightManager.ApplySceneExtraLight(extraLightIndex)
	CueManager.applySceneImageEffects(Const.SCENE_PPB_BATTLE_END[extraLightIndex])

	self.inCustomLighting = true
end

function GameStateBattle:_revertCustomLight(...)
	if not self.inCustomLighting then
		return
	end

	SceneLightManager.ApplySceneMainLight()
	CueManager.applySceneImageEffects(Const.SCENE_PPB_DEFAULT)

	self.inCustomLighting = nil
end

return GameStateBattle
