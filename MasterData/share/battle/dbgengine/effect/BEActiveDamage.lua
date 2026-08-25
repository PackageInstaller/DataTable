local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BEActiveDamage, Super = System.NewClass("BEActiveDamage", BattleEffectServer)

function BEActiveDamage:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEActiveDamage:Dispose()
  Super.Dispose(self)
end

function BEActiveDamage:GetDamageSubTypeValue(params)
  local damageSubType
  if self.isAddState or self.fixArg == "State" then
    damageSubType = params and #params >= 6 and params[6] or 0
  else
    damageSubType = params and #params >= 3 and params[3] or 0
  end
  do return self.GetDamageSubType, self end
  return self.GetDamageSubType, self, damageSubType
end

function BEActiveDamage:DoEffect()
  Super.DoEffect(self)
  local targets = self.targets
  if not targets then
    return false
  end
  self.totalEffectTimes = math.ceil(self.params[2] or 1)
  self.isAddState = self.fixArg == "State"
  self.damageSubType = self:GetDamageSubTypeValue(self.params)
  self.paraPlus = self.params[4]
  if self.isAddState then
    local stateId, layerRate, layerType = self.params[3], self.params[4], self.params[5]
    self.paraPlus = self.params[7]
    local paramStateTarget = self.params[8]
    if paramStateTarget and #paramStateTarget > 0 then
      self.paramStateTarget = paramStateTarget
    else
      self.paramStateTarget = {paramStateTarget}
    end
    self.critLayerRate = #self.params >= 9 and self.params[9] or 100
    if type(stateId) ~= "table" then
      stateId = {stateId}
    end
    if type(layerRate) ~= "table" then
      layerRate = {layerRate}
    end
    if type(layerType) ~= "table" then
      layerType = {layerType}
    end
    self.paramStateIdList = stateId
    self.paramLayerRate = layerRate
    self.paramLayerType = layerType
  end
  local awaker = self.battleEngine:GetObj(self.cmdServer.castRoleUid)
  local additionDamageTimes = awaker:GetProperty(bc.BattleProperty.damagetimes_plus)
  self.totalEffectTimes = self.totalEffectTimes + additionDamageTimes
  local timesPer = awaker:GetProperty(bc.BattleProperty.damagetimes_per) / 100
  self.totalEffectTimes = math.ceil(self.totalEffectTimes * (1 + timesPer))
  self.totalEffectTimes = math.max(1, self.totalEffectTimes)
  self.leftEffectTimes = self.totalEffectTimes
  do return self.DoMultiEffect end
  return self.DoMultiEffect, self, self.totalEffectTimes
end

function BEActiveDamage:__DoMultiEffect()
  local cmdOwner = self.battleEngine:GetObj(self.cmdServer.castRoleUid)
  if not cmdOwner or cmdOwner:IsRoleType(bc.RoleType.Monster) and cmdOwner:IsDead() then
    return false
  end
  local ConstDelay = self.battleEngine.battleDT.GetConstant("MutidamageDelay") or 0
  local delay
  if self.effectConfig.skipPhase or self.totalEffectTimes == self.leftEffectTimes then
    delay = 0
  else
    delay = ConstDelay
  end
  self.battleEngine:AddPassTime(delay)
  local targets = self.targets
  if self:IsSingleTarget() and 1 == #targets and targets[1]:IsDead() then
    local targetExp = self.cmdServer:GenerateTargetsExp(self.effectConfig.cmdCfg.Target, self.uid)
    self.targets = targetExp:GetTargetList()
    targets = self.targets
  end
  for _, target in ipairs(targets) do
    local effectType = bc.BattleEffectType.BEFunctionEffect
    local effectConfig = {
      effectType = effectType,
      func = self.Damage2SingleTarget,
      funcTarget = self,
      funcArgs = {target},
      targets = targets
    }
    self.battleEngine.effectMgr:CreateEffect(effectConfig)
  end
  self.leftEffectTimes = self.leftEffectTimes - 1
  return true
end

function BEActiveDamage:IsSingleTarget()
  local targetTypes = self.battleEngine.battleDT:GetOriginalConstant("BattleDamage_Overflow_Target")
  for _, v in ipairs(targetTypes) do
    if v == self.effectConfig.cmdCfg.Target then
      return true
    end
  end
  return false
end

function BEActiveDamage:Damage2SingleTarget(target)
  if target:IsDead() then
    return
  end
  self:GenParams()
  local cmdServer = self.cmdServer
  local card = cmdServer.cardUid and self.battleEngine:GetObj(cmdServer.cardUid)
  local baseDamage = self.params[1]
  local str = tostring(baseDamage)
  if "inf" == str or "nan" == str then
    self.battleEngine:Error("公式返回了非法数字！！！", self.cmdServer and self.cmdServer.cmdId)
    baseDamage = 0
  end
  local damageVal = self.cmdServer:GetRealDmg(baseDamage, target, nil, self.paraPlus)
  damageVal = math.max(0, damageVal)
  local attackConfig = {
    fromCmdServerUid = self.cmdServerUid,
    castRoleUid = self.cmdServer.castRoleUid,
    damageVal = damageVal,
    isCrit = self.cmdServer:GetMemberValue("IsCrit"),
    damageType = bc.DamageType.Active,
    skillConfigId = cmdServer.skillConfigId,
    damageSubType = self.damageSubType
  }
  local beHitConfig = target:BeHit(attackConfig)
  beHitConfig.cmdServerUid = self.cmdServerUid
  local realDamage = beHitConfig.changeVal
  if self.isAddState then
    for i, stateId in ipairs(self.paramStateIdList) do
      local stateTarget = {target}
      if i <= #self.paramStateTarget then
        local targets = self.paramStateTarget[i]:GetTargetList()
        if targets and 0 ~= #targets then
          stateTarget = targets
        end
      end
      local layerRate = self.paramLayerRate[i] or 1
      local layerType = self.paramLayerRate[i] or nil
      local layer = "UseRealDmg" == layerType and realDamage or damageVal
      local finalLayer = layer * layerRate
      if attackConfig.isCrit then
        local caster = self.cmdServer.castRoleUid and self.battleEngine:GetObj(self.cmdServer.castRoleUid)
        local critDamage = caster:GetProperty(bc.BattleProperty.crit_damage)
        finalLayer = layer * layerRate / (1 + critDamage / 100) * (1 + critDamage / 100 * self.critLayerRate / 100)
      end
      local effectType = bc.BattleEffectType.BEAddState
      local effectConfig = {
        effectType = effectType,
        targets = stateTarget,
        params = {stateId, finalLayer},
        cmdServer = self.cmdServer,
        castRoleUid = self.cmdServer.castRoleUid,
        noDirectCmd = true
      }
      self.battleEngine.effectMgr:CreateEffect(effectConfig)
    end
  end
  if card and target.uid ~= self.cmdServer.castRoleUid then
    card:RecordDamageTargets(target.uid)
  end
end

return BEActiveDamage
