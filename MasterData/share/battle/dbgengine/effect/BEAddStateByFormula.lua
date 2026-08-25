local System = require("System.System")
local BEAddStateParent = require("Battle.DbgEngine.Effect.BEAddStateParent")
local bc = require("Battle.BattleConst")
local BEAddStateByFormula, Super = System.NewClass("BEAddStateByFormula", BEAddStateParent)

function BEAddStateByFormula:CalcStateLayerByDamgeFormula(target, layer, formulaSubType)
  do return self.cmdServer.GetRealDmg, self.cmdServer, layer, target, false, nil end
  return self.cmdServer.GetRealDmg, self.cmdServer, layer, target, false, nil, formulaSubType
end

function BEAddStateByFormula:CalcStateLayerByHealFormula(target, layer, formulaSubType)
  do return self.cmdServer.GetRealHeal, self.cmdServer, layer, target, nil end
  return self.cmdServer.GetRealHeal, self.cmdServer, layer, target, nil, formulaSubType
end

function BEAddStateByFormula:CalcStateLayerByBlockFormula(target, layer, formulaSubType)
  do return self.cmdServer.GetRealBlock, self.cmdServer, layer, target, nil end
  return self.cmdServer.GetRealBlock, self.cmdServer, layer, target, nil, formulaSubType
end

function BEAddStateByFormula:CalcStateLayerUltiEnergyFormula(target, layer, formulaSubType)
  do return self.cmdServer.GetRealUltiEnergy, self.cmdServer, layer, target end
  return self.cmdServer.GetRealUltiEnergy, self.cmdServer, layer, target, formulaSubType
end

function BEAddStateByFormula:CalcStateLayerByPoisonFormula(target, layer, formulaSubType)
  do return self.cmdServer.GetRealPoison, self.cmdServer, layer, target, nil end
  return self.cmdServer.GetRealPoison, self.cmdServer, layer, target, nil, formulaSubType
end

function BEAddStateByFormula:CalcStateLayerByCounterattackFormula(target, layer, formulaSubType)
  do return self.cmdServer.GetRealCounterattack, self.cmdServer, layer, target, nil end
  return self.cmdServer.GetRealCounterattack, self.cmdServer, layer, target, nil, formulaSubType
end

function BEAddStateByFormula:CalcStateLayerByPowerFormula(target, layer, formulaSubType)
  do return self.cmdServer.GetRealPower, self.cmdServer, layer, target, nil end
  return self.cmdServer.GetRealPower, self.cmdServer, layer, target, nil, formulaSubType
end

function BEAddStateByFormula:CalcStateLayerByTentaclePowerFormula(target, layer, formulaSubType)
  do return self.cmdServer.GetRealTentaclePower, self.cmdServer, layer, target, nil end
  return self.cmdServer.GetRealTentaclePower, self.cmdServer, layer, target, nil, formulaSubType
end

function BEAddStateByFormula:CalcStateLayerByExhaustionFormula(target, layer, formulaSubType)
  do return self.cmdServer.GetRealExhaustion, self.cmdServer, layer, target, nil end
  return self.cmdServer.GetRealExhaustion, self.cmdServer, layer, target, nil, formulaSubType
end

function BEAddStateByFormula:CalcStateLayerByFateCutFormula(target, layer, formulaSubType)
  do return self.cmdServer.GetRealFateCut, self.cmdServer, layer, target, nil end
  return self.cmdServer.GetRealFateCut, self.cmdServer, layer, target, nil, formulaSubType
end

function BEAddStateByFormula:CalcStateLayerByCorrosionFormula(target, layer, formulaSubType)
  do return self.cmdServer.GetRealCorrosion, self.cmdServer, layer, target, nil end
  return self.cmdServer.GetRealCorrosion, self.cmdServer, layer, target, nil, formulaSubType
end

local FORMULA_SKIP_CASTER_STATE_LAYER_PER = {
  UsePoisonFormula = true,
  UseCounterattackFormula = true,
  UsePowerFormula = true,
  UseTentacleFormula = true,
  UseExhaustionFormula = true,
  UseFateCutFormula = true,
  UseCorrosionFormula = true
}
local FORMULA_FUNC = {
  UseDmgFormula = BEAddStateByFormula.CalcStateLayerByDamgeFormula,
  UseHealFormula = BEAddStateByFormula.CalcStateLayerByHealFormula,
  UseBlockFormula = BEAddStateByFormula.CalcStateLayerByBlockFormula,
  UseUltiEneFormula = BEAddStateByFormula.CalcStateLayerUltiEnergyFormula,
  UsePoisonFormula = BEAddStateByFormula.CalcStateLayerByPoisonFormula,
  UseCounterattackFormula = BEAddStateByFormula.CalcStateLayerByCounterattackFormula,
  UsePowerFormula = BEAddStateByFormula.CalcStateLayerByPowerFormula,
  UseTentacleFormula = BEAddStateByFormula.CalcStateLayerByTentaclePowerFormula,
  UseExhaustionFormula = BEAddStateByFormula.CalcStateLayerByExhaustionFormula,
  UseFateCutFormula = BEAddStateByFormula.CalcStateLayerByFateCutFormula,
  UseCorrosionFormula = BEAddStateByFormula.CalcStateLayerByCorrosionFormula
}

function BEAddStateByFormula:DoEffect()
  Super.DoEffect(self)
  self.effectConfig.noDirectCmd = true
  local targets = self.targets
  local stateId = self.params[1]
  local formulaType = self.params[2]
  local formulaSubType = self.params[3] or bc.FormulaSubType.All
  local layer = math.ceil(self.params[4] or 1)
  local minLayer = self.params[5] or 0
  if not targets then
    return false
  end
  if layer <= 0 then
    return true
  end
  local n = 6
  local stateParams = {}
  if n <= #self.params then
    for i = n, #self.params do
      table.insert(stateParams, self.params[i])
    end
  end
  self.effectConfig.formulaType = formulaType
  self.effectConfig.skipCasterStateLayerPerAfterFormula = true == FORMULA_SKIP_CASTER_STATE_LAYER_PER[formulaType]
  for _, target in ipairs(targets) do
    local thisLayer = layer
    if formulaType and FORMULA_FUNC[formulaType] then
      thisLayer = FORMULA_FUNC[formulaType](self, target, thisLayer, formulaSubType)
    end
    self:AddState(target, stateId, thisLayer, stateParams, minLayer)
  end
  return true
end

return BEAddStateByFormula
