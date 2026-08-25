local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleCommand = require("Battle.DbgEngine.Event.BattleCommand")
local bc = require("Battle.BattleConst")
local BATTLE_WIN_CONFIRM_STATE_LIST_KEY = "BattleWinConfirmStateList"
local BEBattleWin, Super = System.NewClass("BEBattleWin", BattleEffectServer)

function BEBattleWin:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEBattleWin:Dispose()
  Super.Dispose(self)
  self.battleEngine:UnregisterAllEventsByTarget(self)
end

function BEBattleWin:IsConfiguredConfirmState(stateId)
  if not stateId then
    return false
  end
  local stateIdList = self.battleEngine.battleDT:GetOriginalConstant(BATTLE_WIN_CONFIRM_STATE_LIST_KEY, {})
  for _, configuredStateId in ipairs(stateIdList) do
    if configuredStateId == stateId then
      return true
    end
  end
  return false
end

function BEBattleWin:ShouldYieldLoseConfirm(winCamp)
  if not self.battleEngine:IsPVE() then
    return false
  end
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  if not player or winCamp == player.camp then
    return false
  end
  local cmdServer = self.cmdServer or self.effectConfig.cmdServer
  if not cmdServer then
    return false
  end
  do return self.IsConfiguredConfirmState, self end
  return self.IsConfiguredConfirmState, self, cmdServer.stateId
end

function BEBattleWin:DoEffect()
  Super.DoEffect(self)
  local winCamp = self.battleEngine.boutMgr:GetCurCamp()
  if self:ShouldYieldLoseConfirm(winCamp) then
    self.effectConfig.winCamp = winCamp
    local confirmReason = bc.ConfirmReason.BoutLimit
    local cmdServer = self.cmdServer or self.effectConfig.cmdServer
    self.battleEngine:InfoS("BEBattleWin YieldConfirm stateId:{stateId} winCamp:{winCamp} reason:{reason}", cmdServer and cmdServer.stateId, winCamp, confirmReason)
    self.battleEngine.recordMgr:OnConfirm(self.uid, bc.ConfirmType.Respawn, 0, confirmReason)
    local data = {
      effectUid = self.uid,
      isReliveChoose = true,
      reason = confirmReason
    }
    self.battleEngine.effectMgr:Yield(BattleCommand.lg_Confirm, data)
    return bc.YIELD_FLAG
  end
  self.battleEngine:ActiveBattleEnd(winCamp, true, false)
  return true
end

function BEBattleWin:OnConfirm(msgData)
  if msgData.effectUid ~= self.uid then
    return false
  end
  local winCamp = self.effectConfig.winCamp
  winCamp = winCamp or self.battleEngine.boutMgr:GetCurCamp()
  self.battleEngine:InfoS("BEBattleWin OnConfirm winCamp:{winCamp} confirm:{confirm} rewindToFirst:{rewind}", winCamp, tostring(msgData.confirm), tostring(msgData.rewindToFirst))
  self.battleEngine:ActiveBattleEnd(winCamp, true, false)
  do return self.AfterEffect end
  return self.AfterEffect, self, winCamp, true, false, tostring(msgData.rewindToFirst)
end

return BEBattleWin
