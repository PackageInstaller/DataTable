-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/yardfsm/traincamp.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV, State
  LogInfo("YardFSM", "TrainCamp Enter")
  local sceneId = (controller._yardFSM):GetParameter("sceneId")
  State.trainCampController = (SceneManager.GetSceneControllerByID)(sceneId)
  ;
  (State.trainCampController):SetRootGameObjectActive(true)
  local dialog = (DialogManager.CreateSingletonDialog)("traincamp.interactmodaldialog")
  dialog:Init(State.trainCampController)
  ;
  (State.trainCampController):SetInteractDialog(dialog)
  ;
  (State.trainCampController):EnterTrainCamp()
  ;
  (DialogManager.CreateSingletonDialog)("traincamp.traincampmaindialog")
end

State.Update = function()
  -- function num : 0_1
end

State.OnExit = function(controller, nextState)
  -- function num : 0_2 , upvalues : _ENV, State
  LogInfo("YardFSM", "TrainCamp Exit")
  ;
  (State.trainCampController):SetInteractDialog(nil)
  ;
  (DialogManager.DestroySingletonDialog)("traincamp.traincampmaindialog")
  ;
  (DialogManager.DestroySingletonDialog)("traincamp.interactmodaldialog")
  ;
  (State.trainCampController):ExitTrainCamp()
  ;
  (State.trainCampController):SetRootGameObjectActive(false)
end

return State

