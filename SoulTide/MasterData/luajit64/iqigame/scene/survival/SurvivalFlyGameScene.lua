-- chunkname: @IQIGame\\Scene\\Survival\\SurvivalFlyGameScene.lua

local m = {
	gamePassTime = 0,
	nextRefreshBossTime = 0,
	lastRefreshEnemyDistance = 0,
	nextRefreshMonsterTime = 0,
	SoundPackageId = 0,
	nextRefreshMonsterGroup = {},
	nextRefreshBossGroup = {}
}
local SurvivalFlyGameInputManager = require("IQIGame.Scene.Survival.Input.SurvivalFlyGameInputManager")
local SurvivalFlyGameSceneBG = require("IQIGame.Scene.Survival.SurvivalFlyGameSceneBG")
local SurvivalFlyGamePlayer = require("IQIGame.Scene.Survival.SurvivalFlyGamePlayer")
local SurvivalFlyGameManager = require("IQIGame.Scene.Survival.SurvivalFlyGameManager")

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:Init()
	local rootTrans = UnityEngine.GameObject.Find("Survival").transform

	self.MapRoot = rootTrans:Find("MapRoot")

	local cfgSurvivalChallengeControlData = CfgSurvivalChallengeControlTable[SurvivalModule.GlobalCid]
	local path = UIGlobalApi.GetArtPath(cfgSurvivalChallengeControlData.SurvivalFlyGameBG)

	AssetUtil.LoadAsset(self, path, self.OnLoadBGPrefabSuccess, self.OnLoadBgPrefabFail)
	GameEntry.LuaEvent:FireNow(nil, LoadSceneExtResEndEventArgs():Fill(SceneID.CommonActivity))

	self.InputMgr = SurvivalFlyGameInputManager.New()

	self:AddListeners()
end

function m:RefreshBGM()
	local package = SoundPackageData.New(445, nil)

	self.SoundPackageId = SoundPackagePlayer.Add(package)
end

function m:OnLoadBGPrefabSuccess(assetName, asset, duration, innerUserData)
	local sceneObj = UnityEngine.Object.Instantiate(asset)

	self.View = sceneObj

	sceneObj.transform:SetParent(self.MapRoot, false)
	LuaCodeInterface.BindOutlet(self.View, self)

	self.gameManager = SurvivalFlyGameManager.New(self.PrefabRoot, self)
	self.gameBG = SurvivalFlyGameSceneBG.New(self.BgNode)
	self.gamePlayer = SurvivalFlyGamePlayer.New(self.Hero, self)

	self.gamePlayer:SetPlayerData(FlyGameModule.gamePlayerData, false)
	self.BombEffect:SetActive(false)

	self.gamePassTime = 0
	self.nextRefreshMonsterTime, self.nextRefreshMonsterGroup = self:GetEndlessRefreshMonster()

	self:RefreshNextBoss()

	FlyGameModule.killMonsterNum = 0
	FlyGameModule.killBossNum = 0

	self:Refresh()

	self.gameTimer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.SurvivalFlyGame, function()
		self:TimerUpdate()
	end, 1, -1)

	self.gameTimer:Start()

	self.gameFrameTimer = ModuleTimerUtil.NewFrameTimer(Constant.ModuleTimerName.SurvivalFlyGame, function()
		self:FrameUpdate()
	end, -1, -1)

	self.gameFrameTimer:Start()
	UIModule.Open(Constant.UIControllerName.SurvivalFlyGameMainUI, Constant.UILayer.UI)
end

function m:OnLoadBgPrefabFail(assetName, asset, duration, innerUserData)
	logError(assetName)
end

function m:Refresh()
	self:RefreshBGM()
end

function m:TimerUpdate()
	if FlyGameModule.isGameOver then
		return
	end

	self.gamePassTime = self.gamePassTime + 1

	self:MonsterRefreshByTime(self.gamePassTime)

	local num = CfgDiscreteDataTable[6520096].Data[1]

	if self.gamePassTime % num == 0 then
		self.gameManager:RewardBoxGenerator()
	end

	self.gamePlayer:TimerUpdate()
end

function m:FrameUpdate()
	self.gameBG:FrameUpdate()

	if not FlyGameModule.isGameOver then
		self.gamePlayer:FrameUpdate()
		self.gameManager:FrameUpdate()
	end
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:RefreshNextBoss()
	self.nextRefreshBossTime, self.nextRefreshBossGroup = self:GetEndlessRefreshBoss()
	self.nextRefreshMonsterTime, self.nextRefreshMonsterGroup = self:GetEndlessRefreshMonster()
end

