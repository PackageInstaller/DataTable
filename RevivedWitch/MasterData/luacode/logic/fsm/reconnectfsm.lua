-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/reconnectfsm.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ReconnectFSM = strictclass("ReconnectFSM", require("framework.fsm"))
ReconnectFSM.Init = function(self)
  -- function num : 0_0 , upvalues : ReconnectFSM
  ((ReconnectFSM.super).Init)(self)
  self._parameters = {adult = 2, toQuestIPAndPort = false, ip = "", port = -1}
  self._states = {"Init", "SdkLogin", "QuestIPAndPort", "GameLogin"}
  self._transGraphs = {
{from = "Init", to = "SdkLogin", 
conditions = {
{parameterName = "adult", op = "eq", value = 2}
}
}
, 
{from = "Init", to = "SdkLogin", 
conditions = {
{parameterName = "adult", op = "eq", value = 0}
}
}
, 
{from = "Init", to = "QuestIPAndPort", 
conditions = {
{parameterName = "adult", op = "eq", value = 1}
}
}
, 
{from = "SdkLogin", to = "QuestIPAndPort", 
conditions = {
{parameterName = "toQuestIPAndPort", op = "eq", value = true}
}
}
, 
{from = "QuestIPAndPort", to = "GameLogin", 
conditions = {
{parameterName = "ip", op = "ne", value = ""}
, 
{parameterName = "port", op = "ne", value = -1}
}
}
}
  self._initialState = "Init"
  self:CheckError()
end

return ReconnectFSM

