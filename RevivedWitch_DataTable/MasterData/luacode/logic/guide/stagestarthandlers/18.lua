-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stagestarthandlers/18.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(guideFrame)
  -- function num : 0_0 , upvalues : _ENV
  local child = nil
  local dialog = (DialogManager.GetDialog)("assistbattle.choosesupportroledialog")
  if dialog and dialog._frame and #dialog._listByConditions > 0 then
    local index = 1
    local logicCell = (dialog._frame):GetLogicCell(index)
    if logicCell and logicCell._cell then
      child = (logicCell._cell):GetRootWindow()
    end
    if child then
      (dialog._frame):SetSlide(false)
    end
  end
  do
    return child
  end
end

return func

