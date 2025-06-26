-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stagestarthandlers/9.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(guideFrame)
  -- function num : 0_0 , upvalues : _ENV
  local child = nil
  local dialog = (DialogManager.GetDialog)("task.taskmaindialog")
  do
    if dialog and dialog._helper and (dialog._helper):GetCurrentIndex() and (dialog._helper):GetCurrentIndex() == 1 then
      local tabCell = (dialog._helper):GetCellAtIndex(1)
      if tabCell then
        child = (tabCell._detail):GetChild("GetBtn/Guide")
      end
    end
    return child
  end
end

return func

