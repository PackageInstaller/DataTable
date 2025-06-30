-- chunkname: @IQIGame\\Module\\CommonActivity\\Survival\\FlyGame\\FlyGameModule.lua

local m = {
	flyGameType = 1,
	killBossNum = 0,
	specialItemTotalWeight = 0,
	isGameOver = true,
	killMonsterNum = 0,
	specialItemTab = {},
	refreshMonster = {},
	refreshBoss = {}
}
local SurvivalFlyGameScene = require("IQIGame.Scene.Survival.SurvivalFlyGameScene")

function m.Reload()
	m.isGameOver = true

	m.InitData()
	m.AddListeners()
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m:InitData()
	m.specialItemTotalWeight = 0
	m.specialItemTab = {}

	for i, v in pairsCfg(CfgSurvivalChallengeSpecialItemTable) do
		m.specialItemTotalWeight = m.specialItemTotalWeight + v.Weight

		table.insert(m.specialItemTab, v)
	end

	m.refreshMonster = {}

	for i, v in pairsCfg(CfgSurvivalChallengeRefreshMonsterTable) do
		if v.Group == SurvivalModule.GlobalCid then
			table.insert(m.refreshMonster, v)
		end
	end

	table.sort(m.refreshMonster, function(a, b)
		return a.BossNum < b.BossNum
	end)

	m.refreshBoss = {}

	for i, v in pairsCfg(CfgSurvivalChallengeRefreshBossTable) do
		if v.Group == SurvivalModule.GlobalCid then
			table.insert(m.refreshBoss, v)
		end
	end

	table.sort(m.refreshBoss, function(a, b)
		return a.BossNum < b.BossNum
	end)
end

function m.StartFlightGame(type, levelCid)
	m.flyGameType = type
	m.levelCid = levelCid

	m.EnterSurvivalFlyGameScene()
end

function m.ExitFlightGame()
	CommonActivitySceneModule.Jump(m.DisposeSurvivalFlyGameScene, 10901010)
end

function m.EnterSurvivalFlyGameScene()
	EventDispatcher.Dispatch(EventID.StopBGM)
	CommonActivitySceneModule.EnterScene(CommonActivityVirtualSceneID.Survival, m.OnSceneLoaded)
end

function m.OnSceneLoaded()
	m.isGameOver = false
	m.gamePlayerData = SurvivalModule.survivalPlayer[m.startPlayerCid]
	m.survivalFlyGameScene = SurvivalFlyGameScene.New()
end

function m.GetBombCfgData()
	for i, v in ipairs(m.specialItemTab) do
		if v.Type == FlyGameConstant.SpecialItemType.SpecialItem_Type_Bomb then
			return v
		end
	end

	return nil
end

function m.UseBombs()
	if m.isGameOver or m.survivalFlyGameScene == nil then
		return
	end

	if m.survivalFlyGameScene.gamePlayer.energyValue >= 100 then
		m.survivalFlyGameScene:UseBombs()
	end
end

function m.CheckChallengeLevelEnd()
	if m.flyGameType == FlyGameConstant.ChallengeType.Challenge_Level_Mode then
		local cfgLevelData = CfgSurvivalChallengeLevelTable[m.levelCid]
		local needKillBoss = cfgLevelData.RewardCondition[3]

		if needKillBoss <= m.killBossNum then
			m.GameOver()
		end
	end
end

function m.GameOver()
	if m.flyGameType == FlyGameConstant.ChallengeType.Challenge_Level_Mode then
		SurvivalModule.EndChallenge(m.startPlayerCid, m.levelCid, m.killMonsterNum, m.killBossNum)
	else
		SurvivalModule.EndChallengeUnlimited(m.startPlayerCid, m.killBossNum)
	end

	m.isGameOver = true

	m.survivalFlyGameScene:Clean()

	m.startPlayerCid = nil
end

function m.DisposeSurvivalFlyGameScene()
	if m.survivalFlyGameScene then
		m.survivalFlyGameScene:Dispose()
	end

	m.survivalFlyGameScene = nil
end

function m.Shutdown()
	m.RemoveListeners()
	m.DisposeSurvivalFlyGameScene()

	m.killMonsterNum = 0
	m.killBossNum = 0
	m.currentGroupIndex = 1
	m.isGameOver = true
	m.gamePlayerData = nil
	m.startPlayerCid = nil
end

FlyGameModule = m
