-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/gamefsm/login.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
State.OnEnter = function(lastState)
  -- function num : 0_0 , upvalues : _ENV, State
  LogInfo("GameFSM", "Login Enter")
  GlobalGameFSM:SetBoolean("toGame", false)
  State.value = GlobalGameFSM:GetParameter("toLogin")
  if lastState ~= "PlayPV" and State.value ~= "ReconnectionFromLoginState" and State.value ~= "DisconnectionFromLoginState" then
    GlobalGameFSM:SetString("toLogin", "")
    GlobalGameFSM:SetBoolean("loadSceneEnd", false)
    GlobalGameFSM:SetNumber("sceneLoadingId", 0)
    GlobalGameFSM:SetNumber("sceneId", 0)
    GlobalGameFSM:SetNumber("battleId", 0)
    GlobalGameFSM:SetBoolean("battleLoadingEnd", false)
    GlobalGameFSM:SetBoolean("crossingEnd", false)
    GlobalGameFSM:SetBoolean("toBreakOrReconnect", false)
    ;
    (DialogManager.Clear)()
    ;
    (NekoData.ClearAll)()
    ;
    (EventManager.Clear)()
    ;
    (GameTimer.RemoveAllTask)()
    ;
    (ServerGameTimer.RemoveAllTask)()
    ;
    (GameScene.LoadInGame)()
    ;
    (UIBackManager.Clear)()
  else
    ;
    (DialogManager.Clear)()
    ;
    (UIBackManager.Clear)()
    if State.value == "ReconnectionFromLoginState" or State.value == "DisconnectionFromLoginState" then
      ((NekoData.BehaviorManager).BM_Login):SetLoginFailTimes(((NekoData.BehaviorManager).BM_Login):GetLoginFailTimes() + 1)
    end
  end
  ;
  ((DialogManager.GetGroup)("Guide")):SetObjectActive(true)
  if State.value == "Reconnection" then
    (DialogManager.CreateSingletonDialog)("login.reconnectdialog")
  else
    if lastState == "PlayPV" or State.value == "Disconnection" then
      (SdkManager.OpenLoginDialog)()
      ;
      (NoticeManager.RequestLoginNotice)()
      if global_var_showFrameRate then
        (DialogManager.CreateSingletonDialog)("debug.frameratedialog")
      end
    else
      if State.value == "ReconnectionFromLoginState" or State.value == "DisconnectionFromLoginState" then
        (SdkManager.OpenLoginDialog)()
        if global_var_showFrameRate then
          (DialogManager.CreateSingletonDialog)("debug.frameratedialog")
        end
      end
    end
  end
  ;
  (DialogManager.CreateSingletonDialog)("clickeffect.clickeffectdialog")
  ;
  (LuaAudioManager.PlayBGM)(1)
  ;
  ((NekoData.BehaviorManager).BM_Game):SetVolume()
end

State.Update = function()
  -- function num : 0_1
end

State.OnExit = function(nextState)
  -- function num : 0_2 , upvalues : _ENV
  LogInfo("GameFSM", "Login Exit")
end

return State

