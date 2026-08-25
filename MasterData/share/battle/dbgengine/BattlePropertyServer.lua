local System = require("System.System")
local BattleComponent = require("Battle.Ecs.BattleComponent")
local bc = require("Battle.BattleConst")
local math_ceil = math.ceil
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BattleUtilServer = require("Battle.Util.BattleUtilServer")
local BattlePropertyServer, Super = System.NewClass("BattlePropertyServer", BattleComponent)
local BP = bc.BattleProperty
local PropertyMin = {
  [BP.hp] = 0,
  [BP.block] = 0,
  [BP.energy] = 0,
  [BP.max_energy] = 0,
  [BP.unlimit_swallow] = 0,
  [BP.bout_skill_times] = 0,
  [BP.permanent_tentacle_count] = 1,
  [BP.bout_tentacle_count] = 0,
  [BP.battle_tentacle_count] = 0,
  [BP.permanent_max_tentacle_count] = 1,
  [BP.bout_max_tentacle_count] = 0,
  [BP.battle_max_tentacle_count] = 0,
  [BP.ulti_energy] = 0,
  [BP.relic_num_limit] = 0
}
local DefaultNil = {
  [BP.card_cost] = true,
  [BP.card_origin_cost] = true,
  [BP.useless] = true,
  [BP.card_use_times] = true
}
for _, fixedCostKey in ipairs(bc.CardFixedCostKeys) do
  DefaultNil[fixedCostKey] = true
end

function BattlePropertyServer:ctor(entity, properties)
  Super.ctor(self, entity)
  self.owner = entity
  self.battleEngine = entity.battleEngine
  self.properties = {}
  for key, value in pairs(properties) do
    self.properties[key] = value and math_ceil(value)
  end
  self.owner.data.properties = self.properties
end

function BattlePropertyServer:GetMaxEnergy()
  return 99
end

function BattlePropertyServer:GetPropertyMaxFunc(propertyName)
  local PropertyMax = {
    [BP.hp] = function()
      return self.properties[BP.max_hp] or 0
    end,
    [BP.ulti_energy] = BattlePropertyServer.GetMaxUltiEnergy,
    [BP.keeper_energy] = BattlePropertyServer.GetMaxKeeperEnergy,
    [BP.block] = BattlePropertyServer.GetMaxBlock,
    [BP.max_energy] = BattlePropertyServer.GetMaxEnergy,
    [BP.energy] = BattlePropertyServer.GetMaxEnergy
  }
  return PropertyMax[propertyName]
end

function BattlePropertyServer:GetBasicKeeperEnergy()
  local costPer = self.properties[BP.keeper_energy_cost_per] or 0
  local max = self.properties[BP.max_keeper_energy] or 0
  local cur = max * (1 + costPer / 100)
  do return math.floor end
  return math.floor, cur + 0.5
end

function BattlePropertyServer:GetMaxKeeperEnergy()
  local maxPer = self.properties[BP.max_keeper_energy_per] or 0
  local costPer = self.properties[BP.keeper_energy_cost_per] or 0
  local max = self.properties[BP.max_keeper_energy] or 0
  local cur = max * (1 + maxPer / 100) * (1 + costPer / 100)
  do return math.floor end
  return math.floor, cur + 0.5
end

function BattlePropertyServer:GetMaxUltiEnergy()
  local maxPer = self.properties[BP.ulti_energy_max_per] or 0
  local costPer = self.properties[BP.ulti_energy_cost_per] or 0
  local max = self.properties[BP.ulti_energy_max] or 0
  local costFlat = self.properties[BP.ulti_energy_cost_flat] or 0
  local cur = (max * (1 + costPer / 100) + costFlat) * (1 + maxPer / 100)
  do return math.floor end
  return math.floor, cur + 0.5
end

function BattlePropertyServer:GetMaxBlock()
  local maxPer = self.properties[BP.block_max_per] or 0
  local max = self.properties[BP.max_hp] or 0
  local cur = max * (1 + maxPer / 100)
  do return math.floor end
  return math.floor, cur + 0.5
end

function BattlePropertyServer:GetProperty(propertyName)
  local default = 0
  if DefaultNil[propertyName] then
    default = nil
  end
  if propertyName == BP.tentacle_count then
    local bout = self.properties[BP.bout_tentacle_count] or 0
    local battle = self.properties[BP.battle_tentacle_count] or 0
    local permanent = self.properties[BP.permanent_tentacle_count] or 0
    return bout + battle + permanent
  end
  if propertyName == BP.max_tentacle_count then
    local bout = self.properties[BP.bout_max_tentacle_count] or 0
    local battle = self.properties[BP.battle_max_tentacle_count] or 0
    local permanent = self.properties[BP.permanent_max_tentacle_count] or 0
    return bout + battle + permanent
  end
  return self.properties[propertyName] or default
end

