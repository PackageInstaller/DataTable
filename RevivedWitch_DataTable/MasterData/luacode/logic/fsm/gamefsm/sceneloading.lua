-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/gamefsm/sceneloading.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cSceneInfoStatic = (BeanManager.GetTableByName)("scene.csceneinfostatic")
local State = {}
State.OnEnter = function(lastState)
  -- function num : 0_0 , upvalues : _ENV, State
  LogInfo("GameFSM", "SceneLoading Enter")
  local loadingDialog = (DialogManager.GetDialog)("loadingdialog")
  ;
  (loadingDialog:GetRootWindow()):PlayAnimation("Loading")
  ;
  (LuaNotificationCenter.AddObserver)(State, State.OnLoadingEnd, Common.n_LoadingProgressFinish, nil)
  State.loadSceneId = GlobalGameFSM:GetParameter("sceneLoadingId")
  GlobalGameFSM:SetNumber("sceneLoadingId", 0)
  GlobalGameFSM:SetNumber("sceneId", 0)
  ;
  (State.LoadScene)(State.loadSceneId)
end

State.Update = function()
  -- function num : 0_1
end

State.OnExit = function(nextState)
  -- function num : 0_2 , upvalues : _ENV, State
  LogInfo("GameFSM", "SceneLoading Exit")
  ;
  (LuaNotificationCenter.RemoveObserver)(State)
end

State.LoadScene = function(needLoadSceneId)
  -- function num : 0_3 , upvalues : _ENV, State
  if needLoadSceneId == "" or needLoadSceneId == 0 then
    return 
  end
  local loadingDialog = (DialogManager.GetDialog)("loadingdialog")
  if needLoadSceneId ~= State.loadSceneId then
    (SceneManager.LoadScene)(needLoadSceneId, false, false, false, false, false)
  else
    ;
    (SceneManager.LoadScene)(needLoadSceneId, true, false, true, true, true)
  end
  loadingDialog:AddSceneToLoad(needLoadSceneId)
  local scenesToLoads = (SceneManager.GetNeedLoadScenes)(needLoadSceneId)
  if scenesToLoads ~= nil then
    for k,v in pairs(scenesToLoads) do
      (State.LoadScene)(v)
    end
  end
end

State.OnLoadingEnd = function(self, noitification)
  -- function num : 0_4 , upvalues : _ENV, State
  LogInfoFormat("SceneLoading", "---- State.loadSceneId is complete or not: = %s", ((noitification.userInfo).loadProgressTable)[State.loadSceneId] ~= nil)
  if ((noitification.userInfo).loadProgressTable)[State.loadSceneId] then
    GlobalGameFSM:SetNumber("sceneId", State.loadSceneId)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

return State

