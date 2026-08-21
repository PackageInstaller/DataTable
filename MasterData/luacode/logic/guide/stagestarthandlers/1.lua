-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stagestarthandlers/1.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(guideFrame)
  -- function num : 0_0 , upvalues : _ENV
  if guideFrame[1] then
    if guideFrame[1] ~= "0" then
      local child = nil
      local dialog = (DialogManager.GetDialog)(guideFrame[1])
      if dialog and dialog._rootWindow then
        if guideFrame[2] then
          child = dialog:GetChild(guideFrame[2])
        else
          return dialog._rootWindow
        end
      end
      return child
    else
      do
        do return guideFrame[1] end
      end
    end
  end
end

return func

