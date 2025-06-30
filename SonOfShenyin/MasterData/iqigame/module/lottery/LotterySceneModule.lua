-- chunkname: @IQIGame\\Module\\Lottery\\LotterySceneModule.lua

LotterySceneModule = {}

function LotterySceneModule.Init()
	return
end

function LotterySceneModule.LoadScene()
	CoroutineUtility.StartCoroutine(function()
		local sceneID = 10
		local sceneListConfig = CfgSceneListTable[sceneID]

		if sceneListConfig ~= nil then
			local bgmCid = CfgSceneListTable[sceneID].BGM

			LuaUtility.PlayBGMWithID(bgmCid)
		end

		local MainCityRoot = GameObject.Find("MainCityRoot")

		if MainCityRoot ~= nil then
			MainCityModule.sceneCameraStack = MainCityRoot:GetComponent(typeof(IQIGame.Onigao.Game.SceneCameraStack))

			MainCityModule.sceneCameraStack:AddStackCamera()
		else
			logError("MainCityModule.LoadScene: MainCityRoot is not find.")
		end

		MainCityModule.mainCamera = UnityEngine.Camera.main

		UIModule.Open(Constant.UIControllerName.LotteryUI, Constant.UILayer.UI)
	end)
end

function LotterySceneModule.Shutdown()
	UIModule.Close(Constant.UIControllerName.LotteryUI)
end
