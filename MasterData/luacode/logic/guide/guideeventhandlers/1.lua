local _1 = {}
local _dataTable = {}

function _1.Play(guideID, stageID, eventInfo)
  local dialog = DialogManager.GetDialog(eventInfo.parm[1])
  if dialog == nil then
    return
  end
  local data = _dataTable[stageID]
  if data == nil then
    data = {isPlaying = false}
    _dataTable[stageID] = data
  elseif data.isPlaying then
    return
  end
  data.effectHandler = dialog:PlayEffect(eventInfo.parm[2], 1058)
  data.isPlaying = true
end

function _1.Pause(guideID, stageID, eventInfo)
  local data = _dataTable[stageID]
  if data == nil then
    return
  end
  if data.isPlaying then
    local dialog = DialogManager.GetDialog(eventInfo.parm[1])
    if dialog == nil then
      return
    end
    dialog:RemoveEffect(eventInfo.parm[2], data.effectHandler)
    data.isPlaying = false
    data.effectHandler = nil
  end
end

function _1.Finish(guideID, stageID, eventInfo)
  _1.Pause(guideID, stageID, eventInfo)
  _dataTable[stageID] = nil
end

return _1