function m:GetEndlessRefreshMonster()
	local nextRefreshTime = 0
	local nextRefreshMonster = {}
	local cfgRefreshMonsterData

	for i = 1, #FlyGameModule.refreshMonster do
		local cfgData = FlyGameModule.refreshMonster[i]

		if FlyGameModule.killBossNum >= cfgData.BossNum then
			cfgRefreshMonsterData = cfgData
		end
	end

	if cfgRefreshMonsterData then
		nextRefreshTime = self.gamePassTime + cfgRefreshMonsterData.RefreshTime

		for i = #cfgRefreshMonsterData.MonsterGroup, 2, -1 do
			local random_index = math.random(i)

			cfgRefreshMonsterData.MonsterGroup[i], cfgRefreshMonsterData.MonsterGroup[random_index] = cfgRefreshMonsterData.MonsterGroup[random_index], cfgRefreshMonsterData.MonsterGroup[i]
		end

		for i = 1, cfgRefreshMonsterData.MonsterNum do
			local groupID = cfgRefreshMonsterData.MonsterGroup[i]

			table.insert(nextRefreshMonster, groupID)
		end
	end

	return nextRefreshTime, nextRefreshMonster
end

function m:GetEndlessRefreshBoss()
	local nextRefreshTime = 0
	local nextRefreshBoss = {}
	local cfgRefreshBossData

	for i = 1, #FlyGameModule.refreshBoss do
		local cfgData = FlyGameModule.refreshBoss[i]

		if FlyGameModule.killBossNum >= cfgData.BossNum then
			cfgRefreshBossData = cfgData
		end
	end

	if cfgRefreshBossData then
		nextRefreshTime = self.gamePassTime + cfgRefreshBossData.RefreshTime

		for i = #cfgRefreshBossData.MonsterGroup, 2, -1 do
			local random_index = math.random(i)

			cfgRefreshBossData.MonsterGroup[i], cfgRefreshBossData.MonsterGroup[random_index] = cfgRefreshBossData.MonsterGroup[random_index], cfgRefreshBossData.MonsterGroup[i]
		end

		for i = 1, cfgRefreshBossData.MonsterNum do
			local groupID = cfgRefreshBossData.MonsterGroup[i]

			table.insert(nextRefreshBoss, groupID)
		end
	end

	return nextRefreshTime, nextRefreshBoss
end

function m:MonsterRefreshByTime(time)
	if FlyGameModule.flyGameType == FlyGameConstant.ChallengeType.Challenge_Level_Mode then
		if FlyGameModule.levelCid then
			local levelData = SurvivalModule.GetSurvivalChallengeLevelDataByID(FlyGameModule.levelCid)

			if levelData then
				local monsters = levelData:GetRefreshMonsterByTime(time)

				for i, v in pairs(monsters) do
					self.gameManager:MonsterGenerator(v)
				end
			end
		end
	elseif FlyGameModule.flyGameType == FlyGameConstant.ChallengeType.Challenge_Endless_Mode then
		if time == self.nextRefreshBossTime then
			for i, v in pairs(self.nextRefreshBossGroup) do
				local cfgMonsterGroupData = CfgSurvivalChallengeMonsterGroupTable[v]

				for j, value in pairs(cfgMonsterGroupData.Monster) do
					self.gameManager:MonsterGenerator(value)
				end
			end

			self.nextRefreshMonsterTime = 0
			self.nextRefreshMonsterGroup = {}
		elseif time == self.nextRefreshMonsterTime then
			for i, v in pairs(self.nextRefreshMonsterGroup) do
				local cfgMonsterGroupData = CfgSurvivalChallengeMonsterGroupTable[v]

				for j, value in pairs(cfgMonsterGroupData.Monster) do
					self.gameManager:MonsterGenerator(value)
				end
			end

			self.nextRefreshMonsterTime, self.nextRefreshMonsterGroup = self:GetEndlessRefreshMonster()
		end
	end
end

function m:UseBombs()
	if not FlyGameModule.isGameOver then
		self.gameManager:UseBombs()
		self.BombEffect:SetActive(false)
		self.BombEffect:SetActive(true)
	end
end

function m:Clean()
	self:RemoveListeners()
	self.gamePlayer:CleanData()
	self.gameManager:CleanData()
end

function m:Dispose()
	self.gameManager:Dispose()
	self.InputMgr:Dispose()
	ModuleTimerUtil.Stop(Constant.ModuleTimerName.SurvivalFlyGame)
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	self.gameBG:Dispose()
	self.gamePlayer:Dispose()

	if self.SoundPackageId > 0 then
		SoundPackagePlayer.Remove(self.SoundPackageId)

		self.SoundPackageId = 0
	end

	if self.View then
		LuaCodeInterface.ClearOutlet(self.View, self)
		UnityEngine.Object.Destroy(self.View)

		self.View = nil
	end
end

return m
