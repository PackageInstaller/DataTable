-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stageconditionhandlers/16.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo, luaWindow)
  -- function num : 0_0 , upvalues : _ENV
  if luaWindow then
    local dialog = (DialogManager.GetDialog)("shop.shopmaindialog")
    if dialog and dialog._groupBtnFrame and #dialog._shopIDTypeList > 0 then
      local index = nil
      local params = conditionInfo.parm
      local groupBtnID = tonumber(params[1])
      for i,v in ipairs(dialog._shopIDTypeList) do
        if v == groupBtnID then
          index = i
          break
        end
      end
      do
        if index then
          local logicCell = (dialog._groupBtnFrame):GetLogicCell(index)
          if luaWindow ~= (logicCell._cell):GetChild("GroupBtn") then
            do
              do
                do return not logicCell or not logicCell._cell end
                do return false end
                do return false end
                -- DECOMPILER ERROR: 4 unprocessed JMP targets
              end
            end
          end
        end
      end
    end
  end
end

return func

