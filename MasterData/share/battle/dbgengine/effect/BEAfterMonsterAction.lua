local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BattleRenderEvent = require("Battle.DbgEngine.Event.BattleRenderEvent")
local bc = require("Battle.BattleConst")
local BEAfterMonsterAction, Super = System.NewClass("BEAfterMonsterAction", BattleEffectServer)

function BEAfterMonsterAction:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEAfterMonsterAction:Dispose()
  Super.Dispose(self)
end

function BEAfterMonsterAction:DoEffect()
  Super.DoEffect(self)
  local castRoleUid = self.effectConfig.castRoleUid
  local monster = self.battleEngine.roleMgr:GetRoleByUid(castRoleUid)
  if not monster then
    return false
  end
  if self:IsTriggerBST() then
    local eventData = {castRoleUid = castRoleUid}
    self.battleEngine:CreateEventEffect(BattleLogicEvent.AfterMonsterAction, eventData)
  end
  monster.monsterBehaviorComp:ClearIntentionAfterAction()
  return true
end

function BEAfterMonsterAction:EffectEnd()
  Super.EffectEnd(self)
  local actionType = bc.ActionType.MonsterAction
  self.battleEngine.roleMgr:AfterAction(actionType)
end

return BEAfterMonsterAction
