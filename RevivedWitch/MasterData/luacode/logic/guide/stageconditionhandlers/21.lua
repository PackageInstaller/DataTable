-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stageconditionhandlers/21.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo, luaWindow)
  -- function num : 0_0 , upvalues : _ENV
  if luaWindow then
    local dialog = (DialogManager.GetDialog)("activity.giftoftime.giftoftimemaindialog")
    if dialog then
      local index = 2
      if index then
        local cell = (dialog._frame):GetCellAtIndex(index)
        if cell and cell then
          local window = cell:GetChild("CharCell1")
          local tag = luaWindow == window
          if tag then
            return true
          else
            return false
          end
        else
          return false
        end
      else
        return false
      end
    else
      return false
    end
  else
    return false
  end
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

return func

