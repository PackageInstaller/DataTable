-- chunkname: @IQIGame\\Module\\GhostGame\\GhostGameModule.lua

local ghostGameScene = require("IQIGame.Scene.GhostGame.GhostGameScene")
local ghostEnemyData = require("IQIGame.Module.GhostGame.GhostEnemyData")

GhostGameModule = {
	UIReady = false,
	uiResumeTime = 3,
	IsStart = false,
	IsSceneReady = false,
	IsPause = false
}

function GhostGameModule.Initialize(activityId)
	GhostGameModule.activityId = activityId

	GhostGameModule.AddListeners()
	GhostGameModule.InitBaseData()
	GhostGameModule.RandomEnemy()

	GhostGameModule.ghostGameScene = ghostGameScene.New(22001)

	UIModule.Open(Constant.UIControllerName.GhostGameUI, Constant.UILayer.DefaultUI, {
		gameTime = GhostGameModule.GameTime,
		attackNum = GhostGameModule.ghostGameScene.ghostGamePlayer.attackNum
	})
end

function GhostGameModule.AddListeners()
	EventDispatcher.AddEventListener(EventID.GhostAttackNumChange, GhostGameModule.AttackNumChange)
end

function GhostGameModule.RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.GhostAttackNumChange, GhostGameModule.AttackNumChange)
end

function GhostGameModule.StartGame()
	if GhostGameModule.IsStart then
		return
	end

	GhostGameModule.IsStart = true

	GhostGameModule.StopTimer()

	GhostGameModule.timer = Timer.New(function()
		GhostGameModule.GameUpdate()
	end, 1, -1)

	GhostGameModule.timer:Start()
end

function GhostGameModule.GameUpdate()
	if not GhostGameModule.IsStart or GhostGameModule.IsPause then
		return
	end

	GhostGameModule.GameTime = GhostGameModule.GameTime - 1

	if GhostGameModule.GameTime <= 0 then
		GhostGameModule.GameOver()
	end

	EventDispatcher.Dispatch(EventID.GhostGameCountDownChange, math.max(0, GhostGameModule.GameTime))
end

function GhostGameModule.GameOver()
	GhostGameModule.IsStart = false

	GhostGameModule:RequestEndGame()
end

function GhostGameModule.AttackNumChange(attackNum)
	if attackNum <= 0 then
		GhostGameModule.GameOver()
	end
end

function GhostGameModule.InitBaseData()
	GhostGameModule.MonsterRefreshTime = CfgDiscreteDataTable[12005].Data[1] / 1000
	GhostGameModule.GameTime = CfgDiscreteDataTable[12004].Data[1]
	GhostGameModule.KillList = {}
	GhostGameModule.randomEnemyDataList = {}
	GhostGameModule.EnemySelectCountList = {}
	GhostGameModule.IsPause = false
	GhostGameModule.holdBuffList = {}
end

function GhostGameModule.RandomEnemy()
	local enemyMaxCount = 0

	for k, v in pairsCfg(CfgGhostGameMonsterTable) do
		enemyMaxCount = enemyMaxCount + v.MaxNum
		GhostGameModule.EnemySelectCountList[v.MonsterType] = 0
	end

	for i = 1, enemyMaxCount do
		local radomCfg = GhostGameModule.RandomEnemyConfig()

		table.insert(GhostGameModule.randomEnemyDataList, ghostEnemyData.New(radomCfg))
	end

	log("初始化随机怪物数据")
end

function GhostGameModule.RandomEnemyConfig()
	local totalProbability = 0
	local validConfigs = {}

	for _, config in pairsCfg(CfgGhostGameMonsterTable) do
		if GhostGameModule.EnemySelectCountList[config.MonsterType] < config.MaxNum then
			totalProbability = totalProbability + config.MonsterProbability

			table.insert(validConfigs, config)
		end
	end

	local randomValue = math.random() * totalProbability
	local accumulatedProbability = 0
	local selectedConfig

	for _, config in ipairs(validConfigs) do
		accumulatedProbability = accumulatedProbability + config.MonsterProbability

		if randomValue <= accumulatedProbability then
			selectedConfig = config
			GhostGameModule.EnemySelectCountList[config.MonsterType] = GhostGameModule.EnemySelectCountList[config.MonsterType] + 1

			break
		end
	end

	return selectedConfig
end

function GhostGameModule.RandomBuff(monsterCfg)
	local randomValue = math.random()
	local accumulatedProbability = 0
	local selectedBuff

	for i, probability in ipairs(monsterCfg.MonsterBuffProbability) do
		accumulatedProbability = accumulatedProbability + probability

		if randomValue <= accumulatedProbability then
			selectedBuff = monsterCfg.MonsterBuff[i]

			break
		end
	end

	if not selectedBuff then
		return -1
	else
		return selectedBuff
	end
end

function GhostGameModule.RandomReward()
	return
end

function GhostGameModule.GetEnemyCfg(index)
	return GhostGameModule.randomEnemyDataList[index]
end

function GhostGameModule.GetCanRefreshEnemy()
	for k, v in pairs(GhostGameModule.ghostGameScene.ghostGameCharacterList) do
		if v:GetBuff(Constant.GhostGameBuffType.Frozen) ~= nil then
			return false
		end
	end

	return true
end

function GhostGameModule.AddKillData(ghostGameCharacter)
	if GhostGameModule.KillList[ghostGameCharacter.enemyData.monsterCfg.Id] == nil then
		GhostGameModule.KillList[ghostGameCharacter.enemyData.monsterCfg.Id] = 0
	end

	GhostGameModule.KillList[ghostGameCharacter.enemyData.monsterCfg.Id] = GhostGameModule.KillList[ghostGameCharacter.enemyData.monsterCfg.Id] + 1

	EventDispatcher.Dispatch(EventID.GhostGameKillEnemyEvent)
end

function GhostGameModule.StopTimer()
	if GhostGameModule.timer then
		GhostGameModule.timer:Stop()

		GhostGameModule.timer = nil
	end
end

function GhostGameModule.ExitGame()
	SceneTransferModule.GhostGameToMainCity()
end

function GhostGameModule.AddHoldBuffList(buff)
	GhostGameModule.holdBuffList[buff.type] = buff
end

function GhostGameModule.RemoveHoldBuffList(buff)
	if GhostGameModule.holdBuffList[buff.type] == nil then
		return
	end

	GhostGameModule.holdBuffList[buff.type] = nil
end

function GhostGameModule.Shutdown()
	UIModule.Close(Constant.UIControllerName.GhostGameUI)

	GhostGameModule.IsStart = false
	GhostGameModule.IsSceneReady = false
	GhostGameModule.randomEnemyDataList = nil

	GhostGameModule.StopTimer()
	GhostGameModule.ghostGameScene:Dispose()
	GhostGameModule.RemoveListeners()
end

function GhostGameModule.StartGhostGameResult()
	EventDispatcher.Dispatch(EventID.GhostGameStartEvent)
end

function GhostGameModule.EndGhostGameResult(shows)
	EventDispatcher.Dispatch(EventID.GhostGameOverEvent)

	GhostGameModule.endGameCor = coroutine.start(function()
		coroutine.wait(1)
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, shows)
		coroutine.stop(GhostGameModule.endGameCor)

		GhostGameModule.endGameCor = nil
	end)
end

function GhostGameModule.RequestStartGame()
	net_activity.startGhostGame(GhostGameModule.activityId)
end

function GhostGameModule.RequestEndGame()
	net_activity.endGhostGame(GhostGameModule.activityId, GhostGameModule.KillList)
end
