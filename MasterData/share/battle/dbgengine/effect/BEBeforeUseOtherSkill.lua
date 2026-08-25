local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BEBeforeUseOtherSkill, Super = System.NewClass("BEBeforeUseOtherSkill", BattleEffectServer)

function BEBeforeUseOtherSkill:DoEffect()
  Super.DoEffect(self)
  if self:IsTriggerBST() then
    local beforeEffectConfig = {
      effectType = bc.BattleEffectType.BESendEvent,
      eventId = BattleLogicEvent.BeforeUseOtherSkill,
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

return BEBeforeUseOtherSkill
