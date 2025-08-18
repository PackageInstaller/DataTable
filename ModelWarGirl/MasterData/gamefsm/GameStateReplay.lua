-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/GameFsm\\GameStateReplay.lua

local GameStateBattle = require("GameFsm/GameStateBattle")
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
local ResBattleConfig = require("ClientData/ResBattleConfig")
local ResSpecialBattleAvg = require("ClientData/ResSpecialBattleAvg")
local BossIntroduceConfig = require("ClientData/ResBossIntroduceConfig")
local ResScene = require("ClientData/ResScene")
local ResMonster = require("ClientData/ResMonster")
local ResBossTower = require("ClientData/ResBossTower")
local coroutine = coroutine
local listenerFuncConfig = {
	onMatrixOver = BattleConst.MATRIX_EVENT_BATTLE_OVER
}
local DynamicSceneUtil = DynamicScene.DynamicSceneUtil
local GameObject = UnityEngine.GameObject
local CameraManager = Framework.CameraSystem.CameraManager
local strClassName = "GameStateReplay"
local GameStateReplay = Class(strClassName, GameStateBattle)

function GameStateReplay:_initData()
	GameStateReplay.super._initData(self)

	self.mainDlgName = "battleReplayMainDlg"
end

function GameStateReplay:recordReplayEnv(replayEnv)
	self.replayEnv = replayEnv
end

function GameStateReplay:initPreBattleInfo(battleNo, battlePreInfo, isRetry)
	return
end

function GameStateReplay:startFight(battleInitInfo)
	return
end

function GameStateReplay:setServerReplayData(data, roundNum, startFrame, roundFrameInfo, startTeamResult)
	self.roundNum = roundNum
	self.startFrame = startFrame
	self.roundFrameInfo = roundFrameInfo
	self.battleTeamResult = startTeamResult or {}

	if self.roundNum == nil then
		self.roundNum = 1
		self.isMustSingle = nil
	else
		self.isMustSingle = true
	end

	self.totalRoundNum = #data.client_operate
	self.serverReplayData = data

	local replayData = self:_getReplayData(self.roundNum)

	if replayData then
		self:setReplayData(replayData)
	end
end

function GameStateReplay:_getReplayData(roundIndex)
	if self.serverReplayData == nil then
		return
	end

	local replayData = {}

	replayData.battleServerInfo = self.serverReplayData.start_data
	replayData.frameData = {}

	local roundOperate = self.serverReplayData.client_operate[roundIndex] or {}

	for _, frameInfo in ipairs(roundOperate.framedata or {}) do
		local frameNum = frameInfo.frameid

		if not replayData.frameData[frameNum] then
			replayData.frameData[frameNum] = {}
		end

		table.insert(replayData.frameData[frameNum], {
			frameInfo.optype,
			frameInfo.data
		})
	end

	return replayData
end

function GameStateReplay:setReplayData(replayData)
	self.result = nil

	self:clearBattleComponents()

	self.replayData = replayData
	self.battleServerInfo = replayData.battleServerInfo

	local battleInitInfo = utils.getBattleInitInfo(self.battleServerInfo)

	self.battleInitInfo = battleInitInfo
	self.battleNo = battleInitInfo.battleNo
	self.battleConfig = ResBattleConfig[self.battleNo] or {}
	self.battleType = battleInitInfo.battleType
	self.battleTeamHeros = battleInitInfo.multiTeamHeros
	self.battleTeamPets = battleInitInfo.multiTeamPets

	self:initBattlePreData()

	if self.roundNum > 1 then
		battleInitInfo.heros = battleInitInfo.multiTeamHeros[self.roundNum]
		battleInitInfo.pets = battleInitInfo.multiTeamPets[self.roundNum]
	end

	self.bossIntroduceId = self.battleConfig.boss_introduce or 0

	if self.battleType == BattleConst.BATTLE_TYPE_MAZE then
		self.sceneNo = GameFsm.getState(Const.STATE_MAIN_MAZE).sceneNo
	elseif self.battleConfig.sceneId then
		self.sceneNo = self.battleConfig.sceneId
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

