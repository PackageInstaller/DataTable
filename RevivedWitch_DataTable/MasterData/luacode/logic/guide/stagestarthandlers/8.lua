-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stagestarthandlers/8.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(guideFrame)
  -- function num : 0_0 , upvalues : _ENV
  local child = nil
  local dialog = (DialogManager.GetDialog)("teamedit.changeteamroledialog")
  if dialog and dialog._curTeam and (dialog._curTeam).roles and dialog._listByConditions then
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
        if logicCell and logicCell._cell then
          child = (logicCell._cell):GetRootWindow()
        end
      else
        do
          do
            ;
            ((NekoData.BehaviorManager).BM_Guide):FinishGuide(45)
            if child then
              (dialog._upFrame):SetSlide(false)
            end
            return child
          end
        end
      end
    end
  end
end

return func

