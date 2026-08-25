local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BEAfterUseSpecialDimension, Super = System.NewClass("BEAfterUseSpecialDimension", BattleEffectServer)

function BEAfterUseSpecialDimension:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEAfterUseSpecialDimension:Dispose()
  Super.Dispose(self)
end

function BEAfterUseSpecialDimension:DoEffect()
  Super.DoEffect(self)
  local beforeEffectConfig = {
    effectType = bc.BattleEffectType.BESendEvent,
    eventId = BattleLogicEvent.AfterUseSpecialDimension,
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

return BEAfterUseSpecialDimension
