-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/jumptouimanager.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local JumpToUIManager = {}
JumpToUIManager.GetTaskHandler = function(handlerName)
  -- function num : 0_0 , upvalues : _ENV
  return require("logic.task.taskuihandlers." .. handlerName)
end

JumpToUIManager.RunTaskHandler = function(handlerName, args)
  -- function num : 0_1 , upvalues : _ENV
  local handler = require("logic.task.taskuihandlers." .. handlerName)
  return handler:Handle(args)
end

return JumpToUIManager

