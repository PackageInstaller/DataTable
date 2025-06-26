-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stagestarthandlers/6.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(guideFrame)
  -- function num : 0_0 , upvalues : _ENV
  local child = nil
  local dialog = (DialogManager.GetDialog)("teamedit.changeteamroledialog")
  if dialog and dialog._curTeam and (dialog._curTeam).roles then
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
    do
      do
        if index then
          local logicCell = (dialog._upFrame):GetLogicCell(index)
          if logicCell and logicCell._cell then
            child = (logicCell._cell):GetRootWindow()
          end
        end
        if child then
          (dialog._upFrame):SetSlide(false)
        end
        return child
      end
    end
  end
end

return func