function BattlePropertyServer:SendOnPropertyChanged(uid, propertyName, changedValue, value, reason, extraData)
  local data = table.clone(extraData)
  data.uid = uid
  data.propertyName = propertyName
  data.changedValue = changedValue
  data.value = value
  data.reason = reason
  self.battleEngine:CreateEventEffect(BattleLogicEvent.PropertyChange, data)
  local isSilent = extraData and extraData.isSilent
  if isSilent then
    return
  end
  self.battleEngine.logger:DebugS("yzy SendOnPropertyChanged {data}", data)
  self.battleEngine.recordMgr:OnPropertyChanged(uid, propertyName, changedValue, value, reason, extraData)
end

function BattlePropertyServer:CheckTentacleDamage(propertyName)
  if propertyName == BP.tentacle_dmg and self.battleEngine:IsPVE() and self.owner:IsRoleType(bc.RoleType.Monster) and self.owner:GetProperty(BP.max_tentacle_count) <= 0 then
    return false
  end
  return true
end

function BattlePropertyServer:SetProperty(propertyName, value, extraData)
  local preValue = self.properties[propertyName] or 0
  local changedValue = value - preValue
  if 0 ~= changedValue then
    do return self.ChangeProperty, self, propertyName, changedValue end
    return self.ChangeProperty, self, propertyName, changedValue, extraData
  end
  return self.properties[propertyName]
end

function BattlePropertyServer:ChangeProperty(propertyName, value, extraData)
  extraData.castValue = extraData.castValue or value
  if not self:CheckTentacleDamage(propertyName) then
    return 0
  end
  local ret
  if value > 0 then
    ret = self:AddProperty(propertyName, value, extraData)
  elseif value < 0 then
    ret = self:SubProperty(propertyName, math.abs(value), extraData)
  end
  return ret
end

function BattlePropertyServer:AddProperty(propertyName, value, extraData)
  local preValue = self.properties[propertyName] or 0
  value = self:BeforeAdd(propertyName, value, extraData)
  self.properties[propertyName] = self.properties[propertyName] + value
  self:AfterAdd(propertyName, value, preValue, extraData)
  return self.properties[propertyName]
end

function BattlePropertyServer:SubProperty(propertyName, value, extraData)
  local preValue = self.properties[propertyName]
  value = self:BeforeSub(propertyName, value, extraData)
  self.properties[propertyName] = self.properties[propertyName] - value
  self:AfterSub(propertyName, value, preValue, extraData)
  return self.properties[propertyName]
end

function BattlePropertyServer:BeforeAdd(propertyName, value, extraData)
  if not self.properties[propertyName] then
    self.properties[propertyName] = 0
  end
  if bc.PropertyOfCritAdd[propertyName] then
    value = math.ceil(value * (100 + self:GetProperty(BP.i_crit_per)) / 100)
  elseif bc.PropertyOfCritDamageAdd[propertyName] then
    value = math.ceil(value * (100 + self:GetProperty(BP.i_crit_damage_per)) / 100)
  end
  local propertyMaxFunc = self:GetPropertyMaxFunc(propertyName)
  if (not extraData or not extraData.ignoreMax) and propertyMaxFunc then
    local v = self.properties[propertyName] + value
    local max = propertyMaxFunc(self)
    if v > max then
      value = math.max(0, max - self.properties[propertyName])
    end
  end
  return value
end

function BattlePropertyServer:AfterAdd(propertyName, value, preValue, extraData)
  if propertyName == BP.max_hp and (not extraData or not extraData.skipHp) then
    self:AddProperty(BP.hp, value, extraData)
    if self.properties[BP.hp] > self.properties[BP.max_hp] then
      self:SetProperty(BP.hp, self.properties[BP.max_hp], extraData)
    end
  end
  if propertyName == BP.occupation_master_final_per or propertyName == BP.occupation_master then
    local occupation_master_final = math.ceil(self:GetProperty(BP.occupation_master) * (100 + self:GetProperty(BP.occupation_master_final_per)) / 100)
    self:SetProperty(BP.occupation_master_final, occupation_master_final, extraData)
  end
  if propertyName == BP.occupation_master_final then
    self:RefreshKeeperskillPer(extraData)
  end
  self:RefreshMaxLimit(propertyName, extraData)
  self.owner:OnPropertyChanged(propertyName, preValue, self.properties[propertyName], extraData)
  self:SendOnPropertyChanged(self.owner.uid, propertyName, value, self.properties[propertyName], extraData.reason, extraData)
end

