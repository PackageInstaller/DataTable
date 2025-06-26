-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stagestarthandlers/13.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(guideFrame)
  -- function num : 0_0 , upvalues : _ENV
  ((DialogManager.GetDialog)(guideFrame[1]))
  local dialog = nil
  local child = nil
  if dialog and dialog._rootWindow then
    child = dialog:GetChild(guideFrame[2])
    if child then
      return {parent = child._uiObject, 
effectPos = {posX = 0, posY = 0}
}
    end
  end
end

return func

