local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BP = bc.BattleProperty
local BEHpRemove, Super = System.NewClass("BEHpRemove", BattleEffectServer)

function BEHpRemove:DoEffect()
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

function BEHpRemove:__DoMultiEffect()
  local targets = self.targets
  local cmdServer = self.cmdServer
  for _, target in ipairs(targets) do
    if target:IsDead() then
    else
      local baseDamage = self.params[1]
      local modifyConfig = {
        fromCmdServerUid = self.cmdServerUid,
        castRoleUid = self.cmdServer.castRoleUid,
        destRoleUid = target.uid,
        modifyVal = baseDamage * -1,
        isCrit = false,
        damageType = bc.DamageType.HpRemove,
        skillConfigId = cmdServer.skillConfigId,
        stateId = self.cmdServer.stateId
      }
      target:ModifyHp(modifyConfig)
    end
  end
  self.leftEffectTimes = self.leftEffectTimes - 1
  return true
end

return BEHpRemove
