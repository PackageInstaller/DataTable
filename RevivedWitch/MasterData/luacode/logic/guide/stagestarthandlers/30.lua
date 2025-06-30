-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stagestarthandlers/30.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function()
  -- function num : 0_0 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("equip.bagdialog")
  if dialog and dialog._frame and (dialog._frame):GetCurrentIndex() == 4 then
    local cell = (dialog._frame):GetCellAtIndex(4)
    if cell and cell._cell and cell._roleClick then
      return cell._roleClick
    end
  end
end

return func

