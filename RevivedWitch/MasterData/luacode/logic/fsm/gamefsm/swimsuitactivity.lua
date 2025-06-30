-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/gamefsm/swimsuitactivity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
State.OnEnter = function(lastState)
  -- function num : 0_0 , upvalues : _ENV
  LogInfo("GameFSM", "SwimSuitActivity Enter")
  ;
  (DialogManager.DestroySingletonDialog)("base.hidemaincitymodaldialog")
  ;
  (DialogManager.DestroySingletonDialog)("loadingdialog")
  if ((NekoData.BehaviorManager).BM_Game):GetAutoExploreWithoutBackAwards() then
    (DialogManager.CreateSingletonDialog)("activity.swimsuit.swimsuitaccountdialog")
  end
end

State.Update = function()
  -- function num : 0_1
end

State.OnExit = function(nextState)
  -- function num : 0_2 , upvalues : _ENV
  LogInfo("GameFSM", "SwimSuitActivity Exit")
end

return State

