local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local EnergySection = class("EnergySection", Task)
local EnergyType = {Order = 1, Chaos = 2}

function EnergySection:Ctor(context, energyType, energyLeft, energyRight)
  EnergySection.super.Ctor(self)
  self._energyType = energyType
  self._energyLeft = energyLeft
  self._energyRight = energyRight
  self._battleWorld = context._battleworld
  self._dataUtility = BattleECS.Utility.DataUtility
end

function EnergySection:OnStart()
end

function EnergySection:OnUpdate(deltaTime)
  if self._energyType == EnergyType.Order then
    local orderPower = self._dataUtility.GetPowerGridFunc(self._battleWorld._redPower, self._dataUtility.PowerType.Red)
    if orderPower >= self._energyLeft and orderPower <= self._energyRight then
      return TaskStatus.Success
    end
  elseif self._energyType == EnergyType.Chaos then
    local chaosPower = self._dataUtility.GetPowerGridFunc(self._battleWorld._bluePower, self._dataUtility.PowerType.Blue)
    if chaosPower >= self._energyLeft and chaosPower <= self._energyRight then
      return TaskStatus.Success
    end
  end
  return TaskStatus.Failure
end

function EnergySection:OnEnd()
end

return EnergySection
