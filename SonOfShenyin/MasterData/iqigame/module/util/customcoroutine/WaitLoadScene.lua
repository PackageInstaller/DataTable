-- chunkname: @IQIGame\\Module\\Util\\CustomCoroutine\\WaitLoadScene.lua

WaitLoadScene = class({
	waitType = "WaitLoadScene"
}, CustomWait)

function WaitLoadScene:ctor(sceneID)
	SceneUtility.LoadScene(sceneID, function(sceneID, sceneName)
		print("加载场景" .. sceneName .. "完成")

		self.isComplete = true
	end)
end
