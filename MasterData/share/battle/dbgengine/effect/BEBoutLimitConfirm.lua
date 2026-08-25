local bc = require("Battle.BattleConst")
local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleCommand = require("Battle.DbgEngine.Event.BattleCommand")
local BEBoutLimitConfirm, Super = System.NewClass("BEBoutLimitConfirm", BattleEffectServer)

function BEBoutLimitConfirm:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEBoutLimitConfirm:Dispose()
  Super.Dispose(self)
  self.battleEngine:UnregisterAllEventsByTarget(self)
end

function BEBoutLimitConfirm:DoEffect()
  Super.DoEffect(self)
  local confirmReason = bc.ConfirmReason and bc.ConfirmReason.BoutLimit or 1
  self.battleEngine.recordMgr:OnConfirm(self.uid, bc.ConfirmType.Respawn, 0, confirmReason)
  local data = {
    effectUid = self.uid,
    isReliveChoose = true,
    reason = confirmReason
  }
  self.battleEngine.effectMgr:Yield(BattleCommand.lg_Confirm, data)
  return bc.YIELD_FLAG
end

function BEBoutLimitConfirm:OnConfirm(msgData)
  if msgData.effectUid ~= self.uid then
    return false
  end
  local enemyCamp = self.effectConfig.enemyCamp
  if not enemyCamp then
    local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
    if player then
      enemyCamp = bc.BattleCamp:GetEnemyCamp(player.camp)
    else
      enemyCamp = bc.BattleCamp.Camp2
    end
  end
  self.battleEngine:ActiveBattleEnd(enemyCamp)
  do return self.AfterEffect end
  return self.AfterEffect, self, enemyCamp, player.camp
end

return BEBoutLimitConfirm
