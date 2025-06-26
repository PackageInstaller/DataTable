-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stageconditionhandlers/3.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo, luaWindow)
  -- function num : 0_0 , upvalues : _ENV
  local params = conditionInfo.parm
  if luaWindow and #params > 0 then
    local dialog = (DialogManager.GetDialog)("signboard.signboardmaindialog")
    if dialog then
      local index = tonumber(params[1])
      local logicCell = (dialog.roleListFrame):GetLogicCell(index)
      if logicCell and logicCell._cell then
        local window = (logicCell._cell):GetChild("Cell/Frame")
        local tag = luaWindow == window
        if tag then
          (dialog.roleListFrame):SetSlide(true)
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
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

return func

