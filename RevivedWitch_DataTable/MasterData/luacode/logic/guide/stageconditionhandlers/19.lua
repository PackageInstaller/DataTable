-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stageconditionhandlers/19.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo, luaWindow)
  -- function num : 0_0 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("mainline.mainline.mainlineworlddialog")
  if dialog and dialog._which == 6 and dialog._frame and dialog._data then
    local cell = (dialog._frame):GetLogicCell(1)
    if cell and cell._cell and (cell._cell)._frame and ((cell._cell)._data)[1] then
      return true
    else
      return false
    end
  else
    do
      do return false end
    end
  end
end

return func

