local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BESendEvent, Super = System.NewClass("BESendEvent", BattleEffectServer)

function BESendEvent:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BESendEvent:Dispose()
  Super.Dispose(self)
end

function BESendEvent:DoEffect()
  Super.DoEffect(self)
  local eventId = self.effectConfig.eventId
  local eventData = self.effectConfig.eventData
  self.battleEngine.eventMgr:SendEvent(eventId, eventData)
  return true
end

function BESendEvent:EffectEnd()
  Super.EffectEnd(self)
  if self.effectConfig.eventId == BattleLogicEvent.AfterUseUltiSkill then
    local actionType = bc.ActionType.UseUlti
    self.battleEngine.roleMgr:AfterAction(actionType)
  end
  if self.effectConfig.eventId == BattleLogicEvent.AfterUseKeeperSkill then
    local actionType = bc.ActionType.UseKeeperSkill
    self.battleEngine.roleMgr:AfterAction(actionType)
  end
  if self.effectConfig.eventId == BattleLogicEvent.AfterUseSilverKeyAwake then
    local actionType = bc.ActionType.UseSilverKeyAwake
    self.battleEngine.roleMgr:AfterAction(actionType)
  end
end

return BESendEvent
