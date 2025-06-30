-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/guideeventhandlers/2.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local _2 = {}
_2.Play = function(guideID, stageID, eventInfo)
  -- function num : 0_0 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)((eventInfo.parm)[1])
  if dialog == nil then
    return 
  end
end

_2.Pause = function(guideID, stageID, eventInfo)
  -- function num : 0_1
end

_2.Finish = function(guideID, stageID, eventInfo)
  -- function num : 0_2 , upvalues : _ENV
  LogError("Guide", "finish")
end

return _2

