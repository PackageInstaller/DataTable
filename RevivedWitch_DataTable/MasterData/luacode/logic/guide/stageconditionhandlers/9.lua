-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stageconditionhandlers/9.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo, luaWindow)
  -- function num : 0_0 , upvalues : _ENV
  if luaWindow then
    local dialog = (DialogManager.GetDialog)("equipforge.equipforgedialog")
    if dialog and dialog._tab and dialog._tab == 1 and #dialog._forgeIetmData > 0 then
      local index = 1
      local data = (dialog._forgeIetmData)[index]
      if data then
        local logicCell = (dialog._item_frame):GetLogicCell(index)
        if luaWindow ~= (logicCell._cell):GetRootWindow() then
          do
            do
              do
                do
                  local tag = not logicCell or not logicCell._cell
                  if tag then
                    (dialog._item_frame):SetSlide(true)
                    return true
                  else
                    return false
                  end
                  do return false end
                  do return false end
                  do return false end
                  do return false end
                  -- DECOMPILER ERROR: 7 unprocessed JMP targets
                end
              end
            end
          end
        end
      end
    end
  end
end

return func

