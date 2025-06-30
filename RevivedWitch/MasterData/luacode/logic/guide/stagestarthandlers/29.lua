-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stagestarthandlers/29.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(guideFrame)
  -- function num : 0_0 , upvalues : _ENV
  local params = guideFrame
  local child = nil
  if #params > 0 then
    local dialog = (DialogManager.GetDialog)("signboard.signboardmaindialog")
    if dialog and dialog.roleListFrame and tonumber(params[1]) <= #dialog._listByConditions then
      local index = tonumber(params[1])
      local logicCell = (dialog.roleListFrame):GetLogicCell(index)
      if logicCell and logicCell._cell then
        child = (logicCell._cell):GetRootWindow()
      end
      if child then
        (dialog.roleListFrame):SetSlide(false)
      end
    end
  end
  do
    return child
  end
end

return func

