local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BEAfterUseOtherSkill, Super = System.NewClass("BEAfterUseOtherSkill", BattleEffectServer)

function BEAfterUseOtherSkill:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEAfterUseOtherSkill:Dispose()
  Super.Dispose(self)
  Super.Dispose(self)
end

function BEAfterUseOtherSkill:DoEffect()
  Super.DoEffect(self)
  if self:IsTriggerBST() then
    local beforeEffectConfig = {
      effectType = bc.BattleEffectType.BESendEvent,
      eventId = BattleLogicEvent.AfterUseOtherSkill,
      eventData = {
        skillId = self.effectConfig.skillId,
        castRoleUid = self.effectConfig.castRoleUid,
        level = self.effectConfig.level,
        cmdServer = self.effectConfig.cmdServer
      }
    }
    self.battleEngine.effectMgr:CreateEffect(beforeEffectConfig)
  end
  return true
end

return BEAfterUseOtherSkill
