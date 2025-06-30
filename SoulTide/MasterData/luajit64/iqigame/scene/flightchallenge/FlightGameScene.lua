-- chunkname: @IQIGame\\Scene\\FlightChallenge\\FlightGameScene.lua

local m = {
	gamePassTime = 0,
	currentGroupIndex = 1,
	lastRefreshEnemyDistance = 0,
	SoundPackageId = 0
}
local FlightGameInputManager = require("IQIGame.Scene.FlightChallenge.Input.FlightGameInputManager")
local FlightGameSceneBG = require("IQIGame.Scene.FlightChallenge.FlightGameSceneBG")
local FlightGamePlayer = require("IQIGame.Scene.FlightChallenge.FlightGamePlayer")
local FlightGameManager = require("IQIGame.Scene.FlightChallenge.FlightGameManager")

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:Init()
	local rootTrans = UnityEngine.GameObject.Find("FlightChallenge").transform

	self.MapRoot = rootTrans:Find("MapRoot")

	local path = UIGlobalApi.GetPrefabRoot("/ART_Prefabs/Scene/FlightChallenge/FlightGameBG.prefab")

	AssetUtil.LoadAsset(self, path, self.OnLoadBGPrefabSuccess, self.OnLoadBgPrefabFail)
	GameEntry.LuaEvent:FireNow(nil, LoadSceneExtResEndEventArgs():Fill(SceneID.CommonActivity))

	self.InputMgr = FlightGameInputManager.New()

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

	self.gameManager = FlightGameManager.New(self.PrefabRoot, self)
	self.gameBG = FlightGameSceneBG.New(self.BgNode)
	self.gamePlayer = FlightGamePlayer.New(self.Hero, self)

	self.gamePlayer:SetPlayerData(FlightGameModule.gamePlayerData, false)
	self.BombEffect:SetActive(false)

	self.gamePassTime = 0
	self.currentGroupIndex = 1
	FlightGameModule.flightDistance = 0
	FlightGameModule.bombNum = 0
	FlightGameModule.pickupFlightPointBox = 0

	self:Refresh()

	self.gameTimer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.FlightGame, function()
		self:TimerUpdate()
	end, 1, -1)

	self.gameTimer:Start()

	self.gameFrameTimer = ModuleTimerUtil.NewFrameTimer(Constant.ModuleTimerName.FlightGame, function()
		self:FrameUpdate()
	end, -1, -1)

	self.gameFrameTimer:Start()
	UIModule.Open(Constant.UIControllerName.FlightGameMainUI, Constant.UILayer.UI)
end

function m:OnLoadBgPrefabFail(assetName, asset, duration, innerUserData)
	logError(assetName)
end

function m:Refresh()
	self:RefreshBGM()
end

function m:TimerUpdate()
	if FlightGameModule.isGameOver then
		return
	end

	self.gamePassTime = self.gamePassTime + 1
	FlightGameModule.flightDistance = FlightGameModule.flightDistance + self.gamePlayer.flySpeed

	self:MonsterRefreshByDistance()
	self:MonsterRefreshByTime(self.gamePassTime)

	local num = CfgDiscreteDataTable[6520096].Data[1]

	if self.gamePassTime % num == 0 then
		self.gameManager:RewardBoxGenerator()
	end

	self.gamePlayer:TimerUpdate()
	EventDispatcher.Dispatch(EventID.UpdateFlightGameDistanceEvent)
end

function m:FrameUpdate()
	self.gameBG:FrameUpdate()

	if not FlightGameModule.isGameOver then
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

function m:MonsterRefreshByTime(time)
	local monsterTimerGroupData = FlightGameModule.monsterTimerGroupDataDic[time]

	if monsterTimerGroupData then
		local randomMonster = monsterTimerGroupData:GetRandomMonster()

		for i, v in pairs(randomMonster) do
			self.gameManager:MonsterGenerator(v)
		end
	end
end

function m:MonsterRefreshByDistance()
	local monsterDistanceGroupData = FlightGameModule.monsterDistanceGroupDataDic[self.currentGroupIndex]

	if not monsterDistanceGroupData:IsCurrentThisGroup(FlightGameModule.flightDistance) then
		local nextIndex = self.currentGroupIndex + 1
		local nextGroupData = FlightGameModule.monsterDistanceGroupDataDic[nextIndex]

		if nextGroupData then
			monsterDistanceGroupData = nextGroupData
			self.currentGroupIndex = nextIndex
		end
	end

	if monsterDistanceGroupData:IsCurrentThisGroup(FlightGameModule.flightDistance) then
		local pass = FlightGameModule.flightDistance - self.lastRefreshEnemyDistance

		if pass >= monsterDistanceGroupData:GetConfigData().DistanceInterval then
			local randomMonster = monsterDistanceGroupData:GetRandomMonster()

			for i, v in pairs(randomMonster) do
				self.gameManager:MonsterGenerator(v)
			end

			self.lastRefreshEnemyDistance = FlightGameModule.flightDistance
		end
	end
end

function m:ChangePlayer(data)
	if not FlightGameModule.isGameOver then
		self.gamePlayer:SetPlayerData(data, true)
	end
end

function m:UseBombs()
	if not FlightGameModule.isGameOver then
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
	ModuleTimerUtil.Stop(Constant.ModuleTimerName.FlightGame)
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
