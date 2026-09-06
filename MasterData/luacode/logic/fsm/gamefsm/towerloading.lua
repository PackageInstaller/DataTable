local cSceneInfoStatic = BeanManager.GetTableByName("scene.csceneinfostatic")
local State = {}

function State.OnEnter(lastState)
  LogInfo("GameFSM", "DungeonLoading Enter")
  local loadingDialog = DialogManager.GetDialog("loadingdialog")
  loadingDialog:GetRootWindow():PlayAnimation("Loading")
  LuaNotificationCenter.AddObserver(State, State.OnLoadingEnd, Common.n_LoadingProgressFinish, nil)
  State.loadDungeonId = GlobalGameFSM:GetParameter("sceneLoadingId")
  GlobalGameFSM:SetNumber("sceneLoadingId", 0)
  GlobalGameFSM:SetNumber("sceneId", 0)
  State.LoadScene(State.loadDungeonId)
end

function State.Update()
end

function State.OnExit(nextState)
  LogInfo("GameFSM", "DungeonLoading Exit")
  LuaNotificationCenter.RemoveObserver(State)
end

function State.LoadScene(needLoadSceneId)
  local controller
  if needLoadSceneId ~= "" and needLoadSceneId ~= 0 then
    local loadingDialog = DialogManager.GetDialog("loadingdialog")
    if needLoadSceneId ~= State.loadDungeonId then
      SceneManager.LoadScene(needLoadSceneId, false, false, false, false, false)
    else
      controller = SceneManager.LoadScene(needLoadSceneId, true, false, true, true, true)
    end
    loadingDialog:AddSceneToLoad(needLoadSceneId)
    local scenesToLoads = {}
    if needLoadSceneId == 30009 then
      scenesToLoads = NekoData.BehaviorManager.BM_Tower:GetRequiredScenes()
    end
    if scenesToLoads ~= nil then
      for k, v in pairs(scenesToLoads) do
        State.LoadScene(v)
      end
    end
    return controller
  else
    return nil
  end
end

function State:OnLoadingEnd(noitification)
  if noitification.userInfo.loadProgressTable[State.loadDungeonId] then
    GlobalGameFSM:SetNumber("sceneId", State.loadDungeonId)
  end
end

return State
