local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BERemoveAllTypeState, Super = System.NewClass("BERemoveAllTypeState", BattleEffectServer)

function BERemoveAllTypeState:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BERemoveAllTypeState:Dispose()
  Super.Dispose(self)
end

function BERemoveAllTypeState:DoEffect()
  Super.DoEffect(self)
  local targets = self.targets
  local stateType = self.params[1]
  if not targets or not stateType then
    return false
  end
  for _, target in ipairs(targets) do
    local stateList = self.battleEngine.stateMgr:GetStateByTypeLabel(target.uid, stateType)
    for _, state in ipairs(stateList) do
      self.battleEngine.stateMgr:RemoveState(state)
    end
  end
  return true
end

return BERemoveAllTypeState
