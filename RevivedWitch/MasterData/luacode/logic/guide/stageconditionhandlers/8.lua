-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stageconditionhandlers/8.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo, luaWindow)
  -- function num : 0_0 , upvalues : _ENV
  if luaWindow then
    local dialog = (DialogManager.GetDialog)("teamedit.changeteamroledialog")
    if dialog then
      local index = nil
      for i,role in ipairs(dialog._listByConditions) do
        local tag = (table.keyof)((dialog._curTeam).roles, role:GetRoleId())
        local isJobLimit = not ((NekoData.BehaviorManager).BM_Vocation):GetVocationIsSupport(role, dialog._supportVocationTable)
        if isJobLimit and dialog._curRoleKey ~= role:GetRoleId() then
          tag = true
        end
        if not tag then
          index = i
          break
        end
      end
      do
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
end

return func

