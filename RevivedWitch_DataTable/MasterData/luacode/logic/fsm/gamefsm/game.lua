-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/gamefsm/game.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
State.OnEnter = function(lastState)
  -- function num : 0_0 , upvalues : _ENV
  LogInfo("GameFSM", "Game Enter")
  if not (DialogManager.GetDialog)("clickeffect.clickeffectdialog") then
    (DialogManager.CreateSingletonDialog)("clickeffect.clickeffectdialog")
  end
  ;
  (DialogManager.DestroySingletonDialog)("login.logindialog")
  ;
  (DialogManager.DestroySingletonDialog)("login.soundlogindialog")
  ;
  (DialogManager.DestroySingletonDialog)("login.loginmaindialog")
  ;
  (DialogManager.DestroySingletonDialog)("login.sdklogindialog")
  ;
  (DialogManager.DestroySingletonDialog)("login.reconnectdialog")
  ;
  (DialogManager.DestroySingletonDialog)("login.loginqueuedialog")
  ;
  (DialogManager.DestroySingletonDialog)("login.loginwaitdialog")
  ;
  ((NekoData.BehaviorManager).BM_Login):SetLoginFailTimes(0)
  ;
  ((NekoData.BehaviorManager).BM_Game):StartSpeedTask()
end

State.Update = function()
  -- function num : 0_1
end

State.OnExit = function(nextState)
  -- function num : 0_2 , upvalues : _ENV
  LogInfo("GameFSM", "Game Exit")
  if nextState ~= "BreakOrReconnect" then
    (DialogManager.DestroySingletonDialog)("maindialog")
  end
end

return State

