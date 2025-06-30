-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/gamefsm/towerv2loading.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
State.OnEnter = function(lastState)
  -- function num : 0_0 , upvalues : _ENV, State
  LogInfo("GameFSM", "TowerV2Loading Enter")
  local loadingDialog = (DialogManager.GetDialog)("loadingdialog")
  ;
  (loadingDialog:GetRootWindow()):PlayAnimation("Loading")
  ;
  (LuaNotificationCenter.AddObserver)(State, State.OnLoadingEnd, Common.n_LoadingProgressFinish, nil)
  State.loadDungeonId = GlobalGameFSM:GetParameter("sceneLoadingId")
  GlobalGameFSM:SetNumber("sceneLoadingId", 0)
  GlobalGameFSM:SetNumber("sceneId", 0)
  local controller = (State.LoadScene)(State.loadDungeonId)
  controller:SetData("floorinfo", ((NekoData.BehaviorManager).BM_TowerV2):GetCurrentFloorInfo())
end

State.Update = function()
  -- function num : 0_1
end

State.OnExit = function(nextState)
  -- function num : 0_2 , upvalues : _ENV, State
  LogInfo("GameFSM", "TowerV2Loading Exit")
  ;
  (LuaNotificationCenter.RemoveObserver)(State)
end

State.LoadScene = function(needLoadSceneId)
  -- function num : 0_3 , upvalues : _ENV, State
  local controller = nil
  if needLoadSceneId ~= "" and needLoadSceneId ~= 0 then
    local loadingDialog = (DialogManager.GetDialog)("loadingdialog")
    if needLoadSceneId ~= State.loadDungeonId then
      (SceneManager.LoadScene)(needLoadSceneId, false, false, false, false, false)
    else
      controller = (SceneManager.LoadScene)(needLoadSceneId, true, false, true, true, true)
    end
    loadingDialog:AddSceneToLoad(needLoadSceneId)
    local scenesToLoads = (SceneManager.GetNeedLoadScenes)(needLoadSceneId)
    if scenesToLoads ~= nil then
      for k,v in pairs(scenesToLoads) do
        (State.LoadScene)(v)
      end
    end
    do
      do
        do return controller end
        do return nil end
      end
    end
  end
end

State.OnLoadingEnd = function(self, noitification)
  -- function num : 0_4 , upvalues : _ENV, State
  LogInfo("GameFSM", "TowerV2Loading End")
  if ((noitification.userInfo).loadProgressTable)[State.loadDungeonId] then
    GlobalGameFSM:SetNumber("sceneId", State.loadDungeonId)
  end
end

return State

