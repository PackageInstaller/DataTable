-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stagestarthandlers/24.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(guideFrame)
  -- function num : 0_0 , upvalues : _ENV
  if #guideFrame == 3 then
    local dialog = (DialogManager.GetDialog)(guideFrame[1])
    if dialog and dialog._rootWindow and dialog:GetCurMessageId() == tonumber(guideFrame[3]) then
      return dialog:GetChild(guideFrame[2])
    end
  end
end

return func

