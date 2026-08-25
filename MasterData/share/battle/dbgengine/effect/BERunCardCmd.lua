local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BERunCardCmd, Super = System.NewClass("BERunCardCmd", BattleEffectServer)

function BERunCardCmd:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BERunCardCmd:Dispose()
  Super.Dispose(self)
end

function BERunCardCmd:DoEffect()
  Super.DoEffect(self)
  if self.cmdServer and self.cmdServer:HasMemberValue("ForceExecCardHasSuccess") then
    local forceExecHasSuccess = self.cmdServer:GetMemberValue("ForceExecCardHasSuccess")
    self.cmdServer:SetMemberValue("ForceExecCardHasSuccess", nil)
    if not forceExecHasSuccess then
      self.battleEngine:InfoS("BERunCardCmd:DoEffect skip {reason}", "force_exec_card_all_failed")
      return true
    end
  end
  if 0 == #self.targets then
    return true
  end
  if self.params and #self.params > 0 then
    self.totalEffectTimes = math.ceil(self.params[1] or 1)
    self.isCalDelay = math.ceil(#self.params > 1 and self.params[2] or 0)
    self.isPlayShow = math.ceil(#self.params > 2 and self.params[3] or 0)
    self.randomNeedSelect = math.ceil(#self.params > 3 and self.params[4] or 0)
    self.battleEngine:InfoS("BERunCardCmd:DoEffect {totalEffectTimes} {isCalDelay} {isPlayShow} {randomNeedSelect}", self.totalEffectTimes, self.isCalDelay, self.isPlayShow, self.randomNeedSelect)
  else
    self.totalEffectTimes = 1
  end
  self.leftEffectTimes = self.totalEffectTimes
  do return self.DoMultiEffect end
  return self.DoMultiEffect, self, "BERunCardCmd:DoEffect {totalEffectTimes} {isCalDelay} {isPlayShow} {randomNeedSelect}", self.totalEffectTimes, self.isCalDelay, self.isPlayShow, self.randomNeedSelect
end

function BERunCardCmd:__DoMultiEffect()
  local loopTime = self.cmdServer:GetSkillLoopTime()
  if not loopTime or 0 == loopTime then
    self.battleEngine:AddPassTime(0.2)
  end
  for i, target in ipairs(self.targets) do
    local targetEffectConfig = {
      effectType = bc.BattleEffectType.BEGenerateTargets,
      cmdServer = target:GetCardCmdServer(),
      targetType = target:GetCmdTarget(),
      castRoleUid = self.cmdServer.castRoleUid,
      randomNeedSelect = self.randomNeedSelect
    }
    self.battleEngine.effectMgr:CreateEffect(targetEffectConfig)
    local preCmdServer = target:GetCardPreCmdServer()
    if preCmdServer then
      local preCmdEffectConfig = {
        effectType = bc.BattleEffectType.BECreateSkillPhase,
        castRoleUid = self.cmdServer.castRoleUid,
        cardUid = target.uid,
        cmdServer = preCmdServer,
        skipPhase = not self.isPlayShow or 0 == self.isPlayShow
      }
      self.battleEngine.effectMgr:CreateEffect(preCmdEffectConfig)
    end
    local delay = 1 == i and 0 or loopTime
    local cardEffectConfig = {
      effectType = bc.BattleEffectType.BECreateSkillPhase,
      castRoleUid = self.cmdServer.castRoleUid,
      cmdServer = target:GetCardCmdServer(),
      cardUid = target.uid,
      BeforeDelay = delay,
      skipPhase = not self.isPlayShow or 0 == self.isPlayShow
    }
    self.battleEngine.effectMgr:CreateEffect(cardEffectConfig)
  end
  self.leftEffectTimes = self.leftEffectTimes - 1
  return true
end

return BERunCardCmd
