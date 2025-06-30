-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stagestarthandlers/32.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(guideFrame)
  -- function num : 0_0 , upvalues : _ENV
  local child = nil
  local dialog = (DialogManager.GetDialog)("activity.giftoftime.giftoftimemaindialog")
  do
    if dialog and dialog._frame and (dialog._frame):GetCurrentIndex() == 2 then
      local cell = (dialog._frame):GetCellAtIndex(2)
      if cell then
        child = cell:GetChild("CharCell1")
      end
    end
    return child
  end
end

return func

