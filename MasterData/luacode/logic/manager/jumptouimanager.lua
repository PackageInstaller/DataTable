local JumpToUIManager = {}

function JumpToUIManager.GetTaskHandler(handlerName)
  return require("logic.task.taskuihandlers." .. handlerName)
end

function JumpToUIManager.RunTaskHandler(handlerName, args)
  local handler = require("logic.task.taskuihandlers." .. handlerName)
  return handler:Handle(args)
end

return JumpToUIManager
