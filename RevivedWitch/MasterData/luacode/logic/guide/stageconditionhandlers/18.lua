-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stageconditionhandlers/18.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo, luaWindow)
  -- function num : 0_0 , upvalues : _ENV
  local params = conditionInfo.parm
  local tag = nil
  if luaWindow then
    local dialogName = params[1]
    local dialog = (DialogManager.GetDialog)(dialogName)
    if dialog then
      local child = dialog:GetChild(params[2])
      tag = not child or luaWindow == child
    end
  end
  if not tag then
    local dialog = (DialogManager.GetDialog)("mainline.mainline.mainlineworlddialog")
    if dialog and dialog._which == 7 and dialog._frame and dialog._data then
      local cell = (dialog._frame):GetLogicCell(1)
      if cell and cell._cell and (cell._cell)._frame and ((cell._cell)._data)[1] then
        local cell_cell = ((cell._cell)._frame):GetLogicCell(1)
        if cell_cell and cell_cell._cell then
          tag = true
        end
      end
    end
  end
  do return tag end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

return func

