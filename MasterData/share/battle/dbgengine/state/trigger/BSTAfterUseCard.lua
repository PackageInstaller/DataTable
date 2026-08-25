local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterUseCard, Super = System.NewClass("BSTAfterUseCard", BattleStateTriggerServer)

function BSTAfterUseCard:OnAfterUseCard(eventData)
  local card = self.battleEngine:GetObj(eventData.cardUid)
  if not card then
    return
  end
  local triggerCamp = card:GetCamp()
  if not self:TryTrigger(triggerCamp) then
    return
  end
  if self.cbParams.triggerPara and not card:CardTypeMatch(self.cbParams.triggerPara) then
    return
  end
  local associator2 = {}
  for _, targetUid in ipairs(card:GetDamageTargets()) do
    local target = self.battleEngine:GetObj(targetUid)
    if not target or target:IsDead() then
    else
      table.insert(associator2, target)
    end
  end
  local triggerData = {
    associator = {card},
    associator2 = associator2,
    associator3 = card:GetSkillTarget()
  }
  self:Trigger(triggerData)
end

function BSTAfterUseCard:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.AfterUseCard, self.OnAfterUseCard, self)
end

return BSTAfterUseCard
