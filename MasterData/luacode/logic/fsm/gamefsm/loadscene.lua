local State = {}

function State.OnEnter(lastState)
  LogInfo("GameFSM", "LoadScene Enter")
  LuaNotificationCenter.AddObserver(State, State.OnLoadingStartAnimationEnd, Common.n_LoadingStartAnimationEnd, nil)
  if GlobalGameFSM:GetParameter("sceneLoadingId") == 30001 and GlobalGameFSM:GetParameter("sceneId") ~= 30002 then
    State.SetAccountEnd()
  else
    local loadingDialog = DialogManager.GetDialog("loadingdialog")
    if loadingDialog == nil then
      loadingDialog = DialogManager.CreateSingletonDialog("loadingdialog")
    elseif loadingDialog:IsDestroying() then
      DialogManager.DestroySingletonDialog("loadingdialog")
      loadingDialog = DialogManager.CreateSingletonDialog("loadingdialog")
    end
    loadingDialog:ShowTips(GlobalGameFSM:GetParameter("sceneLoadingId"))
  end
end

function State.Update()
end

function State.OnExit(nextState)
  LogInfo("GameFSM", "LoadScene Exit" .. tostring(os.clock()))
  LuaNotificationCenter.RemoveObserver(State)
  GlobalGameFSM:SetBoolean("loadSceneEnd", false)
  DialogManager.DestroySingletonDialog("battle.battleaccount.battlelosedialog")
  DialogManager.DestroySingletonDialog("battle.battleaccount.battlelose1186dialog")
  DialogManager.DestroySingletonDialog("dungeon.dungeondeathwhitescreen")
  DialogManager.DestroySingletonDialog("activity.activitylistdialog")
end

function State.SetAccountEnd()
  local tip = NekoData.BehaviorManager.BM_Game:GetTip()
  LogInfoFormat("LoadScene", "------- tip = %s -----------", tip)
  if tip ~= 0 and tip ~= 1 and tip ~= 4 then
    local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
    if controller and controller:GetSceneID() ~= 30005 and controller:GetSceneID() ~= 30009 then
      if controller:GetSceneID() // 10000 == 4 then
        local loadingDialog = DialogManager.GetDialog("loadingdialog")
        if loadingDialog == nil then
          loadingDialog = DialogManager.CreateSingletonDialog("loadingdialog")
        elseif loadingDialog:IsDestroying() then
          DialogManager.DestroySingletonDialog("loadingdialog")
          loadingDialog = DialogManager.CreateSingletonDialog("loadingdialog")
        end
        loadingDialog:ShowTips(GlobalGameFSM:GetParameter("sceneLoadingId"))
      else
        EffectFactory.CreateFreezeEffect():Run()
        local time = tonumber(BeanManager.GetTableByName("var.cvarconfig"):GetRecorder(9).Value)
        
        local function task()
          local loadingDialog = DialogManager.GetDialog("loadingdialog")
          if loadingDialog == nil then
            loadingDialog = DialogManager.CreateSingletonDialog("loadingdialog")
          elseif loadingDialog:IsDestroying() then
            DialogManager.DestroySingletonDialog("loadingdialog")
            loadingDialog = DialogManager.CreateSingletonDialog("loadingdialog")
          end
          loadingDialog:ShowTips(GlobalGameFSM:GetParameter("sceneLoadingId"))
          EffectFactory.CreateThawEffect():Run()
        end
        
        if tip ~= 5 and tip ~= 6 then
          GameTimer.AddTask(time, 0, task)
          EffectFactory.CreateVisualEffect("[actor]/Sence_TX_Prefab_huicheng", true):Run()
          EffectFactory.CreateAnimationEffect("[actor]", "Dissolve"):Run()
        else
          task()
        end
      end
    else
      local loadingDialog = DialogManager.GetDialog("loadingdialog")
      if loadingDialog == nil then
        loadingDialog = DialogManager.CreateSingletonDialog("loadingdialog")
      elseif loadingDialog:IsDestroying() then
        DialogManager.DestroySingletonDialog("loadingdialog")
        loadingDialog = DialogManager.CreateSingletonDialog("loadingdialog")
      end
      loadingDialog:ShowTips(GlobalGameFSM:GetParameter("sceneLoadingId"))
    end
  else
    local loadingDialog = DialogManager.GetDialog("loadingdialog")
    if loadingDialog == nil then
      loadingDialog = DialogManager.CreateSingletonDialog("loadingdialog")
    elseif loadingDialog:IsDestroying() then
      DialogManager.DestroySingletonDialog("loadingdialog")
      loadingDialog = DialogManager.CreateSingletonDialog("loadingdialog")
    end
    loadingDialog:ShowTips(GlobalGameFSM:GetParameter("sceneLoadingId"))
  end
end

function State.OnLoadingStartAnimationEnd()
  GlobalGameFSM:SetBoolean("loadSceneEnd", true)
end

return State
