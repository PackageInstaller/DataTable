-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stagestarthandlers/27.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(guideFrame)
  -- function num : 0_0 , upvalues : _ENV
  if guideFrame[1] then
    local child = nil
    local dialog = (DialogManager.GetDialog)("mainline.mainline.mainlineworlddialog")
    if dialog and dialog._which == 6 and dialog._frame and dialog._data then
      local cell = (dialog._frame):GetLogicCell(1)
      if cell and cell._cell and (cell._cell)._helper and #(cell._cell)._data > 0 then
        local cell_cell = ((cell._cell)._helper):GetLogicCell(1)
        if cell_cell and cell_cell._cell then
          child = (cell_cell._cell):GetChild(guideFrame[1])
        end
      end
    end
    do
      do return child end
    end
  end
end

return func

