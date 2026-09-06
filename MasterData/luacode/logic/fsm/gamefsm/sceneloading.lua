local cSceneInfoStatic = BeanManager.GetTableByName("scene.csceneinfostatic")
local State = {}

function State.OnEnter(lastState)
  LogInfo("GameFSM", "SceneLoading Enter")
  local loadingDialog = DialogManager.GetDialog("loadingdialog")
  loadingDialog:GetRootWindow():PlayAnimation("Loading")
  LuaNotificationCenter.AddObserver(State, State.OnLoadingEnd, Common.n_LoadingProgressFinish, nil)
  State.loadSceneId = GlobalGameFSM:GetParameter("sceneLoadingId")
  GlobalGameFSM:SetNumber("sceneLoadingId", 0)
  GlobalGameFSM:SetNumber("sceneId", 0)
  State.LoadScene(State.loadSceneId)
end

function State.Update()
end

function State.OnExit(nextState)
  LogInfo("GameFSM", "SceneLoading Exit")
  LuaNotificationCenter.RemoveObserver(State)
end

function State.LoadScene(needLoadSceneId)
  if needLoadSceneId == "" or needLoadSceneId == 0 then
    return
  end
  local loadingDialog = DialogManager.GetDialog("loadingdialog")
  if needLoadSceneId ~= State.loadSceneId then
    SceneManager.LoadScene(needLoadSceneId, false, false, false, false, false)
  else
    SceneManager.LoadScene(needLoadSceneId, true, false, true, true, true)
  end
  loadingDialog:AddSceneToLoad(needLoadSceneId)
  local scenesToLoads = SceneManager.GetNeedLoadScenes(needLoadSceneId)
  if scenesToLoads ~= nil then
    for k, v in pairs(scenesToLoads) do
      State.LoadScene(v)
    end
  end
end

function State:OnLoadingEnd(noitification)
  LogInfoFormat("SceneLoading", "---- State.loadSceneId is complete or not: = %s", noitification.userInfo.loadProgressTable[State.loadSceneId] ~= nil)
  if noitification.userInfo.loadProgressTable[State.loadSceneId] then
    GlobalGameFSM:SetNumber("sceneId", State.loadSceneId)
  end
end

return State
