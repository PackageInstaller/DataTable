-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/addsoulpowerpoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local AddSoulPowerPoint = class("AddSoulPowerPoint", Task)
AddSoulPowerPoint.Ctor = function(self, context, delta)
  -- function num : 0_0 , upvalues : AddSoulPowerPoint, _ENV
  ((AddSoulPowerPoint.super).Ctor)(self)
  self._addDeltaPointNum = delta
  self._battleWorld = context._battleworld
  self._dataUtility = (BattleECS.Utility).DataUtility
  self._protocolUtility = (BattleECS.Utility).ProtocolUtility
end

AddSoulPowerPoint.OnStart = function(self)
  -- function num : 0_1
end

AddSoulPowerPoint.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : TaskStatus
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  (self._battleWorld)._accumulatePower = (self._battleWorld)._accumulatePower + self._addDeltaPointNum
  ;
  ((self._protocolUtility).SendSBreakOutPowerNumber)(self._battleWorld)
  return TaskStatus.Success
end

AddSoulPowerPoint.OnEnd = function(self)
  -- function num : 0_3
end

return AddSoulPowerPoint

