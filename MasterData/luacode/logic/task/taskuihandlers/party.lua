local TaskUIHandler = {}

function TaskUIHandler:Handle()
  DialogManager.CreateSingletonDialog("teamedit.teampresetmaindialog")
end

return TaskUIHandler
