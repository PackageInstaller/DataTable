-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/energysection.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local EnergySection = class("EnergySection", Task)
local EnergyType = {Order = 1, Chaos = 2}
EnergySection.Ctor = function(self, context, energyType, energyLeft, energyRight)
  -- function num : 0_0 , upvalues : EnergySection, _ENV
  ((EnergySection.super).Ctor)(self)
  self._energyType = energyType
  self._energyLeft = energyLeft
  self._energyRight = energyRight
  self._battleWorld = context._battleworld
  self._dataUtility = (BattleECS.Utility).DataUtility
end

EnergySection.OnStart = function(self)
  -- function num : 0_1
end

EnergySection.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : EnergyType, TaskStatus
  if self._energyType == EnergyType.Order then
    local orderPower = ((self._dataUtility).GetPowerGridFunc)((self._battleWorld)._redPower, ((self._dataUtility).PowerType).Red)
    if self._energyLeft <= orderPower and orderPower <= self._energyRight then
      return TaskStatus.Success
    end
  else
    do
      do
        if self._energyType == EnergyType.Chaos then
          local chaosPower = ((self._dataUtility).GetPowerGridFunc)((self._battleWorld)._bluePower, ((self._dataUtility).PowerType).Blue)
          if self._energyLeft <= chaosPower and chaosPower <= self._energyRight then
            return TaskStatus.Success
          end
        end
        return TaskStatus.Failure
      end
    end
  end
end

EnergySection.OnEnd = function(self)
  -- function num : 0_3
end

return EnergySection

