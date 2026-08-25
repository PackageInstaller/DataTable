local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleCmdTargetsExp = require("Battle.DbgEngine.Cmd.Expression.BattleCmdTargetsExp")
local BESetLockedEnemy, Super = System.NewClass("BESetLockedEnemy", BattleEffectServer)

function BESetLockedEnemy:DoEffect()
  Super.DoEffect(self)
  local lockerRole = self.params[1] and self.params[1]:GetFirstTarget()
  local lockedRole = self.params[2] and self.params[2]:GetFirstTarget()
  if not lockerRole or not lockedRole then
    return false
  end
  if lockerRole:GetCamp() == lockedRole:GetCamp() then
    self.battleEngine.logger:InfoS("BESetLockedEnemy fail: camp is the same")
    return false
  end
  local lockerUid = lockerRole.uid
  local lockedUid = lockedRole.uid
  local lockMap = self.battleEngine.roleMgr:GetLockerUidToLockedUid()
  lockMap[lockerUid] = lockedUid
  self.battleEngine:LogBattleWithTab("设置唤醒体锁定的敌方：%s -> %s", lockerRole:GetBattleLogName(), lockedRole:GetBattleLogName())
  self.battleEngine.recordMgr:OnLockedEnemyChanged(lockMap)
  return true
end

return BESetLockedEnemy
