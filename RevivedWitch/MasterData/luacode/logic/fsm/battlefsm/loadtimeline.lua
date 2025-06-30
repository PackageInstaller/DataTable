-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/battlefsm/loadtimeline.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local dialog = nil
local State = {}
local TimeLineType = {WithStoryLoaing = 1, OnlyStory = 3}
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV, TimeLineType, dialog
  LogInfo("BattleFSM", "LoadTimeline Enter")
  local dialogId = (controller._bsc_battleFSM):GetParameter("chatDialogId")
  local pauseType = (controller._bsc_battleFSM):GetParameter("pauseType")
  if dialogId == 10002 then
    ((NekoData.DataManager).DM_TimeScale):SetTimelinePause()
    ;
    (controller._bsc_battleFSM):SetBoolean("toUnloadTimeline", true)
    ;
    (controller._bsc_battleFSM):SetBoolean("toTimeline", true)
  else
    if pauseType == TimeLineType.OnlyStory then
      local timelineObjectName = (controller._bsc_battleFSM):GetParameter("timelineObjectName")
      if controller.BSC_TimeLineStart and dialogId == 0 then
        (controller._bsc_battleFSM):SetBoolean("chatDialogEnd", true)
        controller:BSC_TimeLineStart(timelineObjectName)
      else
        ;
        ((NekoData.DataManager).DM_TimeScale):SetTimelinePause()
        ;
        (controller._bsc_battleFSM):SetBoolean("toUnloadTimeline", true)
      end
      ;
      (controller._bsc_battleFSM):SetBoolean("toTimeline", true)
    else
      do
        dialog = (DialogManager.CreateSingletonDialog)("storyloadingdialog")
        if dialog then
          dialog:SetUnScaleTime()
        end
      end
    end
  end
end

State.Update = function(controller)
  -- function num : 0_1 , upvalues : dialog, _ENV
  if dialog and dialog:IsCover() then
    local dialogId = (controller._bsc_battleFSM):GetParameter("chatDialogId")
    local timelineObjectName = (controller._bsc_battleFSM):GetParameter("timelineObjectName")
    if controller.BSC_TimeLineStart and dialogId == 0 then
      (controller._bsc_battleFSM):SetBoolean("chatDialogEnd", true)
      controller:BSC_TimeLineStart(timelineObjectName)
    else
      ;
      ((NekoData.DataManager).DM_TimeScale):SetTimelinePause()
      ;
      (controller._bsc_battleFSM):SetBoolean("toUnloadTimeline", true)
    end
    ;
    (controller._bsc_battleFSM):SetBoolean("toTimeline", true)
  end
end

State.OnExit = function(controller, nextState)
  -- function num : 0_2 , upvalues : _ENV, dialog
  LogInfo("BattleFSM", "LoadTimeline Exit")
  ;
  (controller._bsc_battleFSM):SetBoolean("toTimeline", false)
  if dialog then
    dialog = (DialogManager.CreateSingletonDialog)("storyloadingdialog")
    if dialog then
      dialog:SetUnScaleTime()
    end
  end
end

return State

