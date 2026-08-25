local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BEAfterUseBloodRecoverSkill, Super = System.NewClass("BEAfterUseBloodRecoverSkill", BattleEffectServer)

function BEAfterUseBloodRecoverSkill:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEAfterUseBloodRecoverSkill:Dispose()
  Super.Dispose(self)
end

function BEAfterUseBloodRecoverSkill:DoEffect()
  Super.DoEffect(self)
  local beforeEffectConfig = {
    effectType = bc.BattleEffectType.BESendEvent,
    eventId = BattleLogicEvent.AfterUseBloodRecoverSkill,
    eventData = {
      skillId = self.effectConfig.skillId,
      castRoleUid = self.effectConfig.castRoleUid,
      level = self.effectConfig.level,
      cmdServer = self.effectConfig.cmdServer
    }
  }
  self.battleEngine.effectMgr:CreateEffect(beforeEffectConfig)
  return true
end

return BEAfterUseBloodRecoverSkill
