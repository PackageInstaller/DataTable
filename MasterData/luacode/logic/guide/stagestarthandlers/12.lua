-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stagestarthandlers/12.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(guideFrame)
  -- function num : 0_0 , upvalues : _ENV
  local child = nil
  local dialog = (DialogManager.GetDialog)("equipforge.equipforgedialog")
  if dialog and dialog._tab_frame and (dialog._tab_frame):GetCurrentIndex() and (dialog._tab_frame):GetCurrentIndex() == 1 then
    local index = 1
    local tabCell = (dialog._tab_frame):GetCellAtIndex(1)
    if tabCell then
      child = tabCell:GetChild("Frame/StartBtn")
    end
  end
  do
    return child
  end
end

return func

