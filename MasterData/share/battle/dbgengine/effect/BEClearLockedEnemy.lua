local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleCmdTargetsExp = require("Battle.DbgEngine.Cmd.Expression.BattleCmdTargetsExp")
local BEClearLockedEnemy, Super = System.NewClass("BEClearLockedEnemy", BattleEffectServer)

function BEClearLockedEnemy:DoEffect()
  Super.DoEffect(self)
  local lockerRole = self.params[1] and self.params[1]:GetFirstTarget()
  if not lockerRole then
    return false
  end
  local lockerUid = lockerRole.uid
  local lockMap = self.battleEngine.roleMgr:GetLockerUidToLockedUid()
  if not lockMap[lockerUid] then
    return false
  end
  lockMap[lockerUid] = nil
  self.battleEngine:LogBattleWithTab("清除唤醒体 %s 锁定的敌方", lockerRole:GetBattleLogName())
  self.battleEngine.recordMgr:OnLockedEnemyChanged(lockMap)
  return true
end

return BEClearLockedEnemy
