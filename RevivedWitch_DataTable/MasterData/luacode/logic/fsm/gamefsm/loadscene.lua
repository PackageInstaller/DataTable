-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/gamefsm/loadscene.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
State.OnEnter = function(lastState)
  -- function num : 0_0 , upvalues : _ENV, State
  LogInfo("GameFSM", "LoadScene Enter")
  ;
  (LuaNotificationCenter.AddObserver)(State, State.OnLoadingStartAnimationEnd, Common.n_LoadingStartAnimationEnd, nil)
  if GlobalGameFSM:GetParameter("sceneLoadingId") == 30001 and GlobalGameFSM:GetParameter("sceneId") ~= 30002 then
    (State.SetAccountEnd)()
  else
    local loadingDialog = (DialogManager.GetDialog)("loadingdialog")
    if loadingDialog == nil then
      loadingDialog = (DialogManager.CreateSingletonDialog)("loadingdialog")
    else
      if loadingDialog:IsDestroying() then
        (DialogManager.DestroySingletonDialog)("loadingdialog")
        loadingDialog = (DialogManager.CreateSingletonDialog)("loadingdialog")
      end
    end
    loadingDialog:ShowTips(GlobalGameFSM:GetParameter("sceneLoadingId"))
  end
end

State.Update = function()
  -- function num : 0_1
end

State.OnExit = function(nextState)
  -- function num : 0_2 , upvalues : _ENV, State
  LogInfo("GameFSM", "LoadScene Exit" .. tostring((os.clock)()))
  ;
  (LuaNotificationCenter.RemoveObserver)(State)
  GlobalGameFSM:SetBoolean("loadSceneEnd", false)
  ;
  (DialogManager.DestroySingletonDialog)("battle.battleaccount.battlelosedialog")
  ;
  (DialogManager.DestroySingletonDialog)("battle.battleaccount.battlelose1186dialog")
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.dungeondeathwhitescreen")
end

State.SetAccountEnd = function()
  -- function num : 0_3 , upvalues : _ENV
  local tip = ((NekoData.BehaviorManager).BM_Game):GetTip()
  LogInfoFormat("LoadScene", "------- tip = %s -----------", tip)
  if tip ~= 0 and tip ~= 1 and tip ~= 4 then
    local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
    if controller and controller:GetSceneID() ~= 30005 and controller:GetSceneID() ~= 30009 then
      if controller:GetSceneID() // 10000 == 4 then
        local loadingDialog = (DialogManager.GetDialog)("loadingdialog")
        if loadingDialog == nil then
          loadingDialog = (DialogManager.CreateSingletonDialog)("loadingdialog")
        else
          if loadingDialog:IsDestroying() then
            (DialogManager.DestroySingletonDialog)("loadingdialog")
            loadingDialog = (DialogManager.CreateSingletonDialog)("loadingdialog")
          end
        end
        loadingDialog:ShowTips(GlobalGameFSM:GetParameter("sceneLoadingId"))
      else
        do
          ;
          ((EffectFactory.CreateFreezeEffect)()):Run()
          local time = tonumber((((BeanManager.GetTableByName)("var.cvarconfig")):GetRecorder(9)).Value)
          do
            local task = function()
    -- function num : 0_3_0 , upvalues : _ENV
    local loadingDialog = (DialogManager.GetDialog)("loadingdialog")
    if loadingDialog == nil then
      loadingDialog = (DialogManager.CreateSingletonDialog)("loadingdialog")
    else
      if loadingDialog:IsDestroying() then
        (DialogManager.DestroySingletonDialog)("loadingdialog")
        loadingDialog = (DialogManager.CreateSingletonDialog)("loadingdialog")
      end
    end
    loadingDialog:ShowTips(GlobalGameFSM:GetParameter("sceneLoadingId"))
    ;
    ((EffectFactory.CreateThawEffect)()):Run()
  end

            if tip ~= 5 and tip ~= 6 then
              (GameTimer.AddTask)(time, 0, task)
              ;
              ((EffectFactory.CreateVisualEffect)("[actor]/Sence_TX_Prefab_huicheng", true)):Run()
              ;
              ((EffectFactory.CreateAnimationEffect)("[actor]", "Dissolve")):Run()
            else
              task()
            end
            do
              local loadingDialog = (DialogManager.GetDialog)("loadingdialog")
              if loadingDialog == nil then
                loadingDialog = (DialogManager.CreateSingletonDialog)("loadingdialog")
              else
                if loadingDialog:IsDestroying() then
                  (DialogManager.DestroySingletonDialog)("loadingdialog")
                  loadingDialog = (DialogManager.CreateSingletonDialog)("loadingdialog")
                end
              end
              loadingDialog:ShowTips(GlobalGameFSM:GetParameter("sceneLoadingId"))
              local loadingDialog = (DialogManager.GetDialog)("loadingdialog")
              if loadingDialog == nil then
                loadingDialog = (DialogManager.CreateSingletonDialog)("loadingdialog")
              else
                if loadingDialog:IsDestroying() then
                  (DialogManager.DestroySingletonDialog)("loadingdialog")
                  loadingDialog = (DialogManager.CreateSingletonDialog)("loadingdialog")
                end
              end
              loadingDialog:ShowTips(GlobalGameFSM:GetParameter("sceneLoadingId"))
            end
          end
        end
      end
    end
  end
end

State.OnLoadingStartAnimationEnd = function()
  -- function num : 0_4 , upvalues : _ENV
  GlobalGameFSM:SetBoolean("loadSceneEnd", true)
end

return State

