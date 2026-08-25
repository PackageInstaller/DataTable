local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BETriggerState, Super = System.NewClass("BETriggerState", BattleEffectServer)

function BETriggerState:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BETriggerState:Dispose()
  Super.Dispose(self)
end

function BETriggerState:DoEffect()
  Super.DoEffect(self)
  local targets = self.targets
  local stateId = self.params[1]
  local triggerTimes = math.ceil(self.params[2] or 1)
  if not targets or not stateId then
    return false
  end
  local triggerIndex = math.ceil(self.params[3] or 0)
  for _ = 1, triggerTimes do
    for _, target in ipairs(targets) do
      local state = self.battleEngine.stateMgr:GetState(target, stateId)
      if state then
        if triggerIndex > 0 then
          state:Trigger({idx = triggerIndex}, {})
        else
          for idx = 1, 5 do
            state:Trigger({idx = idx}, {})
          end
        end
      end
    end
  end
  return true
end

return BETriggerState
