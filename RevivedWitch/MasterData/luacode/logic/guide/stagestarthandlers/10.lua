-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stagestarthandlers/10.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(guideFrame)
  -- function num : 0_0 , upvalues : _ENV
  ((DialogManager.GetDialog)(guideFrame[1]))
  local dialog = nil
  local child = nil
  if dialog and dialog._rootWindow then
    child = dialog:GetChild(guideFrame[2])
  end
  return child
end

return func

