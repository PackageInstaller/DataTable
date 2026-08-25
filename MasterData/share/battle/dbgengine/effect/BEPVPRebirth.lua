local bc = require("Battle.BattleConst")
local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BEPVPRebirth, Super = System.NewClass("BEPVPRebirth", BattleEffectServer)

function BEPVPRebirth:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEPVPRebirth:Dispose()
  Super.Dispose(self)
  self.battleEngine:UnregisterAllEventsByTarget(self)
end

function BEPVPRebirth:DoEffect()
  local targets = self.targets
  for _, target in ipairs(targets) do
    local rebirthData = {
      castRoleUid = self.effectConfig.castRoleUid,
      targetRoleUid = target.uid
    }
    self.battleEngine:CreateEventEffect(BattleLogicEvent.RoleBeforeRebirth, rebirthData)
  end
  local calcParam
  local needCalc = self.params[2] or 0
  if 0 == needCalc then
    calcParam = true
  else
    calcParam = false
  end
  local stage2 = {
    effectType = bc.BattleEffectType.BERebirthStage,
    targets = self.targets,
    params = self.params,
    castRoleUid = self.effectConfig.castRoleUid,
    cmdServer = self.effectConfig.cmdServer,
    calcParam = calcParam
  }
  self.battleEngine.effectMgr:CreateEffect(stage2)
  return true
end

return BEPVPRebirth
