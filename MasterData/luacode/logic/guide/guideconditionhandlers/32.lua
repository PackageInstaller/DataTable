local function func(conditionInfo)
  return not DialogManager.GetDialog("task.taskmaindialog")
end

return func
