local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local UIManager = CS.PixelNeko.UI.UIManager

local function func(guideFrame)
  local dialog = DialogManager.GetDialog(guideFrame[1])
  if dialog and dialog._which == 1 and dialog._frame then
    local cell = dialog._frame:GetLogicCell(dialog._which)
    if cell and cell._cell then
      local cellIndex, index
      for i, v in ipairs(cell._cell._data) do
        for j, data in ipairs(v) do
          if not data.lock and not (data.unlockLv > NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userlevel) then
            cellIndex = i
            index = data.selecttype
          end
        end
      end
      if cellIndex and index then
        local cell_cell = cell._cell._frame:GetLogicCell(cellIndex)
        if cell_cell and cell_cell._cell then
          return {
            parent = cell_cell._cell._unlockImg[index]._uiObject,
            effectPos = {posX = 0, posY = 0}
          }
        end
      end
    end
  end
end

return func
