-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stageconditionhandlers/12.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo, luaWindow)
  -- function num : 0_0 , upvalues : _ENV
  if luaWindow then
    local dialog = (DialogManager.GetDialog)("handbook.roledetailinfodialog")
    if dialog and dialog._pageHelper then
      local index = (dialog._pageHelper):GetCurrentIndex()
      if index and index == 2 then
        local tabCell = (dialog._pageHelper):GetCellAtIndex(2)
        return luaWindow == tabCell:GetChild("Panel/GiftBtn")
      end
    else
      return false
    end
  else
    return false
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

return func

