-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stagestarthandlers/14.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Status = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local func = function(guideFrame)
  -- function num : 0_0 , upvalues : _ENV, Status
  local child = nil
  local dialog = (DialogManager.GetDialog)("task.taskmaindialog")
  if dialog and dialog._helper then
    if (dialog._helper):GetCurrentIndex() ~= 2 then
      dialog:ToPage(2)
    end
    local tabCell = (dialog._helper):GetCellAtIndex(2)
    if tabCell then
      local everydayFirstFinishTaskIndex = nil
      for i,v in ipairs(tabCell._tasks) do
        if v:GetStatus() == Status.FINISHED then
          everydayFirstFinishTaskIndex = i
          break
        end
      end
      do
        if not everydayFirstFinishTaskIndex then
          ((NekoData.BehaviorManager).BM_Guide):FinishGuide(6)
        else
          local taskcell = (tabCell._helper):GetLogicCell(everydayFirstFinishTaskIndex)
          if taskcell and taskcell._cell then
            child = (taskcell._cell):GetChild("Back/GetBtn")
          end
        end
        do
          return child
        end
      end
    end
  end
end

return func

