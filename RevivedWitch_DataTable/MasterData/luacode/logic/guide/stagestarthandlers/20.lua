-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stagestarthandlers/20.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(guideFrame)
  -- function num : 0_0 , upvalues : _ENV
  local child = nil
  local dialog = (DialogManager.GetDialog)("handbook.favour.givegiftdialog")
  if dialog and dialog._itemFrame and dialog._selectItem then
    local index = 1
    local logicCell = (dialog._itemFrame):GetLogicCell(index)
    if logicCell and logicCell._cell then
      child = (logicCell._cell):GetRootWindow()
    end
    if child then
      (dialog._itemFrame):SetSlide(false)
    end
  end
  do
    return child
  end
end

return func

