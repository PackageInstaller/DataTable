local dialog
local State = {}

function State.OnEnter(controller, lastState)
  LogInfo("BattleFSM", "UnLoadTimeline Enter")
  local dialogId = controller._bsc_battleFSM:GetParameter("chatDialogId")
  local timelineObjectName = controller._bsc_battleFSM:GetParameter("timelineObjectName")
  if controller.BSC_TimeLineEnd and dialogId == 0 then
    controller:BSC_TimeLineEnd(timelineObjectName)
  else
    NekoData.DataManager.DM_TimeScale:CancelTimelinePause()
    controller:BSC_UpdateAllLocalProtocol()
    controller:SetBattleTimelineTag(false)
  end
  controller._bsc_battleFSM:SetNumber("chatDialogId", 0)
  controller._bsc_battleFSM:SetString("timelineObjectName", "")
  controller._bsc_battleFSM:SetBoolean("pasue", false)
end

function State.Update(controller)
end

function State.OnExit(controller, nextState)
  LogInfo("BattleFSM", "UnLoadTimeline Exit")
  controller._bsc_battleFSM:SetBoolean("toUnloadTimeline", false)
  controller._bsc_battleFSM:SetBoolean("chatDialogEnd", false)
end

return State
