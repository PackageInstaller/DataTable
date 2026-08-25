local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BP = bc.BattleProperty
local BEFixedDamage, Super = System.NewClass("BEFixedDamage", BattleEffectServer)

function BEFixedDamage:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEFixedDamage:Dispose()
  Super.Dispose(self)
end

function BEFixedDamage:DoEffect()
  Super.DoEffect(self)
  local targets = self.targets
  if not targets then
    return false
  end
  self.totalEffectTimes = math.ceil(self.params[2] or 1)
  self.totalEffectTimes = math.max(1, self.totalEffectTimes)
  self.leftEffectTimes = self.totalEffectTimes
  do return self.DoMultiEffect end
  return self.DoMultiEffect, self, self.totalEffectTimes
end

function BEFixedDamage:GetShowDamage()
  self:GenParams()
  local baseDamage = self.params[1]
  do return math.ceil end
  return math.ceil, baseDamage
end

function BEFixedDamage:__DoMultiEffect()
  local targets = self.targets
  local cmdServer = self.cmdServer
  local damageSubType = self:GetDamageSubType(self.params[3])
  local enterBeHit = self.params[4] or 0
  for _, target in ipairs(targets) do
    if target:IsDead() then
    else
      local baseDamage = self.params[1]
      local keys = {
        BP.be_fixed_damage_per1,
        BP.be_fixed_damage_per2,
        BP.be_fixed_damage_per3,
        BP.be_fixed_damage_per4,
        BP.be_fixed_damage_per5
      }
      local beFixedDmgPer = 1
      for _, key in ipairs(keys) do
        beFixedDmgPer = beFixedDmgPer * (1 + target:GetProperty(key) / 100)
      end
      baseDamage = math.ceil(baseDamage * beFixedDmgPer)
      baseDamage = math.max(1, self:CalFinalVal(baseDamage))
      local attackConfig = {
        fromCmdServerUid = self.cmdServerUid,
        castRoleUid = self.cmdServer.castRoleUid,
        damageVal = baseDamage,
        isCrit = false,
        damageType = bc.DamageType.Fixed,
        skillConfigId = cmdServer.skillConfigId,
        damageSubType = damageSubType,
        stateId = self.cmdServer.stateId,
        enterBeHit = enterBeHit
      }
      target:BeHit(attackConfig)
    end
  end
  self.leftEffectTimes = self.leftEffectTimes - 1
  return true
end

return BEFixedDamage
