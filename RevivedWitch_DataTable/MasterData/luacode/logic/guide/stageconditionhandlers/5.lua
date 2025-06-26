-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stageconditionhandlers/5.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo, luaWindow)
  -- function num : 0_0 , upvalues : _ENV
  if luaWindow then
    local dialog = (DialogManager.GetDialog)("teamedit.changeteamroledialog")
    if dialog then
      local index = nil
      local count = 0
      for k,v in pairs((dialog._curTeam).roles) do
        if v ~= 0 then
          count = count + 1
        end
      end
      local index = nil
      if count < (table.nums)((dialog._curTeam).roles) then
        index = count + 1
      end
      if index then
        local logicCell = (dialog._upFrame):GetLogicCell(index)
        if luaWindow ~= (logicCell._cell):GetRootWindow() then
          do
            do
              do
                do
                  local tag = not logicCell or not logicCell._cell
                  if tag then
                    (dialog._upFrame):SetSlide(true)
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

