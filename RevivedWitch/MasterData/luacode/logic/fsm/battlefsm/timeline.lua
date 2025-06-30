-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/battlefsm/timeline.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV
  LogInfo("BattleFSM", "TimeLine Enter")
  local dialogId = (controller._bsc_battleFSM):GetParameter("chatDialogId")
  if dialogId ~= 0 then
    ((DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")):SetDialogLibraryId(dialogId)
  else
    ;
    (controller._bsc_battleFSM):SetBoolean("chatDialogEnd", true)
  end
end

State.Update = function(controller, deltaTime)
  -- function num : 0_1
end

State.OnExit = function(controller, nextState)
  -- function num : 0_2 , upvalues : _ENV
  LogInfo("BattleFSM", "TimeLine Exit")
end

return State

