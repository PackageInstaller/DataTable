-- chunkname: @IQIGame\\Module\\TownArea\\TownAreaModule.lua

TownAreaModule = {
	INTERVAL = 1,
	soundPackageId = 0,
	resource = {},
	npc2AreaDic = {},
	npc2CounterDic = {}
}

local TownAreaScene = require("IQIGame.Scene.TownArea.TownAreaScene")

function TownAreaModule.Reload()
	TownAreaModule.RandomAllNpc()
	TownAreaModule.StartTimer()

	TownAreaModule.curLoadingAreaAsset = nil
end

function TownAreaModule.Initialize()
	return
end

function TownAreaModule.Shutdown()
	TownAreaModule.StopTimer()

	if TownAreaModule.areaScene then
		TownAreaModule.areaScene:OnDestroy()
	end

	TownAreaModule.areaScene = nil
	TownAreaModule.areaData = nil
end

function TownAreaModule.EnterArea(areaData)
	if TownAreaModule.areaData ~= nil then
		return
	end

	TownAreaModule.areaData = areaData
	TownAreaModule.curLoadingAreaAsset = nil

	GameEntry.LuaEvent:Unsubscribe(LoadSceneSuccessEventArgs.EventId, TownAreaModule.LoadSceneSuccess)
	GameEntry.LuaEvent:Subscribe(LoadSceneSuccessEventArgs.EventId, TownAreaModule.LoadSceneSuccess)
	SceneManager.ChangeScene(SceneID.TownArea)
end

function TownAreaModule.ExitArea()
	TownAreaModule.CleanAreaScene()
	SceneManager.ChangeScene(SceneID.MainCity)
end

function TownAreaModule.CleanAreaScene()
	TownAreaModule.areaData = nil
	TownAreaModule.curLoadingAreaAsset = nil

	if TownAreaModule.areaScene then
		TownAreaModule.areaScene:OnDestroy()

		TownAreaModule.areaScene = nil
	end

	AssetUtil.UnloadAsset(TownAreaModule.resource)
end

function TownAreaModule.LoadSceneSuccess(sender, args)
	GameEntry.LuaEvent:Unsubscribe(LoadSceneSuccessEventArgs.EventId, TownAreaModule.LoadSceneSuccess)
	TownAreaModule.ShowArea(TownAreaModule.areaData)
end

function TownAreaModule.ShowArea(areaData)
	local cfgWeather = CfgMainCityWeatherTable[WeatherModule.currentWeatherCid]
	local performanceID = cfgWeather.Performance[WeatherModule.periodOfTime]
	local cfgPerformance = CfgMainCityWeatherPerformanceTable[performanceID]
	local prefabIndex

	prefabIndex = (cfgPerformance.TimeGroup == 1 or cfgPerformance.TimeGroup == 2) and 1 or cfgPerformance.TimeGroup == 3 and 3 or (cfgPerformance.TimeGroup == 4 or cfgPerformance.TimeGroup == 5) and 2 or 4

	TownAreaModule.StopSound()

	local envSoundCids = {}
	local prefabPath

	for i = prefabIndex, 1, -1 do
		if i <= #areaData.cfgInfo.AreaPrefabs then
			prefabPath = areaData.cfgInfo.AreaPrefabs[i]

			if areaData.cfgInfo.AmbientSound ~= nil then
				envSoundCids[1] = areaData.cfgInfo.AmbientSound[i]
			end

			TownAreaModule.soundPackage = SoundPackageData.New(areaData.cfgInfo.BGMNew[i], envSoundCids)

			break
		end
	end

	local path = UIGlobalApi.GetArtPath(prefabPath)

	TownAreaModule.curLoadingAreaAsset = path

	AssetUtil.LoadAsset(TownAreaModule.resource, path, TownAreaModule.OnLoadAreaSuccess)
end

function TownAreaModule.OnLoadAreaSuccess(source, assetName, asset, duration, innerUserData)
	if TownAreaModule.curLoadingAreaAsset ~= assetName then
		return
	end

	local goArea = UnityEngine.Object.Instantiate(asset)

	TownAreaModule.areaScene = TownAreaScene.New(goArea)

	TownAreaModule.areaScene:Refresh(TownAreaModule.areaData)
	GameEntry.LuaEvent:FireNow(nil, LoadSceneExtResEndEventArgs():Fill(SceneID.TownArea))
end

function TownAreaModule.StartTimer()
	if TownAreaModule.timer == nil then
		TownAreaModule.timer = Timer.New(function()
			TownAreaModule.OnTimer()
		end, TownAreaModule.INTERVAL, -1)
	end

	for i, v in pairsCfg(CfgTownAreaNpcTable) do
		TownAreaModule.npc2CounterDic[v] = v.CountDown
	end

	TownAreaModule.timer:Start()
end

function TownAreaModule.StopTimer()
	if TownAreaModule.timer then
		TownAreaModule.timer:Stop()
	end
end

function TownAreaModule.OnTimer()
	for i, v in pairs(TownAreaModule.npc2CounterDic) do
		if v <= 0 then
			TownAreaModule.npc2CounterDic[i] = i.CountDown

			TownAreaModule.RandomNpc(i)
			EventDispatcher.Dispatch(EventID.TownAreaRefreshNpc, i)
		end

		TownAreaModule.npc2CounterDic[i] = TownAreaModule.npc2CounterDic[i] - TownAreaModule.INTERVAL
	end
end

function TownAreaModule.RandomAllNpc()
	for i, v in pairsCfg(CfgTownAreaNpcTable) do
		TownAreaModule.RandomNpc(v)
	end
end

function TownAreaModule.RandomNpc(cfgData)
	local totalWeight = 0

	for i, v in ipairs(cfgData.AreaRandomWeight) do
		totalWeight = totalWeight + v
	end

	if totalWeight == 0 then
		return
	end

	local randomWeight = math.random(1, totalWeight)
	local tempTotalWeight = 0

	for i, v in ipairs(cfgData.AreaRandomWeight) do
		if tempTotalWeight <= randomWeight and randomWeight <= tempTotalWeight + v then
			TownAreaModule.npc2AreaDic[cfgData.Id] = cfgData.Area[i]

			break
		end

		tempTotalWeight = tempTotalWeight + v
	end
end

function TownAreaModule.PlaySound()
	if TownAreaModule.soundPackage ~= nil then
		TownAreaModule.soundPackageId = SoundPackagePlayer.Add(TownAreaModule.soundPackage)
	end
end

function TownAreaModule.StopSound()
	if TownAreaModule.soundPackageId ~= 0 then
		SoundPackagePlayer.Remove(TownAreaModule.soundPackageId)
	end

	TownAreaModule.soundPackageId = 0
	TownAreaModule.soundPackage = nil
end
