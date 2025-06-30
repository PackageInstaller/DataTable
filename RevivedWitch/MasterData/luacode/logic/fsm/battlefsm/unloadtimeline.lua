-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/battlefsm/unloadtimeline.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local dialog = nil
local State = {}
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV
  LogInfo("BattleFSM", "UnLoadTimeline Enter")
  local dialogId = (controller._bsc_battleFSM):GetParameter("chatDialogId")
  local timelineObjectName = (controller._bsc_battleFSM):GetParameter("timelineObjectName")
  if controller.BSC_TimeLineEnd and dialogId == 0 then
    controller:BSC_TimeLineEnd(timelineObjectName)
  else
    ;
    ((NekoData.DataManager).DM_TimeScale):CancelTimelinePause()
    controller:BSC_UpdateAllLocalProtocol()
    controller:SetBattleTimelineTag(false)
  end
  ;
  (controller._bsc_battleFSM):SetNumber("chatDialogId", 0)
  ;
  (controller._bsc_battleFSM):SetString("timelineObjectName", "")
  ;
  (controller._bsc_battleFSM):SetBoolean("pasue", false)
end

State.Update = function(controller)
  -- function num : 0_1
end

State.OnExit = function(controller, nextState)
  -- function num : 0_2 , upvalues : _ENV
  LogInfo("BattleFSM", "UnLoadTimeline Exit")
  ;
  (controller._bsc_battleFSM):SetBoolean("toUnloadTimeline", false)
  ;
  (controller._bsc_battleFSM):SetBoolean("chatDialogEnd", false)
end

return State

