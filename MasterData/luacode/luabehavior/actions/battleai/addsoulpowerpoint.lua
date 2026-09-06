local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local AddSoulPowerPoint = class("AddSoulPowerPoint", Task)

function AddSoulPowerPoint:Ctor(context, delta)
  AddSoulPowerPoint.super.Ctor(self)
  self._addDeltaPointNum = delta
  self._battleWorld = context._battleworld
  self._dataUtility = BattleECS.Utility.DataUtility
  self._protocolUtility = BattleECS.Utility.ProtocolUtility
end

function AddSoulPowerPoint:OnStart()
end

function AddSoulPowerPoint:OnUpdate(deltaTime)
  self._battleWorld._accumulatePower = self._battleWorld._accumulatePower + self._addDeltaPointNum
  self._protocolUtility.SendSBreakOutPowerNumber(self._battleWorld)
  return TaskStatus.Success
end

function AddSoulPowerPoint:OnEnd()
end

return AddSoulPowerPoint
