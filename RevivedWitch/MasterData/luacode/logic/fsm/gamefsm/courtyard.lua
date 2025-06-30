-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/gamefsm/courtyard.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
State.OnEnter = function(lastState)
  -- function num : 0_0 , upvalues : _ENV, State
  LogInfo("GameFSM", "CourtYard Enter")
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_TriggerGuide, State, nil)
  State.yardController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
  if State.yardController then
    (State.yardController):SetYardFSM()
  end
end

State.Update = function()
  -- function num : 0_1
end

State.OnExit = function(nextState)
  -- function num : 0_2 , upvalues : _ENV
  LogInfo("GameFSM", "CourtYard Exit")
  ;
  ((DialogManager.GetGroup)("Modal")):ReturnModalDialog()
  ;
  (DialogManager.DestroySingletonDialog)("courtyard.yardmaindialog")
end

return State

