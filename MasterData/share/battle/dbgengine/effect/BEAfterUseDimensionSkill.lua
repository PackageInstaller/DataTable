local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BEAfterUseDimensionSkill, Super = System.NewClass("BEAfterUseDimensionSkill", BattleEffectServer)

function BEAfterUseDimensionSkill:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEAfterUseDimensionSkill:Dispose()
  Super.Dispose(self)
end

function BEAfterUseDimensionSkill:DoEffect()
  Super.DoEffect(self)
  if not self:IsTriggerBST() then
    return true
  end
  local beforeEffectConfig = {
    effectType = bc.BattleEffectType.BESendEvent,
    eventId = BattleLogicEvent.AfterUseDimensionSkill,
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

return BEAfterUseDimensionSkill
