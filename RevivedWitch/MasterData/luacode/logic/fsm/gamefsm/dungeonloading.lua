-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/gamefsm/dungeonloading.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cSceneInfoStatic = (BeanManager.GetTableByName)("scene.csceneinfostatic")
local State = {}
State.OnEnter = function(lastState)
  -- function num : 0_0 , upvalues : _ENV, State
  LogInfo("GameFSM", "DungeonLoading Enter" .. tostring((os.clock)()))
  local loadingDialog = (DialogManager.GetDialog)("loadingdialog")
  ;
  (loadingDialog:GetRootWindow()):PlayAnimation("Loading")
  ;
  (LuaNotificationCenter.AddObserver)(State, State.OnLoadingEnd, Common.n_LoadingProgressFinish, nil)
  State.loadDungeonId = GlobalGameFSM:GetParameter("sceneLoadingId")
  GlobalGameFSM:SetNumber("sceneLoadingId", 0)
  GlobalGameFSM:SetNumber("sceneId", 0)
  local controller = (State.LoadScene)(State.loadDungeonId)
  controller:SetData("bornPosition", ((NekoData.BehaviorManager).BM_SEnterDungeon):GetPoint())
  controller:SetData("randomItems", ((NekoData.BehaviorManager).BM_SEnterDungeon):GetRandomItems())
  controller:SetData("sceneObjects", ((NekoData.BehaviorManager).BM_SEnterDungeon):GetSceneObjects())
  controller:SetData("npcObjects", ((NekoData.BehaviorManager).BM_SEnterDungeon):GetNPCObjects())
  controller:SetData("disabled", ((NekoData.BehaviorManager).BM_SEnterDungeon):GetDisabledSceneObjects())
  controller:SetData("sceneStates", ((NekoData.BehaviorManager).BM_SEnterDungeon):GetReservedEvents())
  controller:SetData("enemies", ((NekoData.BehaviorManager).BM_SEnterDungeon):GetMonsters())
  controller:SetData("chests", ((NekoData.BehaviorManager).BM_SEnterDungeon):GetChests())
  controller:SetData("lastBattleInfo", ((NekoData.BehaviorManager).BM_SEnterDungeon):GetLastBattleInfo())
  controller:SetData("modules", ((NekoData.BehaviorManager).BM_SEnterDungeon):GetModules())
  controller:SetData("interactive", ((NekoData.BehaviorManager).BM_SEnterDungeon):GetInteractive())
  controller:SetData("scrollinfo", ((NekoData.BehaviorManager).BM_SEnterDungeon):GetScrollInfo())
  controller:SetData("buff", ((NekoData.BehaviorManager).BM_SEnterDungeon):GetBuffs())
  local switches = ((NekoData.BehaviorManager).BM_SEnterDungeon):GetSwitches()
  local traps = ((NekoData.BehaviorManager).BM_SEnterDungeon):GetTraps()
  local total = {switches = switches, traps = traps}
  if controller then
    if controller:IsNavMeshReady() then
      (SwitchManager.RestoreState)(switches)
      ;
      (TrapManager.RestoreState)(traps)
    else
      controller:SetData("trapStates", total)
    end
  else
    ;
    (LuaNotificationCenter.AddObserver)(State, function(observer, notification)
    -- function num : 0_0_0 , upvalues : _ENV, State, total
    local controller = (SceneManager.GetSceneControllerByID)(State.loadDungeonId)
    controller:CallMethodAsync(function()
      -- function num : 0_0_0_0 , upvalues : controller, total
      controller:SetData("trapStates", total)
    end
)
    ;
    (LuaNotificationCenter.RemoveObserver)(State)
  end
, Common.n_EndLoadScene, nil)
  end
end

State.Update = function()
  -- function num : 0_1
end

State.OnExit = function(nextState)
  -- function num : 0_2 , upvalues : _ENV, State
  LogInfo("GameFSM", "DungeonLoading Exit")
  ;
  (LuaNotificationCenter.RemoveObserver)(State)
end

State.LoadScene = function(needLoadSceneId)
  -- function num : 0_3 , upvalues : _ENV, State, cSceneInfoStatic
  local controller = nil
  if needLoadSceneId ~= "" and needLoadSceneId ~= 0 then
    local loadingDialog = (DialogManager.GetDialog)("loadingdialog")
    if needLoadSceneId ~= State.loadDungeonId then
      (SceneManager.LoadScene)(needLoadSceneId, false, false, false, false, false)
    else
      controller = (SceneManager.LoadScene)(needLoadSceneId, true, false, true, true, true)
    end
    loadingDialog:AddSceneToLoad(needLoadSceneId)
    local toLoadSceneID = needLoadSceneId
    if needLoadSceneId == 30005 then
      toLoadSceneID = ((NekoData.BehaviorManager).BM_Dungeon):GetCurrentFloorId()
    end
    local sceneInfoRecord = cSceneInfoStatic:GetRecorder(toLoadSceneID)
    if sceneInfoRecord.loadType == 3 then
      (SceneManager.LoadScene)(toLoadSceneID, false, false, false, false, false)
      loadingDialog:AddSceneToLoad(toLoadSceneID)
      ;
      ((NekoData.BehaviorManager).BM_Dungeon):SaveAutoExploreBattleSceneId(toLoadSceneID)
    else
      local scenesToLoads = (SceneManager.GetNeedLoadScenes)(toLoadSceneID)
      if scenesToLoads ~= nil then
        local autoExploreBattleSceneId = 0
        for k,v in pairs(scenesToLoads) do
          (State.LoadScene)(v)
          autoExploreBattleSceneId = v
        end
        if #scenesToLoads == 1 then
          ((NekoData.BehaviorManager).BM_Dungeon):SaveAutoExploreBattleSceneId(autoExploreBattleSceneId)
        else
          ;
          ((NekoData.BehaviorManager).BM_Dungeon):SaveAutoExploreBattleSceneId(0)
        end
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
  -- function num : 0_4 , upvalues : State, _ENV
  if ((noitification.userInfo).loadProgressTable)[State.loadDungeonId] then
    GlobalGameFSM:SetNumber("sceneId", State.loadDungeonId)
  end
end

return State

