-- chunkname: @IQIGame\\Module\\Util\\CustomCoroutine\\WaitLoadSceneAdditively.lua

WaitLoadSceneAdditively = class({
	waitType = "WaitLoadScene"
}, CustomWait)

function WaitLoadSceneAdditively:ctor(sceneID, isSetActiveScene, callback)
	SceneUtility.LoadSceneAdditively(sceneID, function(sceneID, sceneName)
		print("Additively加载场景" .. sceneName .. "完成")

		if isSetActiveScene then
			local path = AssetPath.Get(GlobalKey.ScenePath, sceneName)

			UnityEngine.SceneManagement.SceneManager.SetActiveScene(UnityEngine.SceneManagement.SceneManager.GetSceneByPath(path))
		end

		self.isComplete = true
		self.result = {
			sceneID = sceneID,
			sceneName = sceneName
		}

		if callback then
			callback(sceneID, sceneName)
		end

		if CfgSceneListTable[sceneID].RenderConfig then
			CoroutineUtility.Yield(WaitLoadAsset(BattleView, BattleApi:GetSceneRenderConfigUrl(sceneID), function(assetName, asset, duration, userData)
				SceneRenderConfigManager.ApplyConfig(asset)
			end))
		end
	end)
end
