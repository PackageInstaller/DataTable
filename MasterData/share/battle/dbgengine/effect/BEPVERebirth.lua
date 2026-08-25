local bc = require("Battle.BattleConst")
local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BEPVERebirth, Super = System.NewClass("BEPVERebirth", BattleEffectServer)

function BEPVERebirth:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEPVERebirth:Dispose()
  Super.Dispose(self)
  self.battleEngine:UnregisterAllEventsByTarget(self)
end

function BEPVERebirth:DoEffect()
  local targets = self.targets
  for _, target in ipairs(targets) do
    local rebirthData = {
      castRoleUid = self.effectConfig.castRoleUid,
      targetRoleUid = target.uid
    }
    self.battleEngine:CreateEventEffect(BattleLogicEvent.RoleBeforeRebirth, rebirthData)
  end
  local stage2 = {
    effectType = bc.BattleEffectType.BERebirthStage,
    targets = self.targets,
    params = self.params,
    castRoleUid = self.effectConfig.castRoleUid,
    cmdServer = self.effectConfig.cmdServer,
    calcParam = false
  }
  self.battleEngine.effectMgr:CreateEffect(stage2)
  return true
end

return BEPVERebirth
