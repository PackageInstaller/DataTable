local _2 = {}

function _2.Play(guideID, stageID, eventInfo)
  local dialog = DialogManager.GetDialog(eventInfo.parm[1])
  if dialog == nil then
    return
  end
end

function _2.Pause(guideID, stageID, eventInfo)
end

function _2.Finish(guideID, stageID, eventInfo)
  LogError("Guide", "finish")
end

return _2
