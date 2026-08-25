local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BEPureDamage, Super = System.NewClass("BEPureDamage", BattleEffectServer)

function BEPureDamage:DoEffect()
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

function BEPureDamage:GetShowDamage()
  self:GenParams()
  local baseDamage = self.params[1]
  do return math.ceil end
  return math.ceil, baseDamage
end

function BEPureDamage:__DoMultiEffect()
  local targets = self.targets
  local cmdServer = self.cmdServer
  local includeStats = 1 == (self.params[3] or 1)
  for _, target in ipairs(targets) do
    if target:IsDead() then
    else
      local baseDamage = self.params[1]
      if not baseDamage or baseDamage <= 0 then
      else
        baseDamage = math.ceil(baseDamage)
        local attackConfig = {
          fromCmdServerUid = self.cmdServerUid,
          castRoleUid = self.cmdServer.castRoleUid,
          damageVal = baseDamage,
          isCrit = false,
          damageType = bc.DamageType.Pure,
          skillConfigId = cmdServer.skillConfigId,
          damageSubType = 0,
          stateId = self.cmdServer.stateId,
          ignoreStats = not includeStats
        }
        target:BeHit(attackConfig)
      end
    end
  end
  self.leftEffectTimes = self.leftEffectTimes - 1
  return true
end

return BEPureDamage
