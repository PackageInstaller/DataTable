local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BEAfterUseSilverKeyAwake, Super = System.NewClass("BEAfterUseSilverKeyAwake", BattleEffectServer)

function BEAfterUseSilverKeyAwake:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEAfterUseSilverKeyAwake:Dispose()
  Super.Dispose(self)
end

function BEAfterUseSilverKeyAwake:DoEffect()
  Super.DoEffect(self)
  self:__FireAfterUseSilverKeyAwake()
  return true
end

function BEAfterUseSilverKeyAwake:__FireAfterUseSilverKeyAwake()
  if not self.cmdServer:IsTriggerBST() then
    return
  end
  local skillId = self.effectConfig.skillId
  local castRoleUid = self.effectConfig.castRoleUid
  local level = self.effectConfig.level
  local eventData = {
    skillId = skillId,
    castRoleUid = castRoleUid,
    level = level,
    cmdServer = self.effectConfig.cmdServer
  }
  local effectConfig = {
    effectType = bc.BattleEffectType.BESendEvent,
    eventId = BattleLogicEvent.AfterUseSilverKeyAwake,
    eventData = eventData
  }
  self.battleEngine.effectMgr:CreateEffect(effectConfig)
end

function BEAfterUseSilverKeyAwake:EffectEnd()
  Super.EffectEnd(self)
end

return BEAfterUseSilverKeyAwake
