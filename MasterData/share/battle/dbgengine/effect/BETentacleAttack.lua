local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BP = bc.BattleProperty
local BETentacleAttack, Super = System.NewClass("BETentacleAttack", BattleEffectServer)

function BETentacleAttack:ctor(battleEngine, effectConfig, effectArgs)
  Super.ctor(self, battleEngine, effectConfig, effectArgs)
end

function BETentacleAttack:DoEffect()
  Super.DoEffect(self)
  local caster = self.cmdServer:GetCaster()
  if not caster then
    return false
  end
  local targets = self.targets
  if not targets then
    return false
  end
  if self.battleEngine:IsPVE() and caster:GetCamp() == bc.BattleCamp.Camp1 then
    caster = caster:GetPlayer()
  end
  self.totalEffectTimes = self.params[2] or 1
  self.leftEffectTimes = self.totalEffectTimes
  do return self.DoMultiEffect end
  return self.DoMultiEffect, self
end

function BETentacleAttack:__DoMultiEffect()
  local caster = self.cmdServer:GetCaster()
  if self.battleEngine:IsPVE() and caster:GetCamp() == bc.BattleCamp.Camp1 then
    caster = caster:GetPlayer()
  end
  local tentacleDmg = math.ceil(self.params[1] or 1)
  local damageSubType = self:GetDamageSubType(self.params[3])
  local paraPlusName = self.params[4]
  for _, target in ipairs(self.targets) do
    if not target or target:IsDead() then
    else
      local paraPlus = self.cmdServer:GetSkillArgsPlus(paraPlusName)
      local realTentacleDmg, isCrit = tentacleDmg, false
      if caster.schoolCompPVE then
        realTentacleDmg, isCrit = caster.schoolCompPVE:CalcTentacleDmg(tentacleDmg, target, paraPlus)
      end
      local attackConfig = {
        fromCmdServerUid = self.cmdServerUid,
        castRoleUid = self.cmdServer.castRoleUid,
        damageVal = realTentacleDmg,
        isCrit = isCrit,
        damageType = bc.DamageType.Tentacle,
        skillConfigId = self.cmdServer.skillConfigId,
        damageSubType = damageSubType
      }
      target:BeHit(attackConfig)
    end
  end
  self.leftEffectTimes = self.leftEffectTimes - 1
  return true
end

return BETentacleAttack
