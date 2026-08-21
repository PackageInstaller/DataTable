-- chunkname: @IQIGame\\Core\\GlobalListener.lua

GlobalListener = {}

function GlobalListener.Init()
	GameEntry.LuaEvent:Subscribe(LoadSceneStartEventArgs.EventId, GlobalListener.LoadSceneStart)
	GameEntry.LuaEvent:Subscribe(LoadSceneSuccessEventArgs.EventId, GlobalListener.LoadSceneSuccess)
	GameEntry.LuaEvent:Subscribe(LoadSceneExtResEndEventArgs.EventId, GlobalListener.LoadSceneExtSucceeded)
	GameEntry.LuaEvent:Subscribe(LoadSceneFailureEventArgs.EventId, GlobalListener.LoadSceneFailed)
	GameEntry.LuaEvent:Subscribe(UserInputKeyEventArgs.EventId, GlobalListener.OnUserInputKey)
	GameEntry.LuaEvent:Subscribe(ReceiveUrlEventArgs.EventId, GlobalListener.OnReceiveUrl)
	GameEntry.LuaEvent:Subscribe(RemoveAdditiveSceneSuccessEventArgs.EventId, GlobalListener.OnRemoveAdditiveScene)
end

function GlobalListener.Shutdown()
	GameEntry.LuaEvent:Unsubscribe(LoadSceneStartEventArgs.EventId, GlobalListener.LoadSceneStart)
	GameEntry.LuaEvent:Unsubscribe(LoadSceneSuccessEventArgs.EventId, GlobalListener.LoadSceneSuccess)
	GameEntry.LuaEvent:Unsubscribe(LoadSceneExtResEndEventArgs.EventId, GlobalListener.LoadSceneExtSucceeded)
	GameEntry.LuaEvent:Unsubscribe(LoadSceneFailureEventArgs.EventId, GlobalListener.LoadSceneFailed)
	GameEntry.LuaEvent:Unsubscribe(UserInputKeyEventArgs.EventId, GlobalListener.OnUserInputKey)
	GameEntry.LuaEvent:Unsubscribe(ReceiveUrlEventArgs.EventId, GlobalListener.OnReceiveUrl)
	GameEntry.LuaEvent:Unsubscribe(RemoveAdditiveSceneSuccessEventArgs.EventId, GlobalListener.OnRemoveAdditiveScene)
end

