-- chunkname: @IQIGame\\Module\\MemoryS\\MemorySModule.lua

MemorySModule = {
	soundPackageId = 0,
	resource = {}
}

local MemoryScene = require("IQIGame.Scene.Memory.MemoryScene")

function MemorySModule.Reload()
	MemorySModule.curLoadingAreaAsset = nil
end

function MemorySModule.Initialize()
	return
end

function MemorySModule.Shutdown()
	GameEntry.LuaEvent:Unsubscribe(LoadSceneSuccessEventArgs.EventId, MemorySModule.LoadSceneSuccess)

	MemorySModule.curLoadingAreaAsset = nil

	if MemorySModule.scene then
		MemorySModule.scene:OnDestroy()

		MemorySModule.scene = nil
	end
end

function MemorySModule.EnterScene(memoryChapterCid)
	MemorySModule.cfgChapterData = CfgSoulMemoryChapterTable[memoryChapterCid]
	MemorySModule.cfgSceneData = CfgMemorySceneListTable[MemorySModule.cfgChapterData.Scene]
	MemorySModule.curLoadingAreaAsset = nil

	GameEntry.LuaEvent:Subscribe(LoadSceneSuccessEventArgs.EventId, MemorySModule.LoadSceneSuccess)
	SceneManager.ChangeScene(SceneID.Memory)
end

function MemorySModule.ExitScene(sceneIndex)
	MemorySModule.Shutdown()
	SceneManager.ChangeScene(sceneIndex)
	AssetUtil.UnloadAsset(MemorySModule.resource)
end

function MemorySModule.LoadSceneSuccess(sender, args)
	GameEntry.LuaEvent:Unsubscribe(LoadSceneSuccessEventArgs.EventId, MemorySModule.LoadSceneSuccess)
	MemorySModule.ShowScene()
end

function MemorySModule.ShowScene()
	MemorySModule.StopSound()

	MemorySModule.soundPackage = SoundPackageData.New(MemorySModule.cfgSceneData.BGM, {
		MemorySModule.cfgSceneData.AmbientSound
	})
	MemorySModule.curLoadingAreaAsset = UIGlobalApi.GetArtPath(MemorySModule.cfgSceneData.ScenePrefab)

	AssetUtil.LoadAsset(MemorySModule.resource, MemorySModule.curLoadingAreaAsset, MemorySModule.OnLoadMapSuccess)
end

function MemorySModule.OnLoadMapSuccess(source, assetName, asset, duration, innerUserData)
	if MemorySModule.curLoadingAreaAsset ~= assetName then
		return
	end

	MemorySModule.scene = MemoryScene.New(UnityEngine.Object.Instantiate(asset))

	MemorySModule.scene:Refresh(MemorySModule.cfgSceneData, MemorySModule.cfgChapterData)
	UIModule.Open(Constant.UIControllerName.MemorySceneMainUI, Constant.UILayer.UI, MemorySModule.cfgSceneData)
	GameEntry.LuaEvent:FireNow(nil, LoadSceneExtResEndEventArgs():Fill(SceneID.Memory))
end

function MemorySModule.PlaySound()
	if MemorySModule.soundPackage ~= nil then
		MemorySModule.soundPackageId = SoundPackagePlayer.Add(MemorySModule.soundPackage)
	end
end

function MemorySModule.StopSound()
	if MemorySModule.soundPackageId ~= 0 then
		SoundPackagePlayer.Remove(MemorySModule.soundPackageId)
	end

	MemorySModule.soundPackageId = 0
	MemorySModule.soundPackage = nil
end
