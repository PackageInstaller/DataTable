local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleRenderEvent = require("Battle.DbgEngine.Event.BattleRenderEvent")
local BETimelineLoop, Super = System.NewClass("BETimelineLoop", BattleEffectServer)

function BETimelineLoop:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BETimelineLoop:Dispose()
  Super.Dispose(self)
end

function BETimelineLoop:DoEffect()
  Super.DoEffect(self)
  local eventName = self.fixArg
  local eventId = BattleRenderEvent[eventName]
  if not eventId then
    return false
  end
  self.battleEngine.recordMgr:OnTimelineLoop(self.params[1] or 1)
  return true
end

return BETimelineLoop