function GameStateReplay:initBattlePreData()
	self.battlePreInfo = {}

	if self.battleType == BattleConst.BATTLE_TYPE_BOSSTOWER then
		local bossTowerData = self.battleServerInfo.spec.boss_tower.data
		local towerData = ResBossTower[bossTowerData.type] or {}

		towerData = towerData[bossTowerData.layer]

		if towerData then
			self.battlePreInfo.battleSourceData = towerData
		end
	end
end

function GameStateReplay:hasNextRound(...)
	if self.isMustSingle == true then
		return false
	end

	if self.roundNum < self.totalRoundNum then
		return true
	end

	return false
end

function GameStateReplay:playNextRound(...)
	self.roundNum = math.min(self.totalRoundNum, self.roundNum + 1)

	local replayData = self:_getReplayData(self.roundNum)

	if replayData then
		self:setReplayData(replayData)
	end

	GameFsm.translateState(Const.STATE_BATTLE_REPLAY)
end

function GameStateReplay:onLoadEnded()
	GameStateReplay.super.onLoadEnded(self)
	self:onLoadDynamicScene()
	self:initBattleCamera()
	self:loadBattleConfig()
end

function GameStateReplay:startBattleFormation()
	return
end

function GameStateReplay:stepEnterCamera()
	return
end

function GameStateReplay:onCameraAnimatorOver(cameraNow)
	return
end

function GameStateReplay:stepCheckBattleAVG()
	return
end

function GameStateReplay:startHeroConfig()
	return
end

function GameStateReplay:initBattleCamera()
	self.centerPointGo = GameObject("CenterPoint")
	self.centerPointGo.transform.position = self.centerPoint
	self.cameraCenterPointGo = GameObject("CameraCenterPoint")

	CameraModeManager.setBattleOffset(self, 0)

	if self.battleConfig and self.battleConfig.camera_dist then
		CameraModeManager.setToBattle(self, true, 0, self.battleConfig.camera_dist)
	else
		CameraModeManager.setToBattle(self, true, 0)
	end

	CueManager.forceStopDof()
	CueManager.playUIBGM(10)

	if self:isZombieBattle() then
		CameraModeManager.setToBattle(self, false, 0, 30, 0.1)
	end
end

function GameStateReplay:loadBattleConfig()
	self.inPause = false
	self.startBattle = true
	self.randomSeed = self.battleInitInfo.seed
	self.heros = self.battleInitInfo.heros
	self.petEntity = self.battleInitInfo.pets
	self.speData = self.battleInitInfo.speData

	self:_initConfig()

	for frameNum, oneFrameData in pairs(self.replayData.frameData) do
		for _, frameInfo in ipairs(oneFrameData) do
			self.frameMgr:onReceiveMsg(frameInfo[1], frameInfo[2], frameNum)
		end
	end

	self:playBattleBGM()
end

function GameStateReplay:_initConfig()
	GameStateReplay.super._initConfig(self)

	if self:isZombieBattle() then
		self.mainDlgName = "battleReplayZombieDlg"
	else
		self.mainDlgName = "battleReplayMainDlg"
	end
end

function GameStateReplay:onRaiseMatrixInput(matrixOpType, ...)
	return
end

function GameStateReplay:playSceneBGM(...)
	if self.sceneInfo.bgm then
		self.sceneBgm = self.sceneInfo.bgm
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

function GameStateReplay:exitBattle(needCheckAVG)
	CueManager.stopUIBGM()
	GameFsm.translateState(Const.STATE_MAIN)
end

function GameStateReplay:startGame()
	GameStateReplay.super.startGame(self)

	if self.startFrame and self.startFrame > 0 then
		self.mActorMgr:prepareChaseFrame()

		local chaseFrame = self.startFrame

		for index = 1, chaseFrame do
			self.frameMgr:chaseNextTick()
		end

		self.mActorMgr:chaseFrameRefresh()
	end
