local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BEImplementDimensionSpace, Super = System.NewClass("BEImplementDimensionSpace", BattleEffectServer)

function BEImplementDimensionSpace:DoEffect()
  Super.DoEffect(self)
  local sendEventEffectConfig = {
    effectType = bc.BattleEffectType.BESendEvent,
    eventId = BattleLogicEvent.ImplementDimensionSpace,
    eventData = true
  }
  self.battleEngine.effectMgr:CreateEffect(sendEventEffectConfig)
  return true
end

return BEImplementDimensionSpace
