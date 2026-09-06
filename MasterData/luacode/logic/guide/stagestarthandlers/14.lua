local Status = LuaNetManager.CreateBean("protocol.task.taskstatus")

local function func(guideFrame)
  local child
  local dialog = DialogManager.GetDialog("task.taskmaindialog")
  if dialog and dialog._helper then
    if dialog._helper:GetCurrentIndex() ~= 2 then
      dialog:ToPage(2)
    end
    local tabCell = dialog._helper:GetCellAtIndex(2)
    if tabCell then
      local everydayFirstFinishTaskIndex
      for i, v in ipairs(tabCell._tasks) do
        if v:GetStatus() == Status.FINISHED then
          everydayFirstFinishTaskIndex = i
          break
        end
      end
      if not everydayFirstFinishTaskIndex then
        NekoData.BehaviorManager.BM_Guide:FinishGuide(6)
      else
        local taskcell = tabCell._helper:GetLogicCell(everydayFirstFinishTaskIndex)
        if taskcell and taskcell._cell then
          child = taskcell._cell:GetChild("Back/GetBtn")
        end
      end
    end
  end
  return child
end

return func
