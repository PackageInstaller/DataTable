local dialog
local State = {}
local TimeLineType = {WithStoryLoaing = 1, OnlyStory = 3}

function State.OnEnter(controller, lastState)
  LogInfo("BattleFSM", "LoadTimeline Enter")
  local dialogId = controller._bsc_battleFSM:GetParameter("chatDialogId")
  local pauseType = controller._bsc_battleFSM:GetParameter("pauseType")
  if dialogId == 10002 then
    NekoData.DataManager.DM_TimeScale:SetTimelinePause()
    controller._bsc_battleFSM:SetBoolean("toUnloadTimeline", true)
    controller._bsc_battleFSM:SetBoolean("toTimeline", true)
  elseif pauseType == TimeLineType.OnlyStory then
    local timelineObjectName = controller._bsc_battleFSM:GetParameter("timelineObjectName")
    if controller.BSC_TimeLineStart and dialogId == 0 then
      controller._bsc_battleFSM:SetBoolean("chatDialogEnd", true)
      controller:BSC_TimeLineStart(timelineObjectName)
    else
      NekoData.DataManager.DM_TimeScale:SetTimelinePause()
      controller._bsc_battleFSM:SetBoolean("toUnloadTimeline", true)
    end
    controller._bsc_battleFSM:SetBoolean("toTimeline", true)
  else
    dialog = DialogManager.CreateSingletonDialog("storyloadingdialog")
    if dialog then
      dialog:SetUnScaleTime()
    end
  end
end

function State.Update(controller)
  if dialog and dialog:IsCover() then
    local dialogId = controller._bsc_battleFSM:GetParameter("chatDialogId")
    local timelineObjectName = controller._bsc_battleFSM:GetParameter("timelineObjectName")
    if controller.BSC_TimeLineStart and dialogId == 0 then
      controller._bsc_battleFSM:SetBoolean("chatDialogEnd", true)
      controller:BSC_TimeLineStart(timelineObjectName)
    else
      NekoData.DataManager.DM_TimeScale:SetTimelinePause()
      controller._bsc_battleFSM:SetBoolean("toUnloadTimeline", true)
    end
    controller._bsc_battleFSM:SetBoolean("toTimeline", true)
  end
end

function State.OnExit(controller, nextState)
  LogInfo("BattleFSM", "LoadTimeline Exit")
  controller._bsc_battleFSM:SetBoolean("toTimeline", false)
  if dialog then
    dialog = DialogManager.CreateSingletonDialog("storyloadingdialog")
    if dialog then
      dialog:SetUnScaleTime()
    end
  end
end

return State
