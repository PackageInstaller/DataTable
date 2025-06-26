-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/guideeventhandlers/1.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local _1 = {}
local _dataTable = {}
_1.Play = function(guideID, stageID, eventInfo)
  -- function num : 0_0 , upvalues : _ENV, _dataTable
  local dialog = (DialogManager.GetDialog)((eventInfo.parm)[1])
  if dialog == nil then
    return 
  end
  local data = _dataTable[stageID]
  if data == nil then
    data = {isPlaying = false}
    _dataTable[stageID] = data
  else
    if data.isPlaying then
      return 
    end
  end
  data.effectHandler = dialog:PlayEffect((eventInfo.parm)[2], 1058)
  data.isPlaying = true
end

_1.Pause = function(guideID, stageID, eventInfo)
  -- function num : 0_1 , upvalues : _dataTable, _ENV
  local data = _dataTable[stageID]
  if data == nil then
    return 
  end
  if data.isPlaying then
    local dialog = (DialogManager.GetDialog)((eventInfo.parm)[1])
    if dialog == nil then
      return 
    end
    dialog:RemoveEffect((eventInfo.parm)[2], data.effectHandler)
    data.isPlaying = false
    data.effectHandler = nil
  end
end

_1.Finish = function(guideID, stageID, eventInfo)
  -- function num : 0_2 , upvalues : _1, _dataTable
  (_1.Pause)(guideID, stageID, eventInfo)
  _dataTable[stageID] = nil
end

return _1

