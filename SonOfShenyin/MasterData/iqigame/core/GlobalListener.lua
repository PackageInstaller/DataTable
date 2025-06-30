-- chunkname: @IQIGame\\Core\\GlobalListener.lua

GlobalListener = {}

function GlobalListener.Init()
	GameEntry.LuaEvent:Subscribe(LoadSceneStartEventArgs.EventId, GlobalListener.LoadSceneStart)
	GameEntry.LuaEvent:Subscribe(LoadSceneSuccessEventArgs.EventId, GlobalListener.LoadSceneSuccess)
	GameEntry.LuaEvent:Subscribe(LoadSceneExtResEndEventArgs.EventId, GlobalListener.LoadSceneExtSucceeded)
	GameEntry.LuaEvent:Subscribe(LoadSceneFailureEventArgs.EventId, GlobalListener.LoadSceneFailed)
	GameEntry.LuaEvent:Subscribe(UserInputKeyEventArgs.EventId, GlobalListener.OnUserInputKey)
	GameEntry.LuaEvent:Subscribe(RemoveAdditiveSceneSuccessEventArgs.EventId, GlobalListener.OnRemoveAdditiveScene)
	GameEntry.LuaEvent:Subscribe(RemoveNormalSceneSuccessEventArgs.EventId, GlobalListener.OnRemoveNormalScene)
end

function GlobalListener.Shutdown()
	GameEntry.LuaEvent:Unsubscribe(LoadSceneStartEventArgs.EventId, GlobalListener.LoadSceneStart)
	GameEntry.LuaEvent:Unsubscribe(LoadSceneSuccessEventArgs.EventId, GlobalListener.LoadSceneSuccess)
	GameEntry.LuaEvent:Unsubscribe(LoadSceneExtResEndEventArgs.EventId, GlobalListener.LoadSceneExtSucceeded)
	GameEntry.LuaEvent:Unsubscribe(LoadSceneFailureEventArgs.EventId, GlobalListener.LoadSceneFailed)
	GameEntry.LuaEvent:Unsubscribe(UserInputKeyEventArgs.EventId, GlobalListener.OnUserInputKey)
	GameEntry.LuaEvent:Unsubscribe(RemoveAdditiveSceneSuccessEventArgs.EventId, GlobalListener.OnRemoveAdditiveScene)
	GameEntry.LuaEvent:Unsubscribe(RemoveNormalSceneSuccessEventArgs.EventId, GlobalListener.OnRemoveNormalScene)
end

function GlobalListener.OnUserInputKey(sender, event)
	if event.KeyCode == 27 then
		PlayerModule.IsFirstQuit = true

		LoginModule.OnPlayerExitGame()
	end
end

function GlobalListener.LoadSceneStart(sender, event)
	local isAdditiveScene = event.NextSceneID == SceneID.Battle0

	if not isAdditiveScene then
		PlayerModule.CurrSceneID = 0
	end

	local cfgSceneListData = CfgSceneListTable[event.NextSceneID]

	if cfgSceneListData.LoadingUI ~= "" then
		GlobalListener.LoadingUIName = cfgSceneListData.LoadingUI

		UIModule.Open(GlobalListener.LoadingUIName, Constant.UILayer.Top, {
			sceneId = cfgSceneListData.Id
		})
	end
end

function GlobalListener.LoadSceneSuccess(sender, event)
	return
end

function GlobalListener.LoadSceneExtSucceeded(sender, event)
	return
end

function GlobalListener.LoadSceneFailed(sender, event)
	local sceneAssetName = event.SceneAssetName
	local errorMessage = event.ErrorMessage

	logError("load scene \"" .. sceneAssetName .. "\" failed.\n" .. errorMessage)
end

function GlobalListener.OnRemoveAdditiveScene(sender, args)
	local currAdditiveSceneID = PlayerModule.CurrAdditiveSceneID

	PlayerModule.CurrAdditiveSceneID = 0

	if args.SceneID ~= currAdditiveSceneID then
		-- block empty
	end
end

function GlobalListener.OnRemoveNormalScene(sender, args)
	SoundPackagePlayer.ClearAfterStopAllSound()
end

function GlobalListener.PlaySceneBGM(sceneID, isAddScene)
	local sceneListConfig = CfgSceneListTable[sceneID]

	if sceneListConfig ~= nil then
		local bgmCid = CfgSceneListTable[sceneID].BGM

		if bgmCid ~= 0 then
			-- block empty
		end
	end
end
