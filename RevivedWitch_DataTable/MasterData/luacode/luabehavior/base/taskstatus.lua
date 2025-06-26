-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/base/taskstatus.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Status_Enum = {}
Status_Enum.Running = "Running"
Status_Enum.Success = "Success"
Status_Enum.Failure = "Failure"
Status_Enum.Invalid = "Invalid"
return Status_Enum