function GlobalListener.OnUserInputKey(sender, event)
	if event.KeyCode == 27 then
		if UIModule.HasUI(Constant.UIControllerName.CommunicationUI) then
			return
		end

		local forms = GameEntry.UI:GetAllLoadedUIForms()
		local formQue = {}

		for i = 0, forms.Length - 1 do
			formQue[#formQue + 1] = forms[i]
		end

		table.sort(formQue, function(a, b)
			return a:GetComponent("Canvas").sortingOrder > b:GetComponent("Canvas").sortingOrder
		end)

		for i, v in ipairs(formQue) do
			local ignore = false

			for m, n in pairsCfg(CfgUIConfigurationTable) do
				if n.UIName == v:GetComponent("UIController").UIName then
					ignore = n.IgnoreBackKey

					break
				end
			end

			if not ignore then
				local btnArr = v:GetComponentsInChildren(typeof(UnityEngine.UI.Button), true)
				local targetBtn

				for m = 0, btnArr.Length - 1 do
					local checkBtn = btnArr[m]

					if checkBtn.gameObject.activeInHierarchy and string.find(checkBtn.gameObject.name, "#Back") then
						if targetBtn == nil then
							targetBtn = checkBtn
						else
							targetBtn = GlobalListener.GetTopTargetInHierarchy(targetBtn.gameObject, checkBtn.gameObject)
						end
					end
				end

				if targetBtn then
					GameEntry.Input:SimulatedClick(targetBtn.gameObject)

					return
				end

				break
			end
		end

		LoginModule.OnPlayerExitGame()
	elseif event.KeyCode == 282 and GmListModule.EnableGM() then
		GmListModule.OnClickGm()
	end
end

function GlobalListener.GetTopTargetInHierarchy(goTarget1, goTarget2)
	local path_1 = GlobalListener.GetTransPathFromUI(goTarget1)
	local path_2 = GlobalListener.GetTransPathFromUI(goTarget2)

	for i, v in ipairs(path_1) do
		if path_1[i] ~= path_2[i] then
			if path_1[i].transform:GetSiblingIndex() > path_2[i].transform:GetSiblingIndex() then
				return goTarget1
			else
				return goTarget2
			end
		end
	end
end

function GlobalListener.GetTransPathFromUI(goTarget)
	local pathTrans = {}
	local temp = goTarget.transform

	while temp:GetComponent("UIController") == nil do
		table.insert(pathTrans, 1, temp.transform.parent)

		temp = temp.transform.parent
	end

	pathTrans[#pathTrans + 1] = goTarget.transform

	return pathTrans
end

function GlobalListener.OnReceiveUrl(sender, event)
	GlobalListener.ReceiveUrl = event.Url

	if PlayerModule.CurrSceneID == SceneID.MainCity then
		GlobalListener.checkReceiveUrl()
	end
end

function GlobalListener.checkReceiveUrl()
	if PlayerModule.PlayerInfo.currDialog ~= 0 or GuideModule.HasGuide() then
		return false
	end

	if GlobalListener.ReceiveUrl == nil then
		return false
	end

	local url = GlobalListener.ReceiveUrl

	GlobalListener.ReceiveUrl = nil

	local startIndex, endIndex = string.find(url, "function/")

	if startIndex ~= nil then
		local jumpIdParamStr = string.sub(url, endIndex + 1, -1)
		local jumpIdParam = string.split(jumpIdParamStr, "/")
		local jumpId = tonumber(jumpIdParam[1])
		local jumpParam = tonumber(jumpIdParam[2])

		if jumpId ~= nil then
			if PlayerModule.CurrSceneID == SceneID.MainCity then
				JumpModule.Jump(jumpId, jumpParam)

				return true
			end
		else
			warning("功能跳转参数解析错误：" .. event.Url)

			return false
		end
	end

	return false
end

function GlobalListener.LoadSceneStart(sender, event)
	if event.NextSceneID == SceneID.MainCity then
		RandomSecretaryModule.ChaneRandomSecretary()
	end

	local isAdditiveScene = event.NextSceneID == SceneID.Battle

	if not isAdditiveScene then
		PlayerModule.CurrSceneID = 0
	end

	if PlayerModule.InGame then
		local cfgSceneListData = CfgSceneListTable[event.NextSceneID]

		if cfgSceneListData.LoadingUI ~= "" then
			GlobalListener.LoadingUIName = cfgSceneListData.LoadingUI

			UIModule.Open(GlobalListener.LoadingUIName, Constant.UILayer.Top, {
				sceneId = cfgSceneListData.Id
			})
		end

		SoulModule.ChangeToCandidate()
	end
end

function GlobalListener.LoadSceneSuccess(sender, args)
	SoulModule.spineNeedGreet = true

	EventDispatcher.Dispatch(EventID.LoadSceneSuccess, tonumber(args.UserData))
end

function GlobalListener.LoadSceneExtSucceeded(sender, event)
	local isAdditiveScene = event.SceneID == SceneID.Battle

	if isAdditiveScene then
		PlayerModule.CurrAdditiveSceneID = event.SceneID
	else
		PlayerModule.CurrSceneID = event.SceneID
	end

	if GlobalListener.LoadingUIName ~= nil then
		UIModule.Close(GlobalListener.LoadingUIName)
	end

	SceneManager.IsProcessing = false

	WeatherBGMModule.LoadScene(event.SceneID, isAdditiveScene)
	NoticeModule.CheckResumeNoticeAfterScene(isAdditiveScene)
	GuideModule.OnEnterScene(event.SceneID, isAdditiveScene)

	if not isAdditiveScene and PlayerModule.CurrSceneID ~= SceneID.Maze then
		MazeModule.CheckRecoverEntrance()
	end

	JumpModule.CheckContinueJump(isAdditiveScene)

	if event.SceneID == SceneID.MainCity then
		local ret = GlobalListener.checkReceiveUrl()

		if not ret then
			JumpModule.CheckToAutoOpenUI()
		end
	end

	if not isAdditiveScene and LoginModule.LoginTimeForLog ~= 0 and PlayerModule.CurrSceneID == PlayerModule.InitSceneID then
		local elapseTimeFromLogin = PlayerModule.GetServerTime() - LoginModule.LoginTimeForLog

		SDKLoginModule.LogEnterHall(elapseTimeFromLogin)

		LoginModule.LoginTimeForLog = 0
	end
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
		logError("移除叠加场景出错：移除的场景和现有的场景不符合。")
	end
end