end

function GameStateReplay:replayEndBattle()
	for i = 1, BattleConst.QUICK_MODE_MAX_FRAME do
		if self.mMatrixInstance.battleOver then
			break
		else
			self.frameMgr:nextFrameWithoutEvent()
		end
	end

	if self.mMatrixInstance.lastDeadCamp then
		self:onMatrixOver(self.mMatrixInstance.lastDeadCamp)
	else
		self:onMatrixOver(self.mMatrixInstance.lastDeadCamp, self.mMatrixInstance.battleOver)
	end
end

function GameStateReplay:onMatrixOver(loseCamp, speResultType)
	self:stopCoFinish()

	if speResultType then
		self.result = speResultType
	elseif loseCamp == BattleConst.CAMP_PLAYER then
		self.result = BattleConst.BATTLE_RESULT_LOSE
	else
		self.result = BattleConst.BATTLE_RESULT_WIN
	end

	self.coFinish = coroutine.start(self.coBattleFinish, self)
end

function GameStateReplay:stopCoFinish()
	if self.coFinish then
		coroutine.stop(self.coFinish)

		self.coFinish = nil
	end
end

function GameStateReplay:coBattleFinish()
	UIManager.getUI(self.mainDlgName):setVisible(false)

	UnityEngine.Time.timeScale = BattleConst.BATTLE_SHOW_TIME_SCALE

	coroutine.wait(BattleConst.BATTLE_SHOW_TIME)

	self.coFinish = nil
	UnityEngine.Time.timeScale = 1

	CueManager.setSfxSpeed(1)

	if self.roundNum then
		self.battleTeamResult[self.roundNum] = {
			self.result,
			self.mMatrixInstance.bObjMgr,
			self:getServerReplayData()
		}
	end

	if self.roundFrameInfo and self.roundNum and self.roundFrameInfo[self.roundNum + 1] and self.roundFrameInfo[self.roundNum + 1].time > 0 then
		self:showNowTeamResult()
	else
		self.battleResult = {
			self.battleType,
			self.result
		}

		self:showHeros()
	end
end

function GameStateReplay:startFightNextTeam()
	self:startNextRound()
end

function GameStateReplay:showNowTeamResult()
	if self.battleType == BattleConst.BATTLE_TYPE_TOP_PVP_KNOCKOUT then
		local ui = UIManager.getUI("battleResultKnockOutDlg", true)

		ui:setMiddleFight()
	else
		GameStateReplay.super.showNowTeamResult(self)
	end
end

function GameStateReplay:startNextRound()
	self:setServerReplayData(self.serverReplayData, self.roundNum + 1, 0, self.roundFrameInfo, self.battleTeamResult)
	GameFsm.translateState(Const.STATE_BATTLE_REPLAY)
end

function GameStateReplay:onDisconnect()
	return
end

function GameStateReplay:onReconnect(newInfo)
	return true
end

function GameStateReplay:_startBattleResult()
	if not self.battleResult then
		return
	end

	local ui

	if self.battleType == BattleConst.BATTLE_TYPE_TOP_PVP_KNOCKOUT then
		ui = UIManager.getUI("battleResultKnockOutDlg", true)

		ui:show(self.battleType, self.battleTeamResult, nil, {})
	elseif self.result == BattleConst.BATTLE_RESULT_WIN or self.battleType == BattleConst.BATTLE_TYPE_WORLD_BOSS or self.battleType == BattleConst.BATTLE_TYPE_BOSSTOWER then
		ui = UIManager.getUI("battleVictoryDlg", true)

		ui:onShow(self.battleType, self.result)
	else
		ui = UIManager.getUI("battleLoseDlg", true)

		ui:onShow(self.battleType, nil, self.result, nil)
	end

	return ui
end

return GameStateReplay
