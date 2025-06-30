-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stagestarthandlers/17.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(guideFrame)
  -- function num : 0_0 , upvalues : _ENV
  local child = nil
  local dialog = (DialogManager.GetDialog)("friend.friendsmaindialog")
  do
    if dialog and dialog._pageHelper and (dialog._pageHelper):GetCurrentIndex() == 4 then
      local tabCell = (dialog._pageHelper):GetCellAtIndex(4)
      if tabCell then
        child = tabCell:GetChild("UI/Left/ChangeBtn")
      end
    end
    return child
  end
end

return func

