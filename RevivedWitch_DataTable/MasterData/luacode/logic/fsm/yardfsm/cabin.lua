-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/yardfsm/cabin.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV, State
  LogInfo("YardFSM", "Cabin Enter")
  local sceneId = (controller._yardFSM):GetParameter("sceneId")
  State.cabinController = (SceneManager.GetSceneControllerByID)(sceneId)
  ;
  (State.cabinController):SetRootGameObjectActive(true)
  ;
  (State.cabinController):EnterCabin()
  local dialog = (DialogManager.CreateSingletonDialog)("courtcabin.interactmodaldialog")
  dialog:Init(State.cabinController)
  ;
  (State.cabinController):SetInteractDialog(dialog)
  ;
  ((DialogManager.CreateSingletonDialog)("courtcabin.cabinmaindialog")):Init(State.cabinController)
  State.ThemeFurniture = {sortId = 2, rise = false}
  State.NormalFurniture = {sortId = 1, rise = false}
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_TriggerGuide, State, nil)
end

State.Update = function()
  -- function num : 0_1
end

State.OnExit = function(controller, nextState)
  -- function num : 0_2 , upvalues : _ENV, State
  LogInfo("YardFSM", "Cabin Exit")
  ;
  (State.cabinController):SetInteractDialog(nil)
  ;
  (DialogManager.DestroySingletonDialog)("courtcabin.cabinmaindialog")
  ;
  (DialogManager.DestroySingletonDialog)("courtcabin.interactmodaldialog")
  ;
  (State.cabinController):SetRootGameObjectActive(false)
end

return State