function BattlePropertyServer:RefreshMaxLimit(propertyName, extraData)
  if propertyName == BP.max_hp and self.properties[BP.hp] > self.properties[BP.max_hp] then
    self:SetProperty(BP.hp, self.properties[BP.max_hp], extraData)
  end
  if propertyName == BP.keeper_energy_cost_per or propertyName == BP.max_keeper_energy_per or propertyName == BP.max_keeper_energy then
    local curMax = self:GetMaxKeeperEnergy()
    if self.properties[BP.keeper_energy] and curMax < self.properties[BP.keeper_energy] then
      self:SetProperty(BP.keeper_energy, curMax, extraData)
    end
  end
  if propertyName == BP.ulti_energy_cost_per or propertyName == BP.ulti_energy_cost_flat or propertyName == BP.max_ulti_energy_per or propertyName == BP.max_ulti_energy then
    local curMax = self:GetMaxUltiEnergy()
    if self.properties[BP.ulti_energy] and curMax < self.properties[BP.ulti_energy] then
      self:SetProperty(BP.ulti_energy, curMax, extraData)
    end
  end
end

function BattlePropertyServer:RefreshKeeperskillPer(extraData)
  if not (self.owner and self.owner.IsRoleType) or not self.owner:IsRoleType(bc.RoleType.Player) then
    return
  end
  local battleApiTable = self.battleEngine and self.battleEngine.battleDT and self.battleEngine.battleDT.BattleApi
  local occupationMasterFinal = self:GetProperty(BP.occupation_master_final)
  local keeperskillAtkPer = BattleUtilServer.CalKeeperskillAtkPer(occupationMasterFinal, battleApiTable)
  local keeperskillDefPer = BattleUtilServer.CalKeeperskillDefPer(occupationMasterFinal, battleApiTable)
  self:SetProperty(BP.keeperskill_atk_per, keeperskillAtkPer, extraData)
  self:SetProperty(BP.keeperskill_def_per, keeperskillDefPer, extraData)
end

function BattlePropertyServer:GetSubPropertyValueFunc(propertyName)
  local funcs = {
    [BP.keeper_energy] = BattlePropertyServer.GetSubKeeperEnergyValue
  }
  return funcs[propertyName]
end

function BattlePropertyServer:GetSubKeeperEnergyValue(value, extraData)
  local skillConfigId = extraData and extraData.skillConfigId
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local silverKeyAwakeSkill = player:GetSilverKeyAwakeSkill()
  local ret = value
  local curVal = self.properties[BP.keeper_energy]
  if skillConfigId ~= silverKeyAwakeSkill then
    if curVal <= 0 then
      ret = 0
    else
      ret = math.min(value, curVal)
    end
  end
  self.battleEngine:InfoS("BattlePropertyServer:GetSubKeeperEnergyValue {skillConfigId} {changeValue} {curVal} {ret}", skillConfigId, value, curVal, ret)
  return ret
end

function BattlePropertyServer:BeforeSub(propertyName, value, extraData)
  if not self.properties[propertyName] then
    self.properties[propertyName] = 0
  end
  local subPropertyValueFunc = self:GetSubPropertyValueFunc(propertyName)
  if subPropertyValueFunc then
    value = subPropertyValueFunc(self, value, extraData)
  end
  if PropertyMin[propertyName] then
    local minVal = PropertyMin[propertyName]
    local curVal = self.properties[propertyName]
    if curVal <= value + minVal then
      value = curVal - minVal
    end
  end
  return value
end

function BattlePropertyServer:AfterSub(propertyName, value, preValue, extraData)
  if propertyName == BP.occupation_master_final_per or propertyName == BP.occupation_master then
    local occupationMasterFinal = math.ceil(self:GetProperty(BP.occupation_master) * (100 + self:GetProperty(BP.occupation_master_final_per)) / 100)
    self:SetProperty(BP.occupation_master_final, occupationMasterFinal, extraData)
  end
  if propertyName == BP.occupation_master_final then
    self:RefreshKeeperskillPer(extraData)
  end
  self:RefreshMaxLimit(propertyName, extraData)
  self.owner:OnPropertyChanged(propertyName, preValue, self.properties[propertyName], extraData)
  self:SendOnPropertyChanged(self.owner.uid, propertyName, value * -1, self.properties[propertyName], extraData.reason, extraData)
end

function BattlePropertyServer:PrintProperties()
  local roleName = "玩家"
  if self.owner.camp == bc.BattleCamp.Camp2 then
    roleName = self.owner.configData.MonsterName
  end
  for k, v in pairs(self.properties) do
    self.battleEngine:Info(string.format("%s %s=%s", roleName, k, v))
  end
end

function BattlePropertyServer:Serialize()
  local ret = {}
  for k in pairs(self.properties) do
    local v = self:GetProperty(k)
    ret[k] = 0 ~= v and v or nil
  end
  return ret
end

function BattlePropertyServer:GetBattleLog(tabNum)
  local tabStr = ""
  if tabNum then
    for _ = 1, tabNum do
      tabStr = tabStr .. "\t"
    end
  end
  local str = ""
  local DT = self.battleEngine.battleDT
  for k, v in pairs(self.properties) do
    if DT.BattleApi[k] and 0 ~= v then
      str = str .. string.format(tabStr .. "\t%s: %s\n", DT.BattleApi[k].CnID, v)
    end
  end
  return str
end

return BattlePropertyServer
