-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/yardfsm.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local YardFSM = strictclass("YardFSM", require("framework.fsm"))
YardFSM.Init = function(self)
  -- function num : 0_0 , upvalues : YardFSM
  ((YardFSM.super).Init)(self)
  self._parameters = {sceneId = 0, cameraAnimatorState = 0}
  self._states = {"Init", "Cabin", "TrainCamp"}
  self._transGraphs = {
{from = "Init", to = "Cabin", 
conditions = {
{parameterName = "sceneId", op = "eq", value = 30008}
}
}
, 
{from = "Cabin", to = "Init", 
conditions = {
{parameterName = "sceneId", op = "eq", value = 0}
}
}
, 
{from = "Init", to = "TrainCamp", 
conditions = {
{parameterName = "sceneId", op = "eq", value = 30013}
}
}
, 
{from = "TrainCamp", to = "Init", 
conditions = {
{parameterName = "sceneId", op = "eq", value = 0}
}
}
}
  self._initialState = "Init"
  self:CheckError()
end

return YardFSM

